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
                
                let repo = GithubRepository(name: name)
                repo.addProp(name: "full name", value: repoDictionary["full_name"] as? String)
                repo.addProp(name: "language", value: repoDictionary["language"]  as? String)
                repo.addProp(name: "description", value: repoDictionary["description"]  as? String)
                repo.addProp(name: "url (html)", value: repoDictionary["html_url"]  as? String)
                repo.addProp(name: "url (git)", value: repoDictionary["git_url"]  as? String)
                repo.addProp(name: "has wiki?", value: repoDictionary["has_wiki"]  as? Bool)
                repo.addProp(name: "has pages?", value: repoDictionary["has_pages"]  as? Bool)
                repo.addProp(name: "has projects?", value: repoDictionary["has_projects"]  as? Bool)
                repo.addProp(name: "has downloads?", value: repoDictionary["has_downloads"]  as? Bool)
                repo.addProp(name: "created at", value: repoDictionary["created_at"] as? String)
                repo.addProp(name: "updated at", value: repoDictionary["updated_at"] as? String)
                repo.addProp(name: "pushed at", value: repoDictionary["pushed_at"] as? String)
                repo.addProp(name: "size", value: repoDictionary["size"] as? Int)
                repo.addProp(name: "# of stars", value: repoDictionary["stargazers_count"] as? Int)
                repo.addProp(name: "# of watchers", value: repoDictionary["watchers_count"] as? Int)
                repo.addProp(name: "# of forks", value: repoDictionary["forks_count"] as? Int)
                repo.addProp(name: "# of issues", value: repoDictionary["open_issues_count"] as? Int)
                repos.append(repo)
            } else {
                throw AppError.badJsonData
            }
        }
        
    }
    return repos;
}
