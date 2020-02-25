//
//  LoginViewController.swift
//  Swift5RestrictedApp1
//
//  Created by 宮本一成 on 2020/02/11.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        emailTF.delegate = self
        passwordTF.delegate = self
        
        loginBtn.layer.cornerRadius = 30.0
        
        titleLabel.text = "Log In"
        titleLabel.textColor = UIColor.white
        passwordTF.textColor = UIColor.white
        
        composeUnderline(TF: emailTF, Color: UIColor.gray)
        composeUnderline(TF: passwordTF, Color: UIColor.gray)

        emailTF.attributedPlaceholder = NSAttributedString(string: "  enter your email-address", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        
        passwordTF.attributedPlaceholder = NSAttributedString(string: "  enter your password", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
       
       
    }
    
    
    @IBAction func returnFVC(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    private func composeUnderline(TF: UITextField, Color: UIColor) {
        //TFの高さを変更
        TF.frame.size.height = 36.0
        //TFの枠線除去
        TF.borderStyle = .none
        
        //underline用のUIViewの用意
        let underline = UIView()
        
        //underlineの位置決定
        underline.frame = CGRect(
            x: -32,
            y: TF.frame.height,
            width: TF.frame.width + 32,
            height: 2.5)

        //underlineのカラー
        underline.backgroundColor = Color

        //TFにつける
        TF.addSubview(underline)
        TF.bringSubviewToFront(underline)
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
    
    //signupVCに画面遷移
    @IBAction func signup(_ sender: Any) {
        let vc = SignUpViewController()
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    @IBAction func login(_ sender: Any) {
        guard let email = emailTF.text, let password = passwordTF.text else {
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
        emailLogIn(email: email, password: password)
        
    }
    
    func emailLogIn(email: String, password: String) {
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                if let error = error {
                    self.logInErrorAlert(error)
                } else {
                    let vc = HomeViewController()
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true)
                    
                }
            }
        }
    
    func logInErrorAlert(_ error: Error){
        if let errCode = AuthErrorCode(rawValue: error._code) {
            var message = ""
            switch errCode {
                case .userNotFound:
                    message = "アカウントが見つかりませんでした"
                case .wrongPassword:
                    message = "パスワードを確認してください"
                case .userDisabled:
                    message = "アカウントが無効になっています"
                case .invalidEmail:
                    message = "Eメールが無効な形式です"
                default: message = "エラー: \(error.localizedDescription)"
            }
            showErrorAlert(text: message)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    
}
