//
//  ListViewController.swift
//  BrowserDB
//
//  Created by Valentyn Reshetniak on 06.08.2022.
//

import UIKit


class ListViewController: UIViewController {
    //var watchMoviesID : [MovieID] = []
    //var arrayWatchMovies : [MovieDetail] = []
    @IBOutlet var ListTableView: UITableView!
    

    @IBOutlet var ButtonListReload: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "CellPic", bundle: nil)
        self.ListTableView.register(nib, forCellReuseIdentifier: "CellPic")
        ButtonListReload.setTitle("List of the movies for watch later = " + String(watchMoviesID.count), for: UIControl.State.normal)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {// delay on 0.1 sec for block of code
            self.ListTableView.reloadData()
        }
    }
    @IBAction func ButtonPressedListReload(_ sender: Any) {
        ButtonListReload.setTitle("List of the movies for watch later = " + String(watchMoviesID.count), for: UIControl.State.normal)
        self.ListTableView.reloadData()
    }
}

extension ListViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return watchMoviesID.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if arrayWatchMovies.count > indexPath.row {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CellPic", for: indexPath) as? CellPic{
            let movie = arrayWatchMovies[indexPath.row]
            cell.Configure1(movie:movie)
            return cell
        }
        }
        return UITableViewCell()
    }
}
extension ListViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        248
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let main = UIStoryboard(name: "Main", bundle: nil)
    if let vc1 = main.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController{
        ButtonListReload.setTitle("List of the movies for watch later = " + String(watchMoviesID.count), for: UIControl.State.normal)
        self.ListTableView.reloadData()
        if arrayWatchMovies.count > indexPath.row {
           let movie = arrayWatchMovies[indexPath.row]
           let movied = watchMoviesID[indexPath.row]
           StatusSave = 2
           //show(vc1, sender: self)
            vc1.configureDetail1(movie: movie,movied:  movied)
            navigationController?.pushViewController(vc1, animated: true)
           //vc1.configureDetail1(movie: movie,movied:  movied)
        }
        
        }
    }
}

      
