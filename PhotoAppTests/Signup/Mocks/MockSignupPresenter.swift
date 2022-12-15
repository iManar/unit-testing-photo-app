//
//  MockSignupPresenter.swift
//  QuizAppUnitTests
//
//  Created by Manar Magdy on 11/10/2022.
//

import Foundation
@testable import PhotoApp

class MockSignupPresenter: SignupPresenterProtocol {

    var processUserSignupCalled: Bool = false
    
    required init(validator: SignupModelValidatorProtocol, service: SignupWebserviceProtocol, delegate: SignupViewDelegateProtocol) {
        
    }
    
    func processUserSignup(with form: SignupFormModel) {
        processUserSignupCalled = true
    }
    
}
