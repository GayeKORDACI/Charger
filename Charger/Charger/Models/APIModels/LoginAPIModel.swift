//
//  LoginAPIModel.swift
//  Charger
//
//  Created by Gaye Kordacı Deprem on 16.07.2022.
//

import Foundation


struct LoginAPIModel: Decodable {
    
    var email: String?
    var token: String?
    var userID: Int?
    
}
