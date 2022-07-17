//
//  SplashViewController.swift
//  Charger
//
//  Created by Gaye Kordacı Deprem on 14.07.2022.
//

import UIKit
import CoreLocation
class SplashViewController: BaseViewController {

    @IBOutlet weak var splashBackgroundImage: UIImageView!
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        splashBackgroundImage.image = UIImage(named: "splashBackgroundImage")
        splashBackgroundImage.contentMode = .scaleAspectFill
        self.navigationController?.navigationBar.isHidden = true;
    

        // For use in foreground
        self.locationManager.requestWhenInUseAuthorization()
        
        delayWithSeconds(3) {
            
            
            self.navigationController?.pushViewController(AppBootstrap.createLoginViewController(), animated: true)
            
        }
    }
}
