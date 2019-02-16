//
//  GitHubJobModel.swift
//  JobFinder
//
//  Created by Sanad  on 2/15/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//

import Foundation

class JobsModel: Codable {
    
    var companyLogo: String? 
    var jobTitle: String?
    var companyName: String?
    var location: [String]?
    var postDate: String?
    var jobDetailsURL: String?
    
    
    required init(from decoder: Decoder) throws {

        location = [String]()
        let container1 = try decoder.container(keyedBy: GitHubCodingKeys.self)
        let container2 = try decoder.container(keyedBy: GovSearchCodingKeys.self)

        do {
            
            companyLogo = try? container1.decode(String.self, forKey: .companyLogo)
            location?.append(try container1.decode(String.self, forKey: .location))
            jobTitle = try container1.decode(String.self, forKey: .jobTitle)
            companyName = try container1.decode(String.self, forKey: .companyName)
            postDate = try container1.decode(String.self, forKey: .postDate).string(toFormat: "dd/MM/yyyy", fromFormat: "E MMM d HH:mm:ss Z yy")
            jobDetailsURL = try container1.decode(String.self, forKey: .jobDetailsURL)
        } catch {
            companyName = try container2.decode(String.self, forKey: .organizationName)
            jobTitle = try container2.decode(String.self, forKey: .positionTitle)
            location = try container2.decode([String].self, forKey: .locations)
            postDate = try container2.decode(String.self, forKey: .startDate).string(toFormat: "dd/MM/yyyy", fromFormat: "yyyy-MM-dd")
            jobDetailsURL = try container2.decode(String.self, forKey: .url)
        }
    }
    
    private enum GitHubCodingKeys: String, CodingKey {
        case jobTitle = "title"
        case companyName = "company"
        case location = "location"
        case postDate = "created_at"
        case companyLogo = "company_logo"
        case jobDetailsURL = "url"
    }
    
   private enum GovSearchCodingKeys: String, CodingKey {
        case positionTitle = "position_title"
        case organizationName = "organization_name"
        case startDate = "start_date"
        case locations, url
    }
    
    
}
