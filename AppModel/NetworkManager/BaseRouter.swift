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
    
    case sendData(deviceId: String, readings: [Any])
    case getUser(deviceId: String)
    
    public var httpMethod: String {
        switch self {
        case .sendData:
            return HTTPMethod.put
        case .getUser:
            return HTTPMethod.get
        }
    }
    
    public var path: String {
        return ""
    }
    
    public var params: [String: Any] {
        var param: [String: Any] = [:]
        return param
    }
    
    public var baseUrl: URL {
        return URL(string: APIConfig.AppUrl.Base)!
    }
    
    public var headers: [String: String] {
        var headers = ["Content-Type": "application/json"]
        return headers
    }
}
