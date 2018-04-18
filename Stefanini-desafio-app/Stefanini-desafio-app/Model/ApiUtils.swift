//
//  ApiUtils.swift
//  Stefanini-desafio-app
//
//  Created by Mario C on 17/04/2018.
//  Copyright © 2018 gabrielcarvalho. All rights reserved.
//

import Foundation

public class ApiUtils {
    
    public struct ApiConstants {
        static let API_URL = "https://gateway.marvel.com"
        static let TIME_OUT_INTERVAL_FOR_RESOURCE: TimeInterval = 300
    }
    
    static let sharedInstance = ApiUtils()
    
    func webserviceRequestBuilder(_ servicePath: String) -> URLRequest {
        let url = URL(string: ApiConstants.API_URL + servicePath)
        let request = URLRequest(url: url!)
        return request
    }
}
