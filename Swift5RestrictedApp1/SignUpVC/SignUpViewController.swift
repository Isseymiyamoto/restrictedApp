//
//  SignUpViewController.swift
//  Swift5RestrictedApp1
//
//  Created by 宮本一成 on 2020/02/11.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signupBtn: UIButton!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var userNameTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTF.delegate = self
        passwordTF.delegate = self
        userNameTF.delegate = self
        
        emailTF.textColor = UIColor.white
        passwordTF.textColor = UIColor.white
        userNameTF.textColor = UIColor.white
        
        userNameTF.placeholder = "this name will be used at Ranking site"
        
        composeUnderline(TF: emailTF, Color: UIColor.gray)
        composeUnderline(TF: passwordTF, Color: UIColor.gray)
        composeUnderline(TF: userNameTF, Color: UIColor.gray)
        
        titleLabel.numberOfLines = 2
        titleLabel.text = "New \nAccount"
        titleLabel.textColor = UIColor.white
        
        signupBtn.layer.cornerRadius = 30.0
        
    }
    
    private func composeUnderline(TF: UITextField, Color: UIColor) {
        //TFの高さを変更
        TF.frame.size.height = 30.0
        //TFの枠線除去
        TF.borderStyle = .none
        
        //underline用のUIViewの用意
        let underline = UIView()
        
        //underlineの位置決定
        underline.frame = CGRect(
            x: 0,
            y: TF.frame.height,
            width: TF.frame.width,
            height: 2.5)

        //underlineのカラー
        underline.backgroundColor = Color

        //TFにつける
        TF.addSubview(underline)
        TF.bringSubviewToFront(underline)
    }
    
    @IBAction func returnFVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    //TFを選択した際にunderlineのカラーを変える
        func textFieldDidBeginEditing(_ textField: UITextField) {
    //        textField.removeFromSuperview()
            composeUnderline(TF: textField, Color: UIColor(red:0.36, green:0.61, blue:0.93, alpha:1.0))
        }
        
        //編集が終わったら元に戻す
        func textFieldDidEndEditing(_ textField: UITextField) {
    //        textField.removeFromSuperview()
            composeUnderline(TF: textField, Color: UIColor.gray)
        }
    
    
    @IBAction func signUp(_ sender: Any) {
        guard let email = emailTF.text, let password = passwordTF.text, let name = userNameTF.text else{
            return
        }
        if email.isEmpty {
            showErrorAlert(text: "enter your email address")
            return
        }
        if password.isEmpty {
            showErrorAlert(text: "enter your password")
            return
        }
        if name.isEmpty {
            showErrorAlert(text: "enter your name")
            return
        }
        
        
        emailSignUp(email: email, password: password)
        if UserDefaults.standard.object(forKey: "userName") == nil{
            UserDefaults.standard.set(name, forKey: "userName")
        }
        
    }
    
    func emailSignUp(email: String, password: String) {
            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    print ("👿登録失敗:\(error.localizedDescription)")
                    self.signUpErrorAlert(error)
                } else {
                    print ("🌞登録成功")
                    let vc = HomeViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                }
            }
        }
    
    func signUpErrorAlert(_ error: Error){
        if let errCode = AuthErrorCode(rawValue: error._code) {
            var message = ""
            switch errCode {
            case .invalidEmail:
                message = "有効なメールアドレスを入力してください"
            case .emailAlreadyInUse:
                message = "既に登録されているメールアドレスです"
            case .weakPassword:
                message = "パスワードは６文字以上で入力してください"
            default:
                message = "エラー: \(error.localizedDescription)"
            }
            showErrorAlert(text: message)
        }
    }

   

}
