//
//  EventDetailsController.swift
//  imin
//
//  Created by Rajesh Palkar on 5/3/18.
//  Copyright © 2018 Rajesh Palkar. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces
import GoogleMaps
import Firebase

class EventDetailsController: UIViewController {
    
    var id: String!
    var name: String!
    var address: String!
    var coordinates: CLLocationCoordinate2D!
    var interest: String!
    
    let eventLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Event"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let eventLabelContent: UILabel = {
        let lbl = UILabel()
        lbl.text = "Event"
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    let placeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Place"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let placeLabelContent: UILabel = {
        let lbl = UILabel()
        lbl.text = "Place"
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
    
    var mapViewContainer: GMSMapView = {
        let view = GMSMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    let iminButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 51/255, green: 153/255, blue: 255/255, alpha: 1)
        button.setTitle("Im'IN", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        button.addTarget(self, action: #selector(handleImINButton), for: .touchUpInside)
        
        
        return button
    }()
    
    @objc func handleImINButton(){
            let def = UserDefaults.standard
            
            guard let uid =   Auth.auth().currentUser?.uid
                else{
                    return
            }
            
            print(self.interest)
            print(self.name)
            print(self.address)
            print(self.coordinates)
            
        let values = ["id":self.id, "interest": self.interest, "place": self.name, "location": self.address, "latitude": String(self.coordinates.latitude),"longitude": String(self.coordinates.longitude)] as [String : Any]
                
            let ref = Database.database().reference(fromURL: "https://imin-f4d8c.firebaseio.com/")
            let userReference = ref.child("favorites").child(uid).child(id!)

            userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil {
                    print(error ?? 0)
                    return
                }
            })
            
            let alert = UIAlertController(
                title: "You're 'IN!",
                message: "Check your event in Going Tab",
                preferredStyle: UIAlertControllerStyle.alert)
            
            let action = UIAlertAction(title: "Okay", style: .default) { (action) in
                // do something when user press OK button, like deleting text in both fields or do nothing
                let settingsController = GoingScreenController()
                self.navigationController?.pushViewController(settingsController, animated: true)
            }
            
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        
    }
    
    
    func setUpViews()
    {
        eventLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        eventLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        eventLabelContent.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        eventLabelContent.leftAnchor.constraint(equalTo: eventLabel.rightAnchor, constant: 50).isActive = true
        
        placeLabel.topAnchor.constraint(equalTo: eventLabel.bottomAnchor, constant: 50).isActive = true
        placeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        placeLabelContent.topAnchor.constraint(equalTo: placeLabel.topAnchor, constant: -15).isActive = true
        placeLabelContent.leftAnchor.constraint(equalTo: eventLabelContent.leftAnchor).isActive = true
        placeLabelContent.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        placeLabelContent.bottomAnchor.constraint(equalTo: locationLabelContent.topAnchor).isActive = true
        placeLabelContent.numberOfLines = 0
        placeLabelContent.lineBreakMode = .byWordWrapping
        
        
        locationLabel.topAnchor.constraint(equalTo: placeLabel.bottomAnchor, constant: 50).isActive = true
        locationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        locationLabelContent.topAnchor.constraint(equalTo: locationLabel.topAnchor, constant: -15).isActive = true
        locationLabelContent.leftAnchor.constraint(equalTo: eventLabelContent.leftAnchor).isActive = true
        locationLabelContent.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -15).isActive = true
        locationLabelContent.bottomAnchor.constraint(equalTo: descText.topAnchor).isActive = true
        locationLabelContent.numberOfLines = 0
        locationLabelContent.lineBreakMode = .byWordWrapping
        
        descLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 50).isActive = true
        descLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        descText.topAnchor.constraint(equalTo: descLabel.topAnchor).isActive = true
        descText.leftAnchor.constraint(equalTo: eventLabelContent.leftAnchor).isActive = true
        descText.widthAnchor.constraint(equalToConstant: 120).isActive = true
        descText.heightAnchor.constraint(equalToConstant: 43).isActive = true
        descText.clipsToBounds = true
        descText.layer.cornerRadius = 5.0
        
        mapViewContainer.topAnchor.constraint(equalTo: descLabel.bottomAnchor, constant: 20).isActive = true
        mapViewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapViewContainer.widthAnchor.constraint(equalToConstant: 320).isActive = true
        mapViewContainer.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        iminButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35).isActive = true
        iminButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        iminButton.widthAnchor.constraint(equalToConstant: 320).isActive = true
        iminButton.heightAnchor.constraint(equalToConstant: 43).isActive = true
        iminButton.clipsToBounds = true
        iminButton.layer.cornerRadius = 5.0
    }
    
    func getDetails()
    {
        let uid = Auth.auth().currentUser?.uid
        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                self.eventLabelContent.text = dictionary["interest"] as? String
                self.interest = dictionary["interest"] as? String
            }
        }, withCancel: nil)
        
        self.placeLabelContent.text = self.name
        self.locationLabelContent.text = self.address
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        setUpNavigationBar()
        view.backgroundColor = UIColor.white
        
        view.addSubview(eventLabel)
        view.addSubview(placeLabel)
        view.addSubview(locationLabel)
        view.addSubview(eventLabelContent)
        view.addSubview(placeLabelContent)
        view.addSubview(locationLabelContent)
        view.addSubview(descLabel)
        view.addSubview(descText)
        view.addSubview(mapViewContainer)
        view.addSubview(iminButton)
        
        getDetails()
        setUpViews()
        
        
        let camera = GMSCameraPosition.camera(withLatitude: self.coordinates.latitude, longitude: self.coordinates.longitude, zoom: 12.0)
        self.mapViewContainer.camera = camera
        
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: self.coordinates.latitude, longitude: self.coordinates.longitude))
        marker.title = "Event Location"
        //marker.snippet = "Syracuse,New York"
        marker.map = self.mapViewContainer
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
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)]
        navigationItem.title = "Details"
        UINavigationBar.appearance().tintColor =  UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
    }
    
}
