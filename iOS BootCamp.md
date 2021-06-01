# Swift5Timer

## Timerクラス

```swift
class Timer: NSObject
```

`Timer`クラスは、任意の時間が経過すると発火するメソッドを作成できるクラス。

### Timerクラスのイニシャライザ

```swift
// Creating a Timer
class func scheduledTimer(timeInterval: TimeInterval, target: Any, selector: Selector, userInfo: Any?, repeats: Bool) -> Timer

// パラメータ
// timerInterval - 発火までの時間間隔[秒]
// target - 発火時にメッセージを送信する対象
// selector - メッセージの受信時に実行するメソッドが含まれるデータ(後述)
// userInfo - Timer のユーザ情報。 ※基本的にnil
// repeats - 繰り返し発火させるかどうか
```

### 発火するメソッドの書き方

```swift
class ViewController: UIViewController {
    // Timerクラスのインスタンスを生成
    var timer = Timer()

    // 発火に関する各種指定
    timer = Timer.scheduledTimer(
        timeInterval: 0.2, 
        target: self, 
        selector: #selector(timerUpdate), 
        userInfo: nil, 
        repeats: true
    )

    // 発火時に実行するメソッド
    @objc func timerUpdate() {

        // timeInterval [秒]毎に呼ばれるメソッド

    }

    // タイマーの停止
    timer.invalidate()
}
```

#### Objective-Cの動作モデルとセレクタ
前提:
Appleプラットフォームは`Objective-C`の実行時環境(ランタイムシステム)を基盤にしているため、
Objective-Cの動作モデルに基づいている。

Objective-Cの動作モデル:
プログラムを構成するのは`オブジェクト`(クラスの「インスタンス」または「クラスそのもの」)であり、
オブジェクトが相互に`メッセージ`を送信し合うことによってプログラムが動作する。

オブジェクトがメッセージを受信するとメソッドが起動し、
起動するメソッドは`セレクタ`と呼ばれるデータを使って指定する。

Swiftではセレクタに対応する型として`Selector型`が用意されており、
Selector型を使ってメソッドを呼び出す仕組みはObjective-Cの`NSObject`クラスで定義されているため、
セレクタが適用できるのは`NSObject`のサブクラスのインスタンスに限定される。

また、セレクタを使って呼び出されるメソッドには`@objc`修飾子を付け、
Objective-Cで利用することを明示しておく。

なお、`Selector`型は構造体だが`#selector`という特別な記法を用いる。


# Swift5Keyboard

## returnキーを押すとキーボードを閉じる機能の実装

```swift
// ViewControllerクラスには、UITextFieldDelegateプロトコルに準拠させる
class ViewController: UIViewController, UITextFieldDelegate {
    // returnキーが押されたときにメソッドを呼び出す、UITextFieldDelegateのメソッド
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // キーボードをFirstResponderでなくする(非表示にする)
        textField.resignFirstResponder()
    }
}
```

## UITextFieldDelegateプロトコル
`UITextField`の追加機能を実装するプロトコル。

## textFieldShouldReturnメソッド

```swift
optional func textFieldShouldReturn(_ textField: UITextField) -> Bool
```

キーボードの`return`キーが押されたときに発火するメソッドを実装できる。

## resignFirstResponderメソッド

`UITextField`は、`FirstResponder`になるとキーボードを表示し、
FirstResponderでなくなるとキーボードを非表示にする性質がある。

## DelegateとProtocol
[参考](https://qiita.com/mochizukikotaro/items/a5bc60d92aa2d6fe52ca)

```swift
// プロトコル(手段)
protocol Mochi {
    func sayHello() -> String
}

// 依頼側
class Hoge {
    // delegate は依頼側と代理側を繋ぐ存在で、
    // 依頼側で用意し、代理側に繋ぐプロトコルに準拠させる
    var delegate: Mochi!

    func say() -> String {
        // デリゲートは代理側で実装するメソッドを実行
        return delegate.sayHello()
    }
}

// 代理側
class Piyo: Mochi {
    // 実際に sayHello() を実行するのは代理側なので、
    // 代理側クラスは プロトコルMochi に準拠させる
    func sayHello() -> String {
        return "Hello, world"
    }
}

let hoge = Hoge()
let piyo = Piyo()
// デリゲートには代理側クラスのインスタンスを代入する
hoge.delegate = piyo
// 依頼側クラスのインスタンスは、そのプロパティが準拠しているプロトコルを通じて
// 代理側クラスのメソッドを呼び出す
hoge.say()  // "Hello, world"
```

# Swift5Transition

## Modal遷移から戻る方法

```swift
open func dismiss(animated flag: Bool, completion: (() -> Void)? = nil)

// パラメータ
// animated - 閉じる際のアニメーション
// completion - 子Viewが閉じられた後に実行されるメソッド
```

## 値を渡しながら遷移する方法

```swift
// 画面の遷移
open func performSegue(withIdentifier identifier: String, sender: Any?)

// パラメータ
// withIdentifier - segueのIdentifier
// sender - アクションのトリガーとなるUIクラス

// 遷移先Viewに値を渡す
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    let nextVC = segue.destination as! NextViewController
    nextVC.value2 = value1
}

// パラメータ
// segue - ViewController間を結ぶオブジェクト

// プロパティ
// destination - segueによって最終的に表示されるViewController
```

## NavigationControllerを用いた遷移

```swift
// レシーバ(遷移元View)から遷移先Viewにプッシュ遷移
open func pushViewController(_ viewController: UIViewController, animated: Bool)

// パラメータ
// viewController - Push遷移先のViewController
// animated - 遷移アニメーションを追加するかどうか
```

### 実行コード例

```swift
// Identifierを指定してViewControllerを作成し、Storyboard上のデータで初期化
let showVC = storyboard?.instantiateViewController(identifier: "show") as! ShowViewController

// パラメータ
// identifier - 遷移先の Storyboard ID

navigationController?.pushViewController(showVC, animated: true)
```

# Swift6WebKit

## サブビューの追加

```swift
open func addSubview(_ view: UIView)

// パラメータ
// view - 上(zPositionの正の方向)に追加するView
```

実行例

```swift
var webview = WKWebView()

view.addSubView(webview)
```

## デリゲートメソッドを使えるようにする

```swift
// デリゲートメソッドを使うクラスを、対象Delegateクラスに準拠させる
class ViewController: UIViewController, WKNavigationDelegate {
    override func viewDidLoad() {
        // デリゲートをselfで定義
        webview.navigationDelegate = self
    }

    // デリゲートメソッドの記述
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        // ロード開始時に呼び出すメソッド
    }
}
```

## URLの表示

```swift
// URLの指定
let url = URL(string: "https://www.kurashiru.com/")

// URLリクエストオブジェクトの生成
let request = URLRequest(url: url!)

// URLリクエストのロード
webview.load(request)
```

### URLリクエストのロード

```swift
open func load(_ request: URLRequest) -> WKNavigation?

// パラメータ
// request - 遷移先URLを特定する URLRequest オブジェクト
```

## 特定のViewを前面に出す

```swift
@IBOutlet weak var indicator: UIActivityIndicatorView!

// LayerのzPositionを指定(大きいほど前面)
indicator.layer.zPosition = 2
```

## ロード開始時に実行されるメソッド

```swift
func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
    // ロード開始時に呼び出すメソッド
}
```

## ロード完了時に実行されるメソッド

```swift
func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
    // ロード完了時に呼び出すメソッド
}
```

# Swift6TableView
[Apple公式ドキュメント](https://developer.apple.com/documentation/uikit/views_and_controls/table_views#//apple_ref/doc/uid/TP40007451)

## ViewControllerのライフサイクル
[参考1](https://qiita.com/motokiee/items/0ca628b4cc74c8c5599d)
[参考2](https://qiita.com/entaku0818/items/87d4e7225e23db0b01ff)
[Apple公式ドキュメント](https://developer.apple.com/documentation/uikit/view_controllers/displaying_and_managing_views_with_a_view_controller/)

- [loadView](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621454-loadview)
`view`プロパティがリクエストされたが、nilであった場合に呼び出される。
`loadView`メソッドは、Viewを読み込んだり作成したりするとともに、そのViewを`view`プロパティに割り当てる。
Viewを手動で作成(nibファイルからView階層の情報を読み込む)する場合に`override`して使う。
    - [viewDidLoad](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621495-viewdidload)
    ViewControllerがView階層をメモリに読み込んだ後に呼び出される。
    nibファイルから読み込まれた情報に加えて、自身で何かしらの初期化を行う場合に`override`して使う。
        - [viewWillAppear](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621510-viewwillappear)
        ViewControllerのViewがView階層に追加され、アニメーションが構成される直前に呼び出される。
        Viewが表示される際に付随して呼び出すメソッドを定義する場合に`override`して使う。
            - [viewWillLayoutSubviews](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621437-viewwilllayoutsubviews)
            Viewが子Viewを配置する直前に呼び出される。
                - [viewDidLayoutSubviews](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621398-viewdidlayoutsubviews)
                Viewが子Viewを配置した直後に呼び出される。
                    - [viewDidAppear](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621423-viewdidappear)
                    ViewがView階層に追加された直後に呼び出される。
                    Viewが描写される際に付随して呼び出すメソッドを定義する場合に`override`して使う。
                        - [viewWillDisappear](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621485-viewwilldisappear)
                        ViewがView階層から削除され、アニメーションが構成される直前に呼び出される。
                        サブクラスで編集モードの変化を適用したり、ViewのFirstResponderを取り消したり、その他関連タスクを実行したりする場合に`override`して使う。
                            - [viewDidDisappear](https://developer.apple.com/documentation/uikit/uiviewcontroller/1621477-viewdiddisappear)
                            ViewがView階層から削除された直後に呼び出される。
                            Viewの解放時に付随して呼び出すメソッドを定義する場合に`override`して使う。

### ライフサイクル毎に呼び出されるメソッド

```swift
// UI 部品を View へセットする場合はこちらをオーバーライドします。
// UIの処理はここで定義しなくてもいいですが、決めておくとわかりやすい！
override func loadView() {
    super.loadView()
    print("loadView")
}

// 初期表示時に必要な処理を設定します。
// 基本的な初期化はここで
override func viewDidLoad() {
    super.viewDidLoad()
    print("viewDidLoad")
}

// 画面に表示される直前に呼ばれます。
// viewDidLoadとは異なり毎回呼び出されます。
override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    print("viewWillAppear")
}

// 画面に表示された直後に呼ばれます。
// viewDidLoadとは異なり毎回呼び出されます。
override func viewDidAppear(animated: Bool) {
    super.viewDidAppear(animated)
    print("viewDidAppear")
}

// 画面から非表示になる直前に呼ばれます。
// viewDidLoadとは異なり毎回呼び出されます。
override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    print("viewWillDisappear")
}

// 画面から非表示になる直後に呼ばれます。
// viewDidLoadとは異なり毎回呼び出されます。
override func viewDidDisappear(animated: Bool) {
    super.viewDidDisappear(animated)
    print("viewDidDisappear")
}
```

## UITableViewDataSourceのデリゲートメソッド

```swift
@IBOutlet weak var tableview: UITableView!

// TextFieldに入力された文字列を格納する配列の生成
var textArray = [String]()

func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // SectionあたりのCellの行数を指定(定義必須)
}

func numberOfSections(in tableView: UITableView) -> Int {
    // Sectionの数を指定
}

func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Cellに関する設定(定義必須)

    // Cellの作成
    let cell = tableview.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

    // Cell選択時にハイライトしない
    cell.selectionStyle = .none

    // Cellの文字列(.textLabel?.text)の定義
    cell.textLabel?.text = textArray[indexPath.row]
    // Cellの画像(.imageView!.image)の定義
    cell.imageView!.image = UIImage(named: "cellIcon")

    // 設定が適用されたCellを返却
    return cell
}

// パラメータ
// tableView - TableViewオブジェクト
// indexPath - tableViewの行数
```

## UITableViewDelegateのデリゲートメソッド

```swift
func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    // Cellが選択された時の挙動

    // 遷移先のViewControllerを定義
    let nextVC = storyboard?.instantiateViewController(identifier: "next") as! NextTableViewController
    
    // 遷移先のLabelに代入する文字列の指定
    nextVC.str = textArray[indexPath.row]

    // 遷移方法をPush遷移に指定
    navigationController?.pushViewController(nextVC, animated: true)
}

func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    // Rowの高さを指定
    return ( view.frame.size.height / 6 )   // 画面の高さの1/6
}
```

## UITextFieldDelegateのデリゲートメソッド

```swift
// TextFieldに文字列が入力され、returnキーが押された時の挙動
func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    // 入力された文字列を textArray: [String] に格納
        textArray.append(textField.text!)
        // Keyboardの非表示
        textField.resignFirstResponder()
        
        // 入力された文字列を削除
        textField.text = ""
        // TableViewの再描画
        tableview.reloadData()
        
        // 編集終了イベントの発火
        return true
}
```

# Swift6TableViewApp

## CellにImageViewやLabelを配置

```swift
var imageArray = ["1", "2", "3", "4", "5"]

// UITableViewDataSourceに準拠したクラス
func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    // Cellの定義
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

    // Cellに配置したImageViewの定義(Tag値: 1)
    // UIImageView, UILabelはTableView -> Cell -> ContentViewの階層に配置
    let imageView = cell.contentView.viewWithTag(1) as! UIImageView
    // Cellに配置したLabelの定義(Tag値: 2)
    let label = cell.contentView.viewWithTag(2) as! UILabel

    // ImageViewに反映する画像の定義 ※imageArrayは[String]型
    imageView.image = UIImage(named: imageArray[indexPath.row])
    // Labelに反映する文字列の定義
    label.text = textArray[indexPath.row]

    // 定義したCellを返す
    return cell
}
```

# Swift6Struct

## デリゲートを用いたViewController間の値の受け渡し

|提供元||デリゲート(橋渡し役)||提供先|
|:---:|:---:|:---:|:---:|:---:|
|NextViewController|→|SetOKDelegate|→|ViewController|
|nextVC|person|setOKDelegate|setOK(check:)|personArray|

```swift:Person
// 情報の構成
struct Person {
    var name = String()
    var hobby = String()
    var movie = String()
}
```

```swift:NextViewController
// 提供元がプロトコルを宣言
protocol SetOKDelegate {
    func setOK(check: Person)
}

class NextViewController: UIViewController {
    // 提供する情報のインスタンス
    var person = Person()

    // デリゲートプロパティの定義
    // -> このプロパティを通じて情報のやり取りが行われる
    var setOKDelegate: SetOKDelegate?

    @IBAction func add(_ sender: Any) {
        // ②提供する情報を格納
        person.name = nameTextField.text!
        person.hobby = hobbyTextField.text!
        person.movie = movieTextField.text!

        // ③格納した情報を配列に格納
        setOKDelegate?.setOK(check: person)
    }
}
```

```swift:ViewController
// 提供先はデリゲートプロトコルに準拠 -> デリゲートメソッドを実装する
class ViewController: UIViewController, SetOKDelegate {
    // 情報のインスタンス
    var person = Person()
    var personArray = [Person]()

    // デリゲートメソッドの実装
    func setOK(check: Person) {
        personArray.append(check)
    }

    // 画面遷移前の準備
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 提供元(遷移先)のインスタンス
        let nextVC = segue.destination as! NextViewController

        // ①画面遷移前に提供元のプロパティをself(提供先)に定義
        nextVC.setOKDelegate = self
    }
}
```

# Swift6Protocol

## デリゲートメソッド
プロトコルで定義されたメソッド

# Swift6MapView

## UIGestureRecognizer
[Apple公式ドキュメント](https://developer.apple.com/documentation/uikit/uigesturerecognizer)
各種ジェスチャーを識別するクラス

### UIGestureRecognizerの子クラス
- UITapGestureRecognizer(タップ)
- UIPinchGestureRecognizer(ピンチ)
- UIRotationGestureRecognizer(二本指で回転)
- UISwipeGestureRecognizer(スワイプ)
- UIPanGestureRecognizer(パン)
- UIScreenEdgePanGestureRecognizer(画面端でのパン)
- UILongPressGestureRecognizer(長押し)
- UIHoverGestureRecognizer(カーソルを合わせる)

### Gesture時の処理

```swift
import MapKit
import CoreLocation

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    // 
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var longPress: UILongPressGestureRecognizer!

    @IBAction func longPressTap(_ sender: UILongPressGestureRecognizer) {
        // Gesture開始時の処理
        if sender.state == .began {

       }
       // Gesture終了時の処理
       else if sender.state == .ended {
           // Gesture入力座標の定義
           let tapPoint = sender.location(in: view)

           // Gesture入力座標 -> 指定したViewの2次元座標
           let mapPoint = mapView.convert(tapPoint, toCoordinateFrom: mapView)
       }
    }
}
```

## MapKit
地図や衛星写真をAppに提供するフレームワーク

### Gesture開始時のCGPointを緯度・経度に変換

#### 宣言

```swift
func convert(_ point: CGPoint, toCoordinateFrom view: UIView?) -> CLLocationCoordinate2D
// パラメータ
// point - CGPointで表されるViewの2次元座標
// view - 地理座標に変換するpointの入力View
```

## CoreLocation
デバイスの地理的座標・高度・方向などを取得できるフレームワーク

### CLLocationManager
`CLLocationManager`インスタンスによってCoreLocationサービスの構成・開始および停止を行う

### CLGeocoder
「地理的座標⇄地名」の変換を行うクラス

### CLPlacemark
地理に関する情報を定義するクラス

#### CLPlacemarkのプロパティ
- location: 経度および緯度
- name: 名称
- isoCountryCode: 国・地域の省略名
- country: 国・地域名
- postalCode: 郵便番号
- administrativeArea: 州名・県名
- locality: 都市名
- thoroughfare: 番地
- subThoroughfare: 通り名
- region: 地理的領域
- timeZone: タイムゾーン
- inlandWater: 内陸水域
- ocean: 海名

### 緯度・経度を地名に変換

#### 宣言

```swift
func reverseGeocodeLocation(_ location: CLLocation, completionHandler: @escaping CLGeocodeCompletionHandler)
// パラメータ
// location - 地理座標
// completionHandler - reverse-geocodingリクエスト完了時に実行される処理

typealias CLGeocodeCompletionHandler = ([CLPlacemark]?, Error?) -> Void
// パラメータ
// placemark - CLPlacemarkオブジェクトの配列, 情報を取得できない(=エラーの)場合はnil
// error - (取得成功時)nil または (エラー時)情報が取得できない理由を示すerrorオブジェクト
```

#### コード

```swift
import CoreLocation

class ViewController: UIViewController {
    var address: String = ""

    func convert(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        // 地理的座標⇄地名の変換を行うインスタンス
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)

        // 地理的座標 -> 地名 の変換
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            // ヒット結果が1つ以上ある場合は1番目の要素を選択
            if let placemark == placemarks?[0] {
                // 州・県名 または 都市名 がない場合の処理
                if placemark.administrativeArea != nil || placemark.locality != nil {
                    // 住所は「"名称"+"州・県"+"都市名"」に設定
                    self.address = placemark.name! + placemark.administrativeArea! + placemark.locality!
                } else {
                    // 住所は「名称」に設定
                    self.address = placemark.name!
                }
            }
        }
    }
}
```

### 地図領域の指定

#### CLLocationCoordinate2D
`CLLocationDegrees`(=`Double`)型の緯度・経度を有する構造体

#### 緯度・経度を用いたイニシャライズ

```swift
func CLLocationCoordinate2DMake(_ latitude: CLLocationDegrees, _ longitude: CLLocationDegrees) -> CLLocationCoordinate2D
// パラメータ
// latitude - 緯度
// longitude - 経度
```

#### MKCoordinateSpan
地図の表示領域(=ズームレベル, 縮尺)を定義する構造体

##### イニシャライザ

```swift
init(latitudeDelta: CLLocationDegrees, longitudeDelta: CLLocationDegrees)
// パラメータ
// latitudeDelta - 緯度方向の表示範囲(0-1), 大きいほどズームレベルが高くなる
// longitudeDelta - 経度方向の表示範囲(0-1), 大きいほどズームレベルが高くなる
```

#### MKCoordinateRegion
`CLLocationCoordinate2D`(経緯度)と`MKCoordinateSpan`(縮尺)を有する構造体

##### イニシャライザ

```swift
init(center: CLLocationCoordinate2D, span: MKCoordinateSpan)
// パラメータ
// center - 中心座標
// span - 縮尺
```

#### コード

```swift
import MapKit

@IBOutlet weak var mapView: MKMapView!

let coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(latitude)!, CLLocationDegrees(longitude)!)
let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
let region = MKCoordinateRegion(center: coordinate, span: span)

// 指定した場所をMKMapViewで表示
mapView.setRegion(region, animated: true)
```

# Swift6Question

## Presentation Domain Separation(PDS)
`MVC`, `MVP`, `MVVM`といったアーキテクチャの根底となるアイデア
`PDS`を実践するためのレイヤー構造パターンが`GUIアーキテクチャ`

Presentation(=View): UIに関係するロジック
→ 「コンポーネントのレイアウト」に関心をもつ
Domain(=Model): システム本来の関心領域
→ 「情報のモデリング・処理」に関心をもつ

→ 関心の異なる部分はレイヤーとして分けるべき

### PDSのメリット

- コードが読みやすい
- 重複コードを排除しやすい
- フロントエンド・バックエンドの分業が容易(ファイルが異なるため)
- テスタビリティの向上

## GUIアーキテクチャ
`UI`のあるシステムは以下の処理を行う

1. UIが入力を受ける
2. 入力イベントをシステムが解釈・処理
3. 処理結果をUIに描画

## Model-View-Controller(MVC)

|レイヤー|役割|
|:--:|:--|
|Controller|ユーザの入力を受け、`Model`にコマンドを送る|
|Model|コマンドの入力を受けて処理を実行、`Model`自身を更新|
|View|`Model`の変更を監視、`View`自身を更新|

### MVCの特色

- ウィジェット(`Controller`・`View`)単位でプレゼンテーション(UI)とドメイン(処理)を分離
- `Model`の変更に対し、オブザーバ同期が行われる

### MVCの課題

- プレゼンテーションロジックの表現の限界
ex.) 「値に応じた色の変更」
→ 「値に応じた分岐処理」という観点では`Model`、「色の使い分け」という観点では`View`
- プレゼンテーション状態を保持できない
ex.) 「全てのフォームを埋めることで`enabled`になるボタン」
→ 「ユーザによる入力」がないため、`Model`が機能できない
- テストが難しい

上記の問題を解決するのが`Presentation Modelパターン`

### Presentation Modelパターン
`MVC`における`View`と`Model`の間に`Presentation Model`のレイヤーを設置し、
プレゼンテーションロジックやプレゼンテーション状態の管理を任せる
→ のちに`Application Modelパターン`に発展する

### MVCとPresentation Modelパターンの役割比較

|レイヤー|MVC|Presentation Modelパターン|
|:--:|:--|:--|
|Controller|`Model`にコマンドを送る|`Presentation Model`にコマンドを送る|
|Presentation Model|-|`Model`にコマンドを送る<br>`Model`の変更を監視<br>プレゼンテーションロジック・状態の管理|
|Model|コマンドを受けて処理を実行、<br>`Model`自身の更新|MVCと同様|
|View|`Model`の変更を監視|`Presentation Model`の変更を監視|

## Model-View-ViewModel(MVVM)
`View`のテンプレートを`XAML`(XMLベースのDSL)で宣言
→ システム実行時に`View`と`ViewModel`をバインドするため、コードレスで`ViewModel`の状態が`View`に反映される

### MVVMの課題

- MVVMは大きなアプリケーションのためのアーキテクチャであるため、単純なアプリケーションでは実装コストが「オーバーキル」
- 大きなアプリケーションにおいても、データバインディングによってメモリ効率が悪くなる可能性がある

## Model-View-Presenter(MVP)