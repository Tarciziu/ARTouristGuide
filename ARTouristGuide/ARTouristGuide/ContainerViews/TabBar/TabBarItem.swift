//
//  TabBarItem.swift
//  Crypto
//
//  Created by Tarciziu Gologan on 27.07.2022.
//

import SwiftUI

public enum TabBarItem: Hashable {
  case primary, secondary, tertiary
  
  public var iconName: String {
    switch self {
    case .primary:
      return "Map"
    case .secondary:
      return "Camera"
    case .tertiary:
      return "Visited"
    }
  }
}
