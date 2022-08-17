//
//  DetailViewController.swift
//  BrowserDB
//
//  Created by Valentyn Reshetniak on 05.08.2022.
//

import UIKit
import SDWebImage
import youtube_ios_player_helper

class DetailViewController: UIViewController {
    var movieid = MovieID()
    let DM = DataManager()
    var movieW: Movie?
    var movieDetail: MovieDetail?
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var OverviewLabel: UILabel!
    @IBOutlet var TilleLabel: UILabel!
    @IBOutlet var DateLabel: UILabel!
    @IBOutlet var PopuliarityLabel: UILabel!
    @IBOutlet var ButtonExit: UIButton!
    @IBOutlet var ButtonSave: UIButton!
    @IBOutlet var StatusSaveLabel: UILabel!
    
   // func YTPlayerView.*playerView(){}
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.isHidden = true
        if StatusSave == 1{
//            let movie = arrayOfMovies[indexPath.row]
            configureDetail(movie: movieW!)
            ButtonSave.setTitle("Save to Watch later", for: UIControl.State.normal)
            ButtonSave.backgroundColor = .red
            ButtonSave.layer.cornerRadius = 10
            ButtonExit.isHidden = true
            ButtonExit.setTitle("Exit", for: UIControl.State.normal)
            ButtonExit.backgroundColor = .yellow
            ButtonExit.layer.cornerRadius = 10
        }
        else {
            configureDetail1(movie: movieDetail!,movied: movieid)
            ButtonSave.setTitle("View Movie", for: UIControl.State.normal)
            ButtonSave.backgroundColor = .yellow
            ButtonSave.layer.cornerRadius = 10
            ButtonExit.isHidden = false
            ButtonExit.setTitle("Delete Movie", for: UIControl.State.normal)
            ButtonExit.backgroundColor = .red
            ButtonExit.layer.cornerRadius = 10
        }
    }
 
    @IBOutlet var playerView: YTPlayerView!
    @IBAction func ButtonPressedSave(_ sender: Any) {
        if StatusSave == 1{
            if movieid.ID != 0{
            DM.save(movie: self.movieid)
            StatusSaveLabel.text = "Save to list of Watch Later " + self.movieid.Title + " ended!"
        }
        }
        else
        {if KeyOfVideo.isEmpty == false{
            playerView.isHidden = false
            StatusSaveLabel.text = "Start of the load movie" + self.movieid.Title
            playerView.load(withVideoId: KeyOfVideo)
            }
            else{
                StatusSaveLabel.text = "Not video for movie " + self.movieid.Title
            }
        }
    }
    
    @IBAction func ButtonPressedExit(_ sender: Any) {
        //close ViewController
        if StatusSave == 2 {
            // delete movie
            DM.delete(movieD:  movieid)
            arrayWatchMovies = []
            watchMoviesID = DM.getList()
            if watchMoviesID.count > 0{
                for i in 0 ... watchMoviesID.count-1 {
                    requestWatchMovies(watchMoviesID: watchMoviesID[i])
                }
            }
           // ListViewController.ListTableView.reloadData()
        }
        dismiss(animated: false,completion:  nil)
    }
}
    extension DetailViewController {
    func configureDetail(movie: Movie){
        StatusSave = 1
        movieid.ID = movie.id!
        movieid.Title = movie.title!
        movieid.MoviesOrTV = ""
        if movie.media_type == "movie" { movieid.MoviesOrTV = "Movie"}
        movieid.release_date = movie.release_date ?? ""
        TilleLabel.text = movie.title
        OverviewLabel.text = movie.overview
        DateLabel.text = movie.release_date
        PopuliarityLabel.text = String(format: "%.3f",movie.popularity!)
        let posterPath1 = movie.posterPath ?? ""
        let imageURLString: String = Constants.URL.URLPoster + posterPath1
        let imageURL: URL = URL(string: imageURLString)!
        imageView.sd_setImage(with: imageURL, completed: nil)
        if movie.media_type != "movie"{
            if movie.video == false{
                movieid.ID = 0
                StatusSaveLabel.text = "Video is not for " + self.movieid.Title
            }
        }
    }
        func configureDetail1(movie: MovieDetail, movied: MovieID){
        StatusSave = 2
        movieid = movied
            TilleLabel.text = movie.title
            OverviewLabel.text = movie.overview
            //+ " "
            //+ movie.genres[0]?.name
            //+ " " + movie.genres[1]?.name + " " + movie.genres[2]?.name
        DateLabel.text = movieid.release_date
        PopuliarityLabel.text = String(format: "%.3f",movie.popularity!)
        let posterPath1 = movie.poster_path ?? ""
        let imageURLString: String = Constants.URL.URLPoster  + posterPath1
        let imageURL: URL = URL(string: imageURLString)!
        imageView.sd_setImage(with: imageURL, completed: nil)
        requestVideoMovies(VideoMoviesID: movieid)
    }
}
