//
//  TabBarContainerView.swift
//  Crypto
//
//  Created by Tarciziu Gologan on 27.07.2022.
//

import SwiftUI

// MARK: - TabBarConfiguration Definition

/// Type responsible for containing the configurable parameters used by a FloatingBottomBar component.
public class TabBarConfiguration: ObservableObject {
  // MARK: - Published Properties

  @Published public var selectedTab: TabBarItem = .primary

  /// Action executed every time a new tab is selected.
  @Published public var onSelectedTab: (Int) -> Void = { _ in }

  /// Action executed when a long press gesture was detected on the last tab item.
  @Published public var onLastItemLongPress: () -> Void = {}

  /// The minimum duration of a long press gesture recognised by the view.
  @Published public var longPressGestureDuration: Double = 2

  /// True if bar should be active (visible and interactive), false otherwise.
  @Published public var isActive = true

  // MARK: - Init

  public init() { }
}

public struct TabBarContainerView<Content>: View where Content: View {
  typealias Action = (any View) -> Void

  @EnvironmentObject private var configuration: TabBarConfiguration
  let content: Content
  @State private var tabs: [TabBarItem] = []

  public init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  public var body: some View {
    ZStack {
      content
        .animation(.default, value: configuration.selectedTab)
      VStack {
        Spacer()
        TabBarView(
          tabs: tabs,
          selectedTab: $configuration.selectedTab)
        .environmentObject(configuration)
      }
    }
    .frame(maxWidth: .infinity, maxHeight: .infinity)
    .onPreferenceChange(TabBarItemsPreferenceKey.self) { value in
      self.tabs = value
    }
  }
}
