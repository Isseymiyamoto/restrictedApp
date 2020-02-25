//
//  ViewController.swift
//  Swift5RestrictedApp1
//
//  Created by 宮本一成 on 2020/02/10.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var titleText: UILabel!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //start your abstinenceを一語ずつ改行
        titleText.numberOfLines = 3
        titleText.text = "Start \nYour \nAbstinence"
        titleText.font = titleText.font.withSize(40)
        
        //btnについてのスタイル変更
        //角を丸める
        signupBtn.layer.cornerRadius = 30.0
        loginBtn.layer.cornerRadius = 30.0
        //背景色の変更
        signupBtn.backgroundColor = UIColor(red: 221/255, green: 130/255, blue: 171/255, alpha: 0.8)
        loginBtn.backgroundColor = UIColor(red: 95/255, green: 44/255, blue: 99/255, alpha: 1)
        
                
    }
    
    //signupボタンを押した時の挙動
    @IBAction func signup(_ sender: Any) {
        //signupVCへ遷移
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    //loginボタンを押した際の挙動
    @IBAction func login(_ sender: Any) {
        let vc = LoginViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    

}

