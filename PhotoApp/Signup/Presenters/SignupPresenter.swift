//
//  SignupPresenter.swift
//  QuizApp
//
//  Created by Manar Magdy on 10/10/2022.
//

import Foundation

class SignupPresenter: SignupPresenterProtocol {
    
    private var validator: SignupModelValidatorProtocol
    private var service: SignupWebserviceProtocol
    private weak var delegate: SignupViewDelegateProtocol?
    
    required init(validator: SignupModelValidatorProtocol, service: SignupWebserviceProtocol, delegate: SignupViewDelegateProtocol) {
        self.validator = validator
        self.service = service
        self.delegate = delegate
    }
    
    func processUserSignup(with form: SignupFormModel) {
        if !validator.isFirstNameValid(fName: form.firstName) {
            delegate?.errorHandler(error: .invalidData)
            return
        }
        
        if !validator.isLastNameValid(fName: form.lastName) {
            delegate?.errorHandler(error: .invalidData)
            return
        }
        
        if !validator.isValidEmailFormat(fName: form.email) {
            delegate?.errorHandler(error: .invalidEmail)
            return
        }
        
        if !validator.isPasswordValid(psd: form.password) {
            delegate?.errorHandler(error: .invalidData)
            return
        }
        
        if !validator.doPasswordsMatch(psd: form.password, rptPsd: form.repeatPassword) {
            delegate?.errorHandler(error: .invalidData)
            return
        }
        
        let requestModel = SignFormRequestModel(firstName: form.firstName, lastName: form.lastName, email: form.email, password: form.password)
        
        service.signup(withForm: requestModel) { [weak self] response, error in
            if let error = error {
                self?.delegate?.errorHandler(error: error)
                return
            }
            
            if response != nil {
                self?.delegate?.successfulSignup()
                return
            }
        }
    }
    
}
