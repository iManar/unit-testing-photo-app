//
//  SignupPresenterTests.swift
//  QuizAppUnitTests
//
//  Created by Manar Magdy on 10/10/2022.
//

import XCTest
@testable import PhotoApp

class SignupPresenterTests: XCTestCase {
    
    var signupFormModel: SignupFormModel!
    var mockValidator: MockSignupModelValidator!
    var mockSignupWebservice: MockSignupWebservice!
    var mockSignupViewDelegate: MockSignupViewDelegate!
    var sut: SignupPresenter!
    
    override func setUp() {
        signupFormModel = SignupFormModel(firstName: "Sergey Manar", lastName: "Magdy", email: "test@test.com", password: "1234567890", repeatPassword: "1234567890")
        mockValidator = MockSignupModelValidator()
        mockSignupWebservice = MockSignupWebservice()
        mockSignupViewDelegate = MockSignupViewDelegate()

        sut = SignupPresenter(validator: mockValidator,
                              service: mockSignupWebservice,
                              delegate: mockSignupViewDelegate)
    }
    
    override func tearDown() {
        signupFormModel = nil
        mockValidator = nil
        mockSignupWebservice = nil
        mockSignupViewDelegate = nil
        sut = nil
    }
    
    func testSignupPresenter_WhenInformationProvided_WillValidateEachProperty() {
        // Arrange
        // Act
        sut.processUserSignup(with: signupFormModel)
        
        // Assert
        XCTAssertTrue(mockValidator.isFirstNameValidated)
        XCTAssertTrue(mockValidator.isLastNameValidated)
        XCTAssertTrue(mockValidator.isEmailValidated)
        XCTAssertTrue(mockValidator.isPasswordValidated)
        XCTAssertTrue(mockValidator.isPasswordEqualityValidated)
    }
    
    
    func testSignupPresenter_WhenGivenValidFormModel_ShouldCallSignupMethod() {
        // Arrange
        // Act
        sut.processUserSignup(with: signupFormModel)
        
        // Assert
        XCTAssertTrue(mockSignupWebservice.isSignupMethodCalled)
        XCTAssertEqual(mockSignupViewDelegate.count, 1)
    }
    
    func testSignupPresenter_WhenSignupOperationSuccessful_ShouldCallSuccessOnViewDelegate() {
        // Arrange
        let expectation = expectation(description: "testSignupPresenter_WhenSignupOperationSuccessful_ShouldCallSuccessOnViewDelegate")
        mockSignupViewDelegate.expectation = expectation
        
        // Act
        sut.processUserSignup(with: signupFormModel)
        self.wait(for: [expectation], timeout: 5.0)
        
        // Assert
        XCTAssertTrue(mockSignupWebservice.isSignupMethodCalled)
    }

    
    func testSignupPresenter_WhenSignupOperationFails_ShouldCallErrorOnViewDelegate() {
        // Arrange
        let expectation = expectation(description: "testSignupPresenter_WhenSignupOperationFails_ShouldCallErrorOnViewDelegate")
        mockSignupViewDelegate.expectation = expectation
        mockSignupWebservice.shouldReturnError = true
        // Act
        sut.processUserSignup(with: signupFormModel)
        self.wait(for: [expectation], timeout: 5.0)
        
        // Assert
        XCTAssertEqual(mockSignupViewDelegate.count, 0)
        XCTAssertEqual(mockSignupViewDelegate.errorCount, 1)
        XCTAssertNotNil(mockSignupViewDelegate.signupError)
    }
}
