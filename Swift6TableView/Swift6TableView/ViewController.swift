//
//  ViewController.swift
//  Swift6TableView
//
//  Created by 伊藤直輝 on 2021/05/01.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var textArray = [String]()
    
    // Viewの初期化時に呼び出されるメソッド
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // デリゲートをselfとして定義
        tableview.delegate = self
        tableview.dataSource = self
        textField.delegate = self
    }
    
    // Viewが描写される直前に呼び出すメソッド
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // NavigationBarを非表示にする
        navigationController?.isNavigationBarHidden = true
    }

    // TableViewのSectionあたりのCell数を決定
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textArray.count
    }
    
    // TableViewのSection数を決定
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // TableViewのCellに関する設定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cellの作成
        let cell = tableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Cell選択時のハイライトをなくす
        cell.selectionStyle = .none
        
        // Cellの文字列(.textLabel?.text)を定義
        cell.textLabel?.text = textArray[indexPath.row]
        // Cellの画像(.imageView!.image)を定義
        cell.imageView!.image = UIImage(named: "plus")
        
        return cell
    }
    
    // Cellが選択された時の挙動
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // 遷移先のViewControllerを定義
        let nextVC = storyboard?.instantiateViewController(identifier: "next") as! NextTableViewController
        
        // 遷移先のラベルに代入する文字列を指定
        nextVC.todoStr = textArray[indexPath.row]
        
        // 遷移方法をPush遷移に指定
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // Rowの高さを指定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ( view.frame.size.height / 6 )
    }
    
    // TextFieldでreturnキーが押下された時の挙動
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 入力された文字列を textArray: [String] に格納
        textArray.append(textField.text!)
        // Keyboardの非表示
        textField.resignFirstResponder()
        
        // 入力された文字列を削除
        textField.text = ""
        // TableViewの再描画
        tableview.reloadData()
        
        // 編集終了イベントの発火
        return false
    }
    
}

