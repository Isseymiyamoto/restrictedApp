//
//  PopUpViewController.swift
//  Swift5RestrictedApp1
//
//  Created by 宮本一成 on 2020/02/14.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var resultTimeLabel: UILabel!
    @IBOutlet weak var returnBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        userNameLabel.text = "宮本さん"
        resultTimeLabel.text = "適当秒です"
        returnBtn.layer.cornerRadius = 20.0
    }
    
    
    @IBAction func `return`(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    

}
