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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        bestSellerView.bestSellerCV.dataSource = self
        bestSellerView.bestSellerCV.delegate = self
        bestSellerView.bestSellerCV.register(BestSellerCell.self, forCellWithReuseIdentifier: "bestCell")
    }
}

extension BestSellerViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bestCell", for: indexPath) as? BestSellerCell else {
            fatalError()
        }
        cell.backgroundColor = .systemGray
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
