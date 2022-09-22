//
//  MapPinView.swift
//  ARTouristGuide
//
//  Created by Tarciziu Gologan on 22.09.2022.
//

import SwiftUI

struct MapPinView: View {
  private enum Constants {
    static let pinTopIconSize = 30.0
    static let pinBottomIconSize = 10.0
    static let triangleRotation = 180.0
    static let triangleOffset = -3.0
    static let bottomPadding = pinTopIconSize + pinBottomIconSize
  }

  var body: some View {
    VStack(spacing: 0) {
      Image(systemName: "map.circle.fill")
        .resizable()
        .scaledToFit()
        .frame(
          width: Constants.pinTopIconSize,
          height: Constants.pinTopIconSize
        )
        .font(.headline)
        .foregroundColor(.white)
        .padding(SpacingCatalog.spacingM)
        .background(ColorsCatalog.mapPinColor)
        .cornerRadius(CornerRadiusCatalog.radiusXXL)

      Image(systemName: "triangle.fill")
        .resizable()
        .scaledToFit()
        .frame(
          width: Constants.pinBottomIconSize,
          height: Constants.pinBottomIconSize
        )
        .foregroundColor(ColorsCatalog.mapPinColor)
        .rotationEffect(Angle(degrees: Constants.triangleRotation))
        .offset(y: Constants.triangleOffset)
        .padding(.bottom, Constants.bottomPadding)
    }
  }
}
