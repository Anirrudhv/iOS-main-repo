//
//  DetailsViewController.swift
//  Tumblr
//
//  Created by Anirudh V on 8/2/18.
//  Copyright © 2018 Anirudh V. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController,UIScrollViewDelegate {

    @IBOutlet weak var overviewtext: UILabel!
    var post :URL!
    var overview:String!
    @IBOutlet weak var DetailImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        DetailImage.af_setImage(withURL: post)
        print(overview)
        overviewtext.text = overview
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        overviewtext.text = overview
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
