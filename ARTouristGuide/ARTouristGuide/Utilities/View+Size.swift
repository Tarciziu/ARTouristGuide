//
//  SizeReader.swift
//  ARTouristGuide
//
//  Created by Tarciziu Gologan on 22.09.2022.
//

import SwiftUI

extension View {
  func readViewSize(perform: @escaping (CGSize) -> Void) -> some View {
    self
      .background(
        GeometryReader { geo -> Color in
          DispatchQueue.main.async {
            perform(geo.size)
          }
          return Color.clear
        }
      )
  }
}
