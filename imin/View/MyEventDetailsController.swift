//
//  MyEventDetailsController.swift
//  imin
//
//  Created by Rajesh Palkar on 5/4/18.
//  Copyright © 2018 Rajesh Palkar. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces
import GoogleMaps
import Firebase

class MyEventDetailsController: UIViewController {
    
    var id: String!
    var place: String!
    var location: String!
    var latitude: String!
    var longitude: String!
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
    
    var mapViewContainer: GMSMapView = {
        let view = GMSMapView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
  
    

    
    
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
        locationLabelContent.bottomAnchor.constraint(equalTo: mapViewContainer.topAnchor).isActive = true
        locationLabelContent.numberOfLines = 0
        locationLabelContent.lineBreakMode = .byWordWrapping
        
        
        mapViewContainer.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 40).isActive = true
        mapViewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapViewContainer.widthAnchor.constraint(equalToConstant: 320).isActive = true
        mapViewContainer.heightAnchor.constraint(equalToConstant: 220).isActive = true
        

    }
    
    func getDetails()
    {
        self.eventLabelContent.text = self.interest
        self.placeLabelContent.text = self.place
        self.locationLabelContent.text = self.location
        print(self.interest)
        print(self.place)
        print(self.location)
        print(self.latitude)
        print(self.longitude)
        print(self.id)
        
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
        view.addSubview(mapViewContainer)

        
        getDetails()
        setUpViews()
        
        
        let camera = GMSCameraPosition.camera(withLatitude: Double(self.latitude)!, longitude: Double(self.longitude)!, zoom: 12.0)
        self.mapViewContainer.camera = camera
        
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: Double(self.latitude)!, longitude: Double(self.longitude)!))
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
