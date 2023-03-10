//
//  ViewController.swift
//  ITunesPodcast
//
//  Created by Kyrylo Bielykov on 03.03.2023.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Propertis
//    var presentor = RequestManager()
    var decoder = JSONDecoder()
    var iTunesData: ITunesData?
    
    //MARK: - Outlet Colection
    @IBOutlet weak var SearchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RequestManager.shared.getItunesData()
        self.iTunesData = RequestManager.shared.iTunesData
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerXib(xibName: DetailsTableViewCell.className)
    }
    
    //MARK: - TableView set.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return iTunesData?.results.count ?? 0
    }
    
//    var downloadSess = DownloadSession()
    var podImage = UIImage()
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.className) as? DetailsTableViewCell else {
            return UITableViewCell()
        }
        if  let result = iTunesData?.results[indexPath.row] {
            if let url = URL(string: "\(result.artworkUrl100)") {
                RequestManager.shared.downloadImage(url: url, completion: { data, error in
                    if let data = data {
                        DispatchQueue.main.sync {
                            self.podImage = UIImage(data: data)!
                            cell.configure(with: result, image: self.podImage)
                        }
                    }
                })
                                     
                                        

                
                
        }
    }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let result = iTunesData?.results[indexPath.row] else { return }
        self.showDetails(result: result)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    //MARK: - Navigation
    func showDetails(result: Results) {
        let viewController = DetailsViewController.makeFromNib(result: result)
        self.navigationController?.pushViewController(viewController, animated: true)
    
    }
    
}
