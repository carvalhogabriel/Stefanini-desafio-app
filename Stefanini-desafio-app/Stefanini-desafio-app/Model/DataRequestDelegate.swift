//
//  DataRequestDelegate.swift
//  Stefanini-desafio-app
//
//  Created by Mario C on 18/04/2018.
//  Copyright © 2018 gabrielcarvalho. All rights reserved.
//

import Foundation


class DataRequestDelegate: NSObject, URLSessionDelegate, URLSessionTaskDelegate, URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        print("\(challenge.debugDescription)")
        print("\(String(describing: challenge.error))")
        print("\(String(describing: challenge.failureResponse))")
        print("\(String(describing: challenge.proposedCredential))")
        completionHandler(Foundation.URLSession.AuthChallengeDisposition.performDefaultHandling, nil)
    }
}
