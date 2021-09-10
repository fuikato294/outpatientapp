//
//  PostData.swift
//  outpatientapp
//
//  Created by fumitaka katou on 2021/08/22.
//

import UIKit
import Firebase

class PostData: NSObject {
    var id: String
    var purpose: String?
    var birthday: Date?
    var firstVisit: Date?
    var diagnosis: String?
    var independence: Date?
    var pocketbook: Date?
    var pocketbookGrade: String?
//    var likes: [String] = []
//    var isLiked: Bool = false

    init(document: QueryDocumentSnapshot) {
        self.id = document.documentID

        let postDic = document.data()

        self.purpose = postDic["purpose"] as? String
        
        let birthdayTimestamp = postDic["birthday"] as? Timestamp
        self.birthday = birthdayTimestamp?.dateValue()

        let firstVisitTimestamp = postDic["firstVisit"] as? Timestamp
        self.firstVisit = firstVisitTimestamp?.dateValue()

        self.diagnosis = postDic["diagnosis"] as? String
        
        let independenceTimestamp = postDic["independence"] as? Timestamp
        self.independence = independenceTimestamp?.dateValue()
        
        let pocketbookTimestamp = postDic["pocketbook"] as? Timestamp
        self.pocketbook = pocketbookTimestamp?.dateValue()
        
        self.pocketbookGrade = postDic["pocketbookGrade"] as? String
        
//        if let likes = postDic["likes"] as? [String] {
//            self.likes = likes
//        }
//        if let myid = Auth.auth().currentUser?.uid {
//            // likesの配列の中にmyidが含まれているかチェックすることで、自分がいいねを押しているかを判断
//            if self.likes.firstIndex(of: myid) != nil {
//                // myidがあれば、いいねを押していると認識する。
//                self.isLiked = true
//            }
//        }
        }

}
