//
//  GitUserViewExtensions.swift
//  T-Mobile_Code_Challenge
//
//  Created by mcs on 4/11/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit

extension GitUserView: UITableViewDataSource, UITableViewDelegate {
    func getRepoInfo(searchText: String) {
        let decoder = JSONDecoder()
        //https://api.github.com/users/azat-io/repos
        let url = URLBuilder.buildURL(scheme: "https", host: "api.github.com", path: "/users/\(userName)/repos",queries: [])!
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if error == nil {
                do{
                    self.gitUserRepos = try decoder.decode([UserRepo].self, from: data ?? Data())
                } catch {
                    
                }
            }
            else{
                print("Error: \(String(describing: error))")
            }
        }
        task.resume()
    }
    
//    var isFiltering: Bool {
//        return searchController.isActive && !(searchController.searchBar.text?.isEmpty ?? true)
//    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering {
//            return filteredRepos.count
//        }
        return gitUserRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? GitUserViewCell else {
            return GitUserViewCell()
        }
//        if isFiltering {
//            repo = filteredRepos[indexPath.row]
//        } else {
//            repo = ""
//        }
        cell.repoLabel.text = gitUserRepos[indexPath.row].name ?? "No Repo name found"
        return cell
    }
}
