//
//  ContentView.swift
//  CheatAppBySwiftUI
//
//  Created by 伊藤直輝 on 2021/04/07.
//

import SwiftUI

struct ModalView: View {
    @Environment(\.presentationMode) private var presentationMode
    var body: some View {
        Button("Close ModalView.") {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ModalView_Previews: PreviewProvider {
    static var previews: some View {
        ModalView()
    }
}
