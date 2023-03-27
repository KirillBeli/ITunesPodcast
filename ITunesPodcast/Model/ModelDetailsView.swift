//
//  ModelDetailsView.swift
//  ITunesPodcast
//
//  Created by Kyrylo Bielykov on 27.03.2023.
//

import Foundation
import UIKit

class ModelDetailsView {
    
    func setView(name: UILabel, track: UILabel, relese: UILabel, data: Results?, completion: @escaping (UIImage)->()) {
        name.text = data?.artistName
        track.text = data?.trackName
        relese.text = "Release: \(String(describing: data?.releaseDate))"
            .getDateWith12_24Logic()
            .getDateWithOutHours()
        if let result = data {
            let urlString = "\(result.artworkUrl600)"
            if let url = URL(string: "\(urlString)") {
                RequestManager.shared.downloadImage(url: url, completion: { data, error in
                    if let data = data {
                        DispatchQueue.main.sync {
                            if let image = UIImage(data: data) {
                                completion(image)
                            }
                            
                        }
                    }
                    
                })
                    
            }
        }
    }
}
