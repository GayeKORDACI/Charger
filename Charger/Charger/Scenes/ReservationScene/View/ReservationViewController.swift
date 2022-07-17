//
//  ReservationViewController.swift
//  Charger
//
//  Created by Gaye Kordacı Deprem on 14.07.2022.
//

import UIKit
import CoreLocation
class ReservationViewController: BaseViewController {

    private var viewModel: ReservationViewModel!
    
    var locationManager = CLLocationManager()
    
    static func create(with viewModel: ReservationViewModel) -> ReservationViewController {
        let view = ReservationViewController.instantiateViewController()
        view.viewModel = viewModel
        return view
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
