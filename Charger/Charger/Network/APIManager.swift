//
//  APIManager.swift
//  Charger
//
//  Created by Gaye Kordacı Deprem on 16.07.2022.
//

import Foundation

class APIManager {
    static let shared = APIManager()
 
    // MARK: - Login
    func login(email: String?, deviceUDID: String?, callbackSuccess: @escaping(_ response: LoginAPIModel) -> Void, callbackFailure: @escaping(_ errors: Errors) -> Void) {
        
        let requestParams = ["email": email ,"deviceUDID": deviceUDID] as! [String: String]

        ServiceConnector.shared.connect(.Login(Params: requestParams, UrlPrefix: "")) { (target, response) in
            if let jsonData = response.data(using: .utf8){
                if let responseModel = try? JSONDecoder().decode(LoginAPIModel.self, from: jsonData){
                    
                    Globals.shared.userToken = responseModel.token
                    callbackSuccess(responseModel)
                    return
                } else {
                    callbackFailure(.ParseFailed)
                    return
                }
            }
            
        }
        
    }
    // MARK: - Logout
    func logout(userID: Int, callbackSuccess: @escaping(_ response: LogoutAPIModel) -> Void, callbackFailure: @escaping(_ errors: Errors) -> Void) {
        
        ServiceConnector.shared.connect(.Logout( UserID: "\(userID)")) { (target, response) in
         
            if let jsonData = response.data(using: .utf8){
                if let responseModel = try? JSONDecoder().decode(LogoutAPIModel.self, from: jsonData){

                    Globals.shared.userToken = ""
                    callbackSuccess(responseModel)
                    return
                } else {
                    callbackFailure(.ParseFailed)
                    return
                }
            }
            
        }
        
    }
    // MARK: - Get Cities
    func getCities(userID: String?, callbackSuccess: @escaping(_ response: [String]) -> Void, callbackFailure: @escaping(_ errors: Errors) -> Void) {
        
        let requestParams = ["userID": userID] as! [String: String]

        ServiceConnector.shared.connect(.Cities(Params: requestParams, UrlPrefix: "")) { (target, response) in
            if let jsonData = response.data(using: .utf8){
                if let responseModel = try? JSONDecoder().decode( [String].self, from: jsonData){
                    callbackSuccess(responseModel)
                    return
                } else {
                    callbackFailure(.ParseFailed)
                    return
                }
            }
            
        }
        
    }
    // MARK: - Get All Stations
    func getStations(userID: String?, userLatitude : Double , userLongitude : Double, callbackSuccess: @escaping(_ response: [StationsAPIModel]) -> Void, callbackFailure: @escaping(_ errors: Errors) -> Void) {
        
        let requestParams = ["userID": userID ?? "" , "userLatitude": userLatitude ,"userLongitude": userLongitude ] as! [String: Any]

        ServiceConnector.shared.connect(.Stations(Params: requestParams, UrlPrefix: "")) { (target, response) in
            if let jsonData = response.data(using: .utf8){
                if let responseModel = try? JSONDecoder().decode( [StationsAPIModel].self, from: jsonData){
                    callbackSuccess(responseModel)
                    return
                } else {
                    callbackFailure(.ParseFailed)
                    return
                }
            }
            
        }
        
    }
   
    // MARK: - Get Station Detail
    func getStationDetail(stationID: Int, userID: Int?, date : String? , callbackSuccess: @escaping(_ response: StationAvailabilityAPIModel) -> Void, callbackFailure: @escaping(_ errors: Errors) -> Void) {
        
        let requestParams = ["userID": userID ?? 0, "date": date ?? ""] as! [String: Any]
        
        ServiceConnector.shared.connect(.StationAvailability(stationID: "\(stationID)",Params: requestParams, UrlPrefix: "")) { (target, response) in
         
            if let jsonData = response.data(using: .utf8){
                if let responseModel = try? JSONDecoder().decode(StationAvailabilityAPIModel.self, from: jsonData){

                  
                    callbackSuccess(responseModel)
                    return
                } else {
                    callbackFailure(.ParseFailed)
                    return
                }
            }
            
        }
        
    }
    // MARK: - Create Reservation
    
    //ec2-18-197-100-203.eu-central-1.compute.amazonaws.com:8080/appointments/make? userID=1&userLatitude=39.925058&userLongitude=32.836860
    func createReservation(userID: Int, userLatitude : Double , userLongitude : Double, stationID : Int,socketID :Int, slot : String, date: String, callbackSuccess: @escaping(_ response: ReservationAPIModel) -> Void, callbackFailure: @escaping(_ errors: Errors) -> Void) {
        
        let requestParams = ["userID": userID,"userLatitude": userLatitude,"userLongitude": userLongitude] as! [String: Any]
                          
        
        let bodyParams = ["stationID": stationID, "socketID": socketID,"timeSlot": slot ,"appointmentDate": date ] as! [String: Any]

        ServiceConnector.shared.connect(.CreateReservation(Params: requestParams, BodyParams: bodyParams, UrlPrefix: "")) { (target, response) in
            if let jsonData = response.data(using: .utf8){
                if let responseModel = try? JSONDecoder().decode( ReservationAPIModel.self, from: jsonData){
                    callbackSuccess(responseModel)
                    return
                } else {
                    callbackFailure(.ParseFailed)
                    return
                }
            }
            
        }
        
    }
    
    // MARK: - Get Reservation List By UserID
    func getReservations(userID: Int, userLatitude : Double , userLongitude : Double , callbackSuccess: @escaping(_ response: [ReservationAPIModel]) -> Void, callbackFailure: @escaping(_ errors: Errors) -> Void) {
        
        let requestParams = ["userLatitude": userLatitude ,"userLongitude": userLongitude ] as! [String: Double]
        
        ServiceConnector.shared.connect(.Reservations(UserID: "\(userID)",Params: requestParams, UrlPrefix: "")) { (target, response) in
         
            if let jsonData = response.data(using: .utf8){
                if let responseModel = try? JSONDecoder().decode([ReservationAPIModel].self, from: jsonData){

                  
                    callbackSuccess(responseModel)
                    return
                } else {
                    callbackFailure(.ParseFailed)
                    return
                }
            }
            
        }
        
    }
    // MARK: - Delete Reservation
    
    // donus degerı ne olacakk ????????????
    
    func deleteReservation(appointmentID: Int, userID: Int?, callbackSuccess: @escaping(_ response: StationAvailabilityAPIModel) -> Void, callbackFailure: @escaping(_ errors: Errors) -> Void) {

        let requestParams = ["userID": userID ?? 0] as! [String: Any]

        ServiceConnector.shared.connect(.DeleteReservation(appointmentID: "\(appointmentID)",Params: requestParams, UrlPrefix: "")) { (target, response) in

            if let jsonData = response.data(using: .utf8){
                if let responseModel = try? JSONDecoder().decode(StationAvailabilityAPIModel.self, from: jsonData){


                    callbackSuccess(responseModel)
                    return
                } else {
                    callbackFailure(.ParseFailed)
                    return
                }
            }

        }

    }
  
}
