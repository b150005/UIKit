//
//  ViewController.swift
//  Swift6Map
//
//  Created by 伊藤直輝 on 2021/05/18.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, UIGestureRecognizerDelegate,SearchLocationDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var inputButton: UIButton!
    @IBOutlet var longPress: UILongPressGestureRecognizer!
    
    var lcManager: CLLocationManager!
    var address: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputButton.backgroundColor = .white
        inputButton.layer.cornerRadius = 20.0
    }

    @IBAction func input(_ sender: Any) {
        performSegue(withIdentifier: "next", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next" {
            let nextVC = segue.destination as! NextViewController
            
            nextVC.delegate = self
        }
    }
    
    // 緯度・経度 -> 住所 に変換
    func convert(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        // CLGeocoder: 地理的座標 ⇄ 地名 の変換
        let geocoder = CLGeocoder()
        
        let location = CLLocation(latitude: latitude, longitude: longitude)
        
        // 地理的座標 -> 地名 の変換
        // クロージャ(completionHandler): 座標が無効である場合のエラー処理
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            // 検索候補(placemarks)が1つ以上存在する場合は1番目の要素を選択
            if let placemark = placemarks?[0] {
                // 州・県名 または 都市名 がない場合の処理
                if placemark.administrativeArea != nil || placemark.locality != nil {
                    // 住所は「"名称"+"州・県"+"都市名"」に設定
                    self.address = placemark.name! + placemark.administrativeArea! + placemark.locality!
                } else {
                    // 住所は「名称」に設定
                    self.address = placemark.name!
                }
            }
            
            // 住所をラベルに反映
            self.addressLabel.text = self.address
        }
    }
    
    // NextViewControllerで定義したデリゲートメソッドの実装
    // NextViewControllerで入力された緯度・経度の値をViewControllerに渡す
    func searchLocation(latitude: String, longitude: String) {
        // 緯度・経度の両方に値が入力されている場合の処理
        if latitude.isEmpty != true && longitude.isEmpty != true {
            let latitudeValue = latitude
            let longitudeValue = longitude
            
            // 緯度・経度 -> 2次元座標のデータ構造(CLLocationCoordinate2Dクラス) にフォーマット
            let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(latitudeValue)!, CLLocationDegrees(longitudeValue)!)
            // 地図のズームレベル
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            // 経度・緯度および縮尺
            let region = MKCoordinateRegion(center: coordinate, span: span)
            
            // 指定した拠点をMKMapViewに表示
            mapView.setRegion(region, animated: true)
            // 経緯度 -> 住所 の変換(ユーザ定義)
            convert(latitude: Double(latitudeValue)!, longitude: Double(longitudeValue)!)
            // ラベルに反映
            addressLabel.text = address
        }
        // 緯度または経度に値が入力されていない場合の処理
        else {
            addressLabel.text = "We cannot display on your settings. "
        }
    }
    
    // LongPress時に発火
    @IBAction func longPressTap(_ sender: UILongPressGestureRecognizer) {
        // LongPress開始時の処理
        if sender.state == .began {
            
        }
        // LongPress終了時の処理
        else if sender.state == .ended {
            // LongPressの入力座標
            let tapPoint = sender.location(in: view)
            // LongPressの入力座標 -> MapViewの2次元座標 に変換
            // ここでのconvertメソッドはMapKitのメソッド
            let center = mapView.convert(tapPoint, toCoordinateFrom: mapView)
            // MapViewの2次元座標 -> 緯度・経度 に分割
            let latitude = center.latitude
            let longitude = center.longitude
            
            // ここでのconvertメソッドは自作のもの
            convert(latitude: latitude, longitude: longitude)
        }
    }
    
}

