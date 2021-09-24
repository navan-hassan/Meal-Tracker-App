//
//  SettingsViewController.swift
//  Meal Tracker
//
//  Created by Navan Hassan on 6/30/21.
//
// Navan Hassan NetID: naahassan ID: 112239763

import UIKit

class SettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: Picker view data source
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return settings.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return settings[row]
    }
    
    @IBOutlet weak var saveButton: UIButton!
    
    
    /// Function that is called when the save button is tapped. This will post a Notification containing
    /// the string in the current PickerView row. This string is used by the other view controllers to sort their data.
    @IBAction func saveButtonTapped(_ sender: Any){
        let setting = settings[settingsPicker.selectedRow(inComponent: 0)]
        NotificationCenter.default.post(name: Notification.Name("sortBy"), object: setting)
    }
    
    
    /// Array of settings that is displayed in the PickerView.
    let settings = ["Date", "Category", "Name", "Calories", "Protein", "Fat", "Carbs"]
    
    /// PickerView of various settings to determine how to sort the data displayed in the other view controllers.
    @IBOutlet weak var settingsPicker: UIPickerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Settings"
        settingsPicker.delegate = self
        settingsPicker.dataSource = self
    }
}
