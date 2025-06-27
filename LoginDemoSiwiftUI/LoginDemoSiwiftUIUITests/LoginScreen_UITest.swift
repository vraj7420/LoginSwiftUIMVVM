//
//  LoginScreen_UITest.swift
//  LoginDemoSiwiftUIUITests
//
//  Created by MACM18 on 24/06/25.
//

import XCTest

final class LoginScreen_UITest: XCTestCase {
    
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        navigateToSignInScreen()
    }
    
    private func navigateToSignInScreen() {
        let signInButton = app.buttons["signInButton"]
        XCTAssertTrue(signInButton.waitForExistence(timeout: 3), "Sign In button not found")
        signInButton.tap()
    }
    
    func testUIElementsExist() {
        XCTAssertTrue(app.textFields["login_emailTextField"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.textFields["login_passwordTextField"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["login_signInButton"].waitForExistence(timeout: 3))
    }
    
    
    func testLoginWithValidCredentials() {
        let emailField = app.textFields["login_emailTextField"]
        let passwordField = app.textFields["login_passwordTextField"]
        let loginButton = app.buttons["login_signInButton"]
        
        emailField.tap()
        emailField.typeText("test@example.com")

        passwordField.tap()
        passwordField.typeText("Password123")
        loginButton.tap()
    }
    
    
    func testLoginErrorAlertWithInvalidCredentials() {
        let emailField = app.textFields["login_emailTextField"]
        let passwordField = app.textFields["login_passwordTextField"]
        let loginButton = app.buttons["login_signInButton"]
        
        emailField.tap()
        emailField.typeText("wrong@example.com")
        
        passwordField.tap()
        passwordField.typeText("Password123")
    
        loginButton.tap()
    }
}
