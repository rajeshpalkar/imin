//
//  TabBarMenuController.swift
//  imin
//
//  Created by Rajesh Palkar on 4/26/18.
//  Copyright © 2018 Rajesh Palkar. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class TabBarMenuController: UITabBarController {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.orange
        
        
        UITabBar.appearance().tintColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        
        let firstViewController = HomeScreenController()
        firstViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(named: "home"), tag: 0)
        firstViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 3, left: 0, bottom: -3, right: 0)
       
        
        let secondViewController = LookUpScreenController()
        secondViewController.tabBarItem = UITabBarItem(title: "Look Up", image: UIImage(named: "lookup"), tag: 1)
        secondViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
       
        
        let thirdViewController = GoingScreenController()
        thirdViewController.tabBarItem = UITabBarItem(title: "Going", image: UIImage(named: "star"), tag: 2)
        thirdViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
     
        
        let forthViewController = ProfileScreenController()
        forthViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 3)
        forthViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 2, left: 0, bottom: -2, right: 0)
       
        
        let tabBarList = [firstViewController, secondViewController, thirdViewController, forthViewController]
        
        
        viewControllers = tabBarList
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

