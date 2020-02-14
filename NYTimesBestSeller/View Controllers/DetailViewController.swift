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
    
    private let detailView = DetailView()
    private var googleBooks = [GoogleBook]()
    
    private var dataPersistence: DataPersistence<Book>
    
    private var bookmarkBarButton: UIBarButtonItem!
    
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
         
         let timesReviewAction = UIAlertAction(title: "NYT Review", style: .default) { [weak self] alertAction in
             let nytWebString = self?.book.bookReviewLink
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
    
    @objc
    func saveArticleButtonPressed(_ sender: UIBarButtonItem) {

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

    // ADDITION
    private func updateBookmarkState(_ article: Book) {
      if dataPersistence.hasItemBeenSaved(article) {
        bookmarkBarButton.image = UIImage(systemName: "bookmark.fill")
      } else {
        bookmarkBarButton.image = UIImage(systemName: "bookmark")
      }
    }
}
