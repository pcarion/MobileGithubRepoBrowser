//
//  AppError.swift
//  MobileGithubRepoBrowser
//
//  Created by Pierre Carion on 6/7/19.
//  Copyright © 2019 Pierre Carion. All rights reserved.
//

import Foundation

enum AppError: LocalizedError {
    case invalidJsonResponse(String)
    case badJsonData
    
    var errorDescription: String? {
        switch self {
        case .invalidJsonResponse(let cause):
            return NSLocalizedString(
                "Error parsing the JSON response: \(cause)",
                comment: ""
            )
        case .badJsonData:
            return NSLocalizedString(
                "Error extracting data from the JSON response",
                comment: ""
            )

        }
    }
}
