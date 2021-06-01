//
//  NextViewController.swift
//  Swift6Struct
//
//  Created by 伊藤直輝 on 2021/05/04.
//

import UIKit

// SetOKDelegateプロトコルの定義
// -> SetOKDelegateを通じて情報がNextViewControllerからViewControllerに渡される
protocol SetOKDelegate {
    // 実装は情報の提供先(ViewController)で行う
    func setOK(check: Person)
}

// NextViewControllerはpersonの提供元
// -> SetOKDelegateのデリゲートを通じてViewControllerに情報が渡される
class NextViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var hobbyTextField: UITextField!
    @IBOutlet weak var movieTextField: UITextField!
    
    // 構造体Personのインスタンス化
    var person = Person()
    
    // 情報の橋渡し役(SetOKDelegate)のインスタンスは情報の提供元(NextViewController)で宣言
    // -> 提供先(ViewController)でnextVC.setOKDelegate = self(ViewController)と定義
    var setOKDelegate: SetOKDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // ボタンの挙動
    @IBAction func add(_ sender: Any) {
        // 入力された情報をpersonに格納
        person.name = nameTextField.text!
        person.hobby = hobbyTextField.text!
        person.movie = movieTextField.text!
        
        // setOKDelegateを通じてViewControllerのpersonArrayに格納される
        setOKDelegate?.setOK(check: person)
        
        // モーダル画面を閉じる
        dismiss(animated: true, completion: nil)
    }
    
}
