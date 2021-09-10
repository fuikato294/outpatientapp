//
//  PocketbookGrade.swift
//  outpatientapp
//
//  Created by fumitaka katou on 2021/08/24.
//

import UIKit
import Firebase
import SVProgressHUD

class PocketbookGradeViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    @IBOutlet weak var pocketbookGradeLabel: UILabel!
    
    // 投稿ボタンをタップしたときに呼ばれるメソッド
    @IBAction func pocketbookGradePostButton(_ sender: Any) {
        // 投稿データの保存場所を定義する　let uidを省略
        _ = Auth.auth().currentUser?.uid
        let postRef = Firestore.firestore().collection(Const.PostPath).document(Auth.auth().currentUser!.uid)
        // HUDで投稿処理中の表示を開始
        SVProgressHUD.show()
        // FireStoreに投稿データを保存する
        let postDic = [
            "pocketbookGrade": self.pocketbookGradeLabel.text!,
            ] as [String : Any]
        postRef.setData(postDic, merge: true)
        // HUDで投稿完了を表示する
        SVProgressHUD.showSuccess(withStatus: "投稿しました")
        // 投稿処理が完了したので先頭画面に戻る
       UIApplication.shared.windows.first{ $0.isKeyWindow }?.rootViewController?.dismiss(animated: true, completion: nil)
    }

    let gradeDataList = [["１級","２級","３級"]]
    
    @IBAction func pocketbookGradeCancaelButton(_ sender: Any) {
        // 画面を閉じてタブ画面に戻る
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //コンポーネントの個数を返すメソッド
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return gradeDataList.count
    }
    
    //コンポーネントに含まれるデータの個数を返すメソッド
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gradeDataList[component].count
    }

    //データを返すメソッド
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gradeDataList[component][row]
    }
    
    //データ選択時の呼び出しメソッド
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //コンポーネントごとに現在選択されているデータを取得する。
        let pocketbookGradedata = self.pickerView(pickerView, titleForRow: pickerView.selectedRow(inComponent: 0), forComponent: 0)
        
        pocketbookGradeLabel.text = "\(pocketbookGradedata!)"
    }
    
}

