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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Additional setup after loading the view.
        githubUserName.text = "Hello!"
        suggestionsTableView.delegate = self
        suggestionsTableView.dataSource = self
        // to ensure that dequeueReusableCellWithIdentifier will return a default TableViewCell
        suggestionsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")

    }
}
