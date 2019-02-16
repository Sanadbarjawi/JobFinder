//
//  Configuration.swift
//  JobFinder
//
//  Created by Sanad  on 2/15/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//

import Foundation

// MARK: - Configurations
 struct Configuration {
    
    static var googlePlacesAPIKey: String {
        return "AIzaSyAXa3tGtUNvh2HlL7ZaA2E_32Zi8UG7n2Y"
    }
    static var searchGOVServerURL: String {
        return "https://jobs.search.gov/"
    }
    static var gitHubServerURL: String {
        return  "https://jobs.github.com/"
    }
}

// MARK: - Paths Handling
protocol Endpoint {
    var path: String { get }
}

enum URLPath {
    // jobs
    case searchGOVJobs
    case gitHubJobs
}

extension URLPath: Endpoint {
   
    var path: String {
        switch self {
        case .searchGOVJobs:
            return "\(Configuration.searchGOVServerURL)jobs/search.json?"
        case .gitHubJobs:
             return "\(Configuration.gitHubServerURL)positions.json?"
        }
    }
 

}
