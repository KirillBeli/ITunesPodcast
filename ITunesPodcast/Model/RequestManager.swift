//
//  RequestManager.swift
//  ITunesPodcast
//
//  Created by Kyrylo Bielykov on 03.03.2023.
//

import UIKit

class RequestManager {
    
    //MARK: - Properties
    let decoder = JSONDecoder()
    var session = URLSession.shared
    var images = NSCache<NSString, NSData>()
    static var shared = RequestManager()
    var urlSessionDelegate: URLSessionDelegate?
    private init() {
    }
    
    //MARK: - Get ITunesData from File
     func getItunesData(forResource: String, withExtension: String, complition: @escaping (ITunesData) -> (Void)) {
        guard let fileLocation = Bundle.main.url(forResource: "\(forResource)", withExtension: "\(withExtension)")
         else { return print(NetworkManagerError.errorFileLocation) }
        guard let data = try? Data(contentsOf: fileLocation) else { return print(ErrorPointer.self) }
         guard let result = try? decoder.decode(ITunesData.self, from: data) else { return print(NetworkManagerError.errorDecode) }
        complition(result)
        
    }
    
    //MARK: - DownloadSession
     func downloadImage(url: URL, completion: @escaping (Data?, Error?) -> (Void)) {
        let configur = URLSessionConfiguration.default
        session = URLSession(configuration: configur)
         if let imageData = images.object(forKey: url.absoluteString as NSString) {
             completion(imageData as Data, nil)
             return
         }
        session.downloadTask(with: url) { url, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { completion(nil, NetworkManagerError.errorResponse(response) as? Error)
                return
            }
            guard let url = url else { completion(nil, NetworkManagerError.errorLocalUrl as? Error)
                return
            }
            do{
                let data = try Data(contentsOf: url)
                self.images.setObject(data as NSData, forKey: url.absoluteString as NSString)
                completion(data, nil)
            } catch let error {
                completion(nil, error)
            }
        }.resume()
    }
}


