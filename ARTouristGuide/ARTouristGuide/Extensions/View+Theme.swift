//
//  View+Theme.swift
//  ARTouristGuide
//
//  Created by Tarciziu Gologan on 23.09.2022.
//

import SwiftUI

extension View {
  func shadow(with shadowStyle: ShadowStyle) -> some View {
    self
      .shadow(color: shadowStyle.color, radius: shadowStyle.radius)
  }
}
