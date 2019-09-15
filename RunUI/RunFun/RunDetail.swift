//
//  RunDetail.swift
//  RunFun
//
//  Created by Filip Vabroušek on 12/06/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import MapKit
import CoreLocation
import WebKit


struct AlertButton: View {
    @State var show = false // chnaging to true crashes the app

    var sheet: ActionSheet {
        ActionSheet(title: Text("Message"), message: nil, buttons: [.default(Text("Splits"), action: {
                    // They don't want us to present new Views...
                }), .cancel({
                    // self.show = false
                })])
    }

    var body: some View {

        HStack {
            Button("Show alert") {
                self.show = true
            }.actionSheet(isPresented: $show, content: { self.sheet })

            //.presentation(show ? sheet : nil)

            /*PresentationButton(destination: FeedView()) {
             Text("Hey")
             }*/
        }



        /*
         btn.presentation($show){
         
         
         Alert(title: Text("Message"), message: Text("Message"), dismissButton: .default(Text("Yup!")))*/

    }
}

struct RunDetail: View {
    @State var favorite = 0.0
    var run: RunVM
    var views = ["Run", "Web"]

    var body: some View {
        VStack {
            Text(run.time).font(.system(size: 30)).fontWeight(.heavy)
                .offset(x: 0, y: -40)
            
            Text(run.dist + " km")
                .font(.system(size: 30)).fontWeight(.heavy)
                .offset(x: 0, y: -40)

            AlertButton().offset(x: 0.0, y: -20.0)

            Picker(selection: $favorite, label: Text("Choose")){
                ForEach(0..<views.count){ i in
                    Text(self.views[i])
                }
            }.pickerStyle(SegmentedPickerStyle())
        
            if (favorite == 0){
                Map(loc2d: CLLocationCoordinate2D(latitude: run.lastLAT, longitude: run.lastLON))
            } else {
                WebView(request: URLRequest(url: URL(string:"https://developer.apple.com")!))
            }
        }.frame(width: UIScreen.main.bounds.width)
    }
}

struct WebView: UIViewRepresentable {
    let request: URLRequest

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(request)
    }
}


struct Map: UIViewRepresentable {
    func makeUIView(context: UIViewRepresentableContext<Map>) -> MKMapView {
        return MKMapView()
    }



    var loc2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)

    init(loc2d: CLLocationCoordinate2D) {
        self.loc2D = loc2d
    }


    func updateUIView(_ view: MKMapView, context: Context) {
        let span = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007) // 0.005
        let region = MKCoordinateRegion(center: loc2D, span: span)
        view.setRegion(region, animated: false)
    }
}


