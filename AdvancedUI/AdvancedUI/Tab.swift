//
//  Tab.swift
//  AdvancedUI
//
//  Created by Filip Vabroušek on 30/09/2019.
//  Copyright © 2019 Filip Vabroušek. All rights reserved.
//

import SwiftUI

struct Tab: View {
    var body: some View {
        TabView {
            GProxy().tabItem { Image(systemName: "heart"); Text("Proxy") }.tag(0)
            GeometryEf().tabItem { Image(systemName: "heart"); Text("Effect") }.tag(1)
            CircleView().tabItem { Image(systemName: "heart"); Text("Circles") }.tag(2)
            SidesView().tabItem { Image(systemName: "heart"); Text("Sides") }.tag(3)
            AlignView().tabItem { Image(systemName: "heart"); Text("Align") }.tag(4)
           
            // if we added 6th View, more button allowing us to choose it, would be shown
            // TransitionView().tabItem { Image(systemName: "heart"); Text("Transition") }.tag(4)
        }
    }
}

struct Tab_Previews: PreviewProvider {
    static var previews: some View {
        Tab()
    }
}
