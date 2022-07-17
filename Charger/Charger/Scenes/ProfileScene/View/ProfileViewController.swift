//
//  ProfileViewController.swift
//  Charger
//
//  Created by Gaye Kordacı Deprem on 17.07.2022.
//

import UIKit

class ProfileViewController: BaseViewController {

    private var viewModel: ProfileViewModel!
    
    @IBOutlet weak var profileImegeView: UIImageView!
    @IBOutlet weak var epostaTitleLabel: UILabel!
    @IBOutlet weak var epostaLabel: UILabel!
    @IBOutlet weak var deviceIdTitleLabel: UILabel!
    @IBOutlet weak var deviceIdLabel: UILabel!
    @IBOutlet weak var profileDetailView: UIView!
    @IBOutlet weak var epostaDetailView: UIView!
    @IBOutlet weak var deviceIdDetailView: UIView!
   
    @IBOutlet weak var logoutButton: UIButton!
    
    static func create(with viewModel: ProfileViewModel) -> ProfileViewController {
        let view = ProfileViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        profileImegeView.image = UIImage(named:"Badge")
        
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = [UIColor.charcoalGray.cgColor, UIColor.dark.cgColor]
        gradient.locations = [0.0 , 1.0]
        gradient.frame = self.view.bounds
        self.view.layer.insertSublayer(gradient, at: 0)
        
        epostaTitleLabel.text = "email_profile".localized
        epostaTitleLabel.textColor = .grayscale
        epostaLabel.text = "kordacig@gmail.com"
        epostaLabel.font = UIFont.systemFont(ofSize: 16.0, weight: .bold)
        epostaLabel.textColor = .white
        deviceIdTitleLabel.text = "device_id".localized
        deviceIdTitleLabel.textColor = .grayscale
        deviceIdLabel.text = UIDevice.current.identifierForVendor?.uuidString
        deviceIdLabel.font = UIFont.systemFont(ofSize: 13.0, weight: .bold)
        deviceIdLabel.textColor = .white
        
        profileDetailView.backgroundColor = .charcoalGray
        profileDetailView.setCorners(10)
        epostaDetailView.backgroundColor = .charcoalGray
        deviceIdDetailView.backgroundColor = .charcoalGray
        
        logoutButton.setCorners(logoutButton.frame.size.height/2)
        logoutButton.backgroundColor = .white
        logoutButton.setTitle("logout".localized, for: .normal)
        logoutButton.setTitleColor(.dark, for: .normal)
        logoutButton.titleLabel?.font = UIFont.systemFont(ofSize: 17.0, weight: .bold)
       
    }
    

   

}
