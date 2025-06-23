//
//  SignUp_Test.swift
//  LoginDemoSiwiftUITests
//
//  Created by Vraj on 20/06/25.
//

import XCTest
@testable import LoginDemoSiwiftUI

@MainActor
final class SignUp_Test: XCTestCase {

    var viewModel: SignUpViewModel!
     var mockNetworkManager: MockNetworkManager!

     override func setUp() {
         super.setUp()
         mockNetworkManager = MockNetworkManager()
         viewModel = SignUpViewModel(networkManager: mockNetworkManager)
     }

     override func tearDown() {
         viewModel = nil
         mockNetworkManager = nil
         super.tearDown()
     }

     func testValidateAll_WithEmptyFields_ShouldSetErrorMessages() {
         viewModel.emailAddress = ""
         viewModel.name = ""
         viewModel.password = ""

         let isValid = viewModel.validateAll()

         XCTAssertFalse(isValid)
         XCTAssertEqual(viewModel.errorEmailAddress, StringConsatnts.emailEmptyError)
         XCTAssertEqual(viewModel.errorName, StringConsatnts.invalidNameError)
         XCTAssertEqual(viewModel.errorPassword, StringConsatnts.passwordEmptyError)
     }

     func testValidateAll_WithValidFields_ShouldClearErrorMessages() {
         viewModel.emailAddress = "test@example.com"
         viewModel.name = "Test"
         viewModel.password = "Password123"

         let isValid = viewModel.validateAll()

         XCTAssertTrue(isValid)
         XCTAssertEqual(viewModel.errorEmailAddress, "")
         XCTAssertEqual(viewModel.errorName, "")
         XCTAssertEqual(viewModel.errorPassword, "")
     }

     func testButtonEnablement_WhenAllFieldsValid_ShouldEnableButton() {
         viewModel.emailAddress = "test@example.com"
         viewModel.name = "Test"
         viewModel.password = "Password123"

         let exp = expectation(description: "Enable button")
         DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
             XCTAssertTrue(self.viewModel.isEanbleButton)
             exp.fulfill()
         }

         wait(for: [exp], timeout: 1.0)
     }

     func testSignUp_WithSuccessResponse_ShouldNotShowErrorAlert() async {
         viewModel.emailAddress = "test@example.com"
         viewModel.name = "Test"
         viewModel.password = "Password123"

         await viewModel.signUp()

         XCTAssertFalse(viewModel.showErrorAlert)
         XCTAssertEqual(viewModel.signUPErrorTitle, "")
         XCTAssertEqual(viewModel.signUPErrorMessage, "")
     }

     func testSignUp_WithServerError_ShouldShowServerErrorAlert() async {
         let mock = MockNetworkManager()
         mock.shouldReturnError = true
         mock.mockError  = APIError.server(code: 400, message: "Invalid request")
          let viewModel = SignUpViewModel(networkManager: mock)
         viewModel.emailAddress = "test@example.com"
         viewModel.name = "Test"
         viewModel.password = "Password123"

         await viewModel.signUp()

         XCTAssertTrue(viewModel.showErrorAlert)
         XCTAssertEqual(viewModel.signUPErrorTitle, "\(StringConsatnts.serverError) 400:")
         XCTAssertEqual(viewModel.signUPErrorMessage, "Invalid request")
     }

     func testSignUp_WithUnknownError_ShouldShowUnexpectedError() async {
         let mock = MockNetworkManager()
         mock.shouldReturnError = true
         mock.mockError  = .unknown
         let viewModel = SignUpViewModel(networkManager: mock)

         viewModel.emailAddress = "test@example.com"
         viewModel.name = "Test"
         viewModel.password = "Password123"

         await viewModel.signUp()

         XCTAssertTrue(viewModel.showErrorAlert)
         XCTAssertEqual(viewModel.signUPErrorTitle, StringConsatnts.unexpectedError)
         XCTAssertEqual(viewModel.signUPErrorMessage, "Something went wrong")
     }
 }
