//
//  DataPersistence.swift
//  Movies
//
//  Created by Lucas Brandão on 15/03/21.
//

import UIKit

public class GenresData{
    func saveGenres(genres: [String]) -> Void {
        let userDefaults = UserDefaults.standard
        userDefaults.set(genres, forKey: "genres")
    }
    
    func getGenres() -> [String]?{
        let userDefaults = UserDefaults.standard
        return userDefaults.object(forKey: "genres") as? [String]
    }
}

extension UserDefaults {
  static let group = UserDefaults(suiteName: "group.Lucas-Brandao.Movies")!
}
