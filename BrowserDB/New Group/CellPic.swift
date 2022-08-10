//
//  CellPic.swift
//  HomeWork4
//
//  Created by Valentyn Reshetniak on 23.07.2022.
//

import UIKit

class CellPic: UITableViewCell {

    @IBOutlet weak var imageW: UIImageView!
    @IBOutlet weak var label1: UILabel!
 
    @IBOutlet weak var label2: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func  Configure(movie: Movie){
        label1.text = movie.title
        label2.text = movie.overview
        let posterPath1 = movie.posterPath ?? ""
        let imageURLString: String = "https://image.tmdb.org/t/p/original" + posterPath1
        let imageURL: URL = URL(string: imageURLString)!
        imageW.sd_setImage(with: imageURL, completed: nil)
    }
    func  Configure1(movie: MovieDetail){
        label1.text = movie.title
        label2.text = movie.overview
        let posterPath1 = movie.poster_path ?? ""
        let imageURLString: String = "https://image.tmdb.org/t/p/original" + posterPath1
        let imageURL: URL = URL(string: imageURLString)!
        imageW.sd_setImage(with: imageURL, completed: nil)
    }
}

