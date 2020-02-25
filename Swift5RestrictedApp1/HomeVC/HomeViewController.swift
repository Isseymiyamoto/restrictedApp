

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore


class HomeViewController: UIViewController {
    
    var db: Firestore!
    var DurationArray = [Any]()
    
    //ログインしているユーザー情報の取得
    let user = Auth.auth().currentUser
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var startBtn: UIButton!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var rankLabel: UILabel!
    
    //称号のための配列準備
    let rankTitle = ["Masturbation mokey", "Masturbation chimpanzee", "Human Being", "God", "EMinem", "ISSEY MIYAMOTO"]
    
    
    var timer = Timer()
    var displayedTimer:Int = 0
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var startTimeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //tabbaritemのアイコンをfeaturedに、タグを1と定義する
        self.tabBarItem = UITabBarItem(tabBarSystemItem: .featured, tag: 1)
        
        stopBtn.isEnabled = false
        
        
        timerLabel.text = String(displayedTimer)
        
        //topViewの左下のみCornerRadiusをつける
        topView.layer.cornerRadius = 80.0
        topView.layer.maskedCorners = [.layerMinXMaxYCorner]

        
        // [START setup]
        let settings = FirestoreSettings()

        Firestore.firestore().settings = settings
        // [END setup]
        db = Firestore.firestore()
        
        
//        print("✌️lets get started the test")
        test()
//        print("✌️lets get started the test")
        
    }
    
    
    @IBAction func start(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(Action), userInfo: nil, repeats: true)
        
        //現在時刻を取得してstartTimeLabelに貼り付ける
        let nowTime = dateNow()
        startTimeLabel.text = "Start Date：\(nowTime)"
        
        //stopボタンを使用可能にする
        stopBtn.isEnabled = true
        //startボタンを使用不可にする
        startBtn.isEnabled = false
        
        //テスト用のメソッド
//        test()
    }
    
    @objc func Action(){
        displayedTimer += 1
//        timerLabel.text = String(displayedTimer)
        
        //hh:mm:ssの形式に変換する
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .brief
        formatter.allowedUnits = [.day, .hour, .minute, .second]
        
        let output = formatter.string(from: DateComponents(second: displayedTimer))
        timerLabel.text = output!
        
        if displayedTimer < 3600{
            rankLabel.text = rankTitle[0]
        }else if displayedTimer < 24*3600{
            rankLabel.text = rankTitle[1]
        }else if displayedTimer < 7*24*3600{
            rankLabel.text = rankTitle[2]
        }else if displayedTimer < 30*24*3600{
            rankLabel.text = rankTitle[3]
        }else{
            rankLabel.text = rankTitle[4]
        }
    }
    
    @IBAction func pause(_ sender: Any) {
        timer.invalidate()
        //禁欲時間の結果をresultTimeに代入
        let resultTime = displayedTimer
        
        var uid:String!
        var email:String!
        var userName:String!
        if UserDefaults.standard.object(forKey: "userName") != nil{
            userName = (UserDefaults.standard.object(forKey: "userName") as! String)
        }
        
        if let user = user{
            uid = user.uid
            email = user.email
        }
        
        var ref: DocumentReference? = nil
        ref = db.collection("results").addDocument(data: [
            "Duration": resultTime,
            "uid": uid!,
            "email": email!,
            "name": userName!,
            "date": Date()
        ]) { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
                self.displayedTimer = 0
                self.timerLabel.text = String(self.displayedTimer)
            }
        }
        
        //stopボタンを使用不可にする
        stopBtn.isEnabled = false
        //startボタンを使用可能にする
        startBtn.isEnabled = true
        
        
        //popupの表示
        let vc = PopUpViewController()
        vc.modalPresentationStyle = .popover
        present(vc, animated: true)
        
        
    }
    
    
    
    //現在時刻の取得
    func dateNow() -> String{
        let f = DateFormatter()
        f.timeStyle = .medium
        f.dateStyle = .medium
        f.locale = Locale(identifier: "ja_JP")
        let now = Date()
        return f.string(from: now)
    }
    
    //firebaseに結果的な時間とユーザー名を送信する
    func sendResult(){
        
    }
    
    
    //データ取得テスト
    func test(){
        //durationの数が大きい順にresultsコレクション内を並び替え
        let resultRef = db.collection("results").order(by: "Duration", descending: true)
        resultRef.getDocuments { (querySnapshot, err) in
            if let err = err{
                print("Error getting documents: \(err)")
            }else{
                for document in querySnapshot!.documents{
//                    self.resultArray.append(document.data())
                    
                    print("✌️documentが出力されるよ✌️")
                    let dur = String(describing: document.data()["Duration"]!)
                    print("dur: \(dur)")
                    self.DurationArray.append(dur)
                    
//                    print("✌️documentのデータ型が入るよ✌️")
//                    print(type(of: document.data()))
                    print("DurationArray: \(self.DurationArray)")
                }
            }
        }
        
        
//        print("resultArrayが入るよ")
//        print(resultArray)
//        print("resultArrayが入るよ")
        
    }

    
}
