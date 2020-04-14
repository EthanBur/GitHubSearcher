//
//  GitUserViewExtensions.swift
//  T-Mobile_Code_Challenge
//
//  Created by mcs on 4/11/20.
//  Copyright © 2020 MCS. All rights reserved.
//

import UIKit

extension GitUserView: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var temp: [String] = []
        if gitUserRepos.count != 0 {
            for i in 0..<gitUserRepos.count {
                temp.append(gitUserRepos[i].name)
            }
        }
        defer { tableview.reloadData() }
        guard let text = repoSearchBar.text else {
            filteredRepos = []
            return }
        filteredRepos = temp.filter { (result: String) -> Bool in
            return result.lowercased().contains(text.lowercased())
        }
        tableview.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url = URL(string: gitUserRepos[indexPath.row].htmlURL) {
            UIApplication.shared.open(url)
        }
    }
    
    var isFiltering: Bool {
        return !(repoSearchBar.text?.isEmpty ?? true)
    }
    
    func getRepoInfo(searchText: String) {
        let decoder = JSONDecoder()
        let url = URLBuilder.buildURL(scheme: "https", host: "api.github.com", path: "/users/\(String(describing: user.login))/repos",queries: [])!
        var request = URLRequest(url: url)
        request.addValue("token \(Constants.accessToken)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if error == nil {
                do{
                    self.gitUserRepos = try decoder.decode([UserRepo].self, from: data ?? Data())
                    DispatchQueue.main.async {
                        self.tableview.reloadData()
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
        if isFiltering{
            return filteredRepos.count
        }
        return gitUserRepos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "newCell") as? GitUserViewCell else {
            return GitUserViewCell()
        }
        var bug: String
        if isFiltering {
            for i in 0..<gitUserRepos.count {
                if filteredRepos[indexPath.row] == gitUserRepos[i].name {
                    cell.repoLabel.text = gitUserRepos[i].name
                    cell.forksLabel.text = "\(gitUserRepos[i].forks) Forks"
                    cell.starsLabel.text = "\(gitUserRepos[i].starCount) Stars"
                }
            }
        } else {
            cell.repoLabel.text = gitUserRepos[indexPath.row].name
            cell.forksLabel.text = "\(gitUserRepos[indexPath.row].forks) Forks"
            cell.starsLabel.text = "\(gitUserRepos[indexPath.row].starCount) Stars"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
