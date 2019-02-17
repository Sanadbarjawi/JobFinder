//
//  Enviroment.swift
//  JobFinder
//
//  Created by Sanad  on 2/17/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//


import Foundation

    // MARK: - Keys
        public enum Plist {
            
            case googleAPIKey
            case searchGovServerURL
            case githubServerURL
            
            func value() -> String {
                switch self {
                case .googleAPIKey:
                    return "GOOGLE_PLACES_API_KEY"
                case .searchGovServerURL:
                    return "SEARCH_GOV_SERVER_URL"
                case .githubServerURL:
                    return "GIT_HUB_SERVER_URL"
                }
               
            }
    }


public struct Enviroment {
    // MARK: - Plist
    fileprivate static var infoDictionary: [String: Any] {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return dict
    }
    
    public static func configuration(_ key: Plist) -> String {
        guard let pListStringValue = infoDictionary[key.value()] as? String else {return ""}
        return pListStringValue
    }
}
