//
//  NextViewController.swift
//  Swift6Protocol
//
//  Created by 伊藤直輝 on 2021/05/18.
//

import UIKit

protocol CatchProtocol {
    func catchData(count: Int)
}

// NextViewController -> CatchProtocol -> ViewController で値が渡る
class NextViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    
    var count: Int = 0
    // 実際にはCatchProtocolのインスタンスdelegateを通じて値が渡される
    var delegate: CatchProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func plus(_ sender: Any) {
        count += 1
        countLabel.text = String(count)
    }
    
    @IBAction func back(_ sender: Any) {
        // catchDataメソッドの実装はViewControllerで行う
        // プロパティdelegateのデリゲートメソッドcatchData(count:)を通じて
        // ViewControllerに値が渡る
        delegate?.catchData(count: count)
        dismiss(animated: true, completion: nil)
    }
    

}
