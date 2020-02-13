//
//  SettingsView.swift
//  NYTimesBestSeller
//
//  Created by Tsering Lama on 2/5/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class SettingsView: UIView {
    public lazy var pickerViewSelected : UIPickerView = {
       let picker = UIPickerView()
       
       return picker
       
       }()
       
       override init(frame: CGRect) {
           super.init(frame: UIScreen.main.bounds)
           commonInit()
       }
       
       required init?(coder: NSCoder) {
           super.init(coder: coder)
           commonInit()
       }
       
       private func commonInit() {
           
           setUpPickerViewConstriants()
       }
       
       private func setUpPickerViewConstriants(){
           addSubview(pickerViewSelected)
           
           pickerViewSelected.translatesAutoresizingMaskIntoConstraints = false
           
           NSLayoutConstraint.activate([
           
               pickerViewSelected.centerXAnchor.constraint(equalTo: centerXAnchor),
               pickerViewSelected.centerYAnchor.constraint(equalTo: centerYAnchor),
               pickerViewSelected.leadingAnchor.constraint(equalTo: leadingAnchor),
               pickerViewSelected.trailingAnchor.constraint(equalTo: trailingAnchor)
           ])
       }

}
