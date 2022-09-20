//
//  LandingView.swift
//  ARTouristGuide
//
//  Created by Tarciziu Gologan on 20.09.2022.
//

import SwiftUI

struct LandingView: View {
  @StateObject var tabBarConfiguration = TabBarConfiguration()
  var body: some View {
    TabBarContainerView {
      MapView()
        .tabBarItem(tab: .primary, selectedTab: $tabBarConfiguration.selectedTab)
      CameraView()
        .tabBarItem(tab: .secondary, selectedTab: $tabBarConfiguration.selectedTab)
      VisitedView()
        .tabBarItem(tab: .tertiary, selectedTab: $tabBarConfiguration.selectedTab)
    }
    .environmentObject(tabBarConfiguration)
  }
}
