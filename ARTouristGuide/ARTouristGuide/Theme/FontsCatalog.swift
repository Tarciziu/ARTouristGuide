//
//  FontsCatalog.swift
//  ARTouristGuide
//
//  Created by Tarciziu Gologan on 20.09.2022.
//

import SwiftUI

enum FontsCatalog {
  static let header3 = Font.custom("ProximaNovaT-Bold", size: 32, relativeTo: .largeTitle)
  static let header4 = Font.custom("ProximaNovaT-Bold", size: 24, relativeTo: .largeTitle)
  static let header5 = Font.custom("ProximaNovaT-Bold", size: 20, relativeTo: .title2)
  static let subtitleBold = Font.custom("ProximaNovaT-Bold", size: 16, relativeTo: .headline)
  static let subtitleMedium = Font.custom("ProximaNovaT-Semibold", size: 16, relativeTo: .body)
  static let subtitleRegular = Font.custom("ProximaNovaT-Regular", size: 16, relativeTo: .body)
  static let bodyMedium = Font.custom("ProximaNovaT-Semibold", size: 14, relativeTo: .subheadline)
  static let bodyRegular = Font.custom("ProximaNovaT-Regular", size: 14, relativeTo: .subheadline)
}
