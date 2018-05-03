//
//  HomeScreenController.swift
//  imin
//
//  Created by Rajesh Palkar on 4/26/18.
//  Copyright © 2018 Rajesh Palkar. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class HomeScreenController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    let bandCellId = "cell"
    var imgURL: String?
    
    let welcomeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Welcome,"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let usernameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Im'IN"
        lbl.textColor =  UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    lazy var profileImage: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "test")
        iv.backgroundColor = UIColor.orange
        iv.layer.cornerRadius = 50.0
        iv.layer.borderColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1).cgColor
        iv.layer.borderWidth = 1.0
        iv.layer.masksToBounds = false
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let recommendationsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Recommendations"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.boldSystemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
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
            return 80
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = UITableViewCell(style: .default, reuseIdentifier: "cell" )
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as!  BandCell
        
        let cell = BandCell(style: UITableViewCellStyle.default, reuseIdentifier: "cell\(indexPath.row)")
        
        //print(indexPath.row)
        
        

            cell.eventTitle.text = "Optimus prime"
            cell.dateLabel.text = "test"

        
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
        
        //***let lookup = lookups[(tableView.indexPathForSelectedRow?.row)!]
        
        //self.showDetailedMovie(movie:movie)
        
        
    }
    
    func setUpViews()
    {
        welcomeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        welcomeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        profileImage.leftAnchor.constraint(equalTo: view.rightAnchor, constant: -120).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        usernameLabel.topAnchor.constraint(equalTo: welcomeLabel.bottomAnchor, constant: 5).isActive = true
        usernameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        recommendationsLabel.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 20).isActive = true
        recommendationsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        tableView.topAnchor.constraint(equalTo: recommendationsLabel.bottomAnchor, constant: 10).isActive = true
        tableView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    }
    
    func getUserDetails()
    {
        
            let uid = Auth.auth().currentUser?.uid
            
            Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
                if let dictionary = snapshot.value as? [String: AnyObject]{
                    self.usernameLabel.text = dictionary["name"] as? String
                    self.imgURL = dictionary["ProfileImageUrl"] as? String
                    if let profileImageURL = self.imgURL
                    {
                        let url = URL(string : profileImageURL)
                        URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
                            if error != nil{
                                print(error ?? 0)
                                return
                            }
                            
                            DispatchQueue.main.async {
                                self.profileImage.image = UIImage(data: data!)
                            }
                            
                        }).resume()
                        
                    }
                }
            }, withCancel: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        getUserDetails()
        
        view.addSubview(welcomeLabel)
        view.addSubview(usernameLabel)
        view.addSubview(profileImage)
        view.addSubview(recommendationsLabel)
        view.addSubview(tableView)
        
        setUpViews()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(BandCell.self, forCellReuseIdentifier: bandCellId)
        
        
        self.tableView.allowsMultipleSelectionDuringEditing = false
        
        
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
        self.tabBarController?.navigationItem.title = "Im'IN"
        self.tabBarController?.navigationItem.rightBarButtonItem =  nil
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)]
    }
}
