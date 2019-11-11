//
//  HomeViewController.swift
//  Instagram
//
//  Created by Anirudh V on 8/10/18.
//  Copyright © 2018 Anirudh V. All rights reserved.
//

import UIKit
import Parse

class HomeViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var TableView: UITableView!
    
    
    var posts: [PFObject] = []
    var refreshData: UIRefreshControl!
    @IBAction func OnLogout(_ sender: Any) {
        
        PFUser.logOutInBackground(block: { (error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("Successful loggout")
                // Load and show the login view controller
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let login = storyboard.instantiateViewController(withIdentifier: "LogIn") as! ViewController
                self.present(login, animated: true, completion: nil)
            }
        })
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
        
        refreshData = UIRefreshControl()
        refreshData.addTarget(self, action: #selector(HomeViewController.didPullToRefresh(_:)), for: .valueChanged)
        TableView.insertSubview(refreshData, at: 0)
        TableView.delegate = self
        TableView.dataSource = self
        
        getPosts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @objc func didPullToRefresh(_ refreshData: UIRefreshControl) {
        getPosts()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = TableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostCell
        
        let post = posts[indexPath.row]
        
        if let imageObject = post["media"] as? PFFile {
            imageObject.getDataInBackground(block: {
                (imageFile: Data!, error: Error!) -> Void in
                if error == nil {
                    let image = UIImage(data: imageFile)
                    cell.postImage.image = image
                }
            })
        }
        
        if let caption = post["caption"] as? String {
            cell.captionLabel.text = caption
        }
        
        return cell
    }
    func getPosts() {
        let query = PFQuery(className: "Post")
        query.addDescendingOrder("createdAt")
        query.limit = 20
        
        query.findObjectsInBackground(block: {(posts, err) in
            if err != nil {
                print(err?.localizedDescription as Any)
                self.refreshData.endRefreshing()
            } else if let posts = posts {
                self.posts = posts
                self.TableView.reloadData()
                self.refreshData.endRefreshing()
            }
        })
        
    }
    
    @IBAction func NewButton(_ sender: Any) {
        self.performSegue(withIdentifier: "ComposeSegue", sender: nil)
    }
}
