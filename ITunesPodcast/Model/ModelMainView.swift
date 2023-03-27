//
//  ModelMainView.swift
//  ITunesPodcast
//
//  Created by Kyrylo Bielykov on 27.03.2023.
//

import Foundation
import UIKit

class ModelMainView {
    
    
    //MARK: - Get ITunesData
    func getData(completion: @escaping (ITunesData) -> ()) {
        RequestManager.shared.getItunesData(forResource: "API", withExtension: "json") { result in
            completion(result)
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
                      } else {
                          NetworkManagerError.downloadError
                      }
                          
                          
                      }
                  }
              }
          })
      }
    }
    
    //MARK: - Navigation
    func showDetails(result: Results, navigation: UINavigationController?, tableView: UITableView, index: IndexPath) {
        let viewController = DetailsViewController.makeFromNib(result: result)
        navigation?.pushViewController(viewController, animated: true)
        tableView.deselectRow(at: index, animated: true)
    }
    
    //MARK: - Set Navigation
    func navigationSet(viewController: UIViewController) {
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let firstWindow = firstScene.windows.first else { return }
        let navigation = UINavigationController(rootViewController: viewController)
        firstWindow.rootViewController = navigation
    }
    
    func searchBarSet(data: [Results], bar: UISearchBar, searchText: String, completion: @escaping (Any?, Any?)->()) {
        if bar.text == "" {
            let filter = data
            completion(filter, nil)
        }
        for word in data {
            if word.trackName.contains(searchText) || word.artistName.contains(searchText) || word.collectionName.contains(searchText)  {
                completion(nil, word)
            }
            
        }
//         self.tableView.reloadData()
    }
}
