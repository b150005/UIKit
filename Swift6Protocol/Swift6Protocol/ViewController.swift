//
//  ViewController.swift
//  Swift6Protocol
//
//  Created by 伊藤直輝 on 2021/05/13.
//

import UIKit

// NextViewController -> CatchProtocol -> ViewController で値が渡る
class ViewController: UIViewController, CatchProtocol {
    
    @IBOutlet weak var countLabel2: UILabel!
    
    var count = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // 実装は受け取る側のViewControllerで行うが、
    // 実行は渡す側のNextViewControllerで行う
    func catchData(count: Int) {
        countLabel2.text = String(count)
    }

    @IBAction func next(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    // 画面遷移前にNextViewControllerのdelegateプロパティをselfに定義しておく
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! NextViewController
        
        nextVC.delegate = self
    }
    
}

