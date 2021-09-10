//
//  DiagnosisViewController.swift
//  outpatientapp
//
//  Created by fumitaka katou on 2021/08/19.
//

import UIKit
import Firebase
import SVProgressHUD

class DiagnosisViewController: UIViewController {
    
    @IBOutlet weak var diagnosisTextField: UITextField!

    // 投稿ボタンをタップしたときに呼ばれるメソッド
    @IBAction func diagnosisPostButton(_ sender: Any) {
        // 投稿データの保存場所を定義する　let uidを省略
        _ = Auth.auth().currentUser?.uid
        let postRef = Firestore.firestore().collection(Const.PostPath).document(Auth.auth().currentUser!.uid)
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        
        // FireStoreに投稿データを保存する
         let postDic = [
             "diagnosis": self.diagnosisTextField.text!,
             ] as [String : Any]
         postRef.setData(postDic, merge: true)
         // HUDで投稿完了を表示する
         SVProgressHUD.showSuccess(withStatus: "投稿しました")
         // 投稿処理が完了したので先頭画面に戻る
        UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
    }

    @IBAction func diagnosisCancaelButton(_ sender: Any) {
        // 画面を閉じてタブ画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

