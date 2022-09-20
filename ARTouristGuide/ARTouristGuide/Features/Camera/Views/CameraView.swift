//
//  CameraView.swift
//  ARTouristGuide
//
//  Created by Tarciziu Gologan on 20.09.2022.
//

import SwiftUI

struct CameraView: View {
  @StateObject private var arViewModel : ARViewModel = ARViewModel()

  var body: some View {
    ARViewContainer(arViewModel: arViewModel)
      .edgesIgnoringSafeArea(.all)
  }
}
