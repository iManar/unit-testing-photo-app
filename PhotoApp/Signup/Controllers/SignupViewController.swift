//
//  SignupViewController.swift
//  QuizApp
//
//  Created by Manar Magdy on 11/10/2022.
//

import UIKit


class SignupViewController: UIViewController {
    
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var repeatPasswordTF: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var pushButton: UIButton!
    
    
    var presenter: SignupPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        #if DEBUG
//        if CommandLine.arguments.contains("-skipSurvey") {
//            print("🥰")
//        }
//        #endif
//
//        #if DEBUG
//        if ProcessInfo.processInfo.arguments.contains("-skipSurvey") {
//            print("🤪")
//        }
//        #endif

        
        if presenter == nil {
            let v = SignupFormModelValidator()
            
            let signupUrl = ProcessInfo.processInfo.environment["signupUrl"] ?? "!?"
            print("😣 \(signupUrl)")
            
            let w = SignupWebservice(urlString: SignupConstants.signupUrlString)

            presenter = SignupPresenter(validator: v, service: w, delegate: self)
        }
    }
    
    @IBAction func signupTapped(_ sender: Any) {
        presenter?.processUserSignup(with: SignupFormModel(firstName: firstNameTF.text ?? "",
                                                           lastName: lastNameTF.text ?? "",
                                                           email: emailTF.text ?? "",
                                                           password: passwordTF.text ?? "",
                                                           repeatPassword: repeatPasswordTF.text ?? ""))
    }
    
    
    
    @IBAction func pushButtonTapped(_ sender: Any) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(identifier: "ViewController")
        vc.view.accessibilityIdentifier = "2ndVC"
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


extension SignupViewController: SignupViewDelegateProtocol {
    
    func successfulSignup() {
        let alert = UIAlertController(title: "Success", message: "Your request has been handled this time!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            alert.view.accessibilityIdentifier = "successAlertDialog"
            self.present(alert, animated: true)
        }
    }
    
    func errorHandler(error: SignupError) {
        let alert = UIAlertController(title: "Error", message: "Your request couldn't be handled at this time!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        DispatchQueue.main.async {
            alert.view.accessibilityIdentifier = "errorAlertDialog"
            self.present(alert, animated: true)
        }
    }
}
