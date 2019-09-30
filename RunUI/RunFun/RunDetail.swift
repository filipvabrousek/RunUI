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

struct RunDetail: View {
    @State var favorite = 0
    var run: RunVM
    var views = ["Run", "Splits"]
    @State var off: CGFloat = 0.0
      @State var offh: CGFloat = 0.0
    @State var op: Double = 0.0

    @State var Poff: CGFloat = 0.0
    @State var Pop: Double = 0.0

    @State var Moff: CGFloat = 0.0
    @State var Mop: Double = 0.0
    // string[] po = new string [8]

    var body: some View {
        VStack {
            /*
            withAnimation(Animation.easeInOut(duration: 1.7)) {
                self.whoOpacity += 1.0
                self.tOffset += 6.0
            }
             */


            DateHeader().offset(y: off).opacity(op)
            DetailHeader(run: run).offset(y: off).opacity(op)

            Picker(selection: $favorite, label: Text("")) {
                ForEach(0..<views.count) { i in
                    Text(self.views[i]).tag(i)
                }
            }.pickerStyle(SegmentedPickerStyle())
                .offset(y: Poff).opacity(Pop)

            if (favorite == 0) {
                MapView(loc2D: CLLocationCoordinate2D(latitude: run.lastLAT, longitude: run.lastLON), isDetail: true)
                    .offset(y: Moff).opacity(Mop)
            } else {
                SplitList()
            }
        }.onAppear {
            withAnimation(Animation.easeInOut(duration: 1.7)) {
                self.off -= 30
                self.offh -= 55
                self.op += 1.0
            }


            withAnimation(Animation.easeInOut(duration: 1.7).delay(0.7)) {
                self.Poff -= 30
                self.Pop += 1.0
            }
            
            
            withAnimation(Animation.easeInOut(duration: 1.7).delay(0.9)){
                self.Moff -= 30.0
                self.Mop += 1.0
                
            }


            // print("Hey")
        }
    }
}




struct SplitList: View {
    @State var times = ["10:10", "30:40", "57:20"]

    var body: some View {
        List(times, id: \.self) { l in
            Text(l).bold()
        }
    }
}



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
        }
    }
}

/*
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
*/

struct MapView: UIViewRepresentable {
    var loc2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var isDetail: Bool = false

    init(loc2D: CLLocationCoordinate2D, isDetail: Bool) {
        self.loc2D = loc2D
        self.isDetail = isDetail
    }

    var LM: CLLocationManager = {
        let lm = CLLocationManager()
        lm.desiredAccuracy = kCLLocationAccuracyBest
        lm.requestAlwaysAuthorization()
        return lm
    }()

    func makeUIView(context: UIViewRepresentableContext<MapView>) -> MKMapView {
        // MKMapView(frame: .zero)

        let map: MKMapView = {
            let map = MKMapView()
            if isDetail == false {
                map.showsUserLocation = true
            }

            // user tracing mode
            return map
        }()

        return map
    }

    func updateUIView(_ view: MKMapView, context: Context) {

        let coord = LM.location?.coordinate


        if isDetail {
            let span = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007) // 0.005
            let region = MKCoordinateRegion(center: loc2D, span: span)
            view.setRegion(region, animated: false)
        } else {
            if coord != nil {
                let coord = CLLocationCoordinate2D(latitude: loc2D.latitude, longitude: loc2D.longitude)
                let span = MKCoordinateSpan(latitudeDelta: 0.007, longitudeDelta: 0.007) // 0.005
                let region = MKCoordinateRegion(center: coord, span: span)
                view.setRegion(region, animated: false)
            }
        }
    }
}


struct DateHeader: View {
    var body: some View {
        Text("24/9/2019").bold()
    }
}


struct DetailHeader: View {
    var run: RunVM

    var body: some View {
        VStack {
            HStack {
                Spacer()
                VStack {
                    Text("\(run.dist)").font(.system(size: 30)).bold()
                    Text("Distance").font(.system(size: 19)).bold()
                }.frame(minWidth: 90)

                Spacer()

                VStack {
                    Text("\(run.time)").font(.system(size: 30)).bold()
                    Text("Duration").font(.system(size: 19)).bold()
                }.frame(minWidth: 90)
                Spacer()
            }
        }
    }
}
