//
//  ViewController.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 20/09/19.
//  Copyright © 2019 developer. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnStartClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController

        self.present(destinationVC, animated: true, completion: nil)
    }
    
}

