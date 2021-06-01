//
//  ViewController.swift
//  Swift6TableViewApp
//
//  Created by 伊藤直輝 on 2021/05/04.
//

import UIKit

// ViewControllerはDelegateメソッドを提供するプロトコルに準拠させる
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableview: UITableView!
    
    // TextFieldに入力した文字列を格納する配列
    var textArray = [String]()
    //
    var imageArray = ["1","2","3","4","5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        // delegateをselfに定義
        tableview.delegate = self
        tableview.dataSource = self
    }

    @IBAction func tap(_ sender: Any) {
        // 投稿数が5より大きい または TextFieldが空の場合は何もしない
        if textArray.count > 5 || textField.text?.isEmpty == true {
            return
        }
        
        // textArrayに文字列を格納
        textArray.append(textField.text!)
        // TextFieldを空にする
        textField.text = ""
        
        // 投稿数が5以下の場合はTableViewを再読み込み
        if textArray.count <= 5 {
            tableview.reloadData()
        }
        
    }
    
    // セクションあたりのCellの行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // 投稿数 = Cell数
        return textArray.count
    }
    
    // セクション数
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // Cellに関する定義
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Cellの定義
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        // Cellに配置したImageViewの定義(Tag値: 1)
        let imageView = cell.contentView.viewWithTag(1) as! UIImageView
        // Cellに配置したLabelの定義(Tag値: 2)
        let label = cell.contentView.viewWithTag(2) as! UILabel
        
        // ImageViewに反映する画像の定義 (imageArray: [String])
        imageView.image = UIImage(named: imageArray[indexPath.row])
        // Labelに反映する文字列の定義
        label.text = textArray[indexPath.row]
        
        // 定義したCellを返す
        return cell
    }
    
    // Rowの高さ
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 563
    }
    
}

