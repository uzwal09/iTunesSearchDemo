//
//  DetailViewController.swift
//  iTunesSearch
//
//  Created by Uzwal on 5/28/17.
//  Copyright © 2017 PracticeSession. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
  
  @IBOutlet weak var titleName: UILabel!
  
  @IBOutlet weak var priceAmount: UILabel!
  
  @IBOutlet weak var countryOrigin: UILabel!
  
  @IBOutlet weak var imageArtwork: UIImageView!
  
  @IBOutlet weak var currency: UILabel!
  
  @IBOutlet weak var bookPricee: UILabel!
  var name: String?
  var price:String?
  var origin:String?
  var currencyType: String?
  var bookPrice:String?
  var artImage: UIImage?
  
  
  var selectedItem : Results?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    guard let currentItem = selectedItem else { return }
    titleName.text = currentItem.trackName
    priceAmount.text = currentItem.trackPrice
    countryOrigin.text = currentItem.country
    currency.text = currentItem.currency
    bookPricee.text = currentItem.ebookPrice
    guard let albumImage = currentItem.artworkUrl100 else { return }
    imageArtwork.downloadImage(from: albumImage)
    
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}
