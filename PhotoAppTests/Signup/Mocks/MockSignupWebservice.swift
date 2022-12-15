//
//  MockSignupWebservice.swift
//  QuizAppUnitTests
//
//  Created by Manar Magdy on 10/10/2022.
//

import Foundation
@testable import PhotoApp

class MockSignupWebservice: SignupWebserviceProtocol {
    
    var isSignupMethodCalled: Bool = false
    var shouldReturnError: Bool = false

    func signup(withForm formModel: SignFormRequestModel, completionHandler: @escaping (SignFormResponseModel?, SignupError?) -> Void) {
        
        isSignupMethodCalled = true
        
        if shouldReturnError {
            completionHandler(nil, SignupError.failedRequest(description: "Failed!"))
        } else {
            let response = SignFormResponseModel(status: "Ok")
            completionHandler(response, nil)
        }
    }
}
