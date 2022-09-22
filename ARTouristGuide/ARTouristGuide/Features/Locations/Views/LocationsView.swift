//
//  LocationsView.swift
//  ARTouristGuide
//
//  Created by Tarciziu Gologan on 20.09.2022.
//

import SwiftUI
import MapKit

struct LocationsView: View {
  @StateObject private var viewModel = LocationsViewModel()
  @State private var isPresentingLocations = false

  // MARK: - Body

  var body: some View {
    ZStack {
      Map(coordinateRegion: $viewModel.userLocation)
        .ignoresSafeArea()
      locationsList
    }
  }

  // MARK: - ViewBuilders

  private var locationsList: some View {
    VStack {
      VStack {
        makeLocation(location: viewModel.selectedLocation)
        if isPresentingLocations {
          ForEach(viewModel.locations) { location in
            if location != viewModel.selectedLocation {
              makeLocationItem(location: location)
                .onTapGesture {
                  isPresentingLocations = false
                  viewModel.selectedLocation = location
                }
            }
          }
        }
      }
      .background(ColorsCatalog.listItemBackground)
      .cornerRadius(CornerRadiusCatalog.radiusS)
      .padding(SpacingCatalog.spacingXL)
      Spacer()
    }
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
    .contentShape(Rectangle())
    .onTapGesture {
      isPresentingLocations.toggle()
    }
  }

  private func makeLocationItem(location: LocationUIModel) -> some View {
    Text(location.name)
      .foregroundColor(ColorsCatalog.primaryText)
      .font(FontsCatalog.header5)
      .padding(.vertical, SpacingCatalog.spacingM)
  }

  private var locationItemPlaceholder: some View {
    Text(viewModel.locationPlaceholder)
      .foregroundColor(ColorsCatalog.primaryText)
      .font(FontsCatalog.header5)
      .padding(.vertical, SpacingCatalog.spacingM)
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
