//
//  parseGithubRepos.swift
//  MobileGithubRepoBrowser
//
//  Created by Pierre Carion on 6/8/19.
//  Copyright © 2019 Pierre Carion. All rights reserved.
//

import Foundation

func parseGithubRepos(_ data: Data) throws -> [GithubRepository] {
    var response: Any?
    var repos = [GithubRepository]()
    
    // JSON parsing
    do {
        response = try JSONSerialization.jsonObject(with: data, options: [])
    } catch let parseError as NSError {
        throw AppError.invalidJsonResponse(parseError.localizedDescription)
    }
    
    // the top level element is an array of repos description
    if let array = response as? [Any] {
        // we parse all the items in the arrat
        for object in array {
            // retrieve each element as a dictionary and we grab the properties
            // we are interested in
            if let repoDictionary = object as? [String: Any] {
                let name = repoDictionary["name"] as? String ?? ""
                let starsCount = repoDictionary["stargazers_count"] as? Int ?? -1
                let watchersCount = repoDictionary["watchers_count"] as? Int ?? -1
                let forksCount = repoDictionary["forks_count"] as? Int ?? -1
                let openIssuesCount = repoDictionary["open_issues_count"] as? Int ?? -1
                let description = repoDictionary["description"]  as? String ?? ""
                repos.append(GithubRepository(name: name,
                                              description: description,
                                              starsCount: starsCount,
                                              forksCount: forksCount,
                                              openIssuesCount: openIssuesCount,
                                              watchersCount: watchersCount))
            } else {
                throw AppError.badJsonData
            }
        }
        
    }
    return repos;
}
