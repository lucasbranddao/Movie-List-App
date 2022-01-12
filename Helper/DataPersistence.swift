//
//  DataPersistence.swift
//  Movies
//
//  Created by Lucas Brandão on 15/03/21.
//

import UIKit
import CoreData

public class GenresData{
    
    func saveGenres(genres: [String]){
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            guard let entity = NSEntityDescription.entity(forEntityName: "MoviesEntity", in: context) else { return }
            
            let value = NSManagedObject(entity: entity, insertInto: context)
            value.setValue(genres, forKey: "genres")
            
            do{
                try context.save()
                print("Saved \(genres)")
            } catch{
                print("Error saving genres")
            }
        }
    }
    
    func getGenres() -> [String]{
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate{
            let context = appDelegate.persistentContainer.viewContext
            let request = NSFetchRequest<MoviesEntity>(entityName: "MoviesEntity")
            
            do{
                let results = try context.fetch(request)
                for result in results{
                    if let genres = result.genres as? [String]{
                        print("Getting \(genres)")
                        return genres
                    }
                }
            } catch{
                print("Error saving genres")
            }
        }
        return []
    }
}
