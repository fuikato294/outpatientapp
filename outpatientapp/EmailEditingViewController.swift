//
//  EmailEditingViewController.swift
//  outpatientapp
//
//  Created by fumitaka katou on 2021/08/19.
//

import UIKit
import Firebase
import SVProgressHUD

class EmailEditingViewController: UIViewController {

    @IBOutlet weak var editingEmailTextField: UITextField!
    
    @IBAction func emailEditingButton(_ sender: Any) {
        
        // 変更する表示名が入るのはeditingEmail
        if let editingEmail = editingEmailTextField.text {

            // 表示名が入力されていない時はHUDを出して何もしない
            if editingEmail.isEmpty {
                SVProgressHUD.showError(withStatus: "表示名を入力して下さい")
                return
            }
        
        let user = Auth.auth().currentUser
            Auth.auth().currentUser?.updateEmail(to: editingEmail) { error in
                if let error = error {
                    SVProgressHUD.showError(withStatus: "メールアドレスの変更に失敗しました。")
                    print("DEBUG_PRINT: [emai = \(user?.email!)]の設定に失敗しました。")
                    return
                } else {
                    SVProgressHUD.showError(withStatus: "メールアドレスを変更しました。")
                    print("DEBUG_PRINT: [emai = \(user?.email!)]の設定に成功しました。")

                }

    // キーボードを閉じる
    self.view.endEditing(true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
}
