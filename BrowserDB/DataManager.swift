//
//  DataManager.swift
//  BrowserDB
//
//  Created by Valentyn Reshetniak on 05.08.2022.
//

import Foundation
import RealmSwift

class  MovieID: Object{
    @Persisted  var ID = 0
    @Persisted  var Title = ""
    @Persisted  var MoviesOrTV = ""
    @Persisted  var release_date = ""
}
struct DataManager {
   let realm1 = try? Realm()
    // Save into Base
    func save(movie: MovieID){
        var movies = [MovieID]()
        guard let Record = realm1?.objects(MovieID.self)
        else {
            try! realm1?.write {
            realm1?.add(movie)
            }
            return
        }
        for i in Record {
            movies.append(i)
        }
        if movies.count > 0{
            for j in 0 ... movies.count-1{
                if movie.ID == movies[j].ID{
                    try! realm1?.write {
                        movie.ID = movies[j].ID
                    }
                return
                }
            }
        }
        try! realm1?.write {
            realm1?.add(movie)
        }
    }
   // Get list of the records in Base
    func getList() -> [MovieID]{
        var movies = [MovieID]()
        guard let Record = realm1?.objects(MovieID.self) else {
            do {
                // Delete the realm if a migration would be required, instead of migrating it.
                // While it's useful during development, do not leave this set to `true` in a production app!
                let configuration = Realm.Configuration(deleteRealmIfMigrationNeeded: false)
                let realm1 = try Realm(configuration: configuration)
                _ = try Realm.deleteFiles(for: configuration)
            } catch {
                print("Error opening realm: \(error.localizedDescription)")
            }
            return []}
        for i in Record {
            movies.append(i)
        }
        return movies
    }
    func delete(movieD: MovieID){
        try! realm1?.write {
        // Delete the movieD
            realm1?.delete(movieD)
        }
    }
}
