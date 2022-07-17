//
//  ServiceConnector.swift
//  Charger
//
//  Created by Gaye Kordacı Deprem on 16.07.2022.
//

import Foundation
import Alamofire
import Moya

protocol ConnectionCheckDelegate: AnyObject {
    func tryAgain()
}

enum Services {
    
    case Login(Params: [String: String], UrlPrefix: String)
    case Cities(Params: [String: String], UrlPrefix: String)
    case Logout(UserID: String)
    case Stations(Params: [String: Any], UrlPrefix: String)
    case StationAvailability(stationID: String,Params: [String: Any], UrlPrefix: String)
    case Reservations(UserID: String,Params: [String: Double], UrlPrefix: String)
    case CreateReservation(Params: [String: Any], BodyParams: [String: Any],  UrlPrefix: String)
    case DeleteReservation(appointmentID: String,Params: [String: Any], UrlPrefix: String)
}

class ServiceConnector: NSObject {
    
    static let shared = ServiceConnector()
    let connectivityGroup = DispatchGroup()
    
    let endpointClosure = { (target: Services) -> Endpoint in
        
        print("baseURL:\(target.baseURL)\n path:\(target.path)")
        
        
        var url = "\(target.baseURL.absoluteString)\(target.path)"
        
        print("url:\(url)")
        
        let endpoint = Endpoint (
            url: url,
            sampleResponseClosure: { .networkResponse(200, target.sampleData) },
            method: target.method,
            task: target.task,
            httpHeaderFields: target.headers
        )
        return endpoint.adding(newHTTPHeaderFields: [:])
    }
    
    func connect(_ target : Services) {
        self.connect(target, success: nil)
    }
    
    func connect(_ target : Services, success: ((_ target : Services, _ response : String) -> ())?) {
        self.connect(target, success: success, error: nil)
    }
    
    func connect(_ target : Services, success: ((_ target : Services, _ response : String) -> ())?, error: ((_ target: Services, _ error: MoyaError) -> ())?) {
        
        
        let manager = ServerTrustManager(allHostsMustBeEvaluated: false,
                                         evaluators: [Globals.shared.BaseWebServiceUrl: DisabledTrustEvaluator()])
        
        let configuration = URLSessionConfiguration.af.default
        
        let session = Session(configuration: configuration, serverTrustManager: manager)
        
        var providerPlugin: [PluginType] = []
        
        configuration.timeoutIntervalForRequest = 10
        
        let provider = MoyaProvider<Services>(endpointClosure: endpointClosure, session: session, plugins: providerPlugin)
        
        
        
        let check = NetworkReachabilityManager(host: "https://www.google.com")
        if !(check?.isReachable ?? false) {
            
            // TODO: Fix Alerts
            //            Alert.warning(title: "", text: LocalizationKeys.internetConnection.localized)
            
        }
        
        connectivityGroup.notify(queue: .main) {
            provider.request(target) { result in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                
                switch result {
                case let .success(moyaResponse):
                    
                    let statusCode = moyaResponse.statusCode
                    let dataString = String(data: moyaResponse.data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue))
                    
                    if let ds = dataString {
                        print("Status Code : ", statusCode)
                        if let body = moyaResponse.request?.httpBody {
                            let bodyString = String(decoding: body, as: UTF8.self)
                            print("[Request Body]: \(bodyString)")
                        }
                        
                        if let body = moyaResponse.request?.httpBody {
                            let bodyString = String(decoding: body, as: UTF8.self)
                            print("[Request Body]: \(bodyString)")
                        }
                        
                        let headers = moyaResponse.response!.allHeaderFields
                        
                        print("[Request Headers]: \(headers)")
                        
                        if let s = success {
                            s(target, ds)
                        }
                    }
                    
                    break
                case let .failure(err):
                    print("Error : ", err.errorDescription!)
                    
                    // TODO: Fix Alerts
                    //                    Alert.warning(title: "", text: err.errorDescription ?? LocalizationKeys.serverError.localized)
                    
                    if err.errorDescription?.contains("offline") ?? false {
                        
                    }
                    if let e = error {
                        e(target, err)
                    }
                }
                
            }
        }
    }
}

// MARK: - TargetType Protocol Implementation
extension Services: TargetType {
    
    var headers: [String : String]? {
        var headerParamsExtra = Dictionary<String,String>()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        formatter.timeZone = TimeZone(secondsFromGMT:0)
        let AuthKey = formatter.string(from: Date())
        
        headerParamsExtra["Content-Type"] = "application/json"
        
        switch self {
        case .Cities, .Logout, .Stations , .StationAvailability, .Reservations , .CreateReservation, .DeleteReservation:
            headerParamsExtra["token"] = Globals.shared.userToken ?? ""
        default:
            headerParamsExtra["Content-Type"] = "application/json"
        }
        
        headerParamsExtra["Auth-Key"] = AuthKey
        /*case //Auth Required APIs*/
        
        return headerParamsExtra
    }
    
    
    var baseURL: URL {
        switch self {
            
        default:
            return URL(string: "\(Globals.shared.BaseWebServiceUrl)")!
        }
    }
    
    var path: String {
        switch self {
            
        case .Login(_, _):
            return "auth/login"
        case .Cities(_, _):
            return "provinces"
        case let .Logout(UserID):
            return "auth/logout/\(UserID)"
        case .Stations(_, _):
            return "stations"
        case let .StationAvailability(stationID, _, _):
            return "stations/\(stationID)"
        case let .Reservations(UserID , _, _):
            return "appointments/\(UserID)"
        case .CreateReservation(_,_, _):
            return "appointments/make"
        case .DeleteReservation(_,_, _):
            return "appointments/cancel"
        }
        
        
    }
    
    var method: Moya.Method {
        switch self {
        case .Login, .Logout , .CreateReservation:
            return .post
        case .DeleteReservation:                                   //Delete cases here
            return .delete
            //        case .:                                    //Update cases here
            //            return .patch
            //        case . :         //Put cases here
            //            return .put
        default:
            return .get
        }
    }
    
    public var sampleData: Data {
        return Data()
    }
    
    var parameterEncoding: ParameterEncoding {
        switch self {
            
        default:
            return URLEncoding.default
        }
    }
    
    
    
    
    var task: Task {
        switch self {
            
        case let .Login(Params, _):
            
            if let theJSONData = try? JSONSerialization.data(withJSONObject: Params, options: []) {
                return .requestData(theJSONData)
            }
            return .requestPlain
        case let .Cities(Params,_):
            
            if Params.first?.key != "" {
                return .requestParameters(parameters: Params, encoding: URLEncoding.queryString)
            } else {
                return .requestPlain
            }
        case let .Stations(Params,_):
            
            if Params.first?.key != "" {
                return .requestParameters(parameters: Params, encoding: URLEncoding.queryString)
            } else {
                return .requestPlain
            }
            
        case let .StationAvailability(_, Params, _):
            if Params.first?.key != "" {
                return .requestParameters(parameters: Params, encoding: URLEncoding.queryString)
            } else {
                return .requestPlain
            }
        case let .Reservations(_, Params, _):
            if Params.first?.key != "" {
                return .requestParameters(parameters: Params, encoding: URLEncoding.queryString)
            } else {
                return .requestPlain
            }
        case let .CreateReservation(Params,BodyParams, _):
            if let theJSONData = try? JSONSerialization.data(withJSONObject: BodyParams, options: []) {
//                return .requestData(theJSONData)
                
                return .requestCompositeData(bodyData: theJSONData, urlParameters: Params)

            }
            
                return .requestPlain

//
//            if Params.first?.key != "" {
//                return .requestParameters(parameters: Params, encoding: URLEncoding.queryString)
//            } else {
//                return .requestPlain
//            }
            
        case let .DeleteReservation(_, Params, _):
            if Params.first?.key != "" {
                return .requestParameters(parameters: Params, encoding: URLEncoding.queryString)
            } else {
                return .requestPlain
            }
        default:
            return .requestPlain
        }
    }
}

extension ServiceConnector: ConnectionCheckDelegate {
    func tryAgain() {
        let check = NetworkReachabilityManager()
        if check?.isReachable ?? false {
            connectivityGroup.leave()
            let window = UIApplication.shared.keyWindow
            window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
    }
}
