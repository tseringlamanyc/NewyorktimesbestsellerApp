
//
//  DetailView.swift
//  NYTimesBestSeller
//
//  Created by Tsering Lama on 2/5/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import UIKit

class DetailView: UIView {

 public lazy var newsImageView: UIImageView =  {
      let iv = UIImageView()
          iv.image = UIImage(systemName: "photo")
          iv.contentMode = .scaleAspectFill
          
          return iv
      }()
      
       public lazy var abstractHeadline: UILabel = {
                let label = UILabel()
                label.numberOfLines = 0
                label.font = UIFont.preferredFont(forTextStyle: .title3)
                label.text = "Abstract Headline"
                label.textAlignment = .center
                
                return label
            }()
    
    public lazy var summary: UILabel = {
        let summaryLabel = UILabel()
        summaryLabel.numberOfLines = 3
        summaryLabel.font = UIFont.preferredFont(forTextStyle: .title3)
        summaryLabel.text = "Description"
        summaryLabel.textAlignment = .center
        return summaryLabel
        
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
              setUpWewsImageView()
              setUpAbstractHeadline()
            setupSummaryLabel()
      }
      
      private func setUpWewsImageView(){
          addSubview(newsImageView)
          
          newsImageView.translatesAutoresizingMaskIntoConstraints = false
          
          NSLayoutConstraint.activate([
              newsImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
              newsImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            
              newsImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
              newsImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
          ])
      }
      
      private func setUpAbstractHeadline(){
          addSubview(abstractHeadline)
          
          abstractHeadline.translatesAutoresizingMaskIntoConstraints = false
          
          NSLayoutConstraint.activate([
              abstractHeadline.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 8),
              
              abstractHeadline.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
              
              abstractHeadline.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
              
          ])
          
      }
    
    private func setupSummaryLabel(){
        addSubview(summary)
        
        summary.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            summary.topAnchor.constraint(equalTo: abstractHeadline.bottomAnchor, constant: 8),
            
            summary.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            
            summary.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)
        
        ])
    }

}
