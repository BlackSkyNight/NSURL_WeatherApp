//
//  ViewController.swift
//  WeatcherApp
//
//  Created by Mateusz Matejczyk on 09.12.2017.
//  Copyright © 2017 Mateusz Matejczyk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("load")
        /*Weather.forecast(withLocation: "37.8267,-122.4233") { (results:[Weather]) in
            for result in results
            {
                print("\(result)\n")
            }
        }*/
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

