//
//  FavoritesCell.swift
//  NYTimesBestSeller
//
//  Created by Tsering Lama on 2/5/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import Gemini
import ImageKit

protocol GeminiCellDelegate: AnyObject {
    func didLongPress(_ imageCell: FavoritesCell)
}

class FavoritesCell: GeminiCell {
    public lazy var bookImageView: UIImageView = {
            let iv = UIImageView()
            iv.image = UIImage(systemName: "photo")
            iv.contentMode = .scaleAspectFill
            iv.backgroundColor = .systemTeal
            return iv
        }()
        
        public lazy var bookTitle: UILabel = {
            let label = UILabel()
            label.numberOfLines = 2
            label.font = UIFont.preferredFont(forTextStyle: .headline)
            label.text = "Book Title"
            return label
        }()
        
        public lazy var bookDescription: UILabel = {
            let label = UILabel()
            label.numberOfLines = 4
            label.font = UIFont.preferredFont(forTextStyle: .subheadline)
            label.text = "Book Description"
            return label
        }()
        
        public lazy var selectedView: UIView = {
            let view = UIView()
            view.backgroundColor = .lightGray
            view.isHidden = true
            return view
        }()
        
        weak var geminiDelegate: GeminiCellDelegate?
        
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
            setupSelectedViewConstraints()
        }
        
        private lazy var longPressGesture: UILongPressGestureRecognizer = {
            let gesture = UILongPressGestureRecognizer()
            gesture.addTarget(self, action: #selector(longPressAction(gesture:)))
            return gesture
        }()
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            addGestureRecognizer(longPressGesture)
        }
        
        private func setupImageConstraints() {
            addSubview(bookImageView)
            bookImageView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                bookImageView.topAnchor.constraint(equalTo: topAnchor),
                bookImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
                bookImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
                bookImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
        }
        
        private func setupSelectedViewConstraints() {
            addSubview(selectedView)
            selectedView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                selectedView.centerXAnchor.constraint(equalTo: bookImageView.centerXAnchor),
                selectedView.centerYAnchor.constraint(equalTo: bookImageView.centerYAnchor),
                selectedView.widthAnchor.constraint(equalTo: bookImageView.widthAnchor, multiplier: 0.75),
                selectedView.heightAnchor.constraint(equalTo: bookImageView.heightAnchor, multiplier: 0.75)
            ])
        }
        
        public func configureCell(for book: Book) {
            bookImageView.getImage(with: book.bookImage) {[weak self] (result) in
                switch result {
                case .failure:
                    self?.bookImageView.image = UIImage(systemName: "photo")
                case .success(let image):
                    DispatchQueue.main.async {
                        self?.bookImageView.image = image
                    }
                }
            }
        }
        
        @objc private func longPressAction(gesture: UILongPressGestureRecognizer) {
            if gesture.state == .began {
                gesture.state = .cancelled
                return
            }
            geminiDelegate?.didLongPress(self)
        }

    }
