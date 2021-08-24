//
//  HomeViewController.swift
//  outpatientapp
//
//  Created by fumitaka katou on 2021/08/10.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    @IBOutlet weak var purposeLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var firstVisitLabel: UILabel!
    @IBOutlet weak var diagnosisLabel: UILabel!
    @IBOutlet weak var independenceLabel: UILabel!
    @IBOutlet weak var pocketbookLabel: UILabel!
    
    var postData: [PostData] = []
    
    // Firestoreの監視用リスナー
    var listener: ListenerRegistration?
    
        override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            print("DEBUG_PRINT: viewWillAppear")
        
            // ログイン済みか確認
            if Auth.auth().currentUser != nil {
                // listenerを登録して投稿データの更新を監視する
                // Firestoreの postsフォルダに格納されている投稿データを取得するクエリ
                let postsRef = Firestore.firestore().collection(Const.PostPath)
                listener = postsRef.addSnapshotListener() { (querySnapshot, error) in
                    if let error = error {
                        print("DEBUG_PRINT: snapshotの取得が失敗しました。 \(error)")
                        return
                    }
                    // 取得したdocumentをもとにPostDataを作成する。
                    self.postData = querySnapshot!.documents.map { document in
                        print("DEBUG_PRINT: document取得 \(document.documentID)")
                        let postData = PostData(document: document)
                        _ = Auth.auth().currentUser
                        _ = Firestore.firestore().collection("posts").document(Auth.auth().currentUser!.uid)
                        func setPostData(_ postData: PostData) {
                                    self.purposeLabel.text = "\(postData.purpose!)"
                                    self.diagnosisLabel.text = "\(postData.diagnosis!)"
                                    }
                        return postData
                    }
                }
            }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("DEBUG_PRINT: viewWillDisappear")      
        // listenerを削除して監視を停止する
        listener?.remove()
    }
}
