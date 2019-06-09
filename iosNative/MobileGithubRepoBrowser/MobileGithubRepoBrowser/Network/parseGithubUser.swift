//
//  parseGithubUser.swift
//  MobileGithubRepoBrowser
//
//  Created by Pierre Carion on 6/7/19.
//  Copyright © 2019 Pierre Carion. All rights reserved.
//

import Foundation

// reference:
// https://developer.github.com/v3/users/#get-a-single-user

func parseGithubUser(_ data: Data) throws -> GithubUserModel {
    var response: Any?
    
    // parse the JSOn response
    do {
        response = try JSONSerialization.jsonObject(with: data, options: [])
    } catch let parseError as NSError {
        print("JSONSerialization error: \(parseError.localizedDescription)")
        throw AppError.invalidJsonResponse(parseError.localizedDescription)
    }
    // print ("parse: \(String(describing: response))")
    

    // the top level element is an object describing the user
    if let userDictionary = response as? [String: Any] {
        // retrieve each element as a dictionary and we grab the properties
        // we are interested in
        let login = userDictionary["login"] as? String ?? ""
        let name = userDictionary["name"] as? String ?? ""
        let company = userDictionary["company"] as? String ?? ""
        let location = userDictionary["location"] as? String ?? ""
        let email = userDictionary["email"] as? String ?? ""
        let bio = userDictionary["bio"] as? String ?? ""
        let publicReposCount = userDictionary["public_repos"] as? Int ?? 0
        let followersCount = userDictionary["followers"] as? Int ?? 0
        let followingCount = userDictionary["following"] as? Int ?? 0
        let avatarUrl = userDictionary["avatar_url"] as? String
        
        return GithubUserModel(name: name, login: login, company: company, location: location, email: email, bio: bio, avatarUrl: avatarUrl, publicReposCount: publicReposCount, followersCount: followersCount, followingCount: followingCount)
    } else {
        throw AppError.badJsonData
    }
}
