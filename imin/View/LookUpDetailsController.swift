//
//  LookUpDetailsController.swift
//  imin
//
//  Created by Rajesh Palkar on 5/3/18.
//  Copyright © 2018 Rajesh Palkar. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LookUpDetailsController: UIViewController {
    
     var id: String!
    
    let interestLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Interest"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let interestLabelContent: UILabel = {
        let lbl = UILabel()
        lbl.text = "Interest"
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Date"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let dateLabelContent: UILabel = {
        let lbl = UILabel()
        lbl.text = "Date"
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    
    
    let timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Time"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let timeLabelContent: UILabel = {
        let lbl = UILabel()
        lbl.text = "Time"
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let locationLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Location"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let locationLabelContent: UILabel = {
        let lbl = UILabel()
        lbl.text = "Location"
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    
    let radiusLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Radius"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let radiusLabelContent: UILabel = {
        let lbl = UILabel()
        lbl.text = "Radius"
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let descLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Desc"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let descText: UITextField = {
        let tf = UITextField()
        tf.placeholder = "   Description"
        tf.backgroundColor = UIColor(displayP3Red: 157/255, green: 214/255, blue: 239/255, alpha: 1)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    
    
    func setUpViews()
    {
        interestLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        interestLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        interestLabelContent.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        interestLabelContent.leftAnchor.constraint(equalTo: interestLabel.rightAnchor, constant: 50).isActive = true
        
        dateLabel.topAnchor.constraint(equalTo: interestLabel.bottomAnchor, constant: 50).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        dateLabelContent.topAnchor.constraint(equalTo: dateLabel.topAnchor).isActive = true
        dateLabelContent.leftAnchor.constraint(equalTo: interestLabelContent.leftAnchor).isActive = true
        
        timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 50).isActive = true
        timeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        timeLabelContent.topAnchor.constraint(equalTo: timeLabel.topAnchor).isActive = true
        timeLabelContent.leftAnchor.constraint(equalTo: interestLabelContent.leftAnchor).isActive = true
        
        locationLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 50).isActive = true
        locationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        locationLabelContent.topAnchor.constraint(equalTo: locationLabel.topAnchor).isActive = true
        locationLabelContent.leftAnchor.constraint(equalTo: interestLabelContent.leftAnchor).isActive = true
        
        radiusLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 50).isActive = true
        radiusLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        radiusLabelContent.topAnchor.constraint(equalTo: radiusLabel.topAnchor).isActive = true
        radiusLabelContent.leftAnchor.constraint(equalTo: radiusLabel.rightAnchor, constant: 60).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: radiusLabel.bottomAnchor, constant: 50).isActive = true
        descLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        descText.topAnchor.constraint(equalTo: descLabel.topAnchor).isActive = true
        descText.leftAnchor.constraint(equalTo: interestLabelContent.leftAnchor).isActive = true
        descText.widthAnchor.constraint(equalToConstant: 120).isActive = true
        descText.heightAnchor.constraint(equalToConstant: 43).isActive = true
        descText.clipsToBounds = true
        descText.layer.cornerRadius = 5.0
        
    }
    
    func getDetails()
    {
        let uid = Auth.auth().currentUser?.uid
        print(id!)
        Database.database().reference().child("lookups").child(uid!).child(id).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                self.interestLabelContent.text = dictionary["interest"] as? String
                self.dateLabelContent.text = dictionary["date"] as? String
                self.timeLabelContent.text = dictionary["time"] as? String
                self.locationLabelContent.text = dictionary["location"] as? String
                self.radiusLabelContent.text = dictionary["radius"] as? String
                self.descText.text = dictionary["desc"] as? String
            }
        }, withCancel: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        view.backgroundColor = UIColor.white
        
        view.addSubview(interestLabel)
        view.addSubview(timeLabel)
        view.addSubview(dateLabel)
        view.addSubview(locationLabel)
        view.addSubview(radiusLabel)
        view.addSubview(interestLabelContent)
        view.addSubview(timeLabelContent)
        view.addSubview(dateLabelContent)
        view.addSubview(locationLabelContent)
        view.addSubview(radiusLabelContent)
        view.addSubview(descLabel)
        view.addSubview(descText)

        getDetails()
        
        setUpViews()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpNavigationBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    
    
    func setUpNavigationBar()
    {
        self.tabBarController?.navigationItem.title = "Look Up"
        self.tabBarController?.navigationItem.rightBarButtonItem =  nil
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)]
    }
    
}
