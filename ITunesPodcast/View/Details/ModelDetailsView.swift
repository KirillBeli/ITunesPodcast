//
//  ModelDetailsView.swift
//  ITunesPodcast
//
//  Created by Kyrylo Bielykov on 27.03.2023.
//

import Foundation
import UIKit

class ModelDetailsView {
    
     var details: Results?
    
    func getImage(completion: @escaping (UIImage)->()) {
        
        if let result = details {
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
