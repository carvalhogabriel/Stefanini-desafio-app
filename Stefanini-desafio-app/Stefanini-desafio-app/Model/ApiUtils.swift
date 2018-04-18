//
//  ApiUtils.swift
//  Stefanini-desafio-app
//
//  Created by Gabriel Carvalho on 17/04/2018.
//  Copyright © 2018 gabrielcarvalho. All rights reserved.
//

import Foundation

public class ApiUtils {
    
    public struct ApiConstants {
        //url padrão
        static let API_URL = "https://gateway.marvel.com/v1/public/"
        //timeout da requisição
        static let TIME_OUT_INTERVAL_FOR_RESOURCE: TimeInterval = 300
        //keys geradas na criação da conta
        static let publicKey = "d6efd1b3ba55abf37a49cb163cdcfbb2"
        static let privateKey = "ed6facde3cad57e583e37235248cbdedd0eacc29"
    }
    
    static let sharedInstance = ApiUtils()
    
    //concatena a url padrão e a url da api q está sendo chamada
    func webserviceRequestBuilder(_ servicePath: String) -> URLRequest {
        let url = URL(string: ApiConstants.API_URL + servicePath)
        let request = URLRequest(url: url!)
        return request
    }
}

//extensao para tratar o retorno do json
extension Data {
    func parseJsonData() -> NSDictionary? {
        do {
            return try JSONSerialization.jsonObject(with: self, options:[]) as? NSDictionary
        } catch {
            print("Failed to parse json from response with error \(error)")
            return nil
        }
    }
    
    func parseJsonArrayData() -> [NSDictionary]? {
        do {
            return try JSONSerialization.jsonObject(with: self, options:[]) as? [NSDictionary]
        } catch {
            print("Failed to parse json from response with error \(error)")
            return nil
        }
    }
}

//extensao para transformar uma string em MD5
extension String {
    func md5(_ string: String) -> String {
        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
        var digest = Array<UInt8>(repeating:0, count:Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5_Init(context)
        CC_MD5_Update(context, string, CC_LONG(string.lengthOfBytes(using: String.Encoding.utf8)))
        CC_MD5_Final(&digest, context)
        context.deallocate()
        var hexString = ""
        for byte in digest {
            hexString += String(format:"%02x", byte)
        }
        return hexString
    }
}

//extensao para transformar uma data em miliseconds
extension Date {
    func getCurrentMilisecondsFromDate(dateToConvert: Date) -> String {
        let objDateformat: DateFormatter = DateFormatter()
        objDateformat.dateFormat = "yyyy-MM-dd"
        let strTime: String = objDateformat.string(from: dateToConvert)
        let objUTCDate: NSDate = objDateformat.date(from: strTime)! as NSDate
        let milliseconds: Int64 = Int64(objUTCDate.timeIntervalSince1970)
        let currentDate: String = "\(milliseconds)"
        return currentDate
    }
}
