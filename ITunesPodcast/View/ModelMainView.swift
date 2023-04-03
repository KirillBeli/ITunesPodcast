//
//  ModelMainView.swift
//  ITunesPodcast
//
//  Created by Kyrylo Bielykov on 27.03.2023.
//

import Foundation
import UIKit

class ModelMainView {
    
    //MARK: - Propertis
    private(set) var filterData: [Results] = []
    private(set) var podcastsResult: [Results] = []
    
    //MARK: - Get ITunesData
     func getData() {
         RequestManager.shared.getItunesData(forResource: "API", withExtension: "json") { [weak self] result in
             self?.podcastsResult = result.results
             guard let podcastsResult = self?.podcastsResult else {return}
             self?.filterData = podcastsResult
         }
    }
    
    //MARK: - TableView set
    
    func setUpCell(result: Results, cell: DetailsTableViewCell) {
        
        let reprisentedIdentifire = result.trackId
        cell.reprisentedIdentifire = reprisentedIdentifire
        if let url = URL(string: "\(result.artworkUrl100)") {
            RequestManager.shared.downloadImage(url: url, completion: { data, error in
                if let data = data {
                    DispatchQueue.main.async {
                        if (cell.reprisentedIdentifire == reprisentedIdentifire) {
                            if let image = UIImage(data: data) {
                                cell.configure(with: result, image: image)
                            }
                        }
                    }
                }
            })
        }
    }
    
    //MARK: - Search Methode
    func searchPodcast(searchText text: String, completion: () -> Void) {
        if text.isEmpty {
            self.filterData = podcastsResult
        }
        else {
            self.filterData = podcastsResult.filter {
                $0.artistName.contains(text) ||
                $0.trackName.contains(text) ||
                $0.collectionName.contains(text) }
        }
        completion()
    }
    
}
