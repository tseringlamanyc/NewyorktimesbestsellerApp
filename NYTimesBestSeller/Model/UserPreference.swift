//
//  UserPreference.swift
//  NYTimesBestSeller
//
//  Created by Margiett Gil on 2/13/20.
//  Copyright © 2020 Tsering Lama. All rights reserved.
//

import Foundation

struct UserKey {
  static let sectionName = "News Section"
}

protocol UserPreferenceDelegate: AnyObject {
  func didChangeNewsSection(_ userPreference: UserPreference, sectionName: String)
}

final class UserPreference {
    
  weak var delegate: UserPreferenceDelegate?
  
  public func getSectionName() -> String? {
    return UserDefaults.standard.object(forKey: UserKey.sectionName) as? String
  }
  
  public func setSectionName(_ sectionName: String) {
    UserDefaults.standard.set(sectionName, forKey: UserKey.sectionName)
    delegate?.didChangeNewsSection(self, sectionName: sectionName)
  }
}
