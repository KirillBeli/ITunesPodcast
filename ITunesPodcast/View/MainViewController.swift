//
//  ViewController.swift
//  ITunesPodcast
//
//  Created by Kyrylo Bielykov on 03.03.2023.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    //MARK: - Propertis
    var decoder = JSONDecoder()
    var iTunesData: ITunesData?
    var filterData = [Results]()
    var podImage: UIImage?
    
    //MARK: - Outlet Colection
    
    @IBOutlet weak var searchBar: UISearchBar!{ didSet { self.searchBar.resignFirstResponder()}}
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //MARK: - Set NavigationController
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let firstWindow = firstScene.windows.first else { return }
        let nav = UINavigationController(rootViewController: self)
        firstWindow.rootViewController = nav
        
        getData()
        self.searchBar.delegate = self
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerXib(xibName: DetailsTableViewCell.className)
}
    
    //MARK: - Get ITunesData
    func getData() {
        RequestManager.shared.getItunesData(forResource: "API", withExtension: "json") { [weak self] result in
            self?.iTunesData = result
            self?.filterData = (self?.iTunesData!.results)!
               }
    }
    
    //MARK: - TableView set.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.className) as? DetailsTableViewCell else {
            return UITableViewCell()
        }
          let result = filterData[indexPath.row]
        let reprisentedIdentifire = result.trackId
        cell.reprisentedIdentifire = reprisentedIdentifire
        if let url = URL(string: "\(result.artworkUrl100)") {
            RequestManager.shared.downloadImage(url: url, completion: { [weak self] data, error in
                if let data = data {
                    DispatchQueue.main.async {
//                        print(reprisentedIdentifire, cell.reprisentedIdentifire, reprisentedIdentifire == cell.reprisentedIdentifire)
                        if (cell.reprisentedIdentifire == reprisentedIdentifire) {
                            self?.podImage = UIImage(data: data)
                            cell.configure(with: result, image: self?.podImage)
                        }
                    }
                }
            })
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = filterData[indexPath.row] 
        self.showDetails(result: result)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    //MARK: - Navigation
    func showDetails(result: Results) {
        let viewController = DetailsViewController.makeFromNib(result: result)
        self.navigationController?.pushViewController(viewController, animated: true)
    }

}

//MARK: - SearchBar Method
extension MainViewController: UISearchBarDelegate {
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = []
        if searchBar.text == "" {
            filterData = iTunesData!.results
        }
        for word in iTunesData!.results {
            if word.trackName.contains(searchText) || word.artistName.contains(searchText) || word.collectionName.contains(searchText)  {
                filterData.append(word)
            }
            
        }
         self.tableView.reloadData()
    }
    
}
