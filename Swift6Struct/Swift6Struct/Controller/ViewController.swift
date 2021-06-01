//
//  ViewController.swift
//  Swift6Struct
//
//  Created by 伊藤直輝 on 2021/05/04.
//

import UIKit

// ViewControllerはpersonの提供先
// -> SetOKDelegateのデリゲートを通じてNextViewControllerから情報が渡ってくる
// => SetOKDelegateプロトコルに準拠させる(プロトコルを用意するのは提供元)
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SetOKDelegate {

    @IBOutlet weak var tableview: UITableView!
    
    // 構造体Personのインスタンス化
    var person = Person()
    var personArray = [Person]()
    
    // 最初の描画時の処理
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // delegateをselfに定義
        tableview.delegate = self
        tableview.dataSource = self
    }
    
    // 1セクションあたりのCell数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Cell数 = 登録数
        return personArray.count
    }
    
    // Cellに関する定義
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cellの定義
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Cellに配置するLabelの定義
        let usernameLabel = cell.contentView.viewWithTag(1) as! UILabel
        usernameLabel.text = personArray[indexPath.row].name
        
        let hobbyLabel = cell.contentView.viewWithTag(2) as! UILabel
        hobbyLabel.text = personArray[indexPath.row].hobby
        
        let movieLabel = cell.contentView.viewWithTag(3) as! UILabel
        movieLabel.text = personArray[indexPath.row].movie
        
        // 定義したCellを返す
        return cell
    }
    
    // セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Cellの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    // ボタンの挙動
    @IBAction func commit(_ sender: Any) {
        // モーダルによる画面遷移
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    // SetOKDelegateプロトコルのsetOKメソッドの実装
    func setOK(check: Person) {
        // 構造体Personのインスタンスを配列に格納
        personArray.append(check)
        
        // TableViewを更新
        tableview.reloadData()
    }
    
    // 画面遷移前の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // segueのIdentifierが"next"の場合
        if segue.identifier == "next" {
            // NextViewControllerのインスタンス化
            let nextVC = segue.destination as! NextViewController
            
            // NextViewControllerのデリゲートを自身に定義
            nextVC.setOKDelegate = self
        }
    }
}

