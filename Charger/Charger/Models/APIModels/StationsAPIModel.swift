//
//  StationsAPIModel.swift
//  Charger
//
//  Created by Gaye Kordacı Deprem on 16.07.2022.
//

import Foundation

// MARK: - StationsAPIModel
struct StationsAPIModel: Decodable {
    
    var id: Int?
    var stationCode: String?
    var sockets : [Socket]?
    var socketCount: Int?
    var occupiedSocketCount: Int?
    var distanceInKM: Double?
    var geoLocation: GeoLocation?
    var services: [String]?
    var stationName: String?
}
// MARK: - GeoLocation
struct GeoLocation: Decodable
{
    var longitude : Double?
    var latitude: Double?
    var province: String?
    var address: String?
}






