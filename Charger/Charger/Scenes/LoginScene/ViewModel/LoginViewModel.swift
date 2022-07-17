//
//  LoginViewModel.swift
//  Charger
//
//  Created by Gaye Kordacı Deprem on 14.07.2022.
//

import Foundation

final class LoginViewModel {
    
    var didFetchLoginData: (([ReservationAPIModel]) -> Void)?
    
    func getLocation() {
        let getLocation = GetLocation()

        getLocation.run {
            if let location = $0 {
                print("Get location = \(location.coordinate.latitude) \(location.coordinate.longitude)")
                Globals.shared.userLatitude = location.coordinate.latitude
                Globals.shared.userLongitude = location.coordinate.longitude
            } else {
                print("Get Location failed \(String(describing: getLocation.didFailWithError))")
            }
        }
    }
    
    func loginService(email: String, deviceUDID: String) {
        
        APIManager.shared.login(email: email, deviceUDID: deviceUDID) { response in

            print(response)
            
            self.fetchReservations()
            
        } callbackFailure: { errors in
            
            print(errors)
            
        }
    }
    
    func fetchReservations() {
        
        APIManager.shared.getReservations(userID: Globals.shared.userId ?? -1, userLatitude: Globals.shared.userLatitude!, userLongitude: Globals.shared.userLongitude!) { response in
            
            print(response)
            
            self.didFetchLoginData?(response)

        } callbackFailure: { errors in
            print(errors)
        }
        
        
    }
    
}
