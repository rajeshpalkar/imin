//
//  LookUpScreenController.swift
//  imin
//
//  Created by Rajesh Palkar on 4/26/18.
//  Copyright © 2018 Rajesh Palkar. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class LookUpScreenController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var availableTime: String?
    var availableDate: String?
    let interstArray = ["Swimming", "Painting", "SkyDiving", "YouTube Collab"]
    let locationArray = ["Syracuse", "Albany", "Buffalo","Albany", "Atlanta", "San Jose"]
    
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
    
    let locationPicker : UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        return picker
    }()
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return 1
    }
    
  
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == interestPicker {
            return interstArray.count
        }
        else {
            return locationArray.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == interestPicker {
            return interstArray[row]
        }
        else  {
            return locationArray[row]
        }
        
    }

    let dateLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Date"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()

    
    let datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .date
        dp.backgroundColor =  UIColor.white
        dp.translatesAutoresizingMaskIntoConstraints = false
        dp.addTarget(self, action: #selector(handleDateChange), for: .valueChanged)
        return dp
    }()
    
    @objc func handleDateChange()
    {
        let dateFormatter: DateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "MM/dd/YYYY"
        
        let selectedDate : String = dateFormatter.string(from: datePicker.date)
        
        self.availableDate = selectedDate
        print("selected value of date \(selectedDate)")
    }
    
    
    let timeLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Time"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let timePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.datePickerMode = .time
        dp.backgroundColor =  UIColor.white
        dp.translatesAutoresizingMaskIntoConstraints = false
        
        dp.addTarget(self, action: #selector(handleTimeChange), for: .valueChanged)
        return dp
    }()
    
    @objc func handleTimeChange()
    {
        let timeFormatter: DateFormatter = DateFormatter()
        
        timeFormatter.dateFormat = "HH:mm"
        
        let selectedTime : String = timeFormatter.string(from: timePicker.date)
        self.availableTime = selectedTime
        print("selected value of date \(selectedTime)")
    }
    
    
    let locationLabel: UILabel = {
        let lbl = UILabel()
        lbl.text = "Location"
        lbl.textColor = UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)
        lbl.font = UIFont.systemFont(ofSize: 24)
        lbl.adjustsFontSizeToFitWidth = true
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
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
    
    let lookupButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(displayP3Red: 51/255, green: 153/255, blue: 255/255, alpha: 1)
        button.setTitle("Look Up", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        
        button.addTarget(self, action: #selector(handleUpdateProfile), for: .touchUpInside)
        
        
        return button
    }()
    
    @objc func handleUpdateProfile()
    {
        let selectedInterest =  interstArray[interestPicker.selectedRow(inComponent: 0)]
        let selectedLocation =  locationArray[locationPicker.selectedRow(inComponent: 0)]


        let values = ["interest": selectedInterest,"date": self.availableDate,"time": self.availableTime, "location": selectedLocation, "radius": radiusCountLabel.text!, "desc": self.descText.text!]


        guard let uid =   Auth.auth().currentUser?.uid
            else{
                return
        }

        let ref = Database.database().reference(fromURL: "https://imin-f4d8c.firebaseio.com/")
        let userReference = ref.child("lookups").child(uid).childByAutoId()

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

        let settingsController = GoingScreenController()
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
        
        dateLabel.topAnchor.constraint(equalTo: interestLabel.bottomAnchor, constant: 50).isActive = true
        dateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        datePicker.topAnchor.constraint(equalTo: dateLabel.topAnchor,constant: -15).isActive = true
        datePicker.leftAnchor.constraint(equalTo: interestPicker.leftAnchor,constant: -60).isActive = true
        datePicker.widthAnchor.constraint(equalToConstant: 250).isActive = true
        datePicker.heightAnchor.constraint(equalToConstant: 75).isActive = true

        
        timeLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 50).isActive = true
        timeLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        timePicker.topAnchor.constraint(equalTo: timeLabel.topAnchor,constant: -15).isActive = true
        timePicker.leftAnchor.constraint(equalTo: interestPicker.leftAnchor).isActive = true
        timePicker.widthAnchor.constraint(equalToConstant: 200).isActive = true
        timePicker.heightAnchor.constraint(equalToConstant: 75).isActive = true

        locationLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 50).isActive = true
        locationLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        locationPicker.topAnchor.constraint(equalTo: locationLabel.topAnchor, constant: -20).isActive = true
        locationPicker.leftAnchor.constraint(equalTo: interestPicker.leftAnchor).isActive = true
        locationPicker.widthAnchor.constraint(equalToConstant: 160).isActive = true
        locationPicker.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        radiusLabel.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 50).isActive = true
        radiusLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        radiusSlider.topAnchor.constraint(equalTo: radiusLabel.topAnchor).isActive = true
        radiusSlider.leftAnchor.constraint(equalTo: radiusLabel.rightAnchor, constant: 60).isActive = true
        radiusSlider.heightAnchor.constraint(equalToConstant: 40).isActive = true
        radiusSlider.widthAnchor.constraint(equalToConstant: 140).isActive = true
        
        radiusCountLabel.topAnchor.constraint(equalTo: radiusLabel.topAnchor,constant: 5).isActive = true
        radiusCountLabel.rightAnchor.constraint(equalTo: radiusSlider.rightAnchor, constant: 45).isActive = true
        
        descLabel.topAnchor.constraint(equalTo: radiusLabel.bottomAnchor, constant: 50).isActive = true
        descLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 30).isActive = true
        
        descText.topAnchor.constraint(equalTo: descLabel.topAnchor).isActive = true
        descText.leftAnchor.constraint(equalTo: interestPicker.leftAnchor).isActive = true
        descText.widthAnchor.constraint(equalToConstant: 120).isActive = true
        descText.heightAnchor.constraint(equalToConstant: 43).isActive = true
        descText.clipsToBounds = true
        descText.layer.cornerRadius = 5.0
        
        lookupButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -105).isActive = true
        lookupButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lookupButton.widthAnchor.constraint(equalToConstant: 320).isActive = true
        lookupButton.heightAnchor.constraint(equalToConstant: 43).isActive = true
        lookupButton.clipsToBounds = true
        lookupButton.layer.cornerRadius = 5.0
        
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        view.addSubview(interestLabel)
        view.addSubview(timeLabel)
        view.addSubview(dateLabel)
        view.addSubview(locationLabel)
        view.addSubview(radiusLabel)
        view.addSubview(radiusSlider)
        view.addSubview(radiusCountLabel)
        view.addSubview(lookupButton)
        view.addSubview(interestPicker)
        view.addSubview(locationPicker)
        view.addSubview(descLabel)
        view.addSubview(descText)
        view.addSubview(datePicker)
        view.addSubview(timePicker)

        
        interestPicker.delegate = self
        interestPicker.dataSource = self
        locationPicker.delegate = self
        locationPicker.dataSource = self
        
        radiusSlider.value = 50.0
        
        let timeFormatter: DateFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        let selectedTime : String = timeFormatter.string(from: timePicker.date)
        self.availableTime = selectedTime
        
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/YYYY"
        let selectedDate : String = dateFormatter.string(from: datePicker.date)
        self.availableDate = selectedDate
        
       
        
        setUpViews()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setUpNavigationBar()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @objc func handleSettings(){
        let settingsController = SettingsController()
        //detailedController.id = movie.id
        navigationController?.pushViewController(settingsController, animated: true)
    }
    
    
    func setUpNavigationBar()
    {
        self.tabBarController?.navigationItem.title = "Look Up"
        self.tabBarController?.navigationItem.rightBarButtonItem =  nil
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor: UIColor(displayP3Red: 0/255, green: 153/255, blue: 204/255, alpha: 1)]
    }
    
}

