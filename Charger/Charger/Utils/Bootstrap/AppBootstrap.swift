//
//  AppBootstrap.swift
//  Charger
//
//  Created by Gaye Kordacı Deprem on 14.07.2022.
//

import Foundation

import UIKit

final class AppBootstrap {
    static func configureRoot() -> UIViewController {
    
        let storyboard: UIStoryboard = UIStoryboard(name: "SplashViewController", bundle: nil)
        let navigationController = UINavigationController(rootViewController: storyboard.instantiateViewController(withIdentifier: "SplashViewController"))
        return navigationController
    }
    
    // MARK: - LoginViewController
    static func createLoginViewController() -> UIViewController {
        return LoginViewController.create(with: LoginViewModel())
    }
    
    // MARK: - ReservationViewController
    static func createReservationViewController(datas: [ReservationAPIModel]?) -> UIViewController {
        return ReservationViewController.create(with: ReservationViewModel(), datas: datas)
    }
    
    // MARK: - ProfileViewController
    static func createProfileViewController() -> UIViewController {
        return ProfileViewController.create(with: ProfileViewModel())
    }
}
