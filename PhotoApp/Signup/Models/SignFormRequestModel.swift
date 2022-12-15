//
//  SignFormRequestModel.swift
//  QuizApp
//
//  Created by Manar Magdy on 10/10/2022.
//

import Foundation

struct SignFormRequestModel: Encodable {
    let firstName: String
    let lastName: String
    let email: String
    let password: String
}
