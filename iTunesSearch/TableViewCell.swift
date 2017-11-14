//
//  TableViewCell.swift
//  iTunesSearch
//
//  Created by Uzwal on 5/26/17.
//  Copyright © 2017 PracticeSession. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

  @IBOutlet weak var artworkUrl30: UIImageView!
  @IBOutlet weak var trackName: UILabel!
  @IBOutlet weak var trackPrice: UILabel!
  @IBOutlet weak var country: UILabel!
  var results: Results?
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  
  
  func configureCell(withItem item: Results?) {
    guard let currentItem = item else { return }
    trackName.text = currentItem.trackName
    trackPrice.text = currentItem.trackPrice
    country.text = currentItem.country
    if let thumbnailImageUrl = currentItem.artworkUrl30{
    artworkUrl30.downloadImage(from: thumbnailImageUrl)
    }
  }
  
  
}
