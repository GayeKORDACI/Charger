//
//  ReservationAPIModel.swift
//  Charger
//
//  Created by Gaye Kordacı Deprem on 16.07.2022.
//

import Foundation
// MARK: - ReservationAPIModel
struct ReservationAPIModel: Decodable {
    var time: String?
    var date: String?
    var station: StationsAPIModel?
    var stationCode : String?
    var stationName: String?
    var userID: Int?
    var appointmentID: Int?
    var socketID: Int?
    var hasPassed: Bool?
}







