//
//  ProfileScreenController.swift
//  imin
//
//  Created by Rajesh Palkar on 4/26/18.
//  Copyright © 2018 Rajesh Palkar. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class ProfileScreenController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orange
     
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
        self.tabBarController?.navigationItem.rightBarButtonItem  = UIBarButtonItem(image: UIImage(named: "settings"), style: .plain, target: self , action: #selector(handleSettings))
        self.tabBarController?.navigationItem.rightBarButtonItem?.imageInsets = UIEdgeInsets(top: 1, left: 2, bottom: -1, right: -2)
        self.tabBarController?.navigationItem.title = "Profile"
        self.tabBarController?.navigationItem.rightBarButtonItem?.tintColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
    }
    
    @objc func handleSettings(){
        let settingsController = SettingsController()
        //detailedController.id = movie.id
        navigationController?.pushViewController(settingsController, animated: true)
    }
}

