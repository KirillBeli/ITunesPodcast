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
    var session: URLSession
    static var shared = RequestManager( session: URLSession())
    var urlSessionDelegate: URLSessionDelegate?
    private init(session: URLSession) {
        self.session = session
    }
    
    //MARK: - Get ITunesData from File
    func getItunesData(forResource: String, withExtension: String, complition: @escaping (ITunesData) -> (Void)) {
        guard let fileLocation = Bundle.main.url(forResource: "\(forResource)", withExtension: "\(withExtension)")
        else { return print("error location") }
        guard let data = try? Data(contentsOf: fileLocation) else { return print(ErrorPointer.self) }
        guard let result = try? decoder.decode(ITunesData.self, from: data) else { return print("error Decode") }
        complition(result)
        
    }
    
    //MARK: - DownloadSession
    func downloadImage(url: URL, completion: @escaping (Data?, Error?) -> (Void)) {
        let configur = URLSessionConfiguration.default
        session = URLSession(configuration: configur)
        session.downloadTask(with: url) { url, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else { completion(nil, error)
                return
            }
            guard let url = url else { completion(nil, error)
                return
            }
            do{
                let data = try Data(contentsOf: url)
                completion(data, nil)
            } catch let error {
                completion(nil, error)
            }
        }.resume()
    }
}

