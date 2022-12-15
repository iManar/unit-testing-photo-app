//
//  SignupModelValidatorProtocol.swift
//  QuizApp
//
//  Created by Manar Magdy on 10/10/2022.
//

import Foundation


protocol SignupModelValidatorProtocol {
    func isFirstNameValid(fName: String) -> Bool
    func isLastNameValid(fName: String) -> Bool
    func isValidEmailFormat(fName: String) -> Bool
    func isPasswordValid(psd: String) -> Bool
    func doPasswordsMatch(psd: String, rptPsd: String) -> Bool
}
