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
    var selectedRepo: GithubRepository?
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

        if let user = self.githubUser {
            self.title = user.login
        
             GithubApi.shared.getReposForUser(userName: user.login) {
                (repositories: [GithubRepository]? , errorMessage: String?) in
                if let repositories = repositories {
                    self.repositories.removeAll()

                    // we repopulate the table - each element keeps the same
                    // position it had in the network call result
                    for (index, repo) in repositories.enumerated() {
                        self.repositories.insert(repo, at: index)
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRepoDetails" {
            if let vc = sender as? GithubReposListViewController {
                let controller = segue.destination as! GithubRepoDetailController
                let repository = vc.selectedRepo
                controller.githubRepo = repository
            }
        }
    }

}
