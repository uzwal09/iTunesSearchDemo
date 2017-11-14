//
//  ViewController.swift
//  iTunesSearch
//
//  Created by Uzwal on 5/26/17.
//  Copyright © 2017 PracticeSession. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
  
  @IBOutlet weak var searchBar: UISearchBar!
  @IBOutlet weak var tableView: UITableView!
  
  var resultsArray: [Results]? = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.navigationController?.isNavigationBarHidden = true
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    // Hide the navigation bar on the this view controller
    self.navigationController?.setNavigationBarHidden(true, animated: animated)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    
    // Show the navigation bar on other view controllers
    self.navigationController?.setNavigationBarHidden(false, animated: animated)
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ToDetailViewController", let destination = segue.destination as? DetailViewController{
      
      if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell), let library = resultsArray {
        destination.selectedItem = library[indexPath.row]
      }
    }
  }
}


extension HomeViewController : UITableViewDelegate, UITableViewDataSource {

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.resultsArray?.count ?? 0
  }
  
  
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell:TableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "messageCell", for: indexPath) as! TableViewCell
    cell.configureCell(withItem: resultsArray?[indexPath.row])
    
    return cell
  }
}

extension HomeViewController: UISearchBarDelegate {
  
  // Search Bar functionality
  func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
    searchBar.setShowsCancelButton(true, animated: true)
    return true
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    searchBar.setShowsCancelButton(false, animated: true)
    searchBar.text = " "
  }
  
  func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    if searchBar.text!.isEmpty{
      displayAlert()
    } else {
      self.fetchResults(completion: { (data) in
      self.resultsArray = self.parseJSON(withData: data)
        DispatchQueue.main.async (execute: {
          self.tableView.reloadData()
        })
      })
    }
  }
  
  
  
  func searchBar(_ searchBar: UISearchBar,selectedScopeButtonIndexDidChange selectedScope: Int) {
    if searchBar.text!.isEmpty || searchBar.text == " " {
      displayAlert()
    }else {
      self.fetchResults(completion: { (data) in
        self.resultsArray = self.parseJSON(withData: data)
        DispatchQueue.main.async (execute: {
          self.tableView.reloadData()
        })
      })
    }
  }
}

extension HomeViewController {
  
  func getUrlEntity()-> String {
    if  searchBar.selectedScopeButtonIndex == 0 {
      return KItunes_Music_video
    }else if searchBar.selectedScopeButtonIndex == 1 {
      return kItunes_podcast
    }
    return KItunes_Ebook
  }
  
  func createURLWithComponents() -> URL? {
    let urlComponents = NSURLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "itunes.apple.com"
    urlComponents.path = "/search"
    urlComponents.query = "term=" + "\(self.getSearchBarString()!)" + "\(self.getUrlEntity())"
    
    return urlComponents.url
    
  }
  
  func getSearchBarString()-> String? {
    guard let searchBarString = searchBar?.text  else { return nil }
    let newString = searchBarString.replacingOccurrences(of: " ", with: "+")
    return newString
  }
  
  
  func fetchResults(completion:@escaping (Data?)->()){
    
    let urlString = self.createURLWithComponents()?.absoluteString
    let urlRequest = URLRequest(url: URL(string: urlString!)!)
    
    // executing network call
    let task = URLSession.shared.dataTask(with: urlRequest) { (data,response,error) in
      // error
      if error != nil {
        print("Error fetching results: \(error)")
        DispatchQueue.main.async (execute: {
          self.displayAlertforJsonError()
        })
        
        return
      }
      
      // get back json Data

      completion(data)
    }
    task.resume()
    print(task)
    
  }
  
  func displayAlertforJsonError(){
    let alert = UIAlertController(title: "No results " , message:"no search results found"  , preferredStyle: UIAlertControllerStyle.alert)
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    self.present(alert, animated: true, completion: nil)
  }
}

