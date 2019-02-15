//
//  Configuration.swift
//  JobFinder
//
//  Created by Sanad  on 2/15/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//

import Foundation

// MARK: - Configurations
private struct Configuration {
    static var searchGOVServerURL: String {
        return "https://jobs.search.gov/"
    }
    static var gitHubServerURL: String {
        return  "https://jobs.github.com/"
    }
}

// MARK: - Paths Handling
protocol Endpoint {
    var github: String { get }
    var searGOV: String { get }
}

enum URLPath {
    // jobs
    case jobs
}

extension URLPath: Endpoint {
    
    var searGOV: String {
        switch self {
        case .jobs:
            return "\(Configuration.searchGOVServerURL)jobs/search.json?"
        }
    }
    
    var github: String {
        switch self {
        case .jobs:
            return "\(Configuration.gitHubServerURL)positions.json?"
        }
    }

}
