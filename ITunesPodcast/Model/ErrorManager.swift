//
//  ErrorManager.swift
//  ITunesPodcast
//
//  Created by Kyrylo Bielykov on 20.03.2023.
//

import Foundation

enum NetworkManagerError {
    case errorResponse(URLResponse?)
    case errorLocalUrl
    case errorFileLocation
    case errorDecode
    case downloadError
    
    var errorDescroption: String? {
        switch self {
        case .errorResponse:
            return "Response Error"
        case .errorLocalUrl:
            return "Error local URL"
        case .errorFileLocation:
            return "Error File Loaction"
        case .errorDecode:
            return "Decode Error"
        case .downloadError:
            return "Download Error"
        }
    }
}
