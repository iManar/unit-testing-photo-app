//
//  SignupFormModelValidator.swift
//  QuizApp
//
//  Created by Manar Magdy on 10/10/2022.
//

import Foundation

class SignupFormModelValidator: SignupModelValidatorProtocol {
    
    private let invalidChars = CharacterSet(charactersIn: "{}$#%^&*!@,.?/")
    
    func isFirstNameValid(fName: String) -> Bool {
        var rValue = true
       
        if fName.rangeOfCharacter(from: invalidChars) != nil {
            rValue = false
//            throw SignupError.illegalCharactersFound
        }
        if fName.count < 2 || fName.count > 10 {
            rValue = false
        }
        
        return rValue
    }
    
    func isLastNameValid(fName: String) -> Bool {
        true
    }
    func isPasswordValid(psd: String) -> Bool {
        true
    }
    func isValidEmailFormat(fName: String) -> Bool {
        true
    }
    
    func doPasswordsMatch(psd: String, rptPsd: String) -> Bool {
        psd == rptPsd
    }
}
