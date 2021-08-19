//
//  TabBarController.swift
//  outpatientapp
//
//  Created by fumitaka katou on 2021/08/10.
//

import UIKit
import Firebase

class TabBarController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // タブアイコンの色
        self.tabBar.tintColor = UIColor(red: 1.0, green: 0.44, blue: 0.11, alpha: 1)
        // タブバーの背景色
        self.tabBar.barTintColor = UIColor(red: 0.96, green: 0.91, blue: 0.87, alpha: 1)
        // UITabBarControllerDelegateプロトコルのメソッドをこのクラスで処理する。
        self.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
        
        // ログイン状態を確認する処理は、Firebase Authenticationの Auth クラス
        // currentUserがnilならログインしていない
        if Auth.auth().currentUser == nil {
            // ログインしていないときの処理
            // instantiateViewController(withIdentifier:)メソッドの引数"Login"はStoryboardID
            let loginViewController = self.storyboard?.instantiateViewController(withIdentifier: "Login")
            // present(_:animated:completion:)メソッドでモーダル画面遷移
            self.present(loginViewController!, animated: true, completion: nil)
        }
    }

}
