//
//  RequestManager.swift
//  ITunesPodcast
//
//  Created by Kyrylo Bielykov on 03.03.2023.
//

import UIKit

class RequestManager {
    
    var iTunesData: ITunesData?
    let decoder = JSONDecoder()
    let results: [Results]? = nil
    var session: URLSession
    static var shared = RequestManager( session: URLSession())
//    private init(iTunesData: ITunesData, sewssion: URLSession, result: Results) {
    private init(iTunesData: ITunesData? = nil, session: URLSession) {
        self.iTunesData = iTunesData
        self.session = session
    }
    
//        let configur = URLSessionConfiguration.default
//        session = URLSession(configuration: configur)
    
    var urlSessionDelegate: URLSessionDelegate?
    var image = UIImage()
    
    func getItunesData() {
        guard let fileLocation = Bundle.main.url(forResource: "API", withExtension: "json")
        else { return print("error location") }
        guard let data = try? Data(contentsOf: fileLocation) else { return print(ErrorPointer.self) }
        guard let result = try? decoder.decode(ITunesData.self, from: data) else { return print("error Decode") }
        passData(iTunesData: result)
        self.iTunesData = result
        
    }
    
    func passData(iTunesData: ITunesData?) {
        let vc = MainViewController()
        vc.iTunesData = iTunesData.self
    }
    
    
    func downloadImage(url: URL, completion: @escaping (Data?, Error?) -> (Void)) {
        let configur = URLSessionConfiguration.default
        session = URLSession(configuration: configur)
        let task = session.downloadTask(with: url) { url, response, error in
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
    
//    func downloadImage(url: URL){
//        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
//                if data != nil, error == nil {
////                    DispatchQueue.main.sync {
//                        if let downloadedImage = UIImage(data: data!) {
//                            self.image = downloadedImage                    }
//                        //                            self.image = UIImage(data: data!)
////                    }
//            }
//        }.resume()
//    }
//    func downloadImage(url: URL) {
//            URLSession.shared.dataTask(with: url) { (data, response, error) in
////                DispatchQueue.main.async {
//              guard let data = data else { return }
//
//                  self.image = UIImage(data: data)!
////              }
//            }.resume()
//
//        }
//        else { print("format Error")}
//        let session = URLSession(configuration: .default, delegate: urlSessionDelegate, delegateQueue: .main)
//        session.downloadTask(with: url).resume()
//
//    }
//
//    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
//        if let data = try? Data(contentsOf: location) {
//            if let image = UIImage(data: data) {
//                self.image = image
//            }
//        } else {
//            print("we didn't get the data")
//            return
//        }
    
}
extension UITableView {
    
    func registerXib(xibName: String) {
        let xib = UINib(nibName: xibName, bundle: nil)
        register(xib, forCellReuseIdentifier: xibName)
    }
    
}



