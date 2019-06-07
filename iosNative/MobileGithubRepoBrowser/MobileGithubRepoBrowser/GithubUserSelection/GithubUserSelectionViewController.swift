//
//  GithubUserSelectionViewController.swift
//  MobileGithubRepoBrowser
//
//  Created by Pierre Carion on 6/7/19.
//  Copyright © 2019 Pierre Carion. All rights reserved.
//

import Foundation

import UIKit

class GithubUserSelectionViewController: UIViewController {
    let suggestedUserName: [String] = ["intuit" , "facebook", "pcarion", "google"]
    
    @IBOutlet weak var githubUserName: UITextField!
    @IBOutlet weak var suggestionsTableView: UITableView!
    @IBOutlet weak var selectUserButton: UIButton!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    @IBAction func onSelectGithubUserClick(_ sender: Any) {
        // first we check tht we have an inout for the github user name
        let githubUserName = (self.githubUserName.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if (githubUserName.count == 0) {
            let alert = UIAlertController(title: "Value is required", message: "You need to enter a Github user name", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            GithubApi.shared.getUser(userName: githubUserName) { (githubUserModel: GithubUserModel? , errorMessage: String) in
//                print("user model:")
//                print(githubUserModel?.name)
//                print("errorMessage:")
//                print(errorMessage)
                if let githubUserModel = githubUserModel {
                    guard let destinationViewController = self.storyboard?.instantiateViewController(withIdentifier: "GithubUserInformationViewController") as? GithubUserInformationViewController else {
                        print("could not find GithubUserInformationViewController");
                        return
                    }
                    destinationViewController.githubUser = githubUserModel
                    
                    // dismiss activity indicator
                    self.activityIndicatorView.stopAnimating()
                    self.navigationController?.pushViewController(destinationViewController, animated: true)
                    // change the back key title - otherwise would use the title of this VC
                    self.navigationController?.navigationBar.topItem?.title = "back";
                }
            }
            activityIndicatorView.startAnimating()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
        suggestionsTableView.delegate = self
        suggestionsTableView.dataSource = self
        // to ensure that dequeueReusableCellWithIdentifier will return a default TableViewCell
        suggestionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

    }
    
    func selectSuggestedUser(name: String) {
        githubUserName.text = name
    }
}
