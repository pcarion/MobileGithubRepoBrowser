//
//  GithubRepository.swift
//  MobileGithubRepoBrowser
//
//  Created by Pierre Carion on 6/8/19.
//  Copyright © 2019 Pierre Carion. All rights reserved.
//

import Foundation

class GithubRepository {
    
    let name: String
    let description: String
    let starsCount: Int
    let forksCount: Int
    let openIssuesCount: Int
    let watchersCount: Int
    
    init(name: String,
         description: String,
         starsCount: Int,
         forksCount: Int,
         openIssuesCount: Int,
         watchersCount: Int
        ) {
        self.name = name
        self.description = description
        self.starsCount = starsCount
        self.forksCount = forksCount
        self.openIssuesCount = openIssuesCount
        self.watchersCount = watchersCount
    }
    
}
