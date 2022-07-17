//
//  Enums.swift
//  Charger
//
//  Created by Gaye Kordacı Deprem on 16.07.2022.
//

import Foundation


enum Errors {
    case AuthError
    case EmptyData
    case ParseFailed
    case Failure
    case PaymentNotAuthorized
    case LoginAlreadyInUseException
    case InvalidPasswordException
    case OTP
}

enum LangCode: String {
    case EN = "en"
    case TR = "tr"
}

enum State {
    case loading
    case empty
    case populated
    case `continue`
    case error
}






