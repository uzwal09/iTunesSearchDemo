//
//  Extensions.swift
//  iTunesSearch
//
//  Created by Uzwal on 5/28/17.
//  Copyright © 2017 PracticeSession. All rights reserved.
//

import UIKit

let kItunes_podcast:String = "&entity=podcast"
let KItunes_Music_video:String = "&entity=musicVideo"
let KItunes_Ebook: String = "&entity=ebook"

extension UIImageView {
  
  func downloadImage(from url: String) {
    
    let urlRequest = URLRequest(url: URL(string: url)!)
    
    let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
      
      if error != nil {
        print("Error: \(error)")
        return
      }
      
      DispatchQueue.main.async {
        self.image = UIImage(data: data!)
      }
    }
    task.resume()
  }
}

extension UIViewController {
  func displayAlert(){
    let alert = UIAlertController(title: "Alert", message: "Please enter a key word(ex:Iceland)", preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
  
 
  
  
  func parseJSON(withData: Data?) -> [Results] {
    var results : [Results] = []
    do {
      // declaring new var to store json data
      let jsonData = try JSONSerialization.jsonObject(with: withData!, options: .mutableContainers) as! NSDictionary
      print ("json data :\(jsonData)")
      
      if let resultsFromJsonData = jsonData["results"] as? [[String:AnyObject]] {
        
        print ("resultsFromJsonData:\(resultsFromJsonData)")
        
        for resultFromJson in resultsFromJsonData {
          let result = Results()
          
          if let trackName = resultFromJson["trackName"] as? String {
            result.trackName = trackName
          }
          
          if let trackPrice = (resultFromJson["trackPrice"] as? Float) {
            let price = String (format: "%.2f", abs(trackPrice))
            result.trackPrice = price
          }
          
          if let ebookPrice = (resultFromJson["price"] as? Float) {
            let price = String (format: "%.2f", abs(ebookPrice))
            print ("\(price)")
            result.ebookPrice = price
          }
          
          if let currency = resultFromJson["currency"] as? String {
            result.currency = currency
          }
          
          if let country = resultFromJson["country"] as? String {
            result.country = country
          }
          
          if  let artworkUrl30 = resultFromJson["artworkUrl30"] as? String {
            
            result.artworkUrl30 = artworkUrl30
            
          }
          if  let artworkUrl100 = resultFromJson["artworkUrl100"] as? String {
            
            result.artworkUrl100 = artworkUrl100
            
          }
          results.append(result)
          
        }
      }
    }
    catch let jsonError {
      print(jsonError)
    }
    return results
  }
  
}





