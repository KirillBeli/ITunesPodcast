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
    let modelView = ModelMainView()
    
    //MARK: - Outlet Collection
    @IBOutlet weak var searchBar: UISearchBar!{ didSet { self.searchBar.resignFirstResponder()}}
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modelView.navigationSet(viewController: self)
        modelView.getData() { [weak self] result in
            self?.iTunesData = result
            self?.filterData = (self?.iTunesData!.results)!
        }
        
        self.searchBar.delegate = self
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerXib(xibName: DetailsTableViewCell.className)
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
        modelView.setUpCell(result: result, cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = filterData[indexPath.row]
        modelView.showDetails(result: result, navigation: self.navigationController, tableView: tableView, index: indexPath)
    }
    
}

//MARK: - SearchBar Method
extension MainViewController: UISearchBarDelegate {
     func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterData = []
         modelView.searchBarSet(data: iTunesData!.results, bar: searchBar, searchText: searchText) { [weak self] (filter, word) in
             if let filter = filter as? [Results] {
                 self?.filterData = filter
             }
             if let word = word as? Results {
                 self?.filterData.append(word)
             }
         }
         self.tableView.reloadData()
         }
}
