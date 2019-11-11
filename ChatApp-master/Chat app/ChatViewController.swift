//
//  ChatViewController.swift
//  Chat app
//
//  Created by Anirudh V on 8/9/18.
//  Copyright © 2018 Anirudh V. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
        var refreshControl:UIRefreshControl!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell") as! ChatCellTableViewCell
        
        cell.mess = (messages[indexPath.row]["text"] as? String)!
        cell.username = (messages[indexPath.row]["user"] as? PFObject)?["username"] as? String ?? "EMPTY"
        
        return cell
    }
    
    @IBOutlet weak var ChatField: UITextField!
    var messages:[PFObject] = []
    @IBOutlet weak var TableView: UITableView!
    @IBAction func Message(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = ChatField.text ?? ""
        chatMessage["user"] = PFUser.current()
    chatMessage.saveInBackground { (success, error) in
    if success {
    print("The message was saved!")
        self.ChatField.text = ""
    } else if let error = error {
    print("Problem saving message: \(error.localizedDescription)")
    }
        
        }}

    override func viewDidLoad() {
        super.viewDidLoad()
        if let currentUser = PFUser.current() {
            print("Welcome back \(currentUser.username!) 😀")
            self.createAlert(title: "Welcome back", message: "Welcome back : \(currentUser.username!)")
            
        }
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector
        (ChatViewController.didpullrequest(_refreshControl:)), for: .valueChanged)
        TableView.insertSubview(refreshControl, at: 0)
        
        
        
        TableView.separatorStyle = .none
        TableView.estimatedRowHeight = 50
        TableView.rowHeight = UITableViewAutomaticDimension
        TableView.delegate = self
        TableView.dataSource = self
        
        //        updateMessages()
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer: Timer) in
            self.updateMessages()
        }
    }
    @objc func didpullrequest(_refreshControl: UIRefreshControl){
        updateMessages()
        
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
    private func updateMessages() {
        let query = PFQuery(className:"Message")
        //        query.whereKey("playerName", equalTo:"Sean Plott")
        query.order(byDescending: "createdAt")
        query.includeKey("user")
        query.findObjectsInBackground {
            (objects: [PFObject]?, error: Error?) -> Void in
            
            if error == nil {
                // The find succeeded.
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                            print(object["text"] )
                        
                    }
                }
                
                self.messages = objects!
                self.TableView.reloadData()
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.localizedDescription)")
            }
            self.refreshControl.endRefreshing()
        }
    }
    func createAlert(title : String, message : String){
        let Alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        Alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: {(action) in Alert.dismiss(animated: true, completion: nil)}))
        self.present(Alert, animated: true, completion: nil)
    }

}
