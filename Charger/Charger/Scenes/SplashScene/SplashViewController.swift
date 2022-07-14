//
//  SplashViewController.swift
//  Charger
//
//  Created by Gaye Kordacı Deprem on 14.07.2022.
//

import UIKit

class SplashViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true;
        delayWithSeconds(1) {
            
            
            self.navigationController?.pushViewController(AppBootstrap.createLoginViewController(), animated: true)
            
        }
    }
}
