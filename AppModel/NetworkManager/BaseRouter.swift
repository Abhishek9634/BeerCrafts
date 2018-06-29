//
//  BaseRouter.swift
//  
//
//  Created by Abhishek on 29/06/18.
//  Copyright © 2018 NIckelFox. All rights reserved.
//

import Foundation

struct HTTPMethod {
    static let get = "GET"
    static let post = "POST"
    static let put = "PUT"
    static let delete = "DELETE"
}

enum BaseRouter {
    
    case getBeerList
    
    public var httpMethod: String {
        switch self {
        case .getBeerList:
            return HTTPMethod.get
        }
    }
    
    public var path: String {
        return "/beercraft"
    }
    
    public var params: [String: Any] {
        return [:]
    }
    
    public var baseUrl: URL {
        return URL(string: APIConfig.AppUrl.Base)!
    }
    
    public var headers: [String: String] {
        return ["Content-Type": "application/json"]
    }
}
