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
    
    static var searchGOVServerURL: String {
        return Enviroment.configuration(.searchGovServerURL)
    }
    static var gitHubServerURL: String {
        return  Enviroment.configuration(.githubServerURL)
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
