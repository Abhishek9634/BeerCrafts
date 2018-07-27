//
//  Beer+API.swift
//  
//
//  Created by Abhishek Thapliyal on 29/06/18.
//  Copyright © 2018 Abhishek Thapliyal. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

public extension Beer {
    
    public static func getBeerList(completion: @escaping (_ beerList: [Beer], _ error: Error?) -> Void) {
        let router = BaseRouter.getBeerList
        let request = HTTPRequest.request(router: router)
        HTTPResponse.response(with: request) { (json, error) in
            if let json = json {
                do {
                    let list: [Beer] = try json.arrayValue.map { try Beer.parse($0) }
                    completion(list, nil)
                } catch {
                    print(error)
                    completion([], nil)
                }
            } else {
                completion([], error)
            }
        }
    }
}

// REQUEST OFFLINE
extension Beer {
    
    public static func getBeerListOffline(completion: @escaping (_ beerList: [Beer], _ error: Error?) -> Void) {
        
        guard let filePath = Bundle.main.url(forResource: "beer",
                                             withExtension: "json") else {
            completion([], AppError.fileNotFound)
            return
        }

        do {
            let data = try Data.init(contentsOf: filePath)
            let json = try JSON(data: data)
            let list: [Beer] = try json.arrayValue.map { try Beer.parse($0) }
            completion(list, nil)
        } catch {
            completion([], error)
        }
    }
}
