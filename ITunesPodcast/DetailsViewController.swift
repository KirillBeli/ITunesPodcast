//
//  DetailsViewController.swift
//  ITunesPodcast
//
//  Created by Kyrylo Bielykov on 03.03.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var details: Results?
//    var downloadSess = DownloadSession()
    @IBOutlet weak var podImage: UIImageView?
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var releseDateLebel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.artistNameLabel.text = details?.artistName
        self.trackNameLabel.text = details?.trackName
//        #error("set Date")
        self.releseDateLebel.text = details?.releaseDate
            .getDateWith12_24Logic()
            .getDateWithOutHours()
        if let result = details {
            let urlString = "\(result.artworkUrl600)"
            if let url = URL(string: "\(urlString)") {
                RequestManager.shared.downloadImage(url: url, completion: { [weak self] data, error in
                    if let data = data {
                        DispatchQueue.main.sync {
                            self?.podImage?.image = UIImage(data: data)
                        }
                    }
                    
                })
                    
            }
        }
    }
    
   
    //MARK: - Nib View
    static func makeFromNib(result: Results) -> DetailsViewController {
        let nibName = DetailsViewController.className
        let vc = DetailsViewController(nibName: nibName, bundle: nil)
        vc.details = result
        return vc
    }
}
