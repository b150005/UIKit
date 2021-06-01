//
//  NextViewController.swift
//  Swift6Map
//
//  Created by 伊藤直輝 on 2021/05/18.
//

import UIKit

// NextViewController -> ViewController に値を渡すデリゲートプロトコル
protocol SearchLocationDelegate {
    // メソッドの実装は値を「渡される」側のViewControllerで行う
    func searchLocation(latitude: String, longitude: String)
}

class NextViewController: UIViewController {

    @IBOutlet weak var latitudeTextField: UITextField!
    @IBOutlet weak var longitudeTextField: UITextField!
    
    var delegate: SearchLocationDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func okAction(_ sender: Any) {
        let latitude = latitudeTextField.text!
        let longitude = longitudeTextField.text!
        
        // NextViewControllerでデリゲートに値を渡す
        delegate?.searchLocation(latitude: latitude, longitude: longitude)
        
        // 緯度・経度の両方に値が入力されている場合のみモーダル画面を閉じる
        if latitudeTextField.text != nil && longitudeTextField.text != nil {
            dismiss(animated: true, completion: nil)
        }
    }
    
}
