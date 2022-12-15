//
//  SignupViewControllerTests.swift
//  QuizAppUnitTests
//
//  Created by Manar Magdy on 11/10/2022.
//

import XCTest
@testable import PhotoApp

class SignupViewControllerTests: XCTestCase {
    var sb: UIStoryboard!
    var sut: SignupViewController!
    var navigationController: UINavigationController!
    
    override func setUp() {
        sb = UIStoryboard(name: "Main", bundle: nil)
        sut = sb.instantiateViewController(identifier: "SignupViewController") as SignupViewController
        sut?.loadViewIfNeeded()
        navigationController = UINavigationController(rootViewController: sut)
    }

    override func tearDown() {
        sb = nil
        sut = nil
        navigationController = nil
    }

    func testSignupViewControllerTests_WhenCreated_HasRequiredTextFieldsEmpty() throws {
        
        // We should do that to all fields
        let lastNameTF = try XCTUnwrap(sut.lastNameTF, "Last name text field is not connected to an IBOutlet!")
        
        XCTAssertEqual(sut.firstNameTF.text, "")
        XCTAssertEqual(lastNameTF.text, "")
        XCTAssertEqual(sut.emailTF.text, "")
        XCTAssertEqual(sut.passwordTF.text, "")
        XCTAssertEqual(sut.repeatPasswordTF.text, "")
        
    }
    
    func testSignupViewControllerTests_WhenCreated_HasSignupButtonAndAction() throws {

        let signupButton: UIButton = try XCTUnwrap(sut.signupButton, "SignupButton does not have a referencing IBOutlet!")
        let btnActions = try XCTUnwrap(signupButton.actions(forTarget: sut, forControlEvent: .touchUpInside))

        XCTAssertEqual(btnActions.count, 1)
        XCTAssertEqual(btnActions.first, "signupTapped:")
        
    }

    
    func testSignupViewControllerTests_WhenSignupButtonTapped_InvokesSignupProcess() {
        
        // arrange
        let mockV = MockSignupModelValidator()
        let mockW = MockSignupWebservice()
        let mockD = MockSignupViewDelegate()
        let mockSignupPresenter = MockSignupPresenter(validator: mockV, service: mockW, delegate: mockD)
       
        sut.presenter = mockSignupPresenter
        
        // Act
        sut.signupButton.sendActions(for: .touchUpInside)
        
        // Assert
        XCTAssertTrue(mockSignupPresenter.processUserSignupCalled)
        
    }
    
    
    func testSignupViewControllerTests_WhenCreated_CheckOnTextFieldsCustomParams() throws {
        
        let emailTF = try XCTUnwrap(sut.emailTF)
        XCTAssertEqual(emailTF.textContentType, .emailAddress)
        XCTAssertEqual(emailTF.keyboardType, .emailAddress)
        
        let passwordTF = try XCTUnwrap(sut.passwordTF)
        XCTAssertTrue(passwordTF.isSecureTextEntry)
    }
    
    func testSignupViewControllerTests_WhenIsTapped_2ndVCIsPushed() {

//        let pushButton: UIButton = try XCTUnwrap(sut.pushButton, "SignupButton does not have a referencing IBOutlet!")
//        let btnActions = try XCTUnwrap(pushButton.actions(forTarget: sut, forControlEvent: .touchUpInside))
        
//        XCTAssertEqual(btnActions.count, 1)
//        XCTAssertEqual(btnActions.first, "pushButtonTapped:")

        let p = NSPredicate { input, _ in
            (input as? UINavigationController)?.topViewController is ViewController
        }
        expectation(for: p, evaluatedWith: navigationController)
        sut.pushButton.sendActions(for: .touchUpInside)
        waitForExpectations(timeout: 5.0)
    }
    
    
    func testSignupViewControllerTests_WhenIsTapped_2ndVCIsPushed_2() {
        sut.pushButton.sendActions(for: .touchUpInside)

        RunLoop.current.run(until: Date())
        
        guard let _ =  navigationController.topViewController as? ViewController else {
            XCTFail()
            return
        }
    }
    
    func testSignupViewControllerTests_WhenIsTapped_2ndVCIsPushed_3() {
        
        let spyVC = SpyNavigationController(rootViewController: sut)
        sut.pushButton.sendActions(for: .touchUpInside)
        
        guard let _ =  spyVC.pushedViewController as? ViewController else {
            XCTFail()
            return
        }
    }
    
        
        ///
//        XCTAssertThrowsError(try sut.isFirstNameValid("MANAR#"), "") { errorThrown in
//            XCTAssertEqual(errorThrown as? SignupError, SignupError.illegalCharactersFound)
//        }
        ///
//        XCTAssertNoThrow(try sut.isFirstNameValid("MANAR"))
        ///
//        do {
//            let _ = try sut.isFirstNameValid("MANAR#")
//            XCTFail("")
//        } catch SignupError.illegalCharactersFound {
//            // Success
//            return
//        } catch {
//            XCTFail("Another error thrown instead of illegalCharactersFound")
//            return
//        }
        ///
//        do {
//            let _ = try sut.isFirstNameValid("MANAR")
//        } catch {
//            XCTFail("Valid fName is provided shouldn't throw error")
//            return
//        }
    
}
