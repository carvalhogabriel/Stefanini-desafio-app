//
//  HeroApi.swift
//  Stefanini-desafio-app
//
//  Created by Mario C on 18/04/2018.
//  Copyright © 2018 gabrielcarvalho. All rights reserved.
//

import Foundation
import UIKit

public class HeroApi {
    
    public static let sharedInstance = HeroApi()
    
    lazy var dataSession: URLSession = {
        var config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.timeoutIntervalForRequest = 25
        config.timeoutIntervalForResource = ApiUtils.ApiConstants.TIME_OUT_INTERVAL_FOR_RESOURCE
        
        var delegate = DataRequestDelegate()
        
        var session = URLSession(configuration: config, delegate: delegate, delegateQueue: OperationQueue.main)
        
        return session
    }()
    
    public func getHeros() {
        
    }
    
}
