//
//  SignupFlowUITests.swift
//  PhotoAppUITests
//
//  Created by Manar Magdy on 11/10/2022.
//

import XCTest

class SignupFlowUITests: XCTestCase {

    private var app: XCUIApplication!
    private var fname: XCUIElement!
    private var lname: XCUIElement!
    private var mail: XCUIElement!
    private var psd: XCUIElement!
    private var rpsd: XCUIElement!
    private var btn: XCUIElement!
    
    override func setUpWithError() throws {
    
        try super.setUpWithError()
        
        app = XCUIApplication()
        app.launchArguments = ["-skipSurvey", "-debugServer"]
        app.launchEnvironment = ["signupUrl": "https://stackoverflow.com",
                                 "inAppPurchasesEnabled": "true",
                                 "inAppAdsEnabled": "true"]
        app.launch()
        
        fname = app.textFields["fNameTF"]
        lname = app.textFields["lNameTF"]
        mail = app.textFields["emailTF"]
        psd = app.secureTextFields["psdTF"]
        rpsd = app.secureTextFields["rPsdTF"]
        btn = app.buttons["signupBtn"]
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        app = nil
        fname = nil
        lname = nil
        mail = nil
        psd = nil
        rpsd = nil
        btn = nil
        try super.tearDownWithError()
    }

    func testSignupFlowUITests_WhenViewIsLoaded_AllFieldsAreEnabled() throws {
        
        XCTAssertTrue(fname.isEnabled)
        XCTAssertTrue(lname.isEnabled)
        XCTAssertTrue(mail.isEnabled)
        XCTAssertTrue(psd.isEnabled)
        XCTAssertTrue(rpsd.isEnabled)
        XCTAssertTrue(btn.isEnabled)
    }

    
    func testSignupFlowUITests_WhenInvalidDataSubmitted_DisplayErrorAlertDialog() throws {
        // Arrange

        fname.tap()
        fname.typeText("M")
        
        lname.tap()
        lname.typeText("G")
        
        mail.tap()
        mail.typeText("@")
        
        psd.tap()
        psd.typeText("123456")

        rpsd.tap()
        rpsd.typeText("1234")
                
        // Act
        btn.tap()

//        let screenshot = mail.screenshot()
//        let attach = XCTAttachment(screenshot: screenshot)
//        attach.name = "email.screenshot"
//        attach.lifetime = .keepAlways
//        add(attach)
        
        
//       - let currentAppWindow = app.screenshot()
//       - let currentAppWindow = XCUIScreen.main.screenshot()
//        let currentAppWindowAttach = XCTAttachment(screenshot: currentAppWindow)
//        currentAppWindowAttach.name = "app.currentWindow.screenshot"
//        currentAppWindowAttach.lifetime = .keepAlways
//        add(currentAppWindowAttach)
        
        // Assert
        XCTAssertTrue(app.alerts["errorAlertDialog"].waitForExistence(timeout: 1))
    }

    
    func testSignupFlowUITests_WhenValidDataSubmitted_DisplaySuccessAlertDialog() throws {
        // Arrange

        fname.tap()
        fname.typeText("Manar")
        
        lname.tap()
        lname.typeText("Magdy")
        
        mail.tap()
        mail.typeText("test@test.com")
        
        psd.tap()
        psd.typeText("12345678")

        rpsd.tap()
        rpsd.typeText("12345678")
                
        // Act
        btn.tap()

        // Assert
        XCTAssertTrue(app.alerts["successAlertDialog"].waitForExistence(timeout: 5))
    }
    
    
    func testSignupFlowUITests_WhenPushNewVC() throws {
        // Arrange
        app.buttons["pushBtn"].tap()
        XCTAssertTrue(app.otherElements["2ndVC"].waitForExistence(timeout: 1.5))
        
    }
    
    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
