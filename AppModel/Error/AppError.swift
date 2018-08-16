//
//  AppError.swift
//  AppModel
//
//  Created by Abhishek on 27/07/18.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import Foundation

enum AppError: Error {
    
    case fileNotFound
    case custom(message: String)
    
    var ErrorMessage: String {
        switch self {
        case .fileNotFound:
            return "File Not Found"
        case .custom(let message):
            return message
        }
    }
}
