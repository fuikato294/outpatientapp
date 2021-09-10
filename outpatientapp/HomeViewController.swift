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
    @IBOutlet weak var pocketbookGradeLabel: UILabel!
    
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
            
            // Firestoreからデータを辞書型で取得
            let postsRef = Firestore.firestore().collection(Const.PostPath).document(Auth.auth().currentUser!.uid)
            listener = postsRef.addSnapshotListener() { (documentSnapshot, error) in
                if let error = error {
                    return
                }
                guard let document = documentSnapshot else {
                    return
                }
                print(document.data())
                guard let documentData = document.data() else {
                    return
                }
                    self.purposeLabel.text = "\(documentData["purpose"]!)"
                    self.diagnosisLabel.text = "\(documentData["diagnosis"]!)"
                    self.pocketbookGradeLabel.text = "\(documentData["pocketbookGrade"]!)"
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy/MM/dd"
                    self.birthdayLabel.text = "\(documentData["birthday"]!)"
                    self.firstVisitLabel.text = "\(documentData["firstVisit"]!)"
                    self.independenceLabel.text = "\(documentData["updateIndependence"]!)"
                    self.pocketbookLabel.text = "\(documentData["updatePocketbook"]!)"
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
