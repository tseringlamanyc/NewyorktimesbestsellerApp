//
//  FavoritesViewController.swift
//  NYTimesBestSeller
//
//  Created by Tsering Lama on 2/5/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit
import DataPersistence

class FavoritesViewController: UIViewController {
    
    private let listView = FavoritesView()
    
    private var books = [Book]() {
        didSet {
            listView.geminiCollectionView.reloadData()
            if books.isEmpty {
                listView.geminiCollectionView.backgroundView = EmptyView(title: "Favorited Books", message: "There are currently no saved books in your favorites collection. Start browsing by tapping on the Books Icon.")
            } else {
                addBackgroundGradient()
            }
        }
    }
    
    
    override func loadView() {
        view = listView
    }
    
    private var dataPersistence: DataPersistence<Book>
    
    init(_ dataPersistence: DataPersistence<Book>) {
        self.dataPersistence = dataPersistence
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listView.geminiCollectionView.dataSource = self
        listView.geminiCollectionView.delegate = self
        listView.geminiCollectionView.register(FavoritesCell.self, forCellWithReuseIdentifier: "geminiBookCell")
        navigationItem.title = "Favorite Books"
        view.backgroundColor = .darkGray
        addBackgroundGradient()
        cubeAnimation()
        getSavedBooks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getSavedBooks()
    }
    
    private func getSavedBooks() {
        do {
            books = try dataPersistence.loadItems().reversed()
            dataPersistence.synchronize(books)
//            books = try dataPersistence.loadItems()
        } catch {
            showAlert(title: "Oops", message: "Could not load your saved books")
        }
    }
    
    private func addBackgroundGradient() {
        let collectionViewBackgroundView = UIView()
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = listView.frame.size
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.black.cgColor]
        listView.geminiCollectionView.backgroundView = collectionViewBackgroundView
        listView.geminiCollectionView.backgroundView?.layer.addSublayer(gradientLayer)
    }
    
    private func cubeAnimation() {
        listView.geminiCollectionView.gemini
        .cubeAnimation()
        .cubeDegree(90)
    }
}


extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let maxSize: CGSize = UIScreen.main.bounds.size
        let itemWidth: CGFloat = maxSize.width * 0.75
        let itemHeight: CGFloat = maxSize.height * 0.70
        
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "geminiBookCell", for: indexPath) as? FavoritesCell else {
            fatalError("could not deque cell")
        }
        cell.selectedView.isHidden = true

        let book = books[indexPath.row]
        let bookDetailVC = FavoritesDetailController(dataPersistence, book: book)
        
        self.present(bookDetailVC, animated: true)
        
        listView.geminiCollectionView.alpha = 0.15
        cell.layoutIfNeeded()
        
    }
}

extension FavoritesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return books.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let geminiCell = collectionView.dequeueReusableCell(withReuseIdentifier: "geminiBookCell", for: indexPath) as? FavoritesCell else {
            fatalError("could not deque cell")
        }
        let book = books[indexPath.row]
        
        listView.geminiCollectionView.animateCell(geminiCell)
        geminiCell.backgroundColor = .systemBackground
        geminiCell.geminiDelegate = self
        geminiCell.configureCell(for: book)
        return geminiCell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        listView.geminiCollectionView.animateVisibleCells()
        listView.geminiCollectionView.alpha = 1
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let cell = cell as? FavoritesCell {
            listView.geminiCollectionView.animateCell(cell)
        }
    }
    
}

extension FavoritesViewController: DataPersistenceDelegate {
    func didSaveItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        getSavedBooks()
    }
    
    func didDeleteItem<T>(_ persistenceHelper: DataPersistence<T>, item: T) where T : Decodable, T : Encodable, T : Equatable {
        getSavedBooks()
    }
    
}

extension FavoritesViewController: GeminiCellDelegate {
    func didLongPress(_ imageCell: FavoritesCell, book: Book) {
        print("delegate working")
        
        guard let indexPath = listView.geminiCollectionView.indexPath(for: imageCell) else {
            return
        }
      
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        present(alertController, animated: true)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { [weak self] alertAction in
            self?.deleteImageObject(book: book)
            self?.books.remove(at: indexPath.row)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alertController.addAction(deleteAction)
        alertController.addAction(cancelAction)
    }
    
    private func deleteImageObject(book: Book) {
        guard let index = books.firstIndex(of: book) else {
            return
        }
        do {
            try dataPersistence.deleteItem(at: index)
        } catch {
            showAlert(title: "Error", message: "Could not delete Book")
        }
    }
}
