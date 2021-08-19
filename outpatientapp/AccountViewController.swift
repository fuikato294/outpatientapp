//
//  AccountViewController.swift
//  outpatientapp
//
//  Created by fumitaka katou on 2021/08/10.
//

import UIKit
import Firebase
import SVProgressHUD

class AccountViewController: UIViewController {
   
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var mailAddressLabel: UILabel!
    
    @IBAction func displayNameEditingButton(_ sender: Any) {
        
    }

    @IBAction func mailAddressEditingButton(_ sender: Any) {
        
    }

    
    @IBAction func handleLogoutButton(_ sender: Any) {
    // ログアウトする
    try! Auth.auth().signOut()
        // ログイン画面を表示する
        let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
        self.present(loginViewController!, animated: true, completion: nil)

        // ログイン画面から戻ってきた時のためにホーム画面（index = 0）を選択している状態にしておく
        tabBarController?.selectedIndex = 0
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // アドレスと表示名を取得してTextFieldに設定する
        let user = Auth.auth().currentUser
        if let user = user {
            mailAddressLabel.text = user.email
            displayNameLabel.text = user.displayName
        }
    }
}
