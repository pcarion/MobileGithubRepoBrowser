//
//  GithubUserInformationViewController.swift
//  MobileGithubRepoBrowser
//
//  Created by Pierre Carion on 6/7/19.
//  Copyright © 2019 Pierre Carion. All rights reserved.
//

import Foundation

import UIKit

class GithubUserInformationViewController: UIViewController {
    var githubUser: GithubUserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = self.githubUser?.login
    }
}
