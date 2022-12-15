//
//  SignupViewDelegateProtocol.swift
//  QuizApp
//
//  Created by Manar Magdy on 10/10/2022.
//

import Foundation


protocol SignupViewDelegateProtocol: AnyObject {
    func successfulSignup()
    func errorHandler(error: SignupError)
}
