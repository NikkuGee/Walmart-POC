//
//  ViewController.swift
//  Walmart Test
//
//  Created by Consultant on 8/4/19.
//  Copyright © 2019 Consultant. All rights reserved.
//

import UIKit

class MapSetUpViewController: UIViewController {

    @IBOutlet weak var userLocation: UITextField!
    @IBOutlet weak var searchRadius: UITextField!
    
    var usersLocation: String = ""
    var radius: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    @IBAction func searchMap(_ sender: UIButton) {
    
    }
    
}

