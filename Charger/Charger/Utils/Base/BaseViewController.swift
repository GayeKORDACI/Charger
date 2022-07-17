//
//  BaseViewController.swift
//  Charger
//
//  Created by Gaye Kordacı Deprem on 14.07.2022.
//

import UIKit

class BaseViewController: UIViewController, StoryboardInstantiable {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.setGradientVertically(colors: [UIColor.charcoalGray.cgColor, UIColor.dark.cgColor])
    }
    
}
