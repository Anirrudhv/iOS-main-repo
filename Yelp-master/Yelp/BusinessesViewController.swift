//
//  BusinessesViewController.swift
//  Yelp
//
//  Created by Timothy Lee on 4/23/15.
//  Copyright (c) 2015 Timothy Lee. All rights reserved.
//

import UIKit

class BusinessesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate {
    
    var businesses: [Business]!
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    var filtereddata: [String]!
    var searchActive = false
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        searchBar.delegate = self
        
        Business.searchWithTerm(term: "Indian", completion: { (businesses: [Business]?, error: Error?) -> Void in
            
                self.businesses = businesses
                self.tableview.reloadData()
            
            self.tableview.rowHeight = UITableViewAutomaticDimension
            self.tableview.estimatedRowHeight = 120
                if let businesses = businesses {
                    for business in businesses {
                        print(business.name!)
                        print(business.address!)
                    }
                }
            
            }
        )
        
        /* Example of Yelp search with more search options specified
         Business.searchWithTerm(term: "Restaurants", sort: .distance, categories: ["asianfusion", "burgers"]) { (businesses, error) in
                self.businesses = businesses
                 for business in self.businesses {
                     print(business.name!)
                     print(business.address!)
                 }
         }
         */

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if businesses != nil
        {
            return businesses.count
        }else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: "BusinessCell", for: indexPath) as! BusinessCell
        cell.business = businesses[indexPath.row]
        return cell
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        searchActive = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        Business.searchWithTerm(term: searchBar.text!, completion: { (businesses: [Business]?, error: Error?) -> Void in
            if (businesses?.count != 0) {
                self.businesses = businesses
            }
            
            self.tableview.reloadData()
        }
        )
    }
}

