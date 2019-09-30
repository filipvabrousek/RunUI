//
//  ContentView.swift
//  RunFun
//
//  Created by Filip Vabroušek on 12/06/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI
import CoreLocation
import MapKit
import Combine
import CoreData
import CoreGraphics


struct ActivityView: View {
    @EnvironmentObject var manager: SLM //= SLM(start: CLLocation(latitude: 0.0, longitude: 0.0))
    @EnvironmentObject var timer: MyTimer
    @EnvironmentObject var started: Started
    @State var rm = FV()
    @State var duration = 0
    @State var formatted = ""
    @State var hideStart = false

    var body: some View {
        VStack {

            DataView()

            ZStack(alignment: .bottomLeading) {
                MapView(loc2D: CLLocationCoordinate2D(latitude: manager.lastLoc.coordinate.latitude, longitude: manager.lastLoc.coordinate.longitude), isDetail: false)

                if hideStart == false {
                    Button("Start") {
                        //self.started.didStart = true
                        self.hideStart = true
                        self.timer.reset()
                        self.manager.reset()
                        self.manager.execute()
                    }
                        .modifier(Start())
                        .offset(x: 290, y: -30)
                }

                if hideStart == true {
                    Button("Stop") {
                        let m = self.manager
                        let run = Run(dist: m.distance, time: self.timer.formatted, latPoints: m.latpoints, lonPoints: m.lonpoints)
                        let s = Saver(ename: "Activities", key: "runs", obj: run)
                        print("SAVED")
                        s.save()
                        self.started.didStart = false
                        // self.hideStart = false
                    }
                        .modifier(Stop())
                        .offset(x: 290, y: -30)
                }
            }
        }.onAppear {
            self.timer.setDisplay()
            self.manager.reset()
            self.hideStart = false
            self.started.didStart = false
        }
    }
}




class MyTimer: ObservableObject {
    @Published var duration: Int = 0
    @Published var formatted = ""
    var begin = false

    init() {
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if self.begin {
                self.duration += 1
                let t = Time(seconds: self.duration)
                self.formatted = t.createTime
            }
        }
    }

    func reset() {
        duration = 0
        formatted = "00:00"
        begin = true
    }

    func setDisplay() {
        formatted = "00:00"
    }
}

struct DataView: View {
    @EnvironmentObject var manager: SLM
    @EnvironmentObject var timer: MyTimer

    @State var rm = FV()
    @State var duration = 0
    @State var formatted = ""

    var body: some View {
        VStack {
            Text("RunUI").font(.title).bold()
            HStack {
                Spacer()
                VStack {
                    Text("\(manager.distance / 1000)".prefix(4)).font(.system(size: 30)).bold()
                    Text("Distance").font(.system(size: 19)).bold()
                }.frame(minWidth: 90)

                Spacer()
                VStack {
                    Text("\(timer.formatted)").font(.system(size: 30)).bold()
                    // .onAppear(perform: { _ = self.timer })
                    Text("Duration").font(.system(size: 19)).bold()
                }.frame(minWidth: 90)
                Spacer()
            }
        }
    }
}









// https://stackoverflow.com/questions/56553527/show-user-location-on-map-swiftui


class Started: ObservableObject {
    @Published var didStart = false
}

class SLM: NSObject, CLLocationManagerDelegate, ObservableObject {
    @State var allow = false
    private var manager = CLLocationManager()

    @Published
    var lastLoc: CLLocation

    @Published
    var firstLoc: CLLocation

    @Published
    var distance: Double

    @Published
    var latpoints: [Double]

    @Published
    var lonpoints: [Double]


    var begin = false

    var start: CLLocation

    init(manager: CLLocationManager = CLLocationManager(), start: CLLocation) {
        self.start = start
        self.manager = manager
        self.lastLoc = CLLocation(latitude: 0.0, longitude: 0.0)
        self.firstLoc = CLLocation(latitude: 0.0, longitude: 0.0)
        self.latpoints = [Double]()
        self.lonpoints = [Double]()
        self.distance = 0.0
        super.init()
        self.startUpdate()
    }

    func startUpdate() {
        self.manager.delegate = self
        self.manager.requestWhenInUseAuthorization()
        self.manager.startUpdatingLocation()
    }

    func execute() {
        begin = true
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {


        if begin {


            if locations.last != nil {
                if let val = UserDefaults.standard.value(forKey: "done") as? String {
                    if val == "NO" { // set to NO in SceneDelegate
                        firstLoc = locations.last!
                        UserDefaults.standard.set("YES", forKey: "done")
                    }
                }

                lastLoc = locations.last!
                distance = locations.last!.distance(from: firstLoc) // from: start
                print("D \(distance)")

                latpoints.append(lastLoc.coordinate.latitude)
                lonpoints.append(lastLoc.coordinate.longitude)
            }
        }

    }


    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.startUpdatingLocation()
        }
    }

    func reset() {
        self.begin = false
        self.latpoints = [Double]()
        self.lonpoints = [Double]()
        self.distance = 0.0

        if manager.location != nil {
            self.lastLoc = manager.location!
        }
    }
}




#if DEBUG
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
        }
    }
#endif
