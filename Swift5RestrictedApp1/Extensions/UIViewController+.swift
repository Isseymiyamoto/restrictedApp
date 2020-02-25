//
//  UIViewController+.swift
//  Swift5RestrictedApp1
//
//  Created by 宮本一成 on 2020/02/11.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit

// UIViewController の機能を拡張しているイメージ
// extension は拡張という意味
extension UIViewController {
    // OKを選択させるエラーアラートを表示する
    func showErrorAlert(text: String){
        let alertController = UIAlertController(title: "エラー", message: text , preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}

