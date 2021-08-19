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

    @IBOutlet weak var mailAddressLabel: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // アドレスと表示名を取得してTextFieldに設定する
        let user = Auth.auth().currentUser
        if let user = user {
            mailAddressLabel.text = user.email
        }
    }
}
