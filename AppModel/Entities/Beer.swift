//
//  Beer.swift
//  AppModel
//
//  Created by Abhishek on 29/06/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import Foundation
import JSONParsing

public final class Beer: JSONParseable {
    
    public var abv: String
    public var ibu: String
    public var id: Int
    public var name: String
    public var style: String
    public var ounces: Int
    
    init(abv: String,
         ibu: String,
         id: Int,
         name: String,
         style: String,
         ounces: Int) {
        self.abv = abv
        self.ibu = ibu
        self.id = id
        self.name = name
        self.style = style
        self.ounces = ounces
    }
    
    public static func parse(_ json: JSON) throws -> Beer {
        return try Beer(abv: json["abv"]^,
                        ibu: json["ibu"]^,
                        id: json["id"]^,
                        name: json["name"]^,
                        style: json["style"]^,
                        ounces: json["ounces"]^)
    }
}
