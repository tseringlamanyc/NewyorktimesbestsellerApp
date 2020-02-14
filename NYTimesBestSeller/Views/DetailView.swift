
//
//  DetailView.swift
//  NYTimesBestSeller
//
//  Created by Tsering Lama on 2/5/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class DetailView: UIView {
    lazy var content = CGSize(width: centerView.frame.width, height: centerView.frame.height + 400)
            
            public lazy var scrollView: UIScrollView = {
                let scrollV = UIScrollView(frame: .zero)
                scrollV.frame = self.bounds
                scrollV.contentSize = CGSize(width: (self.frame.width * 0.75), height: (self.frame.height * 0.658))
             
                scrollV.backgroundColor = .systemBackground
                return scrollV
            }()
            
            public lazy var centerView: UIView = {
                let centeredV = UIView()
          
                return centeredV
            }()
            
            public lazy var booksCoverImage: UIImageView = {
                let iv = UIImageView()
                iv.image = UIImage(systemName: "photo")
                iv.contentMode = .scaleToFill
                return iv
            }()
            
            public lazy var abstractHeadline: UILabel = {
                let label = UILabel()
                label.numberOfLines = 3
                label.font = UIFont.preferredFont(forTextStyle: .headline)
        //        label.textColor = .white
                label.text = "Abstract Headline"
                return label
            }()
            
//            public lazy var byLine: UILabel = {
//                let label = UILabel()
//                label.numberOfLines = 0
//                label.font = UIFont.preferredFont(forTextStyle: .subheadline)
//                //        label.textColor = .white
//                label.text = ""
//                return label
//            }()
    
//            public lazy var rankLabel: UILabel = {
//                let label = UILabel()
//                label.numberOfLines = 0
//                label.font = UIFont.preferredFont(forTextStyle: .subheadline)
//                //        label.textColor = .white
//                label.text = ""
//                return label
//            }()
            
//            public lazy var weeksOnListLabel: UILabel = {
//                let label = UILabel()
//                label.numberOfLines = 0
//                label.font = UIFont.preferredFont(forTextStyle: .headline)
//                //        label.textColor = .white
//                label.text = ""
//                return label
//            }()
            
            public lazy var detailbutton: UIButton = {
                let button = UIButton()
                button.setImage(UIImage(systemName: "book.fill"), for: .normal)
                //        button.contentMode = .scaleToFill
                button.imageView?.contentMode = .scaleToFill
                return button
            }()
            
            public lazy var summary: UILabel = {
                let summaryLabel = UILabel()
                summaryLabel.numberOfLines = 0
                summaryLabel.font = UIFont.preferredFont(forTextStyle: .body)
        //        label.textColor = .white
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
                setupScrollViewConstraints()
                setupCenteredViewConstraints()
                setupImageConstraints()
                setupTitleLabelConstraints()
//                setupByLineConstraints()
//                setupRankLabelConstraints()
//                setupByWeeksOnListConstraints()
                setupButtonConstraints()
                setupDescriptionConstraints()
            }
            
             private func setupScrollViewConstraints() {
                    addSubview(scrollView)
                    scrollView.translatesAutoresizingMaskIntoConstraints = false
                    scrollView.layer.cornerRadius = 10
                    let width = self.bounds.width * 0.77
                    let height = self.bounds.height * 0.56
                    
                    NSLayoutConstraint.activate([
                        scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
                        scrollView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -10),
                        scrollView.widthAnchor.constraint(equalToConstant: width),
                        scrollView.heightAnchor.constraint(equalToConstant: height)
                    ])
                }
                
                private func setupCenteredViewConstraints() {
                    scrollView.addSubview(centerView)
                    centerView.translatesAutoresizingMaskIntoConstraints = false
                    centerView.layer.cornerRadius = 10
                    
                    NSLayoutConstraint.activate([
                        centerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
                        centerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
                        centerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
                        centerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
                    ])
                }
                
                
                private func setupImageConstraints() {
                    centerView.addSubview(booksCoverImage)
                    booksCoverImage.translatesAutoresizingMaskIntoConstraints = false
                    booksCoverImage.layer.cornerRadius = 10
                    
                    NSLayoutConstraint.activate([
                        
                        booksCoverImage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
                        booksCoverImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
                        booksCoverImage.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.50),
                        booksCoverImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.50)
                    ])
                }
                
    //MARK: Title
                private func setupTitleLabelConstraints() {
                    centerView.addSubview(abstractHeadline)
                    abstractHeadline.translatesAutoresizingMaskIntoConstraints = false
                    
                    NSLayoutConstraint.activate([
                        abstractHeadline.topAnchor.constraint(equalTo: booksCoverImage.bottomAnchor),
                        
                        abstractHeadline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
                        
                        abstractHeadline.trailingAnchor.constraint(equalTo: centerView.trailingAnchor, constant: -8)
                    ])
                }
                

                
                private func setupButtonConstraints() {
                    centerView.addSubview(detailbutton)
                    detailbutton.translatesAutoresizingMaskIntoConstraints = false
                    
                    NSLayoutConstraint.activate([
                        detailbutton.widthAnchor.constraint(equalToConstant: 60),
                        detailbutton.heightAnchor.constraint(equalToConstant: 60),
                        
                        detailbutton.centerYAnchor.constraint(equalTo: booksCoverImage.centerYAnchor),
                        
                        detailbutton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
                    ])
                    detailbutton.imageView?.contentMode = .scaleToFill
                }
                
                private func setupDescriptionConstraints() {
                    centerView.addSubview(summary)
                    summary.translatesAutoresizingMaskIntoConstraints = false
                    
                    NSLayoutConstraint.activate([
                        summary.topAnchor.constraint(equalTo: abstractHeadline.bottomAnchor, constant: 8),
                        summary.leadingAnchor.constraint(equalTo: booksCoverImage.leadingAnchor),
                        summary.trailingAnchor.constraint(equalTo: abstractHeadline.trailingAnchor),
                        summary.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
                    ])
                }
            }

