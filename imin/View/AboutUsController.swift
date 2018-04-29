//
//  AboutUsController.swift
//  imin
//
//  Created by Rajesh Palkar on 4/28/18.
//  Copyright © 2018 Rajesh Palkar. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleMaps

class AboutUsController: UIViewController {

    // AIzaSyAxyw2ZbhU64pdzyfkee9dQlmplZecYqr8
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Developer\n    Name"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.numberOfLines = 0
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let nameLabelContent: UILabel = {
        let lbl = UILabel()
        lbl.text = "Rajesh Palkar"
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Developer\n    Email"
        lbl.numberOfLines = 0
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let emailLabelContent: UILabel = {
        let lbl = UILabel()
        lbl.text = "rpalkar@syr.edu"
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let officeMapLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Office Map"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
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
    
    
    
    let handsOnLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Our other \nProduct(s)"
        lbl.numberOfLines = 0
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    var youTubeContainer: UIWebView = {
        let view = UIWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    

    let contactUsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 51/255, green: 153/255, blue: 255/255, alpha: 1)
        button.setTitle("Contact us", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        //  button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)
        
        
        return button
    }()
    
    func setUpNavigationBar()
    {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)]
        
        navigationItem.title = "About us"
        UINavigationBar.appearance().tintColor =  UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
    }
    
    func setUpViews()
    {
        
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        
        nameLabelContent.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 20).isActive = true
        nameLabelContent.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 60).isActive = true
        
        emailLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 80).isActive = true
        emailLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        
        emailLabelContent.topAnchor.constraint(equalTo: nameLabelContent.topAnchor, constant: 60).isActive = true
        emailLabelContent.leftAnchor.constraint(equalTo: nameLabelContent.leftAnchor, constant: -15).isActive = true
        
        officeMapLabel.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 40).isActive = true
        officeMapLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        
        mapViewContainer.topAnchor.constraint(equalTo: officeMapLabel.bottomAnchor, constant: 10).isActive = true
        mapViewContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapViewContainer.widthAnchor.constraint(equalToConstant: 320).isActive = true
        mapViewContainer.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        handsOnLabel.bottomAnchor.constraint(equalTo: contactUsButton.topAnchor, constant: -50).isActive = true
        handsOnLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 65).isActive = true
        
        youTubeContainer.topAnchor.constraint(equalTo: mapViewContainer.bottomAnchor, constant: 30).isActive = true
        youTubeContainer.rightAnchor.constraint(equalTo: mapViewContainer.rightAnchor).isActive = true
        youTubeContainer.widthAnchor.constraint(equalToConstant: 120).isActive = true
        youTubeContainer.heightAnchor.constraint(equalToConstant: 120).isActive = true
        
        contactUsButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -45).isActive = true
        contactUsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        contactUsButton.widthAnchor.constraint(equalToConstant: 320).isActive = true
        contactUsButton.heightAnchor.constraint(equalToConstant: 43).isActive = true
        contactUsButton.clipsToBounds = true
        contactUsButton.layer.cornerRadius = 5.0
    
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = UIColor.white
        
        setUpNavigationBar()
        

        view.addSubview(nameLabel)
        view.addSubview(nameLabelContent)
        view.addSubview(emailLabel)
        view.addSubview(emailLabelContent)
        view.addSubview(officeMapLabel)
        view.addSubview(handsOnLabel)
        view.addSubview(contactUsButton)
        view.addSubview(mapViewContainer)
        view.addSubview(youTubeContainer)

    
        setUpViews()
        
        let camera = GMSCameraPosition.camera(withLatitude: 43.048122, longitude: -76.147424, zoom: 12.0)
        self.mapViewContainer.camera = camera
        
        let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: 43.048122, longitude: -76.147424))
        marker.title = "Im'In Headquaters"
        marker.snippet = "Syracuse,New York"
        marker.map = self.mapViewContainer
       
        youTubeContainer.allowsInlineMediaPlayback = true
        let myVideo = "https://www.youtube.com/embed/pm0GVC3iIcE"
        
        youTubeContainer.loadHTMLString("<iframe width=\"120\" height=\"120\" src=\"\(myVideo)\" frameborder=\"0\" allowfullscreen></iframe></body>",baseURL: nil)
        
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
