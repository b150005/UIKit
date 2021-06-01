//
//  ViewController.swift
//  Swift6WebKit
//
//  Created by 伊藤直輝 on 2021/04/29.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var toolbar: UIToolbar!
    
    // WKWebViewのインスタンス化
    var webview = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // インジケータを非表示にする
        indicator.isHidden = true
        
        // フレームサイズの指定
        webview.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height - toolbar.frame.size.height)
        
        view.addSubview(webview)
        
        // デリゲートメソッドを使えるようにする
        webview.navigationDelegate = self
        
        // URLをString型からURL型にキャスト
        let url = URL(string: "https://www.kurashiru.com/")
        
        // URLリクエストを行うオブジェクトの生成
        let request = URLRequest(url: url!)
        
        // URLリクエストのロード
        webview.load(request)
        
        // インジケータを前面に表示
        indicator.layer.zPosition = 2
    }
    
    // ロードの完了時に呼び出されるメソッド
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // インジケータを非表示にする
        indicator.isHidden = true
        // インジケータアニメーションを無効化
        indicator.stopAnimating()
    }
    
    // 読み込み開始時に呼び出されるメソッド
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        // インジケータを表示する
        indicator.isHidden = false
        // インジケータアニメーションを有効化
        indicator.startAnimating()
    }

    @IBAction func back(_ sender: Any) {
        webview.goBack()
    }
    
    @IBAction func go(_ sender: Any) {
        webview.goForward()
    }
    
}

