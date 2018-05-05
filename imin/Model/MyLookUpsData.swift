//
//  MyLookUpsData.swift
//  imin
//
//  Created by Rajesh Palkar on 5/2/18.
//  Copyright © 2018 Rajesh Palkar. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces

class Lookup : NSObject
{
    var title: String!
    var imgUrl: String!
    var date: String!
    var id: String!
}

class PlaceDetails: NSObject
{
    var id: String!
    var name: String!
    var address: String!
    var coordinates: CLLocationCoordinate2D!
    var photoReference: String!
}

class FavEvent: NSObject
{
    var id: String!
    var interest: String!
    var latitude: String!
    var longitude: String!
    var location: String!
    var placeName: String!
    var photoReference: String!
}


extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}



class BandCellReview : UITableViewCell
{
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier:  reuseIdentifier)
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
