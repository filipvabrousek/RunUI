//
//  ActivityView.swift
//  RunFun
//
//  Created by Filip Vabroušek on 13/07/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI

struct ContentView : View {
    var body: some View {
        TabView {
            ActivityView().tabItem {Image("circle"); Text("Run")}.tag(0)
            DetailView().tabItem {Image("circle"); Text("Runs")}.tag(1)
            FeedView().tabItem {Image("circle"); Text("Feed")}.tag(2)
            Forma().tabItem {Image("circle"); Text("Shop")}.tag(3)
            AnimationView().tabItem{Image("circle"); Text("Animation")}.tag(4)
        }
        .onAppear(perform: {UserDefaults.standard.set("NO", forKey: "done")})
    }
}
