//
//  GitHubJobModel.swift
//  JobFinder
//
//  Created by Sanad  on 2/15/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//

import Foundation
class GitHubJobModel: Codable {
    
    var companyLogo: String? //(if available).
    var jobTitle: String?
    var companyName: String?
    var location: String?
    var postDate: String? //(Format: dd/MM/yyyy)
    var jobDetailsURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case jobTitle = "title"
        case companyName = "company"
        case location = "location"
        case postDate = "created_at"
        case companyLogo = "company_logo"
        case jobDetailsURL = "url"
    }

}
