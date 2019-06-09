//
//  GithubReposList.swift
//  MobileGithubRepoBrowser
//
//  Created by Pierre Carion on 6/8/19.
//  Copyright © 2019 Pierre Carion. All rights reserved.
//

import Foundation
import UIKit

class GithubReposListViewController: UIViewController {
    var githubUser: GithubUserModel?
    var repositories = [GithubRepository]()
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        // to ensure that dequeueReusableCellWithIdentifier will return a default TableViewCell
        // tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

        if let user = self.githubUser {
            self.title = user.login
        
             GithubApi.shared.getReposForUser(userName: user.login) {
                (repositories: [GithubRepository]? , errorMessage: String?) in
                if let repositories = repositories {
                    print("repos: \(repositories)");
                    self.repositories.removeAll()

                    // we repopulate the table - each element keeps the same
                    // position it had in the network call result
                    for (index, repo) in repositories.enumerated() {
                        print ("inserting repo: \(repo) at \(index)")
                        self.repositories.insert(repo, at: index)
//                        let indexPath = IndexPath(row: index, section: 0)
//                        self.tableView.insertRows(at: [indexPath], with: .automatic)
                    }
                    // dismiss activity indicator
                    self.activityIndicatorView.stopAnimating()
                    self.tableView.reloadData()
                 }
                
                if let errorMessage = errorMessage {
                    let alert = UIAlertController(title: "error", message: errorMessage, preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)

                }
             }
             activityIndicatorView.startAnimating()
        }
    }
}
