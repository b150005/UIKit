//
//  ContentView.swift
//  CheatAppBySwiftUI
//
//  Created by 伊藤直輝 on 2021/04/07.
//

import SwiftUI

struct ContentView: View {
    @State private var showingModal = false
    
    @State private var vOffset = CGFloat.zero    // 現在のオフセット(y軸方向)
    @State private var vCloseOffset = CGFloat.zero   // 閉状態のオフセット(y軸方向)
    @State private var vOpenOffset = CGFloat.zero    // 開状態のオフセット(y軸方向)
    @State private var hOffset = CGFloat.zero    // 現在のオフセット(x軸方向)
    @State private var hCloseOffset = CGFloat.zero   // 閉状態のオフセット(x軸方向)
    @State private var hOpenOffset = CGFloat.zero    // 開状態のオフセット(x軸方向)
   
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                // メインコンテンツ
                VStack {
                    Button("Show ModalView.") {
                        self.showingModal.toggle()
                    }.sheet(isPresented: $showingModal) {
                        ModalView()
                    }
                    
                    Divider()
                    
                    NavigationView {
                        NavigationLink(destination: PushView()) {
                            Text("Show PushView.")
                        }.navigationBarTitle("ContentView", displayMode: .automatic)
                    }
                    
                    Divider()
                    
                    TabView {
                        TabAView()
                            .tabItem {
                                Image(systemName: "moon")
                                Text("Tab A")
                            }
                        
                        TabBView()
                            .tabItem {
                                Image(systemName: "moon.fill")
                                Text("Tab B")
                            }
                    }
                }
                // 上部メニュー
                PageUpView()
                    .foregroundColor(Color.red)
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    // View描画時に呼び出すメソッド
                    .onAppear(perform: {
                        // PageUpViewのオフセット初期値として負の方向(上方向)に[Safe Areaの高さ]+[PageUpView自体の高さ]分ずらす
                        self.vOffset = -1 * (geometry.frame(in: .global).origin.y + geometry.size.height)
                        // 閉状態のオフセット = 初期状態のオフセット
                        self.vCloseOffset = self.vOffset
                        // 開状態のオフセット = 0
                        self.vOpenOffset = .zero
                    })
                    // オフセット
                    .offset(y: self.vOffset)
                    // アニメーション
                    .animation(.default)
                
                // 左部メニュー
                PageLeftView()
                    .foregroundColor(Color.blue)
                    .frame(width: geometry.size.width)
                    .edgesIgnoringSafeArea(.all)
                    // View描画時に呼び出すメソッド
                    .onAppear(perform: {
                        self.hOffset = -1 * geometry.size.width
                        self.hCloseOffset = self.hOffset
                        self.hOpenOffset = .zero
                    })
                    .offset(x: self.hOffset)
                    .animation(.default)
            }
            //ジェスチャーに関する実装
            .gesture(DragGesture(minimumDistance: 5)
                        // DragGestureの入力開始時の呼び出しメソッド
                        .onChanged { value in
                            // ContentViewのy軸方向の現在のオフセットが初期値でない かつ DragGestureの開始位置のy座標が30未満の場合
                            if (self.vOffset != self.vOpenOffset && value.startLocation.y < 30) {
                                // ContentViewの現在のオフセット = 初期状態からy軸方向にDragされた距離
                                self.vOffset = self.vCloseOffset + value.translation.height
                            }
                            // ContentViewのx軸方向の現在のオフセットが0未満(常に満たす) かつ DragGestureの開始位置のx座標が30未満の場合
                            else if (self.hOffset < self.hOpenOffset && value.startLocation.x < 30) {
                                // ContentViewの現在のオフセット = 初期値からx方向にDragされた距離
                                self.hOffset = self.hCloseOffset + value.translation.width
                            }
                        }
                        // DragGestureの入力終了時の呼び出しメソッド
                        .onEnded { value in
                            //Gesture終了時のViewのy座標がGesture開始時よりも高い(Viewが下方向に動いた場合)
                            if (value.startLocation.y < value.location.y) {
                                // Gestureの開始位置のy座標が30未満の場合
                                if (value.startLocation.y < 30) {
                                    // PageUpViewを開状態にする
                                    self.vOffset = self.vOpenOffset
                                }
                            }
                            // Gesture終了時のViewのx座標がGesture開始時よりも高い(Viewが右方向に動いた場合)
                            else if (value.location.x > value.startLocation.x) {
                                if (value.startLocation.x < 30) {
                                    // PageLeftViewを開状態にする
                                    self.hOffset = self.hOpenOffset
                                }
                            }
                            else {
                                // PageUpView, PageLeftViewを閉状態にする
                                self.hOffset = self.hCloseOffset
                                self.vOffset = self.vCloseOffset
                            }
                        }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
