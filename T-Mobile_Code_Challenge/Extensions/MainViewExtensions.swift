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
        if isFiltering{
            getInfo(searchText: searchBar.text!)
        }
        if gitUsers.count != 0 {
            self.filterContentForSearchText(searchText: searchBar.text!)
        }
    }
    
    var isFiltering: Bool {
        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
    }
    
    func filterContentForSearchText(searchText: String) {
        var temp: [String] = []
        if gitUsers.count != 0 {
            for i in 0...gitUsers.count-1 {
                temp.append(gitUsers[i].login ?? "No bug found!")
            }
        }
        filteredUsers = temp.filter { (result: String) -> Bool in
            return result.lowercased().contains(searchText.lowercased())
        }
        for i in 0..<filteredUsers.count-1 {
            for j in 0..<gitUsers.count-1 {
                if gitUsers[j].login == filteredUsers[i] {
                    filteredUserImageUrl.append(gitUsers[i].avatar_url ?? "https://avatars0.githubusercontent.com/u/9795?v=4")
                }
            }
        }
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
            cell.userImage.downloadImageFrom(link: "\(String(describing: filteredUserImageUrl[0]))", contentMode: UIView.ContentMode.left)
            cell.userImage.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        } else {
            user = ""
        }
        cell.userLabel.text = user
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gitVC = GitUserViewController()
        self.controller?.navigationController?.pushViewController(gitVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
