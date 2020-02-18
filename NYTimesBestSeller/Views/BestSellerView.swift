//
//  BestSellerView.swift
//  NYTimesBestSeller
//
//  Created by Tsering Lama on 2/5/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import Gemini

class BestSellerView: UIView {
    
    public lazy var bestSellerCV: GeminiCollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = GeminiCollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .systemGray4
        return cv
    }()
    
    public lazy var pickerView: UIPickerView = {
        let pv = UIPickerView()
        pv.backgroundColor = .systemGray4
        return pv
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
        setUpCV()
        setupPicker()
    }
    
    private func setUpCV() {
        addSubview(bestSellerCV)
        bestSellerCV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            bestSellerCV.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 0),
            bestSellerCV.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 0),
            bestSellerCV.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: 0),
            bestSellerCV.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, multiplier: 0.40)
        ])
    }
    
    private func setupPicker() {
        addSubview(pickerView)
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pickerView.topAnchor.constraint(equalTo: bestSellerCV.bottomAnchor, constant: 20),
            pickerView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            pickerView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            pickerView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
        
}
