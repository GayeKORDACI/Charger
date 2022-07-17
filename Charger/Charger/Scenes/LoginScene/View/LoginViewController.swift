//
//  LoginViewController.swift
//  Charger
//
//  Created by Gaye Kordacı Deprem on 14.07.2022.
//

import UIKit
import CoreLocation
class LoginViewController: BaseViewController {
    
    // MARK: - Lifecycle
    
    private var viewModel: LoginViewModel!
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var needToLoginLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        
           viewModel.loginService(email: emailTextField.text ?? "", deviceUDID: "047923")
    }
    
    static func create(with viewModel: LoginViewModel) -> LoginViewController {
        let view = LoginViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
   
        setupViewModel()
        
    }
    
    private func setupUI() {

        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "login_title".localized
                
        self.navigationController?.navigationBar.isHidden = false;
        
        let welcomeText = "welcome".localized.changeWithBoldText(text: "Charger")
        welcomeLabel.attributedText =  welcomeText
        welcomeLabel.textColor = .white
        welcomeLabel.textAlignment = NSTextAlignment.center
        // welcomeLabel.font = UIFont.systemFont(ofSize: 30.0)
        
        needToLoginLabel.text = "need_to_login".localized
        needToLoginLabel.textColor = .grayscale
        needToLoginLabel.textAlignment = NSTextAlignment.center
        needToLoginLabel.numberOfLines = 0
        needToLoginLabel.font = UIFont.systemFont(ofSize: 17.0)
        
        
        emailTextField.setUnderLine()
        emailTextField.placeholder = "email".localized.localizedUppercase
        emailTextField.placeHolderColor = .grayscale
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.textColor = .grayscale
        emailTextField.text = "kullanici@gmail.com"
        
        loginButton.setCorners(loginButton.frame.size.height/2)
        loginButton.backgroundColor = .white
        loginButton.setTitle("login".localized, for: .normal)
        loginButton.setTitleColor(.dark, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        
    }
    
    private func setupViewModel() {
        viewModel.getLocation()
        
        viewModel.didFetchLoginData = { [weak self] response in
            guard let self = self else {return}
            self.navigationController?.pushViewController(AppBootstrap.createReservationViewController(datas: response), animated: true)

        }
    }
    
//    APIManager.shared.logout(userID: response.userID ?? 0) { response in
//        print(response)
//    } callbackFailure: { errors in
//        print(errors)
//    }
    
    
}
