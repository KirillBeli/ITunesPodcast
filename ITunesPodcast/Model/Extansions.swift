//
//  Extansions.swift
//  ITunesPodcast
//
//  Created by Kyrylo Bielykov on 12.03.2023.
//

import Foundation
import UIKit

//MARK: - ClassName
@objc
extension NSObject {
    
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

//MARK: - TableView EX
extension UITableView {
    
    func registerXib(xibName: String) {
        let xib = UINib(nibName: xibName, bundle: nil)
        register(xib, forCellReuseIdentifier: xibName)
    }
    
}

enum NetworkManagerError {
    case badResponse(URLResponse?)
    case badLocalUrl
}

//MARK: - Date
extension String {
    
    func getDateWith12_24Logic() ->Date {
       
        let formater = DateFormatter()
        formater.dateFormat = Fromters.regular.rawValue
        formater.locale = Locale.current
        formater.timeZone = TimeZone(abbreviation: "GMT")
        if let date_24 = formater.date(from: self){
          return  date_24
        }
        else{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = Fromters.regular.rawValue
            dateFormatter.locale = Locale.current
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
            dateFormatter.locale = Locale(identifier: "he_IL_POSIX")
            if let date_12 = dateFormatter.date(from: self){
                return  date_12
            }
            else{
                return Date()
            }
        }
    }
}

enum Fromters :String {
    
    case regular = "yyyy-MM-dd'T'HH:mm:ss"
    case timeOnly = "HH:mm"
    case dateOnly = "yyyy-MM-dd"
    case ampm = "yyyy-MM-dd'T'hh:mm:ss"
}

extension Date {
    func getDateWithOutHours() -> String {
        let formater = DateFormatter()
        formater.dateFormat = Fromters.dateOnly.rawValue
        formater.timeZone = TimeZone(abbreviation: "GMT +3:00")
        return formater.string(from: self)
    }
}
