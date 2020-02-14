//
//  DetailViewController.swift
//  NYTimesBestSeller
//
//  Created by Tsering Lama on 2/5/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import DataPersistence
import SafariServices

class DetailViewController: UIViewController {
    
    private var book: Book
    //  private var buy: BuyLink
    
    private let detailView = DetailView()
    private var googleBooks = [GoogleBook]()
    
    private var dataPersistence: DataPersistence<Book>
    
    private var bookmarkBarButton: UIBarButtonItem!
    
    //    init(<#parameters#>) {
    //        <#statements#>
    //    }
    
    init(_ dataPersistence: DataPersistence<Book>, books: Book) {
        self.dataPersistence = dataPersistence
        self.book = books
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailView.detailbutton.addTarget(self, action: #selector(linkButton(sender:)), for: .touchUpInside)
        
        view.backgroundColor = .systemBackground
        
        // adding a UIBarButtonItem to the right side to the navigation bar's title
        bookmarkBarButton = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveArticleButtonPressed(_:)))
        navigationItem.rightBarButtonItem = bookmarkBarButton
        
        updateUI()
    }
    
    private func updateUI() {
        
        updateBookmarkState(book)
        navigationItem.title = book.title
        
        detailView.booksCoverImage.getImage(with: book.bookImage) { [weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.detailView.booksCoverImage.image = UIImage(systemName: "exclamationmark-octogon")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.detailView.booksCoverImage.image = image
                }
            }
        }
        
        GoogleAPIClient.getGoogleBooks(for: book.primaryIsbn10) { (result) in
            switch result {
            case .failure(let appError):
                print("error \(appError)")
            case .success(let book):
                DispatchQueue.main.async {
                    self.detailView.summary.text = book.first?.volumeInfo.description ?? "N/A"
                    self.detailView.abstractHeadline.text = book.first?.volumeInfo.title ?? "N/A"
                }
            }
        }
        
        
    }
    @IBAction func linkButton(sender: UIButton) {
        print("button pressed")
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        present(alertController, animated: true)
        
        let amazonLink = book.getBuyLinkURL(for: .amazon)
        
        let amazonBuy = UIAlertAction(title: "Buy From Amazon", style: .default) { [weak self] alertAction in
            
            guard let url = URL(string: amazonLink) else {
                if amazonLink == "" {
                    self?.showAlert(title: "Sorry", message: "Amazon does not have this book for sell")
                }
                return
            }
            let safariNYTVC = SFSafariViewController(url: url)
            self?.present(safariNYTVC, animated: true)
        }
        let appleLink = book.getBuyLinkURL(for: .appleBooks)
        
        let appleInfoAction = UIAlertAction(title: "Buy From Apple Books", style: .default) { [weak self] alertAction in
            
            
            guard let url = URL(string: appleLink) else {
                if appleLink == "" {
                    self?.showAlert(title: "Sorry", message: "Apple does not have this book")
                }
                return
            }
            let safariNYTVC = SFSafariViewController(url: url)
            self?.present(safariNYTVC, animated: true)
        }
        let barnesAndNobleLink = book.getBuyLinkURL(for: .barnesAndNoble)
        
        let barnesAndNobleInfo = UIAlertAction(title: "Buy from Barnes & Noble", style: .default) { [weak self] alertAction in
            
            
            guard let url = URL(string: barnesAndNobleLink) else {
                if barnesAndNobleLink == "" {
                    self?.showAlert(title: "Sorry", message: "Barnes & Noble does not have this book")
                }
                return
            }
            let safariNYTVC = SFSafariViewController(url: url)
            self?.present(safariNYTVC, animated: true)
        }
        let localBooksellersLink = book.getBuyLinkURL(for: .localBooksellers)
        
        let localBooksellersInfo = UIAlertAction(title: "Buy from Local Book sellers", style: .default) { [weak self] alertAction in
            
            
            guard let url = URL(string: barnesAndNobleLink) else {
                if localBooksellersLink == "" {
                    self?.showAlert(title: "Sorry", message: "The Local Book sellers does not have this book")
                }
                return
            }
            let safariNYTVC = SFSafariViewController(url: url)
            self?.present(safariNYTVC, animated: true)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(amazonBuy)
        alertController.addAction(appleInfoAction)
        alertController.addAction(barnesAndNobleInfo)
        alertController.addAction(localBooksellersInfo)
        alertController.addAction(cancelAction)
    }
    
    @objc
    func saveArticleButtonPressed(_ sender: UIBarButtonItem) {
        
        if dataPersistence.hasItemBeenSaved(book) {
            sender.isEnabled = false
        } else {
            do {
                // save to documents directory
                try dataPersistence.createItem(book)
            } catch {
                print("error saving article: \(error)")
            }
            showAlert(title: "❤️", message: "Book was saved to your Favorites")
            sender.isEnabled = false
            
            // ADDITION:
            // update bookmark state
            updateBookmarkState(book)
        }
    }
    // ADDITION
    private func updateBookmarkState(_ article: Book) {
        if dataPersistence.hasItemBeenSaved(article) {
            bookmarkBarButton.image = UIImage(systemName: "bookmark.fill")
        } else {
            bookmarkBarButton.image = UIImage(systemName: "bookmark")
        }
    }
}
