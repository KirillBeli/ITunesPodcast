//
//  ObjectManager.swift
//  ITunesPodcast
//
//  Created by Kyrylo Bielykov on 03.03.2023.
//

import Foundation

//MARK: - NSObject
@objc
extension NSObject {
    
    var className: String {
        return String(describing: type(of: self))
    }
    
    class var className: String {
        return String(describing: self)
    }
}

// MARK: - ITunesData
struct ITunesData : Codable {
    let resultCount : Int
    let results : [Results]

    enum CodingKeys: String, CodingKey {

        case resultCount = "resultCount"
        case results = "results"
    }

}

// MARK: - Result
struct Results : Codable {
    let wrapperType : String
    let kind : String
    let collectionId : Int
    let trackId : Int
    let artistName : String
    let collectionName : String
    let trackName : String
    let collectionCensoredName : String
    let trackCensoredName : String
    let collectionViewUrl : String
    let feedUrl : String
    let trackViewUrl : String
    let artworkUrl30 : String
    let artworkUrl60 : String
    let artworkUrl100 : String
    let collectionPrice : Double
    let trackPrice : Double
    let collectionHdPrice : Int
    let releaseDate : String
    let collectionExplicitness : String
    let trackExplicitness : String
    let trackCount : Int
    let trackTimeMillis : Int
    let country : String
    let currency : String
    let primaryGenreName : String
    let contentAdvisoryRating : String
    let artworkUrl600 : String
    let genreIds : [String]
    let genres : [String]
    
    enum CodingKeys: String, CodingKey {
        
        case wrapperType = "wrapperType"
        case kind = "kind"
        case collectionId = "collectionId"
        case trackId = "trackId"
        case artistName = "artistName"
        case collectionName = "collectionName"
        case trackName = "trackName"
        case collectionCensoredName = "collectionCensoredName"
        case trackCensoredName = "trackCensoredName"
        case collectionViewUrl = "collectionViewUrl"
        case feedUrl = "feedUrl"
        case trackViewUrl = "trackViewUrl"
        case artworkUrl30 = "artworkUrl30"
        case artworkUrl60 = "artworkUrl60"
        case artworkUrl100 = "artworkUrl100"
        case collectionPrice = "collectionPrice"
        case trackPrice = "trackPrice"
        case collectionHdPrice = "collectionHdPrice"
        case releaseDate = "releaseDate"
        case collectionExplicitness = "collectionExplicitness"
        case trackExplicitness = "trackExplicitness"
        case trackCount = "trackCount"
        case trackTimeMillis = "trackTimeMillis"
        case country = "country"
        case currency = "currency"
        case primaryGenreName = "primaryGenreName"
        case contentAdvisoryRating = "contentAdvisoryRating"
        case artworkUrl600 = "artworkUrl600"
        case genreIds = "genreIds"
        case genres = "genres"
    }
    
}
