//
//  Networking.swift
//  JobFinder
//
//  Created by Sanad  on 2/15/19.
//  Copyright © 2019 SanadBarj. All rights reserved.
//

import Foundation
import Alamofire

typealias NetworkingCompletionHandler = (Data?, Swift.Error?) -> Void

protocol Networking {
    
    func getRequest(endPoint: Endpoint, parameters: Parameters?, headers: HTTPHeaders?, queryItems: [URLQueryItem]?, callback: @escaping NetworkingCompletionHandler)
}

extension Networking {
    // MARK :- main request
    private func request(method: HTTPMethod, endPoint: Endpoint, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, queryItems: [URLQueryItem]? = nil,callback: @escaping NetworkingCompletionHandler) {
        
        guard var urlComp = URLComponents(string: endPoint.path) else { return }
        urlComp.queryItems = queryItems
        guard let url = urlComp.url else {return}
        
        Alamofire.request(url, method: method, parameters: parameters, headers: headers).validate(statusCode: 200...299)
            .responseData { resposne in
                
                callback(resposne.data, resposne.error)
        }
    }
    
    // MARK :- get request
    func getRequest(endPoint: Endpoint, parameters: Parameters? = nil, headers: HTTPHeaders? = nil, queryItems: [URLQueryItem]? = nil, callback: @escaping NetworkingCompletionHandler) {
        
        request(method: .get, endPoint: endPoint, parameters: parameters, headers: headers, queryItems: queryItems, callback: callback)
    }
    
}

struct APIHelper: Networking { }
