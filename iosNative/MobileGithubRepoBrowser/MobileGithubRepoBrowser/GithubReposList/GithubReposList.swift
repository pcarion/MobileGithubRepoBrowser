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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = self.githubUser {
            self.title = user.login
        }
        
        print("GithubReposListViewController>viewDidLoad()")
    }
}
