//
//  MockSignupViewDelegate.swift
//  QuizAppUnitTests
//
//  Created by Manar Magdy on 10/10/2022.
//

import Foundation
import XCTest
@testable import PhotoApp

class MockSignupViewDelegate: SignupViewDelegateProtocol {
    
    var expectation: XCTestExpectation?
    var signupError: SignupError?
    var errorCount = 0
    var count = 0
    
    
    func successfulSignup() {
        count += 1
        expectation?.fulfill()
    }
    
    func errorHandler(error: SignupError) {
        errorCount += 1
        signupError = error
        expectation?.fulfill()
    }
}
