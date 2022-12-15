//
//  SignupPresenterProtocol.swift
//  QuizApp
//
//  Created by Manar Magdy on 11/10/2022.
//

import Foundation

protocol SignupPresenterProtocol: AnyObject {
    
    init(validator: SignupModelValidatorProtocol, service: SignupWebserviceProtocol, delegate: SignupViewDelegateProtocol)
    func processUserSignup(with form: SignupFormModel)
    
}
