//
//  StationAvailabilityAPIModel.swift
//  Charger
//
//  Created by Gaye Kordacı Deprem on 16.07.2022.
//

import Foundation

// MARK: - StationAvailabilityAPIModel
struct StationAvailabilityAPIModel: Decodable {
    var stationID: Int?
    var stationCode: String?
    var sockets: [Socket]?
    var geoLocation: GeoLocation?
    var services: [String]?
    var stationName: String?
}
// MARK: - Socket
struct Socket: Decodable {
    var socketID: Int?
    var day: Day?
    var socketType: String?
    var chargeType: String?
    var power: Int?
    var socketNumber: Int?
    var powerUnit: String?
   
}
// MARK: - Day
struct Day: Decodable {
    var id: Int?
    var date: String?
    var timeSlots: [TimeSlot]?
}

// MARK: - TimeSlot
struct TimeSlot: Decodable {
    var slot: String?
    var isOccupied: Bool?
}

