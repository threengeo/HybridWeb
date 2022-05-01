//
//  ContentView.swift
//  HybridWeb
//
//  Created by qwsyv on 2022/04/26.
//

import SwiftUI

struct TVShow: Identifiable {
    var id: String { name }
    let name: String
}

struct ContentView: View {
    @State private var selectedShow: TVShow?
    
    var body: some View {
        VStack {
            Text("MainWebView")
            MainWebView(urlString: "http://sumpro.todayjeju.net")
        }
        
//        VStack(spacing: 20) {
//            Text("What is your favorite TV show?")
//                .font(.headline)
//
//            Button("Select Ted Lasso") {
//                selectedShow = TVShow(name: "Ted Lasso")
//            }
//
//            Button("Select Bridgerton") {
//                selectedShow = TVShow(name: "Bridgerton")
//            }
//        }
//        .alert(item: $selectedShow) { show in
//            Alert(title: Text(show.name), message: Text("Great choice!"), dismissButton: .cancel())
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
