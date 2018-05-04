//
//  SettingsController.swift
//  imin
//
//  Created by Rajesh Palkar on 4/27/18.
//  Copyright © 2018 Rajesh Palkar. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import GoogleSignIn

class SettingsController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imgURL: String!
    
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
        iv.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleProfileImageView)))
        iv.isUserInteractionEnabled = true
        
        return iv
    }()
    
    @objc func handleProfileImageView()
    {
        print(123)
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        var selectedImage : UIImage?
        
        if let editedImage = info["UIImagePickerControllerEditedImage"] as? UIImage{
            selectedImage = editedImage
        }else if let originalImage = info["UIImagePickerControllerOriginalImage"] as? UIImage{
            selectedImage = originalImage
        }
        
        if let selImg = selectedImage{
            profileImage.image = selImg
        }
        
        updateImageInDatabase()
        
        dismiss(animated: true, completion: nil)
    }
    
    func updateImageInDatabase()
    {
        let imageName = NSUUID().uuidString
        
        let storageRef = Storage.storage().reference().child("Profile_Images").child("\(imageName).png")
        if let uploadData = UIImagePNGRepresentation(self.profileImage.image!){
            storageRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                if error != nil{
                    print(error ?? 0)
                    return
                }
                
                guard let uid =   Auth.auth().currentUser?.uid
                    else{
                        return
                }
                
                if let profileImageURL = metadata?.downloadURL()?.absoluteString{
                    let values = ["ProfileImageUrl": profileImageURL]
                
                    let ref = Database.database().reference(fromURL: "https://imin-f4d8c.firebaseio.com/")
                    print(ref)
                    print(uid)
                    let userReference = ref.child("users").child(uid)
                    print(userReference)
                    
                    userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                        if error != nil {
                            print(error ?? 0)
                            return
                        }
                    })
                }
            })
        }
    
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }

    let loggedInLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Logged 'IN as"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 28)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    let nameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Name"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let nameLabelContent: UILabel = {
        let lbl = UILabel()
        lbl.text = "Im'IN"
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let emailLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Email"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let emailLabelContent: UILabel = {
        let lbl = UILabel()
        lbl.text = "Im'IN"
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
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
        lbl.text = "Update your Interest"
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    let cityLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "City"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let cityLabelContent: UILabel = {
        let lbl = UILabel()
        lbl.text = "Update your City"
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let stateLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "State"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let stateLabelContent: UILabel = {
        let lbl = UILabel()
        lbl.text = "Update your State"
        lbl.textColor = UIColor.black
        lbl.font = UIFont.systemFont(ofSize: 20)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    
    let notificationsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Notifications"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.boldSystemFont(ofSize: 28)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let generalAlertsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "General Event Alerts"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let myAlertsLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "My event(s) Alerts"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let generalCheckButton: UIButton = {
        let button = UIButton()
      
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
         button.addTarget(self, action: #selector(handleGeneralCheck), for: .touchUpInside)
        
        
        return button
    }()
    
    @objc func handleGeneralCheck()
    {
        if UserDefaults.standard.bool(forKey: "generalCheck"){
            generalCheckButton.setImage(UIImage(named:"unchecked"), for: .normal)
              UserDefaults.standard.set(false, forKey: "generalCheck")
        }else{
            generalCheckButton.setImage( UIImage(named:"checked"), for: .normal)
              UserDefaults.standard.set(true, forKey: "generalCheck")
        }
    }
    
    let myAlertCheckButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(handleMyAlertCheck), for: .touchUpInside)
        return button
    }()
    
    @objc func handleMyAlertCheck()
    {
        if UserDefaults.standard.bool(forKey: "myAlertCheck"){
            myAlertCheckButton.setImage(UIImage(named:"unchecked"), for: .normal)
            UserDefaults.standard.set(false, forKey: "myAlertCheck")
        }else{
            myAlertCheckButton.setImage( UIImage(named:"checked"), for: .normal)
            UserDefaults.standard.set(true, forKey: "myAlertCheck")
        }
    }
    
    let aboutUsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 51/255, green: 153/255, blue: 255/255, alpha: 1)
        button.setTitle("About us", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        button.addTarget(self, action: #selector(handleAboutUs), for: .touchUpInside)
        
        
        return button
    }()
    
    @objc func handleAboutUs()
    {
        let aboutController = AboutUsController()
        navigationController?.pushViewController(aboutController, animated: true)
    }
    
    let logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 255/255, green: 85/255, blue: 85/255, alpha: 1)
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        
        
        return button
    }()
    
    @objc func handleLogout(){
        
        let alert = UIAlertController(
            title: "Do you want to Logout?",
            message: "",
            preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action: UIAlertAction!) in
          
            do{
                print("user loggedOut")
                try Auth.auth().signOut()
                GIDSignIn.sharedInstance().signOut()

            }
            catch let logoutError{
                print(logoutError)
            }
        

            let navController = LoginController()
            navController.modalTransitionStyle = .flipHorizontal
            self.present(navController,animated: true,completion: nil)


        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
           
        }))
        
        present(alert, animated: true, completion: nil)

        
    }
    
    func setUpNavigationBar()
    {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)]
        
        navigationItem.title = "Settings"
        UINavigationBar.appearance().tintColor =  UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
    }
    
    func setUpViews()
    {
          loggedInLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
          loggedInLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
          profileImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
          profileImage.leftAnchor.constraint(equalTo: loggedInLabel.rightAnchor, constant: 40).isActive = true
          profileImage.heightAnchor.constraint(equalToConstant: 100).isActive = true
          profileImage.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
          nameLabel.topAnchor.constraint(equalTo: loggedInLabel.topAnchor, constant: 120).isActive = true
          nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
          nameLabelContent.topAnchor.constraint(equalTo: nameLabel.topAnchor).isActive = true
          nameLabelContent.leftAnchor.constraint(equalTo: nameLabel.rightAnchor, constant: 60).isActive = true
        
          emailLabel.topAnchor.constraint(equalTo: nameLabel.topAnchor, constant: 40).isActive = true
          emailLabel.leftAnchor.constraint(equalTo: nameLabel.leftAnchor).isActive = true
        
          emailLabelContent.topAnchor.constraint(equalTo: nameLabelContent.topAnchor, constant: 40).isActive = true
          emailLabelContent.leftAnchor.constraint(equalTo: nameLabelContent.leftAnchor).isActive = true
        
          interestLabel.topAnchor.constraint(equalTo: emailLabel.topAnchor, constant: 40).isActive = true
          interestLabel.leftAnchor.constraint(equalTo: emailLabel.leftAnchor).isActive = true
        
          interestLabelContent.topAnchor.constraint(equalTo: emailLabelContent.topAnchor, constant: 40).isActive = true
          interestLabelContent.leftAnchor.constraint(equalTo: emailLabelContent.leftAnchor).isActive = true
        
          cityLabel.topAnchor.constraint(equalTo: interestLabel.topAnchor, constant: 40).isActive = true
          cityLabel.leftAnchor.constraint(equalTo: emailLabel.leftAnchor).isActive = true
        
          cityLabelContent.topAnchor.constraint(equalTo: interestLabelContent.topAnchor, constant: 40).isActive = true
          cityLabelContent.leftAnchor.constraint(equalTo: emailLabelContent.leftAnchor).isActive = true
        
          stateLabel.topAnchor.constraint(equalTo: cityLabel.topAnchor, constant: 40).isActive = true
          stateLabel.leftAnchor.constraint(equalTo: emailLabel.leftAnchor).isActive = true
        
          stateLabelContent.topAnchor.constraint(equalTo: cityLabelContent.topAnchor, constant: 40).isActive = true
          stateLabelContent.leftAnchor.constraint(equalTo: emailLabelContent.leftAnchor).isActive = true
        
          notificationsLabel.bottomAnchor.constraint(equalTo: generalAlertsLabel.topAnchor).isActive = true
          notificationsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
          generalAlertsLabel.bottomAnchor.constraint(equalTo: myAlertsLabel.topAnchor, constant: -10).isActive = true
          generalAlertsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        
          generalCheckButton.bottomAnchor.constraint(equalTo: myAlertCheckButton.topAnchor, constant: -10).isActive = true
          generalCheckButton.rightAnchor.constraint(equalTo: myAlertCheckButton.rightAnchor).isActive = true
        
          myAlertsLabel.bottomAnchor.constraint(equalTo: aboutUsButton.topAnchor, constant: -25).isActive = true
          myAlertsLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 40).isActive = true
        
          myAlertCheckButton.bottomAnchor.constraint(equalTo: aboutUsButton.topAnchor, constant: -20).isActive = true
          myAlertCheckButton.leftAnchor.constraint(equalTo: myAlertsLabel.rightAnchor, constant: 60).isActive = true
        
          logoutButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -35).isActive = true
          logoutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
          logoutButton.widthAnchor.constraint(equalToConstant: 320).isActive = true
          logoutButton.heightAnchor.constraint(equalToConstant: 43).isActive = true
          logoutButton.clipsToBounds = true
          logoutButton.layer.cornerRadius = 5.0
        
          aboutUsButton.bottomAnchor.constraint(equalTo: logoutButton.topAnchor, constant: -15).isActive = true
          aboutUsButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
          aboutUsButton.widthAnchor.constraint(equalToConstant: 320).isActive = true
          aboutUsButton.heightAnchor.constraint(equalToConstant: 43).isActive = true
          aboutUsButton.clipsToBounds = true
          aboutUsButton.layer.cornerRadius = 5.0
        
    }
    
    
    func getUserDetails()
    {
        let uid = Auth.auth().currentUser?.uid

        Database.database().reference().child("users").child(uid!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let dictionary = snapshot.value as? [String: AnyObject]{
                self.nameLabelContent.text = dictionary["name"] as? String
                self.emailLabelContent.text = dictionary["email"] as? String
                self.cityLabelContent.text = dictionary["city"] as? String
                self.stateLabelContent.text = dictionary["state"] as? String
                self.interestLabelContent.text = dictionary["interest"] as? String
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
        self.hideKeyboardWhenTappedAround() 
        getUserDetails()
    
        if UserDefaults.standard.bool(forKey: "generalCheck"){
            generalCheckButton.setImage(UIImage(named:"checked"), for: .normal)
        }else{
            generalCheckButton.setImage(UIImage(named:"unchecked"), for: .normal)
        }
        
        if UserDefaults.standard.bool(forKey: "myAlertCheck"){
            myAlertCheckButton.setImage(UIImage(named:"checked"), for: .normal)
        }else{
            myAlertCheckButton.setImage(UIImage(named:"unchecked"), for: .normal)
        }
        
        view.backgroundColor = UIColor.white
        
        setUpNavigationBar()
        
        view.addSubview(loggedInLabel)
        view.addSubview(profileImage)
        view.addSubview(nameLabel)
        view.addSubview(nameLabelContent)
        view.addSubview(emailLabel)
        view.addSubview(emailLabelContent)
        view.addSubview(interestLabel)
        view.addSubview(interestLabelContent)
        view.addSubview(cityLabel)
        view.addSubview(cityLabelContent)
        view.addSubview(stateLabel)
        view.addSubview(stateLabelContent)
        view.addSubview(notificationsLabel)
        view.addSubview(generalAlertsLabel)
        view.addSubview(myAlertsLabel)
        view.addSubview(generalCheckButton)
        view.addSubview(myAlertCheckButton)
        view.addSubview(aboutUsButton)
        view.addSubview(logoutButton)
    
    
        setUpViews()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

