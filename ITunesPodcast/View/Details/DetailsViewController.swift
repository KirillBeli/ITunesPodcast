//
//  DetailsViewController.swift
//  ITunesPodcast
//
//  Created by Kyrylo Bielykov on 03.03.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    //MARK: - Propertis
    @IBOutlet weak var podImage: UIImageView?
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var releseDateLebel: UILabel!
    var model = ModelDetailsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        artistNameLabel.text = model.details?.artistName
        trackNameLabel.text = model.details?.trackName
        guard let text = model.details?.releaseDate
            .getDateWith12_24Logic()
            .getDateWithOutHours()
        else {return}
        releseDateLebel.text = "Releas: \(text)"
        model.getImage(completion: { [weak self] image in
            self?.podImage?.image = image
        })
    }
   
    //MARK: - Nib View
    static func makeFromNib(result: Results) -> DetailsViewController {
        let nibName = DetailsViewController.className
        let vc = DetailsViewController(nibName: nibName, bundle: nil)
        vc.model.details = result
        return vc
    }
}
