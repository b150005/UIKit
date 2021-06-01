//
//  ViewController.swift
//  Swift6Question
//
//  Created by 伊藤直輝 on 2021/05/24.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func answer(_ sender: Any) {
        // ○ボタンが押された場合の処理
        if (sender as AnyObject).tag == 1 {
            
        }
        // ×ボタンが押された場合の処理
        else if (sender as AnyObject).tag == 2 {
            
        }
    }
    
}

