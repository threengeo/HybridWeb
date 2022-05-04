//
//  ContentView.swift
//  HybridWeb
//
//  Created by qwsyv on 2022/04/26.
//

import SwiftUI

struct ContentView: View {
    @StateObject var webViewModel = WebViewModel()
    
    @State private var showAppAlert: AppAlert?
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    MainWebView(urlString: "https://www.jejusumpro.com")
                        .edgesIgnoringSafeArea(.all)
                }
                .alert(item: $showAppAlert) { appAlert in
                    Alert(title: Text(appAlert.title), message: Text(appAlert.message), dismissButton: .default(Text("확인")))
                }
            }
            .onReceive(webViewModel.alertEvent, perform: { appAlert in
                print("ContentView - AppAlert: ", appAlert)
                self.showAppAlert = appAlert
            })
        }
        .environmentObject(webViewModel)
        .navigationTitle("")
        .navigationBarHidden(true)
//        .navigationBarTitle("", displayMode: .automatic)
//        .navigationBarHidden(true)
        
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
//            Alert(title: Text(show.name), message: Text("Great choice!"), primaryButton: .destructive(Text("취소"), action: {
//                print("취소...")
//            }), secondaryButton: .default(Text("확인."), action: {
//                print("확인...")
//            }))
//        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
