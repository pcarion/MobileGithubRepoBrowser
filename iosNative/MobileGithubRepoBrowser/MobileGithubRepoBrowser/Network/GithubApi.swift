//
//  GithubApi.swift
//  MobileGithubRepoBrowser
//
//  Created by Pierre Carion on 6/7/19.
//  Copyright © 2019 Pierre Carion. All rights reserved.
//

// API is described here
// https://developer.github.com/v3/

import Foundation

class GithubApi {
    typealias QueryUserResult = (GithubUserModel?, String?) -> Void
    typealias QueryDownloadResult = (NSData?, String? ) -> Void

    static let shared = GithubApi()
    
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    private init() {
        // private constructore ti ensure that we have a singleton
    }
    
    func getUser(userName: String, completion: @escaping QueryUserResult) {
        guard let queryUrl = URL(string: "https://api.github.com/users/\(userName)") else {
            // should not happen... but safer anyway
            DispatchQueue.main.async {
                completion(nil, "internal error")
            }
            return
        }
        
        var request = URLRequest(url:queryUrl)
        
        dataTask?.cancel()
        dataTask = defaultSession.dataTask(with: request) { data, response, error in
            // cleanup when we're done processing the request
            defer {
                self.dataTask = nil
            }
            if let error = error {
                DispatchQueue.main.async {
                    completion(nil, "DataTask error: \(error.localizedDescription)")
                }
            } else if let data = data,
                let response = response as? HTTPURLResponse,
                response.statusCode == 200 {
                do {
                    let githubUser = try parseGithubUser(data)
                    // we pass back, on the UI thread, the result of the query
                    DispatchQueue.main.async {
                        completion(githubUser, "")
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(nil, error.localizedDescription)
                    }
                }
            }
        }
        dataTask?.resume()
    }
    
    func download(downloadUrl: String, completion: @escaping QueryDownloadResult)
    {
        guard let queryUrl = URL(string: downloadUrl) else {
            DispatchQueue.main.async {
                completion(nil, "bad URL: \(downloadUrl)")
            }
            return
        }
        
        let request = URLRequest(url:queryUrl)
        
        let task = defaultSession.downloadTask(with: request) { (tempLocalUrl, response, error) in
            
            if let tempLocalUrl = tempLocalUrl, error == nil {
                if let statusCode = (response as? HTTPURLResponse)?.statusCode,
                    statusCode == 200 {
                    let rawImageData = NSData(contentsOf: tempLocalUrl)
                    completion(rawImageData!, nil)
                }
            } else {
                completion(nil, "Error downloading file: \(String(describing: error?.localizedDescription))")
            }
        }
        task.resume()
    }
    
    /*
    // parse the JSOn ersponse from the get repos call
    func parseResponse(_ data: Data) {
        var response: Any?
        repos.removeAll()
        
        // JSON parsing
        do {
            response = try JSONSerialization.jsonObject(with: data, options: [])
        } catch let parseError as NSError {
            errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
            return
        }
        
        // the top level element is an array of repos description
        if let array = response as? [Any] {
            // we parse all the items in the arrat
            for object in array {
                // retrieve each element as a dictionary and we grab the properties
                // we are interested in
                if let repoDictionary = object as? [String: Any],
                    let name = repoDictionary["name"] as? String,
                    let starsCount = repoDictionary["stargazers_count"] as? Int,
                    let watchersCount = repoDictionary["watchers_count"] as? Int,
                    let forksCount = repoDictionary["forks_count"] as? Int,
                    let openIssuesCount = repoDictionary["open_issues_count"] as? Int,
                    let description = repoDictionary["description"] as? String {
                    repos.append(Repo(name: name,
                                      description: description,
                                      starsCount: starsCount,
                                      forksCount: forksCount,
                                      openIssuesCount: openIssuesCount,
                                      watchersCount: watchersCount))
                    print ("Repo: \(name) : \(description) - \(starsCount)")
                } else {
                    errorMessage += "Problem parsing trackDictionary\n"
                }
            }
            
        }
        //        print(response!)
    }
 */
}

