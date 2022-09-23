//
//  LocationPreviewView.swift
//  ARTouristGuide
//
//  Created by Tarciziu Gologan on 22.09.2022.
//

import SwiftUI

struct LocationPreviewView: View {
  // MARK: - Private Types
  private enum Constants {
    static let imageWidth = 100.0
    static let imageHeight = 100.0
    static let charsPerLine = 20
    static let buttonWidth = 125.0
    static let buttonHeight = 35.0
  }

  // MARK: - State Properties

  @State private var locationPreviewHeight: CGFloat = .zero

  // MARK: - Properties

  let location: LocationUIModel
  let topButtonAction: () -> Void
  let bottomButtonAction: () -> Void

  // MARK: - Body

  var body: some View {
    HStack(alignment: .bottom, spacing: 0) {
      VStack(alignment: .leading, spacing: SpacingCatalog.spacingL) {
        image
        title
      }
      Spacer()
      buttons
    }
    .padding(SpacingCatalog.spacingM)
    .frame(maxWidth: .infinity)
    .background(
      RoundedRectangle(cornerRadius: CornerRadiusCatalog.radiusM)
        .fill(.thinMaterial)
        .offset(y: Constants.imageHeight / 3)
    )
  }

  // MARK: - View Builders

  private var image: some View {
    Group {
      AsyncImage(url: location.images.first) { image in
        image
          .resizable()
          .scaledToFill()
          .frame(width: Constants.imageWidth, height: Constants.imageHeight)
          .cornerRadius(CornerRadiusCatalog.radiusL)
      } placeholder: {
        ProgressView()
          .frame(width: Constants.imageWidth, height: Constants.imageHeight)
      }
    }
    .padding(SpacingCatalog.spacingS)
    .background(ColorsCatalog.listItemBackground)
    .cornerRadius(CornerRadiusCatalog.radiusL)
  }

  private var title: some View {
    VStack(alignment: .leading, spacing: SpacingCatalog.spacingXS) {
      Text(location.name)
        .font(FontsCatalog.header5)
        .foregroundColor(ColorsCatalog.primaryText)
        .lineLimit(2)

      Text(location.cityName)
        .font(FontsCatalog.subtitleRegular)
        .foregroundColor(ColorsCatalog.primaryText)
        .lineLimit(2)
    }
  }

  private var buttons: some View {
    VStack(spacing: SpacingCatalog.spacingXL) {
      Button {
        topButtonAction()
      } label: {
        Text("Open in maps")
          .font(FontsCatalog.bodyMedium)
          .foregroundColor(ColorsCatalog.secondaryText)
          .frame(width: Constants.buttonWidth, height: Constants.buttonHeight)
      }
      .buttonStyle(.borderedProminent)
      .tint(ColorsCatalog.primaryButton)

      Button {
        bottomButtonAction()
      } label: {
        Text("Next")
          .font(FontsCatalog.bodyMedium)
          .foregroundColor(ColorsCatalog.primaryText)
          .frame(width: Constants.buttonWidth, height: Constants.buttonHeight)
      }
      .buttonStyle(.bordered)
      .tint(ColorsCatalog.secondaryButton)
    }
  }
}
