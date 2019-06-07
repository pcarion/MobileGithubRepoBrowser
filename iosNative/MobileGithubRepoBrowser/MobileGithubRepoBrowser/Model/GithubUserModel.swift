//
//  GithubUserModel.swift
//  MobileGithubRepoBrowser
//
//  Created by Pierre Carion on 6/7/19.
//  Copyright © 2019 Pierre Carion. All rights reserved.
//

import Foundation

class GithubUserModel {
    
    let name: String
    let login: String
    let company: String
    let location: String
    let email: String
    let bio: String
    let publicReposCount: Int
    let followersCount: Int
    let followingCount: Int

    init(name: String,
        login: String,
        company: String,
        location: String,
        email: String,
        bio: String,
        publicReposCount: Int,
        followersCount: Int,
        followingCount: Int
    ) {
        self.name = name
        self.login = login;
        self.company = company;
        self.location = location;
        self.email = email;
        self.bio = bio;
        self.publicReposCount = publicReposCount;
        self.followersCount = followersCount;
        self.followingCount = followingCount;
    }
    
}
