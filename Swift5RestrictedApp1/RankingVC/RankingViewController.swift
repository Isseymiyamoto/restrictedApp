//
//  RankingViewController.swift
//  Swift5RestrictedApp1
//
//  Created by 宮本一成 on 2020/02/15.
//  Copyright © 2020 ISSEY MIYAMOTO. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore

class RankingViewController: UITableViewController {
        
    var DurationArray = [Any]()
    
    
    var db: Firestore!
    //ログインしているユーザー情報の取得
    let user = Auth.auth().currentUser

    override func viewDidLoad() {
        super.viewDidLoad()
        
        db = Firestore.firestore()
//        test()

//        // [START setup]
//        let settings = FirestoreSettings()
//
//        Firestore.firestore().settings = settings
        // [END setup]
        
        
        let nib = UINib(nibName: "CustomCell", bundle: nil)
        tableView.register( nib, forCellReuseIdentifier: "CustomCell")

//        print(db.collection("result").accessibilityElementCount())
    }
    
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
//        return db.collection("result").accessibilityElementCount()
        return 4
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        
        let resultRef = db.collection("results").order(by: "Duration", descending: true)
                resultRef.getDocuments { (querySnapshot, err) in
                    if let err = err{
                        print("Error getting documents: \(err)")
                    }else{
                        for document in querySnapshot!.documents{
        //                    self.resultArray.append(document.data())
                            
                            print("✌️documentが出力されるよ✌️")
                            var dur = String(describing: document.data()["Duration"]!)
                            self.DurationArray.append(dur)
                            
                        }
                    }
                    cell.userNameLabel.text = self.DurationArray[indexPath.row] as! String
                }
        
        
        
        return cell
    }
    
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
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 48
//    }
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    

}
}
