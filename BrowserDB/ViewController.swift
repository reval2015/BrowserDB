//
//  ViewController.swift
//  BrowserDB
//
//  Created by Valentyn Reshetniak on 01.08.2022.
//

import UIKit

class ViewController: UIViewController {
    let DM = DataManager()
    @IBOutlet weak var tabBar1: UITabBar!
    
    @IBOutlet weak var Films: UITabBarItem!
    
    @IBOutlet weak var WatchLater: UITabBarItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}
extension ViewController: UITabBarDelegate{
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item == Films {
            let main = UIStoryboard(name: "Main", bundle: nil)
        if let vc = main.instantiateViewController(withIdentifier: "ViewControllerFilms") as? ViewControllerFilms{
            
            show(vc, sender: self)
        }}
       else{
           arrayWatchMovies = []
           watchMoviesID = DM.getList()
           if watchMoviesID.count > 0{
               for i in 0 ... watchMoviesID.count-1 {
                   requestWatchMovies(watchMoviesID: watchMoviesID[i])
               }
           }
            let main = UIStoryboard(name: "Main", bundle: nil)
           if let vc2 = main.instantiateViewController(withIdentifier: "ListViewController") as? ListViewController{
              
            show(vc2, sender: self)
           }
        }
        
}
}
