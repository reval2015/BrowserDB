//
//  Constants.swift
//  BrowserDB
//
//  Created by Valentyn Reshetniak on 15.08.2022.
//

import Foundation
struct Constants {
    struct URL {
        static let URLPoster: String = "https://image.tmdb.org/t/p/original"
        static let URLTV: String = "https://api.themoviedb.org/3/tv/"
        static let URLMovie: String = "https://api.themoviedb.org/3/movie/"
        static let URLvideos: String = "/videos"
        static let URLMovieTrend: String = "https://api.themoviedb.org/3/trending/movie/week"
        static let URLTVTrend: String = "https://api.themoviedb.org/3/trending/tv/week"
        static let URLMovieSearch: String = "https://api.themoviedb.org/3/search/movie"
        static let URLTVSearch: String = "https://api.themoviedb.org/3/search/tv"
        static let URLSearchquery: String = "&language=en-US&page=1&include_adult=false&query="
        static let APIKey: String = "?api_key=f8c00b14f420dc4ee3d72cebaa60a86e"
    }
    struct Text{
        static let List: String = "List of the movies for watch later = "
    }
}
