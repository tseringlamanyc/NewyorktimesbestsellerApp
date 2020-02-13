//
//  FavoritesDetailView.swift
//  NYTimesBestSeller
//
//  Created by Kelby Mittan on 2/13/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class FavoritesDetailView: UIView {
    
    lazy var contentViewSize = CGSize(width: centerView.frame.width, height: centerView.frame.height + 400)
    
    public lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: .zero)
        sv.frame = self.bounds
        sv.contentSize = CGSize(width: (self.frame.width * 0.75), height: (self.frame.height * 0.658))
        sv.layer.borderWidth = 4
        sv.layer.borderColor = UIColor.lightText.cgColor
        sv.backgroundColor = .placeholderText
        return sv
    }()
    
    public lazy var centerView: UIView = {
        let centeredV = UIView()
        
        //        centeredV.frame.size = contentViewSize
        //                centeredV.layer.borderWidth = 4
        //        centeredV.layer.borderColor = UIColor.lightText.cgColor
        //        centeredV.backgroundColor = .systemGray6
        centeredV.isOpaque = false
        //        centeredV.backgroundColor = .quaternarySystemFill
        centeredV.alpha = 0.9
        return centeredV
    }()
    
    public lazy var bookImageView: UIImageView = {
        let iv = UIImageView()
        //        iv.image = UIImage(systemName: "photo")
        iv.contentMode = .scaleToFill
        return iv
    }()
    
    public lazy var bookTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 3
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.textColor = .white
        label.text = ""
        return label
    }()
    
    public lazy var byLine: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        //        label.textColor = .white
        label.text = ""
        return label
    }()
    
    public lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        //        label.textColor = .white
        label.text = ""
        return label
    }()
    
    public lazy var weeksOnListLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        //        label.textColor = .white
        label.text = ""
        return label
    }()
    
    public lazy var menuButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "book.fill"), for: .normal)
        //        button.contentMode = .scaleToFill
        button.imageView?.contentMode = .scaleToFill
        return button
    }()
    
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = .white
        label.text = ""
        return label
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
        setupByLineConstraints()
        setupRankLabelConstraints()
        setupByWeeksOnListConstraints()
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
            scrollView.centerYAnchor.constraint(equalTo: centerYAnchor),
            scrollView.widthAnchor.constraint(equalToConstant: width),
            scrollView.heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    private func setupCenteredViewConstraints() {
        scrollView.addSubview(centerView)
        centerView.translatesAutoresizingMaskIntoConstraints = false
        centerView.layer.cornerRadius = 10
        //        let width = self.bounds.width / 1.15
        //        let height = self.bounds.height / 1.35
        
        NSLayoutConstraint.activate([
            centerView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            centerView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            centerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            centerView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        ])
    }
    
    
    private func setupImageConstraints() {
        centerView.addSubview(bookImageView)
        bookImageView.translatesAutoresizingMaskIntoConstraints = false
        bookImageView.layer.cornerRadius = 5
        NSLayoutConstraint.activate([
            bookImageView.topAnchor.constraint(equalTo: centerView.topAnchor, constant: 10),
            bookImageView.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: 10),
            bookImageView.widthAnchor.constraint(equalTo: centerView.widthAnchor, multiplier: 0.35),
            bookImageView.heightAnchor.constraint(equalTo: centerView.heightAnchor, multiplier: 0.27)
        ])
    }
    
    private func setupTitleLabelConstraints() {
        centerView.addSubview(bookTitle)
        bookTitle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bookTitle.topAnchor.constraint(equalTo: bookImageView.topAnchor),
            bookTitle.leadingAnchor.constraint(equalTo: bookImageView.trailingAnchor, constant: 8),
            bookTitle.trailingAnchor.constraint(equalTo: centerView.trailingAnchor, constant: -8)
        ])
    }
    
    private func setupByLineConstraints() {
        centerView.addSubview(byLine)
        byLine.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            byLine.topAnchor.constraint(equalTo: bookTitle.bottomAnchor, constant: 5),
            byLine.leadingAnchor.constraint(equalTo: bookTitle.leadingAnchor),
            byLine.trailingAnchor.constraint(equalTo: bookTitle.trailingAnchor)
        ])
    }
    
    private func setupRankLabelConstraints() {
        centerView.addSubview(rankLabel)
        rankLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rankLabel.bottomAnchor.constraint(equalTo: bookImageView.bottomAnchor),
            rankLabel.leadingAnchor.constraint(equalTo: bookTitle.leadingAnchor),
            rankLabel.trailingAnchor.constraint(equalTo: byLine.centerXAnchor)
        ])
    }
    
    private func setupByWeeksOnListConstraints() {
        centerView.addSubview(weeksOnListLabel)
        weeksOnListLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weeksOnListLabel.topAnchor.constraint(equalTo: bookImageView.bottomAnchor, constant: 8),
            weeksOnListLabel.leadingAnchor.constraint(equalTo: bookImageView.leadingAnchor),
            weeksOnListLabel.trailingAnchor.constraint(equalTo: bookTitle.trailingAnchor)
        ])
    }
    
    private func setupButtonConstraints() {
        centerView.addSubview(menuButton)
        menuButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            menuButton.widthAnchor.constraint(equalToConstant: 60),
            menuButton.heightAnchor.constraint(equalToConstant: 60),
            menuButton.centerYAnchor.constraint(equalTo: rankLabel.centerYAnchor),
            menuButton.trailingAnchor.constraint(equalTo: byLine.trailingAnchor)
        ])
        menuButton.imageView?.contentMode = .scaleToFill
    }
    
    private func setupDescriptionConstraints() {
        centerView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: weeksOnListLabel.bottomAnchor, constant: 2),
            descriptionLabel.leadingAnchor.constraint(equalTo: bookImageView.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: bookTitle.trailingAnchor),
            descriptionLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
    }
}
