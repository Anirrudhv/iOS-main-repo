//
//  DetailViewController.swift
//  Flix
//
//  Created by Anirudh V on 8/1/18.
//  Copyright © 2018 Anirudh V. All rights reserved.
//

import UIKit

enum MovieKey{
    static let title = "title"
    static let backdroppath = "backdrop_path"
    static let posterpath = "poster_path"
}

class DetailViewController: UIViewController {
    @IBOutlet weak var TitleLabel: UILabel!
    @IBOutlet weak var BackDropImage: UIImageView!
    @IBOutlet weak var OverviewLabel: UILabel!
    @IBOutlet weak var PosterImage: UIImageView!
    @IBOutlet weak var ReleaseDate: UILabel!
    
    var movie : [String:Any]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movie = movie{
            TitleLabel.text = movie[MovieKey.title] as? String
            ReleaseDate.text = movie["release_date"] as? String
            OverviewLabel.text = movie["overview"] as? String
            let backdroppath = movie[MovieKey.backdroppath] as! String
            let posterpath = movie[MovieKey.posterpath] as! String
            let BaseURL = "https://image.tmdb.org/t/p/w500"
            let backdropURL = URL(string: BaseURL + backdroppath)!
            BackDropImage.af_setImage(withURL: backdropURL)
            let poserpathURL = URL(string: BaseURL + posterpath)!
            PosterImage.af_setImage(withURL: poserpathURL)
        }
        // Do any additional setup after loading the view.
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

}
