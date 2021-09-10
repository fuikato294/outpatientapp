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
        let controller = UIAlertController(title: "サインインが必要です",
                                           message: "xxxxx@sample.comのパスワードを入力してください。",
                                           preferredStyle: .alert)

        controller.addTextField { textField in
            textField.placeholder = "パスワード"
            textField.isSecureTextEntry = true
            textField.keyboardAppearance = .dark
        }

        let cancelAction = UIAlertAction(title: "キャンセル",
                                         style: .cancel,
                                         handler: nil)

        let authenticate = UIAlertAction(title: "OK",
                                      style: .default) { action in
            if let password = controller.textFields?.first?.text {
                print(password)

                let user = Auth.auth().currentUser
                let credential = EmailAuthProvider.credential(withEmail: (user?.email)!, password: password)

                // Prompt the user to re-provide their sign-in credentials

                user?.reauthenticate(with: credential) { (result, error)  in
                  if let error = error {
                    print("reauthencate error:", error)
                    return
                    // An error happened.
//                        //アラートが消えるのと画面遷移が重ならないように0.5秒後に画面遷移するようにしてる
//                           DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//                            // 0.5秒後に実行したい処理
//                             self.performSegue(withIdentifier: "emailEditingSegue", sender: nil)
//                           }
                  } else {
                    // User re-authenticated.
                  }
                }
                //アラートが消えるのと画面遷移が重ならないように0.5秒後に画面遷移するようにしてる
                   DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    // 0.5秒後に実行したい処理
                     self.performSegue(withIdentifier: "emailEditingSegue", sender: nil)
                   }
            }
        }

        controller.addAction(cancelAction)
        controller.addAction(authenticate)

        self.present(controller, animated: true, completion: nil)
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

        // アドレスと表示名を取得してLabelに設定する
        let user = Auth.auth().currentUser
        if let user = user {
            mailAddressLabel.text = user.email
            displayNameLabel.text = user.displayName
        }
    }
}
