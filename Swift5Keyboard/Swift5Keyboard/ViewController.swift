//
//  ViewController.swift
//  Swift5Keyboard
//
//  Created by 伊藤直輝 on 2021/04/28.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {


    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        username.delegate = self
        password.delegate = self
        
    }

    @IBAction func login(_ sender: Any) {
        logo.image = UIImage(named: "loginOK")
        
        usernameLabel.text = username.text
        passwordLabel.text = password.text
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // viewはUIViewControllerが有するプロパティ
        view.endEditing(true)
    }
    
    // Return キーを押すとキーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
    
}

