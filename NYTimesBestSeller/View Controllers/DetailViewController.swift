//
//  DetailViewController.swift
//  NYTimesBestSeller
//
//  Created by Tsering Lama on 2/5/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import DataPersistence

class DetailViewController: UIViewController {
    
    private var book: Book
    
    private let detailView = DetailView()
    
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
      view.backgroundColor = .systemBackground
      
      // adding a UIBarButtonItem to the right side to the navigation bar's title
      bookmarkBarButton = UIBarButtonItem(image: UIImage(systemName: "bookmark"), style: .plain, target: self, action: #selector(saveArticleButtonPressed(_:)))
      navigationItem.rightBarButtonItem = bookmarkBarButton
      
      updateUI()
    }
    
    private func updateUI() {
     
//      guard let updateBook = book else {
//        fatalError("did not load an article")
//      }
      updateBookmarkState(book)
        navigationItem.title = book.title
     //detailView.abstractHeadline.text = book.abstract
      
        detailView.newsImageView.getImage(with: book.bookImage) { [weak self] (result) in
        switch result {
        case .failure:
          DispatchQueue.main.async {
            self?.detailView.newsImageView.image = UIImage(systemName: "exclamationmark-octogon")
          }
        case .success(let image):
          DispatchQueue.main.async {
            self?.detailView.newsImageView.image = image
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
    
    @objc func saveArticleButtonPressed(_ sender: UIBarButtonItem) {
////      guard let article = book else { return }
//      // ADDITION: check for duplicates
//      if dataPersistence.hasItemBeenSaved(book) {
//        if let index = try? dataPersistence.loadItems().firstIndex(of: book) {
//          do {
//            try dataPersistence.deleteItem(at: index)
//          } catch {
//            print("error deleting article: \(error)")
//          }
//        }
//      } else {
        do {
          // save to documents directory
          try dataPersistence.createItem(book)
        } catch {
          print("error saving article: \(error)")
        }

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
