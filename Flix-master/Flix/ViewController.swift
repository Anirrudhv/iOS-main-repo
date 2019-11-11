//
//  ViewController.swift
//  Flix
//
//  Created by Anirudh V on 7/27/18.
//  Copyright © 2018 Anirudh V. All rights reserved.
//

import UIKit
import AlamofireImage
class ViewController: UIViewController,UITableViewDataSource,UISearchBarDelegate{
    
    @IBOutlet weak var ac: UIActivityIndicatorView!
    
    var refreshcontrol:UIRefreshControl!
    var issearching = false
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return movies.count
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        cell.Title.text = title
        cell.Overview.text = overview
        
        let posterpathstring = movie["poster_path"] as! String
        let baseURL = "https://image.tmdb.org/t/p/w500"
        let posterURL = URL(string: baseURL+posterpathstring)!
        cell.PosterImage.af_setImage(withURL: posterURL)
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.gray
        cell.selectedBackgroundView = backgroundView
        
        
        
        
        return cell
    }
    
    
    
    var movies: [[String:Any]] = []
    
    var filtereddata = [String]()
    

    @IBOutlet weak var TableView: UITableView!
    override func viewDidLoad() {
        
        //TableView.estimatedRowHeight = UITableViewAutomaticDimension
        TableView.rowHeight = 150
        refreshcontrol = UIRefreshControl()
        refreshcontrol.addTarget(self, action: #selector
            (ViewController.didpullrequest(_refreshcontrol:)), for: .valueChanged)
        TableView.insertSubview(refreshcontrol, at: 0)
       
        TableView.dataSource = self
        super.viewDidLoad()
        ac.startAnimating()

        networkRequest()
    
    }
    

    
    @objc func didpullrequest(_refreshcontrol: UIRefreshControl){
        networkRequest()
    }
    func networkRequest(){
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
                self.createAlert(title : "Network ERROR", message : "PLease connect to the internet")
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String:Any]]
                self.movies = movies
                self.TableView.reloadData()
                self.ac.stopAnimating()
                self.refreshcontrol.endRefreshing()
                
               // DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                //  self.ac.isHidden = true
              //  }
                
                
            }
        }
        task.resume()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        if let indexpath = TableView.indexPath(for: cell)
        {
            let movie = movies[indexpath.row]
            let DetailViewController = segue.destination as! DetailViewController
            DetailViewController.movie = movie
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func createAlert(title : String, message : String){
        let Alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        Alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in Alert.dismiss(animated: true, completion: nil)}))
        self.present(Alert, animated: true, completion: nil)
    }
   
    
    
    
}

