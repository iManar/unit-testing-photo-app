//
//  SignupWebserviceTests.swift
//  QuizAppUnitTests
//
//  Created by Manar Magdy on 10/10/2022.
//

import XCTest
@testable import PhotoApp

class SignupWebserviceTests: XCTestCase {
    
    // sut = system under test
    var sut: SignupWebservice!
    var signFormModel: SignFormRequestModel!
    
    override func setUp() {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession(configuration: config)
   
        sut = SignupWebservice(urlString: SignupConstants.signupUrlString, urlSession: urlSession)
        signFormModel = SignFormRequestModel(firstName: "Manar", lastName: "Magdy", email: "imanarmagdy@gmailc.om", password: "234567890")
        
    }

    override func tearDown() {
        sut = nil
        signFormModel = nil
        MockURLProtocol.stubReponseData = nil
        MockURLProtocol.error = nil
    }
    

    func testSignupWebservice_WhenGivenSuccessfulResponse_ReturnsSuccess() {
        // Arrange
        let jsonString = "{\"status\":\"ok\"}"
        MockURLProtocol.stubReponseData = jsonString.data(using: .utf8)

        let expectation = self.expectation(description: "testSignupWebservice_WhenGivedSuccessfulResponse_ReturnsSuccess")
        
        // Act
        sut.signup(withForm: signFormModel) { (responseModel, error) in
            
            // Assert
            XCTAssertEqual(responseModel?.status, "ok")
            expectation.fulfill()
            
        }
        self.wait(for: [expectation], timeout: 5.0)
    }

    
    
    func testSignupWebservice_WhenReceivedDifferentJSONResponse_ErrorToolPlace() {
        // Arrange
        let jsonString = "{\"path\":\"/users\", \"error\": \"InternalServer Error\"}"
        MockURLProtocol.stubReponseData = jsonString.data(using: .utf8)

        let expectation = self.expectation(description: "testSignupWebservice_WhenReceivedDifferentJSONResponse_ErrorToolPlace")
        
        // Act
        sut.signup(withForm: signFormModel) { (responseModel, error) in
            
            // Assert
            XCTAssertNil(responseModel)
            XCTAssertEqual(error, SignupError.invalidResponseModel)
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 5.0)
    }

    
    
    func testSignupWebservice_WhenEmptyURLStringProvided_ReturnError() {
        // Arrange
        sut = SignupWebservice(urlString: "")
        let expectation = self.expectation(description: "testSignupWebservice_WhenEmptyURLStringProvided_ReturnError")
        
        // Act
        sut.signup(withForm: signFormModel) { (responseModel, error) in
            
            // Assert
            XCTAssertNil(responseModel)
            XCTAssertEqual(error, SignupError.invalidRequestUrlString)
            expectation.fulfill()
        }
        self.wait(for: [expectation], timeout: 2.0)
    }
    
    
    
    func testSignupWebservice_WhenURLRequestFails_ReturnErrorMessageDescription() {
        // Arrange
        let errorDescription = "A localized error description"
        MockURLProtocol.error = SignupError.failedRequest(description: errorDescription)

        let expectation = self.expectation(description: "testSignupWebservice_WhenURLRequestFails_ReturnErrorMessageDescription")
        
        // Act
        sut.signup(withForm: signFormModel) { (responseModel, error) in
            
            // Assert
            XCTAssertNil(responseModel)
            XCTAssertNotEqual(error, SignupError.failedRequest(description: errorDescription))
            expectation.fulfill()
        }
        
        self.wait(for: [expectation], timeout: 2.0)
    }
}
