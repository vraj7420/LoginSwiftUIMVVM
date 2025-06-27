//
//  SignUpScreen_UITest.swift
//  LoginDemoSiwiftUIUITests
//
//  Created by MACM18 on 25/06/25.
//

import XCTest

final class SignUpScreen_UITest: XCTestCase {

    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
        navigateToSignUpScreen()
    }
    
    private func navigateToSignUpScreen() {
        let signUpButton = app.buttons["signUpButton"]
        XCTAssertTrue(signUpButton.waitForExistence(timeout: 3), "Sign Up button not found")
        signUpButton.tap()
    }
    
    func testUIElementsExist() {
        XCTAssertTrue(app.textFields["signup_emailTextField"].waitForExistence(timeout: 3), "Email text field not found")
        XCTAssertTrue(app.textFields["signup_nameTextField"].waitForExistence(timeout: 3), "Name text field not found")
        XCTAssertTrue(app.textFields["signup_passwordTextField"].waitForExistence(timeout: 3), "Password text field not found")
        XCTAssertTrue(app.buttons["signup_signUpButton"].waitForExistence(timeout: 3), "Sign Up button not found")
    }
    
    func testSignUpWithInvalidCredentials() {
        let emailField = app.textFields["signup_emailTextField"]
        let nameField = app.textFields["signup_nameTextField"]
        let passwordField = app.textFields["signup_passwordTextField"]
        emailField.tap()
        emailField.typeText("invalid-email")
        nameField.tap()
        nameField.typeText("")
        passwordField.tap()
        passwordField.typeText("123")
    }
    
    func testSignUpWithValidCredentials() {
        let emailField = app.textFields["signup_emailTextField"]
        let nameField = app.textFields["signup_nameTextField"]
        let passwordField = app.textFields["signup_passwordTextField"]
        let signUpButton = app.buttons["signup_signUpButton"]
        emailField.tap()
        emailField.typeText("test@gmail.com")
        nameField.tap()
        nameField.typeText("Test")
        passwordField.tap()
        passwordField.typeText("Password123")
        signUpButton.tap()
    }
    
    
    func testSocialLoginButtonsExist() {
        XCTAssertTrue(app.buttons["signup_facebookButton"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["signup_twitterButton"].waitForExistence(timeout: 3))
        XCTAssertTrue(app.buttons["signup_googleButton"].waitForExistence(timeout: 3))
    }
}
