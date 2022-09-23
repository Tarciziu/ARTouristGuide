//
//  LocationsView.swift
//  ARTouristGuide
//
//  Created by Tarciziu Gologan on 20.09.2022.
//

import SwiftUI
import MapKit

struct LocationsView: View {
  // MARK: - State Properties

  @StateObject private var viewModel = LocationsViewModel()
  @State private var isPresentingLocations = false
  @State private var scrollViewChildSize: CGSize = .zero

  // MARK: - Private Properties

  @Namespace private var namespace
  @Environment(\.openURL) private var openURL

  // MARK: - Body

  var body: some View {
    ZStack(alignment: .top) {
      mapLayer
        .ignoresSafeArea()
      locationHeader
        .frame(maxHeight: UIScreen.main.bounds.height / 2, alignment: .top)
      locationPreview
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(SpacingCatalog.spacingL)
    }
  }

  // MARK: - View Builders

  private var mapLayer: some View {
    Map(coordinateRegion: $viewModel.userLocation,
        annotationItems:viewModel.locations) { location in
      MapAnnotation(coordinate: location.coordinates) {
        MapPinView()
          .shadow(radius: 10)
          .onTapGesture {
            viewModel.selectedLocation = location
          }
      }
    }
        .matchedGeometryEffect(id: String(describing: self), in: namespace)
        .animation(.default, value: viewModel.selectedLocation)
        .animation(.default, value: isPresentingLocations)
  }

  private var locationHeader: some View {
    VStack(spacing: 0) {
      VStack(spacing: 0) {
        makeLocation(location: viewModel.selectedLocation)
        if isPresentingLocations {
          locationsList
        }
      }
      .background(ColorsCatalog.listItemBackground)
      .cornerRadius(CornerRadiusCatalog.radiusS)
      .padding(.horizontal, SpacingCatalog.spacingXL)
    }
  }

  private var locationsList: some View {
    ScrollView(showsIndicators: false) {
      ForEach(viewModel.locations) { location in
        if location != viewModel.selectedLocation {
          makeLocationItem(location: location)
            .onTapGesture {
              isPresentingLocations = false
              viewModel.selectedLocation = location
            }
        }
      }
      .readViewSize { size in
        scrollViewChildSize = size
      }
    }
    .frame(maxHeight: scrollViewChildSize.height)
  }

  private var locationPreview: some View {
    Group {
      Group {
        if let selectedLocation = viewModel.selectedLocation {
          LocationPreviewView(
            location: selectedLocation,
            topButtonAction: {
              if let validURL = URL(string: viewModel.getLocationString()) {
                openURL(validURL)
              }
            },
            bottomButtonAction: viewModel.selectNextLocation
          )
        }
        Spacer()
      }
      .frame(maxHeight: UIScreen.main.bounds.height / 2)
    }
    .frame(maxHeight: UIScreen.main.bounds.height / 2, alignment: .bottom)
    .shadow(radius: 10)
  }

  private func makeLocation(location: LocationUIModel?) -> some View {
    VStack {
      Group {
        if let location = location {
          makeLocationItem(location: location)
        } else {
          locationItemPlaceholder
        }
      }
      .frame(maxWidth: .infinity)
      .overlay(alignment: .trailing) {
        arrow
      }
    }
    .onTapGesture {
      isPresentingLocations.toggle()
    }
  }

  private func makeLocationItem(location: LocationUIModel) -> some View {
    HStack {
      Text(location.name)
        .foregroundColor(ColorsCatalog.primaryText)
        .font(FontsCatalog.header5)
        .contentShape(Rectangle())
        .padding(.vertical, SpacingCatalog.spacingL)
    }
    .frame(maxWidth: .infinity)
  }

  private var locationItemPlaceholder: some View {
    Text(viewModel.locationPlaceholder)
      .foregroundColor(ColorsCatalog.primaryText)
      .font(FontsCatalog.header5)
      .contentShape(Rectangle())
      .padding(.vertical, SpacingCatalog.spacingL)
      .frame(maxWidth: .infinity)
  }

  private var arrow: some View {
    VStack {
      if isPresentingLocations {
        unselectedArrow
      } else {
        selectedArrow
      }
    }
  }

  private var selectedArrow: some View {
    Image(systemName: "arrow.down")
      .padding(.horizontal, SpacingCatalog.spacingM)
  }

  private var unselectedArrow: some View {
    Image(systemName: "arrow.forward")
      .padding(.horizontal, SpacingCatalog.spacingM)
  }
}
