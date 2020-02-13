//
//  BestSellerCell.swift
//  NYTimesBestSeller
//
//  Created by Tsering Lama on 2/5/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import ImageKit
import Gemini

class BestSellerCell: GeminiCell {
    
    private var googleBook = [GoogleBook]()
    
    
    public lazy var booksImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true 
        return imageView
    }()
    
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
        setupImage()
        setupLabel()
    }
    
    private func setupImage() {
        addSubview(booksImage)
        booksImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            booksImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            booksImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            booksImage.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.60),
            booksImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        ])
    }
    
    private func setupLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: booksImage.bottomAnchor, constant: 8),
            descriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            descriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            descriptionLabel.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.30)
        ])
    }
    
    public func updateCell(book: Book) {
        
        GoogleAPIClient.getGoogleBooks(for: book.primaryIsbn10) { [weak self] (result) in
            switch result {
            case .failure(_):
                print("no description")
            case .success(let googleBook):
                DispatchQueue.main.async {
                    self?.googleBook = googleBook
                    self?.descriptionLabel.text = googleBook.first?.volumeInfo.description
                }
            }
        }
        
        
        booksImage.getImage(with: book.bookImage) { [weak self](result) in
            switch result {
            case .failure(_):
                print("couldnt load image")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.booksImage.image = image
                }
            }
        }
    }
    
}
