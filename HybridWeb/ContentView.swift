//
//  ContentView.swift
//  HybridWeb
//
//  Created by qwsyv on 2022/04/26.
//

import SwiftUI

struct FullScreenModalView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("This is modal view")
            Text("Tab to dismiss")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .edgesIgnoringSafeArea(.all)
        .background(Color.red)
        .onTapGesture {
            self.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct ContentView: View {
    @StateObject var webViewModel = WebViewModel()
    
    @State private var showAppAlert: AppAlert?
    
    @State private var isPresented = false
    
    var body: some View {
//        Button("Present!") {
//            self.isPresented.toggle()
//        }
//        .fullScreenCover(isPresented: $isPresented, content: FullScreenModelScreen.init)
//
//        NavigationView {
//            ZStack {
//                VStack {
//                    MainWebView(urlString: "https://www.jejusumpro.com")
//                        .edgesIgnoringSafeArea(.all)
//                }
//                .navigationBarHidden(true)
//                .alert(item: $showAppAlert) { appAlert in
//                    Alert(title: Text(appAlert.title), message: Text(appAlert.message), dismissButton: .default(Text("확인")))
//                }
//            }
//            .onReceive(webViewModel.alertEvent, perform: { appAlert in
//                print("ContentView - AppAlert: ", appAlert)
//                self.showAppAlert = appAlert
//            })
//        }
//        .environmentObject(webViewModel)
//        .navigationTitle("")
//        .navigationBarHidden(true)
        
        ZStack {
            VStack {
                Button("Present!") {
                    self.isPresented.toggle()
                }
                
                MainWebView(urlString: "https://www.naver.com")
                    .edgesIgnoringSafeArea(.all)
            }
            .alert(item: $showAppAlert) { appAlert in
                Alert(title: Text(appAlert.title), message: Text(appAlert.message), dismissButton: .default(Text("확인")))
            }
        }
        .fullScreenCover(isPresented: $isPresented, content: {
            MainWebView(urlString: "https://www.apple.com")
                .edgesIgnoringSafeArea(.all)
        })
        .onReceive(webViewModel.alertEvent, perform: { appAlert in
            print("ContentView - AppAlert: ", appAlert)
            self.showAppAlert = appAlert
        })
        .environmentObject(webViewModel)
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
