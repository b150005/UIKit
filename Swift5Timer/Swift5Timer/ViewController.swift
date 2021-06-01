//
//  ViewController.swift
//  Swift5Timer
//
//  Created by 伊藤直輝 on 2021/04/18.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    // Timerクラスのインスタンス生成
    var timer = Timer()
    
    var count = Int()
    
    // UIImageを格納する配列を生成
    var imageArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // countの初期化
        count = 0
        
        // stopButtonを押せなくする
        stopButton.isEnabled = false
        
        // imageArrayに用意した画像を格納
        for i in 0 ..< 5 {
            let image = UIImage(named: "\(i)")
            
            imageArray.append(image!)
        }
        
        // 初期画像の指定
        imageView.image = UIImage(named: "0")
    }

    // タイマー
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(timerUpdate), userInfo: nil, repeats: true)
    }
    
    // 0.2秒ごとに呼び出されるメソッド
    @objc func timerUpdate() {
        // カウントアップ
        count += 1
        
        // 反映される画像を指定
        imageView.image = imageArray[count % 5]
    }
    
    // startButtonが押されたときに呼ばれるメソッド
    @IBAction func start(_ sender: Any) {
        // imageViewのimageに画像を反映する
        startTimer()
        
        // startButtonを押せなくし、stopButtonを押せるようにする
        startButton.isEnabled = false
        stopButton.isEnabled = true
    }
    
    // stopButtonが押されたときに呼ばれるメソッド
    @IBAction func stop(_ sender: Any) {
        // startButtonを押せるようにし、stopButtonを押せなくする
        startButton.isEnabled = true
        stopButton.isEnabled = false
        
        // タイマーを止める
        timer.invalidate()
    }
    
}

