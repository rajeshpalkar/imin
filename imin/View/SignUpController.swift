//
//  SignUpController.swift
//  imin
//
//  Created by Rajesh Palkar on 4/26/18.
//  Copyright © 2018 Rajesh Palkar. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class SignUpController: UIViewController {
    
    var name: String!
    var email: String!
    var zip: String!
    
    let signUpLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Sign Up"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 36)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let seperatorLineBottom: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(displayP3Red: 220/255, green: 220/255, blue: 220/255, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameText: UITextField = {
        let tf = UITextField()
        tf.placeholder = "   Name"
        tf.backgroundColor = UIColor(displayP3Red: 157/255, green: 214/255, blue: 239/255, alpha: 1)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let emailText: UITextField = {
        let tf = UITextField()
        tf.placeholder = "   Email"
        tf.backgroundColor = UIColor(displayP3Red: 157/255, green: 214/255, blue: 239/255, alpha: 1)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()
    
    let passText: UITextField = {
        let tf = UITextField()
        tf.placeholder = "   Password"
        tf.backgroundColor =  UIColor(displayP3Red: 157/255, green: 214/255, blue: 239/255, alpha: 1)
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        return tf
    }()
    
    let zipcodeText: UITextField = {
        let tf = UITextField()
        tf.placeholder = "   Zipcode"
        tf.backgroundColor = UIColor(displayP3Red: 157/255, green: 214/255, blue: 239/255, alpha: 1)
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    }()

    let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 51/255, green: 153/255, blue: 255/255, alpha: 1)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        button.addTarget(self, action: #selector(handleSignUpUser), for: .touchUpInside)
        
        
        return button
    }()
    
    @objc func handleSignUpUser(){
        
        guard let email = emailText.text, let password = passText.text else{
            print("Not valid entries!")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password){ (user, error) in
            if(error != nil){
                print(error ?? 0)
                return
            }
            self.createUserDetailsInDatabase()
        }
    
        let alert = UIAlertController(
            title: "Account Created",
            message: "Redirecting to Profile Page!",
            preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            // do something when user press OK button, like deleting text in both fields or do nothing
        }
        
        alert.addAction(action)
        
        let menuController = TabBarMenuController()
        menuController.selectedIndex = 3
        let navController = UINavigationController(rootViewController: menuController)
        navController.modalTransitionStyle = .flipHorizontal
        self.present(navController, animated: true, completion: nil)
        
    }
    
    
    func createUserDetailsInDatabase()
    {
            name = self.nameText.text
            email = self.emailText.text
            zip = self.zipcodeText.text
        
            let values = ["name": self.name, "email": self.email, "zipcode": self.zip]
                        
            if(self.email == nil){
              self.email = Auth.auth().currentUser?.email
            }
                        
            guard let uid =   Auth.auth().currentUser?.uid
            else{
             return
             }
        
        let ref = Database.database().reference(fromURL: "https://imin-f4d8c.firebaseio.com/")
        let userReference = ref.child("users").child(uid)
        
        userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
            if error != nil {
                print(error ?? 0)
                return
            }
        })
        
    }

    func setUpViews(){
        
        view.backgroundColor = UIColor.white
        
        nameText.topAnchor.constraint(equalTo: view.topAnchor, constant: 180).isActive = true
        nameText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nameText.widthAnchor.constraint(equalToConstant: 280).isActive = true
        nameText.heightAnchor.constraint(equalToConstant: 43).isActive = true
        nameText.clipsToBounds = true
        nameText.layer.cornerRadius = 5.0
        
        emailText.topAnchor.constraint(equalTo: nameText.bottomAnchor, constant: 20).isActive = true
        emailText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailText.widthAnchor.constraint(equalToConstant: 280).isActive = true
        emailText.heightAnchor.constraint(equalToConstant: 43).isActive = true
        emailText.clipsToBounds = true
        emailText.layer.cornerRadius = 5.0
        
        
        passText.topAnchor.constraint(equalTo: emailText.bottomAnchor, constant: 20).isActive = true
        passText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passText.widthAnchor.constraint(equalToConstant: 280).isActive = true
        passText.heightAnchor.constraint(equalToConstant: 43).isActive = true
        passText.clipsToBounds = true
        passText.layer.cornerRadius = 5.0
        
        zipcodeText.topAnchor.constraint(equalTo: passText.bottomAnchor, constant: 20).isActive = true
        zipcodeText.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        zipcodeText.widthAnchor.constraint(equalToConstant: 280).isActive = true
        zipcodeText.heightAnchor.constraint(equalToConstant: 43).isActive = true
        zipcodeText.clipsToBounds = true
        zipcodeText.layer.cornerRadius = 5.0
        
        signUpButton.topAnchor.constraint(equalTo: zipcodeText.bottomAnchor, constant: 60).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 280).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 43).isActive = true
        signUpButton.clipsToBounds = true
        signUpButton.layer.cornerRadius = 5.0
    
        
    }
    
    func setUpNavigationBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain,
                                                           target: self, action: #selector(goToLoginScreen))
        navigationItem.leftBarButtonItem?.tintColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        navigationItem.title = "Sign Up"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)]
    }
    
    @objc func goToLoginScreen()
    {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.hideKeyboardWhenTappedAround()
        
        setUpNavigationBar()
        
          view.addSubview(nameText)
          view.addSubview(emailText)
          view.addSubview(passText)
          view.addSubview(zipcodeText)
          view.addSubview(signUpButton)
        
        setUpViews();

    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

