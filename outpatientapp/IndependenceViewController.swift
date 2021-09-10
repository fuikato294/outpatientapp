//
//  IndependenceViewController.swift
//  outpatientapp
//
//  Created by fumitaka katou on 2021/08/10.
//

import UIKit
import Firebase

class IndependenceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var independenceTableView: UITableView!
    
    // Buttonのon/offデータを格納する配列
    var checkArray = [true,true,true,true,true,true]
    // アップロードした画像を配列に格納
    let imageName = ["checkIncomplete","checkComplete"]
//    var changeImgNo = 1
    
    let stepArray: [String] = [
        "STEP0.",
        "STEP1.",
        "STEP2.",
        "STEP3.",
        "STEP4.",
        "STEP5."
    ]
    
//    var switchButon:Bool = false
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 画面の横の長さ
        let width = self.view.frame.size.width
        // 画面の縦の長さ
        let height = self.view.frame.size.height
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("DEBUG_PRINT: viewWillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("DEBUG_PRINT: viewWillDisappear")
    }
    
    // section数
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // データの数（＝セルの数・rowの数）を返すメソッド
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stepArray.count
    }

    // Cellの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    // 各Cellの内容を返すメソッド
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // // dequeueReusableCell(withIdentifier: for:)で再利用可能な cell を取得
        let cell = tableView.dequeueReusableCell(withIdentifier: "independenceCell", for: indexPath)
        
        // ボタンにアクセス
        let button = cell.contentView.viewWithTag(1) as! UIButton
        // セル内のボタンのアクションをソースコードで設定する
        // 第一引数selfはindependencrVC、第二引数actionの#selectorでhandleButton(_ : forEvent :)を呼び出す
            button.addTarget(self, action:#selector(handleButton(_:forEvent:)), for: .touchUpInside)
      
        // ラベルにアクセス
        let label = cell.contentView.viewWithTag(2) as! UILabel
          // セルに表示する値を設定する
          label.text = stepArray[indexPath.row]
        
        // Cellに値を設定する
        let task = stepArray[indexPath.row]
        
            
        return cell
    }
    
    // セル内のボタンがタップされた時に呼ばれるメソッド
    @objc func handleButton(_ sender: UIButton, forEvent event: UIEvent) {
        print("DEBUG_PRINT: switchButonがタップされました。")
        
        // タップされたセルのインデックスを求める
        let touch = event.allTouches?.first
        let point = touch!.location(in: self.independenceTableView)
        let indexPath = independenceTableView.indexPathForRow(at: point)
        
        let check = checkArray[indexPath!.row]
        
        // checkArrayの中の配列を更新して、画像を切り替える
        if check {
            print("false")
            checkArray[indexPath!.row] = false
            // ボタンにはるImageを指定
            let buttonImage = UIImage(named: "checkComplete")
            // setImage(_: for:)メソッドを使ってボタンの画像を更新
            sender.setImage(UIImage(named: "checkComplete"), for: .normal)
        } else {
            print("true")
            checkArray[indexPath!.row] = true
            let buttonImage = UIImage(named: "checkIncomplete")
            sender.setImage(UIImage(named: "checkIncomplete"), for: .normal)
        }

    }
    
    
    // 各セルを選択した時に実行されるメソッド
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "independenceCellSegue",sender: nil)
    }

    // UIButtonを選択した時
        func buttonEvemt(_ sender: UIButton) {
//         print("buttonTag", sender.tag)
    }
    

}


