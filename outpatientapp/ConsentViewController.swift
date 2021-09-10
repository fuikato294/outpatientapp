//
//  ConsentViewController.swift
//  outpatientapp
//
//  Created by fumitaka katou on 2021/08/10.
//

import UIKit
import Firebase
import SVProgressHUD

class ConsentViewController: UIViewController {
    
    @IBOutlet weak var consentTextView: UITextView!
    
    @IBAction func startUsingButton(_ sender: Any) {
        // 画面を閉じてタブ画面に戻る
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 枠のカラー
        consentTextView.layer.borderColor = UIColor.black.cgColor
        
        // 枠の幅
        consentTextView.layer.borderWidth = 5.0
        
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("DEBUG_PRINT: viewWillDisappear")
        
        // 投稿データの保存場所を定義する　let uidを省略
        _ = Auth.auth().currentUser?.uid
        let postRef = Firestore.firestore().collection(Const.PostPath).document(Auth.auth().currentUser!.uid)
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()

        // FireStoreに投稿データを保存する
         let postDic = [
            "purpose":"未登録",
            "diagnosis": "未登録",
            "pocketbookGrade":"未登録",
            "birthday":"未登録",
            "firstVisit":"未登録",
            "updateIndependence":"未登録",
            "updatePocketbook":"未登録",
             ] as [String : Any]
         postRef.setData(postDic, merge: true)
        print("DEBUG_PRINT: 初期データを投稿しました")
        
        // HUDを消す
        SVProgressHUD.dismiss()
//        self.navigationController?.dismiss(animated: true, completion: nil)
        
    }

}
