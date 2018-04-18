//
//  Hero.swift
//  Stefanini-desafio-app
//
//  Created by School Picture Dev on 18/04/18.
//  Copyright © 2018 gabrielcarvalho. All rights reserved.
//

import Foundation

open class Hero: Codable {
    var name: String
    var description: String
    var thumbnail: String
    
    init(name: String?,
         description: String?,
         thumbnail: String?) {
        self.name = name ?? ""
        self.description = description ?? ""
        self.thumbnail = thumbnail ?? ""
    }
}
