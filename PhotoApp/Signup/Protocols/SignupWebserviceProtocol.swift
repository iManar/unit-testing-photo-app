//
//  SignupWebserviceProtocol.swift
//  QuizApp
//
//  Created by Manar Magdy on 10/10/2022.
//

import Foundation

protocol SignupWebserviceProtocol {
    func signup(withForm formModel: SignFormRequestModel, completionHandler: @escaping (SignFormResponseModel?, SignupError?) -> Void)
}
