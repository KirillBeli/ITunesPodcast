//
//  DetailsTableViewCell.swift
//  ITunesPodcast
//
//  Created by Kyrylo Bielykov on 03.03.2023.
//

import UIKit

class DetailsTableViewCell: UITableViewCell, URLSessionDelegate {

    var reprisentedIdentifire: Int = 0
    var image: UIImage?
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var podcastImage: UIImageView?
    
    func configure(with result: Results, image: UIImage?) {
        artistNameLabel.text = result.artistName
        trackNameLabel.text = result.trackName
        podcastImage?.image = image
    }
  
}


