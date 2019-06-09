//
//  GithubRepoDetailViewController.swift
//  MobileGithubRepoBrowser
//
//  Created by Pierre Carion on 6/8/19.
//  Copyright © 2019 Pierre Carion. All rights reserved.
//

import Foundation
import UIKit

class GithubRepoDetailController: UIViewController {
    var githubRepo: GithubRepository?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = githubRepo?.name ?? "--"
    }
}
