//
//  MainViewExtensions.swift
//  T-Mobile_Code_Challenge
//
//  Created by mcs on 4/11/20.
//  Copyright © 2020 MCS. All rights reserved.
//

//two dateformatters 1st to date then 2nd tostring
//

import UIKit

extension MainView: UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        guard searchBar.text?.isEmpty == false else { return }
        self.timer?.invalidate()
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            self.getInfo(searchText: searchBar.text!) {
                DispatchQueue.main.async {
                    self.tableview.reloadData()
                }
            }
        })
    }
    
    func getInfo(searchText: String, completion: @escaping () -> Void) {
        let decoder = JSONDecoder()
        let url = URLBuilder.buildURL(scheme: "https", host: "api.github.com", path: "/search/users",queries: [URLQueryItem(name: "q", value: searchText)])!
        var request = URLRequest(url: url)
        request.addValue("token \(Constants.accessToken)", forHTTPHeaderField: "Authorization")
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
            } else {
                print("Error: \(String(describing: error))")
            }
            completion()
        }
        task.resume()
    }
    
    func getAdditionalInfo(urlString: String, completion: @escaping (AdditionalUser?) -> Void) {
        let decoder = JSONDecoder()
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        var request = URLRequest(url: url)
        request.addValue("token \(Constants.accessToken)", forHTTPHeaderField: "Authorization")
        let task = URLSession.shared.dataTask(with: request) {
            data, response, error in
            
            if error == nil {
                do{
                    let gitUserData = try decoder.decode(AdditionalUser.self, from: data ?? Data())
                    completion(gitUserData)
                } catch {
                    print(error.localizedDescription)
                    completion(nil)
                }
            } else {
                print("Error: \(String(describing: error))")
                completion(nil)
            }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gitUsers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as? MainViewCell else {
            return MainViewCell()
        }
        let user = gitUsers[indexPath.row]
        if let url = user.url {
            self.getAdditionalInfo(urlString: url) { userInfo in
                self.additionalUserInfoDictionary[indexPath] = userInfo
                DispatchQueue.main.async {
                    cell.repoNumLabel.text = "Repos: \(userInfo?.publicRepos ?? 0)"
                }
            }
        }
        cell.userImage.downloadImageFrom(link:  gitUsers[indexPath.row].avatarURL ?? "https://secure.gravatar.com/avatar/25c7c18223fb42a4c6ae1c8db6f50f9b?d=https://a248.e.akamai.net/assets.github.com%2Fimages%2Fgravatars%2Fgravatar-user-420.png", contentMode: .scaleAspectFit)
        cell.userLabel.text = user.login
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gitVC = GitUserViewController()
        gitVC.user = gitUsers[indexPath.row]
        gitVC.addUserInfo = additionalUserInfoDictionary[indexPath]
        self.searchController.isActive = false
        self.controller?.navigationController?.pushViewController(gitVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
