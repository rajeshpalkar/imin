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

class ProfileScreenController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var availableTime: String?
    let interstArray = ["Swimming", "Painting", "SkyDiving", "YouTube Collab"]
    let cityArray = ["Syracuse", "Albany", "Buffalo","Albany", "Atlanta", "San Jose"]
    let stateArray = ["New York", "California", "Georgia"]

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == interestPicker {
             return interstArray.count
        }
        else if pickerView == cityPicker {
            return cityArray.count
        }
        else {
            return stateArray.count
        }
       
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == interestPicker {
             return interstArray[row]
        }
        else if pickerView == cityPicker {
            return cityArray[row]
        }
        else {
            return stateArray[row]
        }
        
       
    }
    
    let interestLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Interest"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let interestPicker : UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    let availabilityLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Availability"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let availabilityPicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .time
        dp.backgroundColor =  UIColor.white
        dp.translatesAutoresizingMaskIntoConstraints = false
        
        dp.addTarget(self, action: #selector(handleTimeChange), for: .valueChanged)
        return dp
    }()
    
    @objc func handleTimeChange()
    {
        let dateFormatter: DateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "HH:mm"
        
        let selectedDate : String = dateFormatter.string(from: availabilityPicker.date)
        
        self.availableTime = selectedDate
        print("selected value of date \(selectedDate)")
    }
    
    
    let cityLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "City"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let cityPicker : UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
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
    
    let statePicker : UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
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
    
    let radiusSlider: UISlider = {
        let rs = UISlider()
        rs.minimumValue = 0
        rs.maximumValue = 100
        rs.translatesAutoresizingMaskIntoConstraints = false
        rs.tintColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        rs.addTarget(self, action: #selector(handleSliderValue), for: .valueChanged)
        return rs
        
    }()
    
    @objc func handleSliderValue()
    {
        let radiusValue = lroundf(radiusSlider.value)
        
        radiusCountLabel.text = String(radiusValue)
    }
    
    let radiusCountLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "50"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let updateButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 51/255, green: 153/255, blue: 255/255, alpha: 1)
        button.setTitle("Update", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        button.addTarget(self, action: #selector(handleUpdateProfile), for: .touchUpInside)
        
        
        return button
    }()
    
    @objc func handleUpdateProfile()
    {
        let selectedInterest =  interstArray[interestPicker.selectedRow(inComponent: 0)]
        let selectedCity =  cityArray[cityPicker.selectedRow(inComponent: 0)]
        let selectedState =  stateArray[statePicker.selectedRow(inComponent: 0)]
        
        
        let values = ["time": self.availableTime, "interest": selectedInterest, "city": selectedCity, "state": selectedState, "radius": radiusCountLabel.text!]
    
        
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
        
        let alert = UIAlertController(
            title: "Details Updated",
            message: "Redirecting to Settings Page!",
            preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "Okay", style: .default) { (action) in
            // do something when user press OK button, like deleting text in both fields or do nothing
        }
        
        alert.addAction(action)
        
        let settingsController = SettingsController()
        navigationController?.pushViewController(settingsController, animated: true)
        
    }

    
    func setUpViews()
    {
        interestLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 120).isActive = true
        interestLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        interestPicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        interestPicker.leftAnchor.constraint(equalTo: interestLabel.rightAnchor, constant: 50).isActive = true
        interestPicker.widthAnchor.constraint(equalToConstant: 180).isActive = true
        interestPicker.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        availabilityLabel.topAnchor.constraint(equalTo: interestLabel.bottomAnchor, constant: 50).isActive = true
        availabilityLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        availabilityPicker.topAnchor.constraint(equalTo: availabilityLabel.topAnchor, constant: -10).isActive = true
        availabilityPicker.leftAnchor.constraint(equalTo: interestPicker.leftAnchor).isActive = true
        availabilityPicker.widthAnchor.constraint(equalToConstant: 150).isActive = true
        availabilityPicker.heightAnchor.constraint(equalToConstant: 75).isActive = true
        
        cityLabel.topAnchor.constraint(equalTo: availabilityLabel.bottomAnchor, constant: 50).isActive = true
        cityLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        cityPicker.topAnchor.constraint(equalTo: cityLabel.topAnchor, constant: -20).isActive = true
        cityPicker.leftAnchor.constraint(equalTo: interestPicker.leftAnchor).isActive = true
        cityPicker.widthAnchor.constraint(equalToConstant: 180).isActive = true
        cityPicker.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        stateLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 50).isActive = true
        stateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        statePicker.topAnchor.constraint(equalTo: stateLabel.topAnchor, constant: -20).isActive = true
        statePicker.leftAnchor.constraint(equalTo: interestPicker.leftAnchor).isActive = true
        statePicker.widthAnchor.constraint(equalToConstant: 180).isActive = true
        statePicker.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        radiusLabel.topAnchor.constraint(equalTo: stateLabel.bottomAnchor, constant: 50).isActive = true
        radiusLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        radiusSlider.topAnchor.constraint(equalTo: radiusLabel.topAnchor).isActive = true
        radiusSlider.leftAnchor.constraint(equalTo: radiusLabel.rightAnchor, constant: 60).isActive = true
        radiusSlider.heightAnchor.constraint(equalToConstant: 40).isActive = true
        radiusSlider.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        radiusCountLabel.topAnchor.constraint(equalTo: radiusLabel.topAnchor,constant: 5).isActive = true
        radiusCountLabel.rightAnchor.constraint(equalTo: radiusSlider.rightAnchor, constant: 45).isActive = true
        
        updateButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -105).isActive = true
        updateButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        updateButton.widthAnchor.constraint(equalToConstant: 320).isActive = true
        updateButton.heightAnchor.constraint(equalToConstant: 43).isActive = true
        updateButton.clipsToBounds = true
        updateButton.layer.cornerRadius = 5.0
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(interestLabel)
        view.addSubview(availabilityLabel)
        view.addSubview(cityLabel)
        view.addSubview(stateLabel)
        view.addSubview(radiusLabel)
        view.addSubview(radiusSlider)
        view.addSubview(radiusCountLabel)
        view.addSubview(updateButton)
        view.addSubview(interestPicker)
        view.addSubview(cityPicker)
        view.addSubview(statePicker)
        view.addSubview(availabilityPicker)
        
        interestPicker.delegate = self
        interestPicker.dataSource = self
        cityPicker.delegate = self
        cityPicker.dataSource = self
        statePicker.delegate = self
        statePicker.dataSource = self
        
        radiusSlider.value = 50.0
        
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

