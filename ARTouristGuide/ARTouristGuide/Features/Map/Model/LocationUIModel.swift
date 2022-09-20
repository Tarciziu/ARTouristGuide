//
//  LocationUIModel.swift
//  ARTouristGuide
//
//  Created by Tarciziu Gologan on 20.09.2022.
//

import SwiftUI
import CoreLocation

struct LocationUIModel: Identifiable {
  let id = UUID()
  let name: String
  let cityName: String
  let coordinates: CLLocationCoordinate2D
  let description: String
  let images: [ImageSource]
  let learnMoreLink: [URL]
}
