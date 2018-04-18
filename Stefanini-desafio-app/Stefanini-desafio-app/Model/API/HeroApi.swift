//
//  HeroApi.swift
//  Stefanini-desafio-app
//
//  Created by Mario C on 18/04/2018.
//  Copyright © 2018 gabrielcarvalho. All rights reserved.
//

import UIKit
import Foundation

open class HeroApi {
    
    open static let sharedInstance = HeroApi()
    
    //criando a sessao da requisicao
    lazy var dataSession: URLSession = {
        var config = URLSessionConfiguration.default
        config.allowsCellularAccess = true
        config.timeoutIntervalForRequest = 25
        config.timeoutIntervalForResource = ApiUtils.ApiConstants.TIME_OUT_INTERVAL_FOR_RESOURCE
        
        var delegate = DataRequestDelegate()
        
        var session = URLSession(configuration: config, delegate: delegate, delegateQueue: OperationQueue.main)
        
        return session
    }()
    
    //função para trazer os herois
    open func getHeros(callback: @escaping(_ hero: [Hero]?, _ error: NSError?) -> Void) {
        //pegar a data atual para transformar em miliseconds
        let currentDate = Date()
        let currentDateInMs = currentDate.getCurrentMilisecondsFromDate(dateToConvert: currentDate)
        //criando o hash da requisição
        let stringToMd5 = String()
        let md5 = stringToMd5.md5("\(currentDateInMs)\(ApiUtils.ApiConstants.privateKey)\(ApiUtils.ApiConstants.publicKey)")
        //criando a requisição
        var request = ApiUtils.sharedInstance.webserviceRequestBuilder("characters?ts=\(currentDateInMs)&apikey=\(ApiUtils.ApiConstants.publicKey)&hash=\(md5)")
        request.httpMethod = "GET"
        
        let task = dataSession.dataTask(with: request as URLRequest, completionHandler: {
            data, response, responseError in
            //verifica a resposta http
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                //caso for 200 (OK) transforma o json e instancia o Objeto Heroi
                case 200:
                    guard let json = data?.parseJsonData() else {
                        //caso não conseguir transformar o json em objeto retorna erro
                        print("Failed to parse json")
                        callback(nil, NSError(domain: "webeleven", code: 0, userInfo: ["Generic Error": "0"]))
                        return
                    }
                    //pegando a parte de resultados do json
                    if let dataOfJson = json["data"] as? NSDictionary {
                        //criando uma lista de herois
                        var hero = [Hero]()
                        var thumbnail = String()
                        if let resultsDictionary = dataOfJson["results"] as? [NSDictionary] {
                            for r in resultsDictionary {
                                if let heroImageDictionary = r["thumbnail"] as? NSDictionary {
                                    //concatena a url para baixar imagem
                                    thumbnail = "\(String(describing: heroImageDictionary["path"] as! String)).\(String(describing: heroImageDictionary["extension"] as! String))"
                                }
                                //adicionar na lista de herois
                                hero.append(Hero.init(name: r["name"] as? String,
                                                      description: r["description"] as? String,
                                                      thumbnail: thumbnail))
                            }
                        }
                        //retorna lista de herois caso não existir nenhum erro
                        callback(hero, nil)
                    }
                default:
                    //caso nao retorno 200 retorna um erro
                    print("Failed to get heros")
                    callback(nil, NSError(domain: "webeleven", code: 0, userInfo: ["Generic Error": "0"]))
                }
            }
        })
        task.resume()
    }
}
