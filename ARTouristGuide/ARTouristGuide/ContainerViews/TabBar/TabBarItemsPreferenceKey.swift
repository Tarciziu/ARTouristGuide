//
//  TabBarItemsPreferenceKey.swift
//  Crypto
//
//  Created by Tarciziu Gologan on 27.07.2022.
//

import SwiftUI

public struct TabBarItemsPreferenceKey: PreferenceKey {
  public static var defaultValue: [TabBarItem] = []
  
  public static func reduce(value: inout [TabBarItem], nextValue: () -> [TabBarItem]) {
    value += nextValue()
  }
}

public struct TabBarItemViewModifier: ViewModifier {

  @Binding private var selectedTab: TabBarItem
  private let tab: TabBarItem

  public init(tab: TabBarItem, selectedTab: Binding<TabBarItem>) {
    self.tab = tab
    self._selectedTab = selectedTab
  }
  
  public func body(content: Content) -> some View {
    content
      .opacity(selectedTab == tab ? 1.0 : 0.0)
      .preference(key: TabBarItemsPreferenceKey.self, value: [tab])
  }
}

public extension View {
  func tabBarItem(tab: TabBarItem, selectedTab: Binding<TabBarItem>) -> some View {
    self
      .modifier(TabBarItemViewModifier(tab: tab, selectedTab: selectedTab))
  }
}
