//
//  LogIn_Test.swift
//  LoginDemoSiwiftUITests
//
//  Created by Vraj on 20/06/25.
//

import XCTest
@testable import LoginDemoSiwiftUI

@MainActor
final class LogInViewModel_ValidationTests: XCTestCase {

    var viewModel: LogInViewModal!
    var mockNetworkManager:MockNetworkManager = MockNetworkManager()

    override func setUp() {
        viewModel = LogInViewModal(networkManager: mockNetworkManager)
    }

    func testValidateAll_WhenEmailAndPasswordAreEmpty_ShouldShowEmptyErrors() {
        viewModel.emailAddress = ""
        viewModel.password = ""

        let result = viewModel.validateAll()

        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorEmailAddress, StringConsatnts.emailEmptyError)
        XCTAssertEqual(viewModel.errorPassword, StringConsatnts.passwordEmptyError)
    }

    func testValidateAll_WhenEmailIsInvalid_ShouldShowInvalidEmailError() {
        viewModel.emailAddress = "wrong"
        viewModel.password = "Valid123"

        let result = viewModel.validateAll()

        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorEmailAddress, StringConsatnts.invalidEmailError)
        XCTAssertEqual(viewModel.errorPassword, "")
    }

    func testValidateAll_WhenPasswordIsInvalid_ShouldShowInvalidPasswordError() {
        viewModel.emailAddress = "test@email.com"
        viewModel.password = "123" // too short or missing rules

        let result = viewModel.validateAll()

        XCTAssertFalse(result)
        XCTAssertEqual(viewModel.errorEmailAddress, "")
        XCTAssertEqual(viewModel.errorPassword, StringConsatnts.invalidPasswordError)
    }

    func testValidateAll_WhenEmailAndPasswordAreValid_ShouldPass() {
        viewModel.emailAddress = "test23@email.com"
        viewModel.password = "Valid123"

        let result = viewModel.validateAll()

        XCTAssertTrue(result)
        XCTAssertEqual(viewModel.errorEmailAddress, "")
        XCTAssertEqual(viewModel.errorPassword, "")
    }

    func testCombineValidationPublisher_ShouldSetIsEnableButtonCorrectly() {
        let expectation = XCTestExpectation(description: "Wait for isEanbleButton to become true")
          let cancellable = viewModel.$isEanbleButton
              .dropFirst()
              .sink { value in
                  if value == true {
                      expectation.fulfill()
                  }
              }

          viewModel.emailAddress = "test@email.com"
          viewModel.password = "Valid123"
          wait(for: [expectation], timeout: 2)
          cancellable.cancel()
    }
    
    func testLogin_Success_ShouldNotShowError() async {
        mockNetworkManager.shouldReturnError = false
        mockNetworkManager.mockResponse = LoginResponse(accessToken: "abc", refreshToken: "fetf32")
        let viewModel = LogInViewModal(networkManager: mockNetworkManager)
        viewModel.emailAddress = "test@email.com"
        viewModel.password = "Valid123"
        await viewModel.login()
        XCTAssertFalse(viewModel.showErrorAlert)
    }

    func testLogin_Failure_Unauthorized_ShouldShowInvalidCredentials() async {
        let mock = MockNetworkManager()
        mock.shouldReturnError = true
        mock.mockError = .server(code: 401, message: nil) // ✅ APIError.server

        let viewModel = LogInViewModal(networkManager: mock)
        viewModel.emailAddress = "wrong@email.com"
        viewModel.password = "Wrong123"
        await viewModel.login()
        XCTAssertTrue(viewModel.showErrorAlert)
        XCTAssertEqual(viewModel.logINErrorMessage, StringConsatnts.invalidCredentials)
    }

}
