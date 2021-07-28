//
//  NavigationController.swift
//  Messages
//
//  Created by ozan honamlioglu on 28.07.2021.
//

import UIKit

class NavigationController: UINavigationController {
    
    lazy var drawer: UIView = {
        let vw = UIView()
        vw.frame = CGRect(x: -10, y: 0, width: 200, height: ScreenHeight)
        vw.backgroundColor = .red
        return vw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
