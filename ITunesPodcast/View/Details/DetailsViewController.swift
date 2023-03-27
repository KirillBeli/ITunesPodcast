//
//  DetailsViewController.swift
//  ITunesPodcast
//
//  Created by Kyrylo Bielykov on 03.03.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var details: Results?
    @IBOutlet weak var podImage: UIImageView?
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var releseDateLebel: UILabel!
    let modelView = ModelDetailsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        modelView.setView(name: artistNameLabel, track: trackNameLabel, relese: releseDateLebel, data: details) { [weak self] image in
            self?.podImage?.image = image
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
