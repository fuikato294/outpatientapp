//
//  BirthdayViewController.swift
//  outpatientapp
//
//  Created by fumitaka katou on 2021/08/19.
//

import UIKit
import Firebase
import SVProgressHUD

class BirthdayViewController: UIViewController {
    
    @IBOutlet weak var birthdayLabel: UILabel!
    
    // 投稿ボタンをタップしたときに呼ばれるメソッド
    @IBAction func purposePostButton(_ sender: Any) {
        // 投稿データの保存場所を定義する　let uidを省略
        _ = Auth.auth().currentUser?.uid
        let postRef = Firestore.firestore().collection(Const.PostPath).document(Auth.auth().currentUser!.uid)
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        // FireStoreに投稿データを保存する
        let postDic = [
            "birthday": self.birthdayLabel.text!,
            ] as [String : Any]
        postRef.setData(postDic, merge: true)
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        // 投稿処理が完了したので先頭画面に戻る
       UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    //データ変更時の呼び出しメソッド
    @IBAction func changeBirthday(sender: UIDatePicker) {
    
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        
        birthdayLabel.text = formatter.string(from: sender.date)
    
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // キャンセルボタンをタップしたときに呼ばれるメソッド
    @IBAction func birthdayCancelButton(_ sender: Any) {
    }
    
}
