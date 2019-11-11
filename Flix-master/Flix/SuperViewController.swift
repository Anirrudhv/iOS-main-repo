//
//  SuperViewController.swift
//  Flix
//
//  Created by Anirudh V on 8/1/18.
//  Copyright © 2018 Anirudh V. All rights reserved.
//

import UIKit

class SuperViewController: UIViewController,UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
   
    var movies: [[String:Any]] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumInteritemSpacing = 3
        layout.minimumLineSpacing = layout.minimumInteritemSpacing
        let cellsperline : CGFloat = 2
        let interimspace = layout.minimumLineSpacing * (cellsperline - 1)
        let width = collectionView.frame.size.width / cellsperline - interimspace / cellsperline
        layout.itemSize = CGSize(width: width, height: width * 3 / 2)
        
        
        networkRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PosterCell", for: indexPath) as! PosterCell
        let movie = movies[indexPath.item]
        if let posterpathString = movie["poster_path"] as? String
        {
            let baseURL = "https://image.tmdb.org/t/p/w500"
            let posterURL = URL (string: baseURL+posterpathString)!
            cell.PosterImageView.af_setImage(withURL: posterURL)
        }
    return cell
        
    }
    func networkRequest(){
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                let movies = dataDictionary["results"] as! [[String:Any]]
                self.movies = movies
                self.collectionView.reloadData()
                
                // DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                //  self.ac.isHidden = true
                //  }
                
                
            }
        }
        task.resume()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UICollectionViewCell
        if let indexpath = collectionView.indexPath(for: cell)
        {
            let movie = movies[indexpath.row]
            let DetailViewController = segue.destination as! DetailViewController
            DetailViewController.movie = movie
        }
    }
}
