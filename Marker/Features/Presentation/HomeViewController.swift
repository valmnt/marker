//
//  HomeViewController.swift
//  Marker
//
//  Created by Valentin Mont on 06/09/2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = R.color.primaryBackground.callAsFunction()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

