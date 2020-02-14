
//
//  DetailView.swift
//  NYTimesBestSeller
//
//  Created by Tsering Lama on 2/5/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class DetailView: UIView {
            
            public lazy var booksCoverImage: UIImageView = {
                let iv = UIImageView()
                iv.image = UIImage(systemName: "photo")
                iv.contentMode = .scaleAspectFit
                return iv
            }()
            
            public lazy var abstractHeadline: UILabel = {
                let label = UILabel()
                label.numberOfLines = 3
                label.font = UIFont.preferredFont(forTextStyle: .headline)
                label.textAlignment = .center
                label.text = "Abstract Headline"
                return label
            }()
            
            
            public lazy var detailbutton: UIButton = {
                let button = UIButton()
                button.setImage(UIImage(systemName: "book.fill"), for: .normal)
               
                button.imageView?.contentMode = .scaleToFill
                return button
            }()
            
            public lazy var summary: UITextView = {
                let summaryLabel = UITextView()
                summaryLabel.font = UIFont.preferredFont(forTextStyle: .body)
                summaryLabel.text = ""
                
                return summaryLabel
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

                setupImageConstraints()
                setupTitleLabelConstraints()
                setupButtonConstraints()
                setupDescriptionConstraints()
            }
            
                
                
                private func setupImageConstraints() {
                    addSubview(booksCoverImage)
                    booksCoverImage.translatesAutoresizingMaskIntoConstraints = false
                    booksCoverImage.layer.cornerRadius = 20
                    
                    NSLayoutConstraint.activate([
                        
                        booksCoverImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
                        booksCoverImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                        booksCoverImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
                        booksCoverImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.40)
                    ])
                }
                
    //MARK: Title
                private func setupTitleLabelConstraints() {
                    addSubview(abstractHeadline)
                    abstractHeadline.translatesAutoresizingMaskIntoConstraints = false
                    
                    NSLayoutConstraint.activate([
                        abstractHeadline.topAnchor.constraint(equalTo: booksCoverImage.bottomAnchor, constant: 8),
                        
                        abstractHeadline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                        
                        abstractHeadline.trailingAnchor.constraint(equalTo:trailingAnchor, constant: -8),
                        
                        abstractHeadline.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.025)
                        
                    ])
                }
                

                
                private func setupButtonConstraints() {
                 addSubview(detailbutton)
                    detailbutton.translatesAutoresizingMaskIntoConstraints = false
                    
                    NSLayoutConstraint.activate([
                        detailbutton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
                        detailbutton.widthAnchor.constraint(equalToConstant: 60),
                        detailbutton.heightAnchor.constraint(equalToConstant: 60),
                        

                        
                        detailbutton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
                    ])
                    detailbutton.imageView?.contentMode = .scaleToFill
                }
                
                private func setupDescriptionConstraints() {
                    addSubview(summary)
                    summary.translatesAutoresizingMaskIntoConstraints = false
                    
                    NSLayoutConstraint.activate([
                       
                        summary.topAnchor.constraint(equalTo: abstractHeadline.bottomAnchor, constant: 1),
                        
                        summary.leadingAnchor.constraint(equalTo: leadingAnchor),
                        
                        summary.trailingAnchor.constraint(equalTo: trailingAnchor),
                        
                        summary.bottomAnchor.constraint(equalTo: bottomAnchor)
                    ])
                }
            }

