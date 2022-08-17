//
//  ViewControllerFilms.swift
//  BrowserDB
//
//  Created by Valentyn Reshetniak on 01.08.2022.
//

import UIKit
import Alamofire
import SDWebImage
 
    


class ViewControllerFilms: UIViewController {
    var searchFilm: String = ""
    var countsearch: Int = 0
    var timer: Timer?
    var arrayOfMovies : [Movie] = []
    
    @IBOutlet var searchBarFilm: UISearchBar!
    
    @IBOutlet var segmControl: UISegmentedControl!
    
    @IBOutlet var tableViewFilm: UITableView!
    @IBOutlet var Item: UITabBarItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        segmControl.setTitle("Movies",forSegmentAt: 0)
        segmControl.setTitle("Series",forSegmentAt: 1)
        requestFilms()
        let nib = UINib(nibName: "CellPic", bundle: nil)
        self.tableViewFilm.register(nib, forCellReuseIdentifier: "CellPic")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {// delay on 0.1 sec for block of code
            self.tableViewFilm.reloadData()
        }
     //   ViewControllerFilms.providesPresentationContextTransitionStyle = true
     //   ViewControllerFilms.definesPresentationContext = true
    }
    @IBAction func swtchOfSegment(_ sender: Any) {
        requestFilms()
        self.tableViewFilm.reloadData()
    }
}
extension ViewControllerFilms: UISearchBarDelegate{
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool
    {
        createTimer()
        return true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
        searchFilm = ""
        countsearch = 0
    }
    func searchBar(
        _ searchBar: UISearchBar,
        textDidChange searchText: String
    ){
        cancelTimer()
        createTimer()
        if searchText.count == 0 {
           searchFilm = "";countsearch = 0}
        if searchFilm .hasSuffix("%20"){}
        else{
        if searchText.hasSuffix(" "){
            searchFilm = String(searchText.prefix(searchText.count-1)) + "%20"
        }else{
            searchFilm = searchText}}
    }
}

extension ViewControllerFilms {
  func createTimer() {
    if timer == nil {
      let timer = Timer(timeInterval: 1.0,
        target: self,
        selector: #selector(updateTimer),
        userInfo: nil,
        repeats: true)
      RunLoop.current.add(timer, forMode: .common)
      timer.tolerance = 0.1
      
      self.timer = timer
    }
  }
    func cancelTimer() {
      timer?.invalidate()
      timer = nil
    }
    @objc func updateTimer() {
        updateTime()
    }
    func updateTime() {
        if searchFilm.count > 1 {//start search film
         countsearch = 2
            requestFilms()
            self.tableViewFilm.reloadData()
            cancelTimer()
        }
        else {countsearch = 0}
 
    }
    func requestFilms() {
        var url = Constants.URL.URLTVSearch + Constants.URL.APIKey + Constants.URL.URLSearchquery + searchFilm
        if countsearch == 2{
              if segmControl.selectedSegmentIndex == 0{
                  url = Constants.URL.URLMovieSearch + Constants.URL.APIKey + Constants.URL.URLSearchquery + searchFilm}
        }
        else{
      url = Constants.URL.URLTVTrend + Constants.URL.APIKey
        if segmControl.selectedSegmentIndex == 0{
             url = Constants.URL.URLMovieTrend + Constants.URL.APIKey}
        }
        self.arrayOfMovies = []
        let URL1: URL = URL(string: url)!
        AF.request(URL1).responseJSON { responce in
        do {
            let allData = try JSONDecoder().decode(TrendingMovies.self, from: responce.data!)
            self.arrayOfMovies = allData.results ?? []
            self.tableViewFilm.reloadData()
            //self.label3.text = allData.results![0].title
            //self.label4.text = allData.results![0].posterPath
        } catch {
            print(error)
        }
        }
    }
    
}
var StatusSave = 1 // Status Save movie to list of the Watch later
// or View movie in player end delete movie
var watchMoviesID : [MovieID] = []
var arrayWatchMovies : [MovieDetail] = []
func requestWatchMovies(watchMoviesID: MovieID) {
   // struct DecodableType: Decodable { var url: String }
  //arrayWatchMovies = []
    var url = ""
   
    //for i in 0 ... watchMoviesID.count-1 {
         url = Constants.URL.URLTV + String(watchMoviesID.ID) +  Constants.URL.APIKey
     if watchMoviesID.MoviesOrTV  == "Movie"{
          url = Constants.URL.URLMovie + String(watchMoviesID.ID) +  Constants.URL.APIKey}
        let URL1: URL = URL(string: url)!
        AF.request(URL1).validate()
            .responseDecodable(of: MovieDetail.self) { responce in
                do { let allData = try JSONDecoder().decode(MovieDetail.self, from: responce.data!)
                    arrayWatchMovies.append(allData)
                }catch{
                    print(error)
                }
            }
}
var KeyOfVideo =  ""
func requestVideoMovies(VideoMoviesID: MovieID) {
    var url = ""
    url = Constants.URL.URLTV + String(VideoMoviesID.ID) +  Constants.URL.URLvideos + Constants.URL.APIKey
     if VideoMoviesID.MoviesOrTV  == "Movie"{
          url = Constants.URL.URLMovie + String(VideoMoviesID.ID) +  Constants.URL.URLvideos + Constants.URL.APIKey}
        let URL1: URL = URL(string: url)!
        let request = AF.request(URL1).validate()
            request.responseDecodable(of: MovieDetail.self)  {
            responce in
        do {
            let allData = try JSONDecoder().decode(KeyOfMovie.self, from: responce.data!)
            if allData.results?.isEmpty == false{
                KeyOfVideo = allData.results?[0].key ?? ""}
        } catch {
            print(error)
        }
    }
    
   // return MovieDetail.init(from: Decoder)
    
}
extension ViewControllerFilms: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  arrayOfMovies.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CellPic", for: indexPath) as? CellPic{
            let movie = arrayOfMovies[indexPath.row]
            cell.Configure(movie:movie)
            return cell
        }
        return UITableViewCell()
    }
}

extension ViewControllerFilms: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 248
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let main = UIStoryboard(name: "Main", bundle: nil)
    if let vc = main.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
        vc.movieW = arrayOfMovies[indexPath.row]
        StatusSave = 1
        show(vc, sender: Any?.self)
        //navigationController?.pushViewController(vc, animated: true)
    }
}
}
