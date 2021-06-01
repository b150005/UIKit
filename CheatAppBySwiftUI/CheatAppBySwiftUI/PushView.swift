//
//  PushView.swift
//  CheatAppBySwiftUI
//
//  Created by 伊藤直輝 on 2021/04/08.
//

import SwiftUI

struct PushView: View {
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        Button("Back to ContentView.") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct PushView_Previews: PreviewProvider {
    static var previews: some View {
        PushView()
    }
}
