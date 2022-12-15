//
//  MockURLProtocol.swift
//  QuizAppUnitTests
//
//  Created by Manar Magdy on 10/10/2022.
//

import Foundation
@testable import PhotoApp

class MockURLProtocol: URLProtocol {
    
    static var stubReponseData: Data?
    static var error: SignupError?
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        if let signupError = MockURLProtocol.error {
            self.client?.urlProtocol(self, didFailWithError: signupError)
        } else {
            self.client?.urlProtocol(self, didLoad: MockURLProtocol.stubReponseData ?? Data())
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() {}
}
