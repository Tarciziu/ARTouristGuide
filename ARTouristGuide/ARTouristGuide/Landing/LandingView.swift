//
//  LandingView.swift
//  ARTouristGuide
//
//  Created by Tarciziu Gologan on 20.09.2022.
//

import SwiftUI

struct LandingView: View {
    var body: some View {
      TabView {
        Text("First")
          .tabItem {
            Image(systemName: "square")
          }

        Text("Second")
          .tabItem {
            Image(systemName: "circle")
          }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
    }
}
