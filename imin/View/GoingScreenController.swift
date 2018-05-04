//
//  GoingScreenController.swift
//  imin
//
//  Created by Rajesh Palkar on 4/26/18.
//  Copyright © 2018 Rajesh Palkar. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class GoingScreenController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let bandCellId = "cell"
    var lookups = [Lookup]()
    var favEvents = [FavEvent]()
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items:["Matched Events","My Look Ups"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.tintColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        sc.selectedSegmentIndex  = 0
        sc.addTarget(self, action: #selector(handleToggleChange), for: .valueChanged)
        return sc
    }()
    
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        return tv
    }()
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if segmentedControl.selectedSegmentIndex == 0 {
            return favEvents.count
        }else {
        return lookups.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = UITableViewCell(style: .default, reuseIdentifier: "cell" )
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!  BandCell
        
        let cell = BandCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell\(indexPath.row)")
    
        
        if segmentedControl.selectedSegmentIndex == 0 {
           let favEvent = favEvents[indexPath.row]
            cell.eventTitle.text = favEvent.placeName
            cell.dateLabel.text = favEvent.interest
        }else {
            let lookup = lookups[indexPath.row]
            cell.eventTitle.text = lookup.title
            cell.dateLabel.text = lookup.date
        }
        
         cell.eventPicture.image = UIImage(named: "test")
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //   let indexPath = tableView.indexPathForSelectedRow
        //getting the current cell from the index path
        //  let currentCell = tableView.cellForRow(at: indexPath!)! as UITableViewCell
        
        if segmentedControl.selectedSegmentIndex == 0 {
             let favEvent = favEvents[(tableView.indexPathForSelectedRow?.row)!]
            self.showDetailedEvent(favEvent:favEvent)
        }else {
            let lookup = lookups[(tableView.indexPathForSelectedRow?.row)!]
            
            self.showDetailedLookup(lookup:lookup)
        }
      
    }
    
    func showDetailedLookup(lookup: Lookup)
    {
        let detailedController = LookUpDetailsController()
        detailedController.id = lookup.id
        navigationController?.pushViewController(detailedController, animated: true)
    }
    
    func showDetailedEvent(favEvent: FavEvent)
    {
        let detailedController = MyEventDetailsController()
         detailedController.id = favEvent.id
         detailedController.interest = favEvent.interest
         detailedController.latitude = favEvent.latitude
         detailedController.longitude = favEvent.longitude
         detailedController.place = favEvent.placeName
         detailedController.location = favEvent.location
       
        navigationController?.pushViewController(detailedController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            // remove the item from the data model
            lookups.remove(at: indexPath.row)
            
            // delete the table view row
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            // Not used in our example, but if you were adding a new row, this is where you would do it.
        }
    }
    
    
    @objc func handleToggleChange(){
        if segmentedControl.selectedSegmentIndex == 0 {
            tableView.setContentOffset(CGPoint.zero, animated: true)
            fetchFavEvents()
            tableView.reloadData()
        }else {
            tableView.setContentOffset(CGPoint.zero, animated: true)
            fetchLookups()
            tableView.reloadData()
        }
        
    }
    
    func setUpViews()
    {
        segmentedControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        segmentedControl.widthAnchor.constraint(equalToConstant: 300).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        tableView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 700).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func fetchFavEvents()
    {
        guard let uid =   Auth.auth().currentUser?.uid
            else{
                return
        }
        print(uid)
        favEvents.removeAll()
        Database.database().reference().child("favorites").child(uid).observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let myEvent = FavEvent()
                
                myEvent.id = dictionary["id"] as! String
                myEvent.interest = dictionary["interest"] as! String
                myEvent.latitude = dictionary["latitude"] as! String
                myEvent.longitude = dictionary["longitude"] as! String
                myEvent.location = dictionary["location"] as! String
                myEvent.placeName = dictionary["place"] as! String
                
                
                
                self.favEvents.append(myEvent)
                print(myEvent.interest)
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            print(snapshot)
        }, withCancel: nil)
    }
    
    func fetchLookups(){
        guard let uid =   Auth.auth().currentUser?.uid
            else{
                return
        }
        print(uid)
        lookups.removeAll()
        Database.database().reference().child("lookups").child(uid).observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                let myLookup = Lookup()
                
                myLookup.title = dictionary["interest"] as! String
                myLookup.date = dictionary["date"] as! String
                myLookup.id = dictionary["id"] as! String
                
            
                
                self.lookups.append(myLookup)
                print(myLookup.title)
                
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
            print(snapshot)
        }, withCancel: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchLookups()
        fetchFavEvents()
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        view.addSubview(segmentedControl)
        view.addSubview(tableView)
        
        setUpViews()
        
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(BandCell.self, forCellReuseIdentifier: bandCellId)
        
        
        self.tableView.allowsMultipleSelectionDuringEditing = false
        
       view.backgroundColor = UIColor.white
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpNavigationBar()
    }
    
    func setUpNavigationBar()
    {
        self.tabBarController?.navigationItem.title = "Going"
        self.tabBarController?.navigationItem.rightBarButtonItem =  nil
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)]
    }
}

class BandCell : UITableViewCell
{
    
    let eventPicture: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "test")
        iv.layer.cornerRadius = 20.0
        iv.layer.borderColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1).cgColor
        iv.layer.borderWidth = 1.0
        iv.layer.masksToBounds = false
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = true
        return iv
    }()
    
    let eventTitle: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = true
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.adjustsFontSizeToFitWidth = false
        lbl.lineBreakMode = NSLineBreakMode.byTruncatingTail
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        return lbl
    }()
    
    let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "0"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.adjustsFontSizeToFitWidth = false
        lbl.lineBreakMode = NSLineBreakMode.byTruncatingTail
        lbl.font = UIFont.boldSystemFont(ofSize: 18)
        
        return lbl
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier:  reuseIdentifier)
        setup()
    }
    
    
    
    func setup()
    {
        
        eventPicture.frame = CGRect(x: 20, y: 10, width: 50, height: 50)
        eventTitle.frame = CGRect(x: 80, y: 10, width: 250, height: 20)
        dateLabel.frame =  CGRect(x: 100, y: 40, width:250, height: 20)
        
        contentView.addSubview(eventTitle)
        contentView.addSubview(eventPicture)
        contentView.addSubview(dateLabel)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}



