//
//  ViewController.swift
//  IzibookTestAnimation
//
//  Created by Eugene Kireichev on 25/06/2020.
//  Copyright © 2020 Eugene Kireichev. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var customView: CustomUIView!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        customView.beginAnimations()
    }
    
}
