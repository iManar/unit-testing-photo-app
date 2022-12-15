//
//  SignUpError.swift
//  QuizApp
//
//  Created by Manar Magdy on 10/10/2022.
//

import Foundation


enum SignupError: LocalizedError, Equatable {
    case invalidEmail
    case invalidData
    case illegalCharactersFound
    case invalidResponseModel
    case invalidRequestUrlString
    case failedRequest(description: String)
    
    var errorDescription: String? {
        switch self {
        case .failedRequest(let description):
            return description
        case .invalidResponseModel,
                .invalidRequestUrlString,
                .illegalCharactersFound,
                .invalidEmail,
                .invalidData:
            return ""
        }
    }
   
}
