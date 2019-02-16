//
//  JobService.swift
//  JobFinder
//
//  Created by Sanad  on 2/15/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//

import Foundation
class JobService {
    
    private var apiHelper = APIHelper()
    
    func getGitHubJobs(params: [String: Any], success: @escaping ([JobsModel]) -> Void, failure: @escaping (Error?) -> Void) {
        apiHelper.getRequest(endPoint: URLPath.gitHubJobs, parameters: params, headers: nil) { (data, error) in

            if error != nil {
                failure(error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "data not found ", code: -1, userInfo: nil)
                failure(error)
                return
            }
            
            do {
                let gitHubModel = try JSONDecoder().decode([JobsModel].self, from: data)
                success(gitHubModel)
            } catch {
                failure(error)
            }
            
        }
    }
    
    
    func getGOVSearchJobs(params: [String: Any], success: @escaping ([JobsModel]) -> Void, failure: @escaping (Error?) -> Void) {
        apiHelper.getRequest(endPoint: URLPath.searchGOVJobs, parameters: params, headers: nil) { (data, error) in
            
            if error != nil {
                failure(error)
                return
            }
            
            guard let data = data else {
                let error = NSError(domain: "data not found ", code: -1, userInfo: nil)
                failure(error)
                return
            }
            
            do {
                let govSearchModel = try JSONDecoder().decode([JobsModel].self, from: data)
                success(govSearchModel)
            } catch {
                failure(error)
            }
            
        }
    }
}

