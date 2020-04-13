//
//  MainViewExtensions.swift
//  T-Mobile_Code_Challenge
//
//  Created by mcs on 4/11/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit

extension MainView: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            if self.isFiltering{
                self.getInfo(searchText: searchBar.text!)
                var num = 0
                if self.gitUsers.count > 10{
                    num = 10
                } else {
                    num = self.gitUsers.count
                }
                for i in 0..<num {
                    self.getAdditionalInfo(urlString: self.gitUsers[i].url ?? "https://api.github.com/users/tom")
                }
            }
        }
        tableview.reloadData()
    }
    
    var isFiltering: Bool {
        return !(searchController.searchBar.text?.isEmpty ?? true)
    }
    
    //https://api.github.com/search/users?q=tom
    func getInfo(searchText: String) {
        let decoder = JSONDecoder()
        let url = URLBuilder.buildURL(scheme: "https", host: "api.github.com", path: "/search/users",queries: [URLQueryItem(name: "q", value: searchText)])!
        var request = URLRequest(url: url)
        request.addValue("token \(apiKey)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if error == nil {
                do{
                    let gitUserData = try decoder.decode(GitUser.self, from: data ?? Data())
                    if gitUserData.items != nil {
                        self.gitUsers = self.gitUsers + gitUserData.items!
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            else{
                print("Error: \(String(describing: error))")
            }
        }
        task.resume()
    }

    func getAdditionalInfo(urlString: String) {        let decoder = JSONDecoder()
        guard let url = URL(string: urlString) else { return  }
        var request = URLRequest(url: url)
        request.addValue("token \(apiKey)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if error == nil {
                do{
                    let gitUserData = try decoder.decode(additionalUser.self, from: data ?? Data())
                    if gitUserData != nil {
                        self.gitUserAdditional.append(gitUserData)
                    }
                } catch {
                    print(error.localizedDescription)
                }
            }
            else{
                print("Error: \(String(describing: error))")
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return gitUsers.count
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? MainViewCell else {
            return MainViewCell()
        }
        var user: String
        if isFiltering {
            user = gitUsers[indexPath.row].login ?? "Username not found!"
            cell.userImage.downloadImageFrom(link: "\(String(describing: gitUsers[indexPath.row].avatar_url))", contentMode: .scaleAspectFit)
            if gitUserAdditional.count > indexPath.row {
                cell.repoNumLabel.text = "Repos: \(gitUserAdditional[indexPath.row].public_repos ?? 0)"
            }
        } else {
            user = ""
        }
        cell.userLabel.text = user
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gitVC = GitUserViewController()
        gitVC.user = gitUsers[indexPath.row]
        gitVC.addUserInfo = gitUserAdditional[indexPath.row]
        self.searchController.isActive = false
        self.controller?.navigationController?.pushViewController(gitVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
