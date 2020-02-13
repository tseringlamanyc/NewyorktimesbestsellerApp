//
//  BestSellerViewController.swift
//  NYTimesBestSeller
//
//  Created by Tsering Lama on 2/5/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class BestSellerViewController: UIViewController {
    
    private var bestSellerView = BestSellerView()
    
    override func loadView() {
        view = bestSellerView
    }
    
    var sections = [String]() {
        didSet {
            bestSellerView.pickerView.reloadAllComponents()
        }
    }
    
    private var allCategories = [Categories]() {
        didSet {
            sections = allCategories.map {$0.listName}
        }
    }
    
    private var allBooks = [Book]() {
        didSet {
            DispatchQueue.main.async {
                self.bestSellerView.bestSellerCV.reloadData()
            }
        }
    }
    
    var nowBook = "Animals"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        bestSellerView.bestSellerCV.dataSource = self
        bestSellerView.bestSellerCV.delegate = self
        bestSellerView.bestSellerCV.register(BestSellerCell.self, forCellWithReuseIdentifier: "bestCell")
        bestSellerView.pickerView.dataSource = self
        bestSellerView.pickerView.delegate = self
        getCategories()
        getBooks(category: nowBook)
    }
    
    private func getCategories() {
        CategoryAPI.getCategory { [weak self] (result) in
            switch result {
            case .failure(_):
                print("Couldnt get categories")
            case .success(let data):
                DispatchQueue.main.async {
                    self?.allCategories = data
                }
            }
        }
    }
    
    private func getBooks(category: String) {
        NYTAPIClient.getBooks(for: nowBook) { [weak self] (result) in
            switch result {
            case .failure(_):
                print("couldnt load books")
            case .success(let books):
                self?.allBooks = books
            }
        }
    }
}


extension BestSellerViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allBooks.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bestCell", for: indexPath) as? BestSellerCell else {
            fatalError()
        }
        cell.updateCell(book: allBooks[indexPath.row])
        cell.backgroundColor = .systemBackground
        return cell
    }
}

extension BestSellerViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let maxSize = UIScreen.main.bounds.size
        let itemwidth: CGFloat = maxSize.width * 0.47
        let itemHeight: CGFloat = maxSize.height * 0.37
        return CGSize(width: itemwidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
    }
}

extension BestSellerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return sections.count
    }
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        <#code#>
//    }
    
}
extension BestSellerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return sections[row]
    }
}
