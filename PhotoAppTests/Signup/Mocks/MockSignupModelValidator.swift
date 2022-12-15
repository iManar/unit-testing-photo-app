//
//  MockSignupModelValidator.swift
//  QuizAppUnitTests
//
//  Created by Manar Magdy on 10/10/2022.
//

import XCTest
@testable import PhotoApp

class MockSignupModelValidator: SignupModelValidatorProtocol {
    var isFirstNameValidated: Bool = false
    var isLastNameValidated: Bool = false
    var isEmailValidated: Bool = false
    var isPasswordValidated: Bool = false
    var isPasswordEqualityValidated: Bool = false
    
    func isFirstNameValid(fName: String) -> Bool {
        isFirstNameValidated = true
        return isFirstNameValidated
    }
    
    func isLastNameValid(fName: String) -> Bool {
        isLastNameValidated = true
        return isLastNameValidated
    }
    
    func isValidEmailFormat(fName: String) -> Bool {
        isEmailValidated = true
        return isEmailValidated
    }
    
    func isPasswordValid(psd: String) -> Bool {
        isPasswordValidated = true
        return isPasswordValidated
    }
    
    func doPasswordsMatch(psd: String, rptPsd: String) -> Bool {
        isPasswordEqualityValidated = true
        return isPasswordEqualityValidated
    }
}
