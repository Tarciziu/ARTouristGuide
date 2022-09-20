//
//  ARViewContainer.swift
//  ARTouristGuide
//
//  Created by Tarciziu Gologan on 20.09.2022.
//

import RealityKit
import SwiftUI

struct ARViewContainer: UIViewRepresentable {
  var arViewModel: ARViewModel
  private let augmentedView = ARView()
  
  func makeUIView(context: Context) -> ARView {
    return augmentedView
  }
  
  func updateUIView(_ uiView: ARView, context: Context) {}
  
}
