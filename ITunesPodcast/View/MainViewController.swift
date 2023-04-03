//
//  ViewController.swift
//  ITunesPodcast
//
//  Created by Kyrylo Bielykov on 03.03.2023.
//

import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
  
    //MARK: - Propertis
    var model = ModelMainView()
    var decoder = JSONDecoder()
    var podImage: UIImage?
    
    //MARK: - Outlet Collection
    @IBOutlet weak var searchBar: UISearchBar!{ didSet { self.searchBar.resignFirstResponder()}}
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationSet()
        model.getData()
        
        self.searchBar.delegate = self
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerXib(xibName: DetailsTableViewCell.className)
}
    
    
    //MARK: - Set Navigation
    func navigationSet() {
        guard let firstScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
        guard let firstWindow = firstScene.windows.first else { return }
        let navigation = UINavigationController(rootViewController: self)
        firstWindow.rootViewController = navigation
    }
    
    //MARK: - TableView set.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.model.filterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DetailsTableViewCell.className) as? DetailsTableViewCell else {
            return UITableViewCell()
        }
        let result = model.filterData[indexPath.row]
            model.setUpCell(result: result, cell: cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let result = model.filterData[indexPath.row]
        showDetails(result: result)
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
        model.searchPodcast(searchText: searchText) {
            self.tableView.reloadData()
        }
    }
}
