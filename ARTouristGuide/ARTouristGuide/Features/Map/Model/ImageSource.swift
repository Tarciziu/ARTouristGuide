//
//  ImageSource.swift
//  ARTouristGuide
//
//  Created by Tarciziu Gologan on 20.09.2022.
//

import Foundation

enum ImageSource: Hashable {
  case url(URL)
  case asset(String)
  case system(String)
  case placeholder
}
