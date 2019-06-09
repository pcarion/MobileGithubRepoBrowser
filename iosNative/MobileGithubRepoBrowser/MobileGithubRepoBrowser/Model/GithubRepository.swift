//
//  GithubRepository.swift
//  MobileGithubRepoBrowser
//
//  Created by Pierre Carion on 6/8/19.
//  Copyright © 2019 Pierre Carion. All rights reserved.
//

import Foundation

struct GithubRepoProperty {
    var name: String
    var value: String
}

class GithubRepository {
    
    let name: String
    var props:[GithubRepoProperty]
    
    init(name: String) {
        self.name = name;
        self.props = [];
        addProp(name: "name", value: name)
    }
    
    func addProp(name: String, value: Any?) {
        guard let value = value else {
            return
        }
        if let value = value as? String {
            props.append(GithubRepoProperty(name: name, value: value))
            return
        }
        if let value = value as? Int {
            props.append(GithubRepoProperty(name: name, value: String(value)))
            return
        }
        if let value = value as? Bool {
            props.append(GithubRepoProperty(name: name, value: String(value)))
            return
        }
        props.append(GithubRepoProperty(name: name, value: "_"))
    }
    
    func value(propName: String) -> String {
        if let found = props.first(where: { $0.name == propName }) {
            return found.value
        }
        return "?"
    }
    
}
