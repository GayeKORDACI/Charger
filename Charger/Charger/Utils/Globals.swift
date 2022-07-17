//
//  Globals.swift
//  Charger
//
//  Created by Gaye Kordacı Deprem on 16.07.2022.
//

import Foundation


class Globals {
    
    static let shared = Globals()
    
    var BaseWebServiceUrl = "http://ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/"
    var userId: Int?
    var userToken: String?
    var userLatitude: Double?
    var userLongitude: Double?
    
}
