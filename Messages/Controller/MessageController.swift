//
//  MessageController.swift
//  Messages
//
//  Created by ozan honamlioglu on 28.07.2021.
//

import UIKit

class MessageController: UIViewController, UIGestureRecognizerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    // MARK: - Handlers
    private func setup() {
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"), style: .plain, target: self, action: #selector(pop))
    }
    
    @objc func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
}

