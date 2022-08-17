//
//  ViewController.swift
//  BrowserDB
//
//  Created by Valentyn Reshetniak on 01.08.2022.
//

import UIKit

class ViewController: UITabBarController{
    let DM = DataManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
     
      //  navigationController?.navigationBar.isHidden = true


    }

    
    
}
extension ViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
    
    
   /*     if (didSelectViewController.navigationItem.value(forKey: "ListViewController") != nil) == true {
           arrayWatchMovies = []
           watchMoviesID = DM.getList()
           if watchMoviesID.count > 0{
               for i in 0 ... watchMoviesID.count-1 {
                   requestWatchMovies(watchMoviesID: watchMoviesID[i])
               }
           }
     
        }
 */
}
}
