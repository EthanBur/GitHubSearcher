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
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            if self.isFiltering{
                self.getInfo(searchText: searchBar.text!)
                for i in 0..<self.gitUsers.count {
                    self.getAdditionalInfo(urlString: self.gitUsers[i].url ?? "https://api.github.com/users/tom")
                }
            }
            if self.gitUsers.count != 0 {
                self.filterContentForSearchText(searchText: searchBar.text!)
            }
        }
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }
    
    func filterContentForSearchText(searchText: String) {
        var temp: [String] = []
        filteredUserImageUrl = []
        if gitUsers.count != 0 {
            for i in 0...gitUsers.count-1 {
                temp.append(gitUsers[i].login ?? "No name found!")
            }
        }
        filteredUsers = temp.filter { (result: String) -> Bool in
            return result.contains(searchText)
        }
        temp = []
        for i in 0..<filteredUsers.count {
            for j in 0..<gitUsers.count {
                if gitUsers[j].login == filteredUsers[i] {
                    temp.append(gitUsers[i].avatar_url ?? "https://avatars0.githubusercontent.com/u/9795?v=4")
                }
            }
        }
        filteredUserImageUrl = temp
        tableview.reloadData()
    }
    
    //https://api.github.com/search/users?q=tom
    func getInfo(searchText: String) {
        let decoder = JSONDecoder()
        let url = URLBuilder.buildURL(scheme: "https", host: "api.github.com", path: "/search/users",queries: [URLQueryItem(name: "q", value: searchText)])!
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if error == nil {
                do{
                    let gitUserData = try decoder.decode(GitUser.self, from: data ?? Data())
                    if gitUserData.items != nil {
                        self.gitUsers = self.gitUsers + gitUserData.items!
                    }
                } catch {
                    
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
        let task = URLSession.shared.dataTask(with: url) {
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
            return filteredUsers.count
        }
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? MainViewCell else {
            return MainViewCell()
        }
        var user: String
        if isFiltering {
            user = filteredUsers[indexPath.row]
            cell.userImage.downloadImageFrom(link: "\(String(describing: filteredUserImageUrl[indexPath.row]))", contentMode: .scaleAspectFit)
            cell.repoNumLabel.text = gitUserAdditional[indexPath.row].public_repos?.description
        } else {
            user = ""
        }
        cell.userLabel.text = user
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gitVC = GitUserViewController()
        gitVC.user = gitUsers[indexPath.row]
        self.searchController.isActive = false
        self.controller?.navigationController?.pushViewController(gitVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
