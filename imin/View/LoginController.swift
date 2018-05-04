//
//  ViewController.swift
//  imin
//
//  Created by Rajesh Palkar on 4/25/18.
//  Copyright © 2018 Rajesh Palkar. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class LoginController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
      var imgURL: String?
      var strLabel = UILabel()
      var activityIndicator = UIActivityIndicatorView()
      let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    
    let appNameLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Im'IN"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 72)
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

   


    let signInButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 51/255, green: 153/255, blue: 255/255, alpha: 1)
        button.setTitle("Login", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false


        button.addTarget(self, action: #selector(handleLogin), for: .touchUpInside)


        return button
    }()
    
    @objc func handleLogin()
    {
        guard let email = emailText.text, let password = passText.text else{
            print("Not valid entries!")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if(error != nil){
                print(error ?? 0)
               
                let alert = UIAlertController(
                    title: "Login Failed!",
                    message: "Invalid email or password",
                    preferredStyle: UIAlertControllerStyle.alert)
                
                let action = UIAlertAction(title: "Dismiss", style: .default) { (action) in
                    // do something when user press OK button, like deleting text in both fields or do nothing
                }
                
                alert.addAction(action)
            
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            
            print("Sucessfully LoggedIn!")
           // self.activityIndicatoor()
            
            let menuController = TabBarMenuController()
            menuController.selectedIndex = 0
            let navController = UINavigationController(rootViewController: menuController)
            navController.modalTransitionStyle = .flipHorizontal
            self.present(navController, animated: true, completion: nil)
            
        }
    }
    
    func activityIndicatoor() {
        
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = "Logging 'IN.."
        strLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if error != nil{
            print(error ?? 0)
            return
        }
        
        self.imgURL = user.profile.imageURL(withDimension: 200).absoluteString
        
        print(self.imgURL!)
        
        guard let idToken = user.authentication.idToken else {return}
        guard let accessToken = user.authentication.accessToken else {return}
        
        let credentials = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        Auth.auth().signIn(with: credentials) { (user, error) in
            if let err = error{
                print("Failed to create Firebase user with Google",err)
                return
            }
            
            guard let uid = user?.uid else {return}
            print("Sucessfully logged in with google and firebase",uid)
            
            guard let username = user?.displayName else { return}
            guard let email = user?.email else {return}
        

            
            let values = ["name": username, "email": email, "zipcode": "13210", "ProfileImageUrl": self.imgURL!]
            
            
            let ref = Database.database().reference(fromURL: "https://imin-f4d8c.firebaseio.com/")
            let userReference = ref.child("users").child(uid)
            
            userReference.updateChildValues(values, withCompletionBlock: { (error, ref) in
                if error != nil {
                    print(error ?? 0)
                    return
                }
            })
            
            
            let menuController = TabBarMenuController()
            menuController.selectedIndex = 0
            let navController = UINavigationController(rootViewController: menuController)
            navController.modalTransitionStyle = .flipHorizontal
            self.present(navController, animated: true, completion: nil)
            
            
            
        }
    }

    
    let googleButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 51/255, green: 153/255, blue: 255/255, alpha: 1)
        button.setTitle("Google", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        button.addTarget(self, action: #selector(handleGoogleSignIn), for: .touchUpInside)
        
        
        return button
    }()

    @objc func handleGoogleSignIn()
    {
        GIDSignIn.sharedInstance().signIn()
    }

    let facebookButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 51/255, green: 153/255, blue: 255/255, alpha: 1)
        button.setTitle("Facebook", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false


        //button.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)


        return button
    }()
    
    
    let newHereLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "New Here?"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.adjustsFontSizeToFitWidth = false
        lbl.lineBreakMode = NSLineBreakMode.byTruncatingTail
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = UIFont.boldSystemFont(ofSize: 18)

        return lbl
    }()
    
    let signUpButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 51/255, green: 153/255, blue: 255/255, alpha: 1)
        button.setTitle("Sign Up", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false


        button.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)


        return button
    }()

    @objc func handleSignUp()
    {
        let signUpController = SignUpController()
        let navController = UINavigationController(rootViewController: signUpController)
        self.present(navController, animated: true, completion: nil)
    }
    
    func setUpViews(){
        
        view.backgroundColor = UIColor.white
    
        
        appNameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        appNameLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        appNameLabel.widthAnchor.constraint(equalToConstant: 140).isActive = true
        appNameLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        emailText.topAnchor.constraint(equalTo: appNameLabel.bottomAnchor, constant: 60).isActive = true
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
        
        signInButton.topAnchor.constraint(equalTo: passText.bottomAnchor, constant: 30).isActive = true
        signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signInButton.widthAnchor.constraint(equalToConstant: 280).isActive = true
        signInButton.heightAnchor.constraint(equalToConstant: 43).isActive = true
        signInButton.clipsToBounds = true
        signInButton.layer.cornerRadius = 5.0
        
        facebookButton.leftAnchor.constraint(equalTo: signInButton.leftAnchor).isActive = true
        facebookButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20).isActive = true
        facebookButton.heightAnchor.constraint(equalToConstant: 43).isActive = true
        facebookButton.widthAnchor.constraint(equalToConstant: 132).isActive = true
        facebookButton.clipsToBounds = true
        facebookButton.layer.cornerRadius = 5.0
      
        googleButton.rightAnchor.constraint(equalTo: signInButton.rightAnchor).isActive = true
        googleButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 20).isActive = true
        googleButton.heightAnchor.constraint(equalToConstant: 43).isActive = true
        googleButton.widthAnchor.constraint(equalToConstant: 132).isActive = true
        googleButton.clipsToBounds = true
        googleButton.layer.cornerRadius = 5.0
        
        
        newHereLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 60).isActive = true
        newHereLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        newHereLabel.heightAnchor.constraint(equalToConstant: 43).isActive = true
        newHereLabel.widthAnchor.constraint(equalToConstant: 132).isActive = true
        

        signUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50).isActive = true
        signUpButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 43).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 132).isActive = true
        signUpButton.clipsToBounds = true
        signUpButton.layer.cornerRadius = 5.0
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        
        view.addSubview(appNameLabel)
        view.addSubview(emailText)
        view.addSubview(passText)
        view.addSubview(signInButton)
        view.addSubview(facebookButton)
        view.addSubview(googleButton)
        view.addSubview(newHereLabel)
        view.addSubview(signUpButton)
        
        setUpViews();
        
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

