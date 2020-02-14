//
//  SettingsViewController.swift
//  NYTimesBestSeller
//
//  Created by Tsering Lama on 2/5/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
private let settingsView = SettingsView()
  
  public var userPreference: UserPreference!
    
  override func loadView() {
    view = settingsView
  }
    
    var sections = [String]() {
          didSet {
              settingsView.pickerViewSelected.reloadAllComponents()
          }
      }
      
      private var allCategories = [Categories]() {
          didSet {
              sections = allCategories.map {$0.listName}
          }
      }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemGroupedBackground
    
    // setup picker view
    settingsView.pickerViewSelected.dataSource = self
    settingsView.pickerViewSelected.delegate = self
    
    // ADDITION: scroll to picker view's index if there is a section saved in UserDefaults
//    if let sectionName = userPreference.getSectionName() {
//      if let index = sections.firstIndex(of: sectionName) {
//        settingsView.pickerViewSelected.selectRow(index, inComponent: 0, animated: true)
//      }
//    }
  }
}

extension SettingsViewController: UIPickerViewDataSource {
  func numberOfComponents(in pickerView: UIPickerView) -> Int {
    return 1
  }
  
  func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    return sections.count
  }
}

extension SettingsViewController: UIPickerViewDelegate {
  func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    return sections[row] // accessing each individual string in the sections array
  }
  
  func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    // store the current selected news section in user defaults
    let sectionName = sections[row]
    userPreference.setSectionName(sectionName)
  }
}


