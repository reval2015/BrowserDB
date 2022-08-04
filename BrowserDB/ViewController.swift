//
//  ViewController.swift
//  BrowserDB
//
//  Created by Valentyn Reshetniak on 01.08.2022.
//

import UIKit

class ViewController: UIViewController {

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
            //navigationController!.pushViewController(vc, animated: false)
            show(vc, sender: self)
        }}
                    
        }
        
}
