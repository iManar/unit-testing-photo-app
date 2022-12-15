//
//  SignupWebservice.swift
//  QuizApp
//
//  Created by Manar Magdy on 10/10/2022.
//

import Foundation


class SignupWebservice: SignupWebserviceProtocol {
    
    private var urlSession: URLSession
    private var urlString: String
    
    init(urlString: String, urlSession: URLSession = .shared) {
        self.urlString = urlString
        self.urlSession = urlSession
    }
    
    func signup(withForm formModel: SignFormRequestModel, completionHandler: @escaping (SignFormResponseModel?, SignupError?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completionHandler(nil, SignupError.invalidRequestUrlString)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(formModel)
        
        let dTask = urlSession.dataTask(with: request) { data, response, error in
            
            if let reqError = error {
                completionHandler(nil, SignupError.failedRequest(description: reqError.localizedDescription))
                return
            }
            
            if let data = data, let signResponseModel = try? JSONDecoder().decode(SignFormResponseModel.self, from: data) {
                completionHandler(signResponseModel, nil)
            } else {
                completionHandler(nil, SignupError.invalidResponseModel)
            }
        }
        dTask.resume()
    }
    
}
