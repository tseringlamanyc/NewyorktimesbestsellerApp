//
//  FavoritesDetailController.swift
//  NYTimesBestSeller
//
//  Created by Kelby Mittan on 2/13/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import SafariServices
import DataPersistence
import SCLAlertView

class FavoritesDetailController: UIViewController {
    
    public var modallView = FavoritesDetailView()
    
    override func loadView() {
        view = modallView
    }
    
    private lazy var tapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action: #selector(didTap(_:)))
        return gesture
    }()
    
    private var googleBooks = [GoogleBook]() {
        didSet {
        }
    }
    
    private var dataPersistence: DataPersistence<Book>
    
    private var selectedBook: Book
    
    init(_ dataPersistence: DataPersistence<Book>, book: Book) {
        self.dataPersistence = dataPersistence
        self.selectedBook = book
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        modallView.menuButton.addTarget(self, action: #selector(linkButton(sender:)), for: .touchUpInside)
        modallView.backgroundColor = .clear
        modallView.isUserInteractionEnabled = true
        modallView.addGestureRecognizer(tapGesture)
        loadBooks()
        updateBookImage()
        updateUI()
    }
    
    private func loadBooks() {
        
        GoogleAPIClient.getGoogleBooks(for: selectedBook.primaryIsbn10) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let bookArr):
                self?.googleBooks = bookArr
                DispatchQueue.main.async {
                    self?.modallView.descriptionLabel.text = bookArr.first?.volumeInfo.description ?? "N/A"
                    self?.modallView.bookTitle.text = bookArr.first?.volumeInfo.title ?? "N/A"
                }
            }
        }
        dump(googleBooks)
    }
    
    private func updateUI() {
        let book = selectedBook
        
        DispatchQueue.main.async {
            self.modallView.rankLabel.text = "Rank: \(book.rank)"
            self.modallView.byLine.text = book.contributor
            if book.rankLastWeek == 0 {
                self.modallView.weeksOnListLabel.text = "\(book.weeksOnList) weeks on list... Not ranked last week"
            } else {
                self.modallView.weeksOnListLabel.text = "\(book.weeksOnList) weeks on list. Ranked \(book.rankLastWeek) last week"
            }
        }
    }
    
    private func updateBookImage() {
        modallView.bookImageView.getImage(with: selectedBook.bookImage) {[weak self] (result) in
            switch result {
            case .failure:
                self?.modallView.bookImageView.image = UIImage(systemName: "photo")
            case .success(let image):
                DispatchQueue.main.async {
                    self?.modallView.bookImageView.image = image
                }
            }
        }
        modallView.bookImageView.backgroundColor = .blue
    }
    
    @IBAction func linkButton(sender: UIButton) {
        let appearance = SCLAlertView.SCLAppearance(
            kCircleBackgroundTopPosition: 0,
            kCircleHeight: 100,
            kCircleIconHeight: 80,
            showCircularIcon: true,
            circleBackgroundColor: .clear
        )

        let alertView = SCLAlertView(appearance: appearance)

        alertView.addButton("NYT Review") { [weak self] in
            print("first button")
            let nytWebString = self?.selectedBook.bookReviewLink
            guard let url = URL(string: nytWebString ?? "") else {
                if nytWebString == "" {
                    self?.showAlert(title: "Sorry", message: "The New York Times has yet to review this book.")
                }
                return
            }
            let safariNYTVC = SFSafariViewController(url: url)
            self?.present(safariNYTVC, animated: true)
        }
        alertView.addButton("Preview on Google") { [weak self] in
            let googleWebString = self?.googleBooks.first?.volumeInfo.previewLink
            guard let url = URL(string: googleWebString ?? "") else {
                if googleWebString == "" {
                    self?.showAlert(title: "Sorry", message: "There is no preview of this book available on Google Books.")
                }
                return
            }
            let safariNYTVC = SFSafariViewController(url: url)
            self?.present(safariNYTVC, animated: true)
        }
        let image = UIImage.gif(name: "bookGIF2")!
        let title = selectedBook.title

        alertView.showCustom("  ", subTitle: "\(title )", color: .gray, icon: image)
        
    }
    
    @objc private func didTap(_ gesture: UITapGestureRecognizer) {
        
        UIView.animate(withDuration: 0.75, delay: 0.0, options: [], animations: {
            self.modallView.scrollView.transform = CGAffineTransform(scaleX: 20, y: 20)
            self.modallView.alpha = 0.0
        }) { (done) in
            self.dismiss(animated: true)
        }
    }
    
}


extension UIViewController {
    func showAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: completion)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}
