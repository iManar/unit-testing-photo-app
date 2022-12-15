//
//  SignupFormModelValidatorTests.swift
//  QuizAppUnitTests
//
//  Created by Manar Magdy on 10/10/2022.
//


import XCTest
@testable import PhotoApp

class SignupFormModelValidatorTests: XCTestCase {
    
    var sform: SignupFormModelValidator!
    
    override func setUp() {
        // arrange
        sform = SignupFormModelValidator()
    }
    
    override func tearDown() {
        sform = nil
    }
    

    func testSignupFormModelValidattor_whenValidFirstNameProvided_ShouldReturnTrue() {
        let isValid = sform.isFirstNameValid(fName: "Manar")
        //assert
        XCTAssertTrue(isValid)
    }
    
    func testSignupFormModelValidattor_whenTooShortFNameProvided_ShouldReturnFalse() {
        let isInvalid = sform.isFirstNameValid(fName: "M")
        //assert
        XCTAssertFalse(isInvalid)
    }
    
    func testSignupFormModelValidattor_whenTooLongFNameProvided_ShouldReturnFalse() {
        let isInvalid = sform.isFirstNameValid(fName: "ManarMagdyMorsy")
        //assert
        XCTAssertFalse(isInvalid)
    }
    
    func testSignupFormModelValidattor_doPasswordsMatch_ShouldReturnTrue() {
        let isValid = sform.doPasswordsMatch(psd: "1234567890", rptPsd: "1234567890")
        //assert
        XCTAssertTrue(isValid)
    }
    
    func testSignupFormModelValidattor_doPasswordsNotMatch_ShouldReturnFalse() {
        let isInvalid = sform.doPasswordsMatch(psd: "1234567890", rptPsd: "1567890")
        //assert
        XCTAssertFalse(isInvalid)
    }
}
