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
    
    
    static func create(with viewModel: LoginViewModel) -> LoginViewController {
        let view = LoginViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.charcoalGray.cgColor, UIColor.dark.cgColor]
        gradient.locations = [0.0 , 1.0]
        //gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
        //gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
        //gradient.frame = CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        gradient.frame = self.view.bounds
        self.view.layer.insertSublayer(gradient, at: 0)
        
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
        
        
        loginButton.setCorners(loginButton.frame.size.height/2)
        loginButton.backgroundColor = .white
        loginButton.setTitle("login".localized, for: .normal)
        loginButton.setTitleColor(.dark, for: .normal)
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
        
        let getLocation = GetLocation()

        getLocation.run {
            if let location = $0 {
                //print("location = \(location.coordinate.latitude) \(location.coordinate.longitude)")
                Globals.shared.userLatitude = location.coordinate.latitude
                Globals.shared.userLongitude = location.coordinate.longitude
            } else {
                print("Get Location failed \(getLocation.didFailWithError)")
            }
        }
        
        
        APIManager.shared.login(email: "kullanici@gmail.com", deviceUDID: "047923") { response in
            
            print(response)
            
           
            APIManager.shared.getStations(userID: "\(response.userID ?? 0)", userLatitude: Globals.shared.userLatitude!, userLongitude: Globals.shared.userLongitude!) { response in
                print(response)

            } callbackFailure: { errors in
                print(errors)
            }
            
            APIManager.shared.getStationDetail(stationID: 10, userID: response.userID ?? 0, date: "2022-11-30") { response in
                print(response)
            } callbackFailure: { errors in
                print(errors)
            }
            
            APIManager.shared.getReservations(userID: response.userID ?? 0, userLatitude: Globals.shared.userLatitude!, userLongitude: Globals.shared.userLongitude!) { response in
                print(response)
            } callbackFailure: { errors in
                print(errors)
            }

            APIManager.shared.createReservation(userID: response.userID ?? 0, userLatitude: Globals.shared.userLatitude!, userLongitude: Globals.shared.userLongitude!, stationID: 10, socketID: 21, slot: "02:00", date: "2022-11-30") { response in
                print(response)
            } callbackFailure: { errors in
                print(errors)
            }


            
        } callbackFailure: { errors in
            
            print(errors)
            
        }
        
    }
    
    //APIManager.shared.getCities(userID: "\(response.userID ?? 0)") { response in
    
    //        self.delayWithSeconds(3) {
    //
    //            self.navigationController?.pushViewController(AppBootstrap.createReservationViewController(), animated: true)
    //
    //        }
    
    //    }
    //    callbackFailure: { errors in
    //        print(errors)
    //    }
    
    
    
//    APIManager.shared.logout(userID: response.userID ?? 0) { response in
//        print(response)
//    } callbackFailure: { errors in
//        print(errors)
//    }
    
    
}
