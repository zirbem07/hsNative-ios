//
//  ChatViewController.swift
//  HealthSnapsProject
//
//  Created by Maxwell Zirbel on 9/30/17.
//  Copyright © 2017 Maxwell Zirbel. All rights reserved.
//

import UIKit

class ChatViewController: UIViewController, UITableViewDelegate,
    UITableViewDataSource,
    UISearchResultsUpdating,
    UISearchBarDelegate {
    
    @IBOutlet weak var tblSearchResults: UITableView!
    
    var dataArray = [chatObject]()
    var filteredArray = [chatObject]()
    var shouldShowSearchResults = false
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        dataArray.append(chatObject(Name: "Jordan Mather", Status: "Sent 5:32 PM", temp: true))
        dataArray.append(chatObject(Name: "Max Zirbel", Status: "Recieved 3:12 AM", temp: false))
        dataArray.append(chatObject(Name: "Tony Stark", Status: "Recieved 2:59 AM", temp: false))
        dataArray.append(chatObject(Name: "Peter Parker", Status: "Sent 6:36 PM", temp: true))
        dataArray.append(chatObject(Name: "Jane Goodal", Status: "Recieved 8:45 PM", temp: true))
        
        
        tblSearchResults.delegate = self
        tblSearchResults.dataSource = self
        tblSearchResults.layer.cornerRadius = 15
        
        tblSearchResults.reloadData()
        //configureSearchController()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return filteredArray.count
        }
        else {
            return dataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell") as! ChatTableViewCell
        
        if shouldShowSearchResults {
            cell.nameLabel.text = dataArray[indexPath.row].Name
            cell.statusLabel.text = dataArray[indexPath.row].Status
            if dataArray[indexPath.row].temp {
                cell.imageView?.image = UIImage(named:"blue_triangle_filled")
            } else {
                cell.imageView?.image = UIImage(named:"orange_square_open")
            }
        }
        else {
            cell.nameLabel.text = dataArray[indexPath.row].Name
            cell.statusLabel.text = dataArray[indexPath.row].Status
            if dataArray[indexPath.row].temp {
                cell.imageView?.image = UIImage(named:"blue_triangle_filled")
            } else {
                cell.imageView?.image = UIImage(named:"orange_square_open")
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 60.0
    }
    
    func configureSearchController() {
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Chat..."
        searchController.searchBar.isTranslucent = true
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        tblSearchResults.tableHeaderView = searchController.searchBar
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredArray = dataArray.filter({(chat: chatObject) -> Bool in
            return Bool(chat.Name.contains(searchText))
        })
        
        tblSearchResults.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tblSearchResults.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tblSearchResults.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults {
            shouldShowSearchResults = true
            tblSearchResults.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }

}

class ChatTableViewCell: UITableViewCell {
    
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
}

class chatObject {
    var Image = UIImage()
    var Name: String
    var Status: String
    var temp: Bool
    
    init (Name: String, Status: String, temp: Bool) {
        self.Name = Name
        self.Status = Status
        self.temp = temp
    }
}


