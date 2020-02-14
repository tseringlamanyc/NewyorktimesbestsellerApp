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

class FavoritesDetailController: UIViewController {
    
    public var modallView = FavoritesDetailView()
    
    override func loadView() {
        view = modallView
    }
    
    private var googleBooks = [GoogleBook]()
    
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
        
        loadBooks()
        updateBookImage()
        updateUI()
    }
    
    
    
    private var googleTitle = "" {
        didSet {
            print(googleTitle)
            updateUI()
        }
    }
    
    private func loadBooks() {
        
        GoogleAPIClient.getGoogleBooks(for: selectedBook.primaryIsbn10) { [weak self] (result) in
            switch result {
            case .failure(let appError):
                print("error: \(appError)")
            case .success(let bookArr):
                //                self?.googleBook = bookArr
                //                self?.googleTitle = bookArr.first?.volumeInfo.title ?? "N/A"
                DispatchQueue.main.async {
                    self?.modallView.descriptionLabel.text = bookArr.first?.volumeInfo.description ?? "N/A"
                    self?.modallView.bookTitle.text = bookArr.first?.volumeInfo.title ?? "N/A"
                }
                dump(bookArr)
            }
        }
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
        print("button pressed")
        print(selectedBook.getBuyLinkURL(for: .appleBooks))
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        present(alertController, animated: true)
        
        let timesReviewAction = UIAlertAction(title: "NYT Review", style: .default) { [weak self] alertAction in
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
        
        let googleInfoAction = UIAlertAction(title: "Google", style: .default) { [weak self] alertAction in
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
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(timesReviewAction)
        alertController.addAction(googleInfoAction)
        alertController.addAction(cancelAction)
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
