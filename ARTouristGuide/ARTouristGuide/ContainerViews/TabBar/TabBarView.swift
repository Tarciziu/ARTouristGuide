//
//  TabBarView.swift
//  Crypto
//
//  Created by Tarciziu Gologan on 27.07.2022.
//

import SwiftUI

typealias Action = (any View) -> Void

struct TabBarView: View {
  // MARK: - Environment Variables

  @EnvironmentObject var configuration: TabBarConfiguration

  // MARK: - Private Properties
  
  private let tabs: [TabBarItem]
  @Binding private var selectedTab: TabBarItem
  
  private let backgroundID = "backgroundID"
  @Namespace private var namespace

  // MARK: - Computed Properties

  private var selectedItemBackgroundColor: Color {
    .black
  }

  private var backgroundGradient: LinearGradient {
    LinearGradient(
      colors: [
        ColorsCatalog.tabbarPrimary,
        ColorsCatalog.tabbarSecondary
      ],
      startPoint: .leading,
      endPoint: .trailing)
  }

  private var selectedItemColor: Color {
    ColorsCatalog.tabbarSelected
  }

  private var unselectedItemColor: Color {
    ColorsCatalog.tabbarUnselected
  }

  private var longPressGesture: some Gesture {
    LongPressGesture(minimumDuration: configuration.longPressGestureDuration)
      .onEnded { _ in
        configuration.onLastItemLongPress()
      }
  }

  // MARK: - Init

  public init(
    tabs: [TabBarItem],
    selectedTab: Binding<TabBarItem>
  ) {
    self.tabs = tabs
    self._selectedTab = selectedTab
  }

  // MARK: - Body
  
  var body: some View {
    HStack {
      ForEach(tabs, id: \.self) { tab in
        if tab != tabs.last {
          makeTabItem(tab: tab)
        } else {
          makeTabItem(tab: tab)
            .simultaneousGesture(longPressGesture)
        }
      }
    }
    .padding(4)
    .background(Capsule().fill(backgroundGradient))
    .padding(8)
    .shadow(color: .black.opacity(0.3), radius: 10)
    .padding(.horizontal)
  }

  @ViewBuilder private func makeTabItem(tab: TabBarItem) -> some View {
    makeTabIcon(tab: tab)
      .onTapGesture {
        switchToTab(tab: tab)
      }
    if tab != tabs.last {
      Spacer()
    }
  }

  @ViewBuilder private func makeTabIcon(tab: TabBarItem) -> some View {
    Image(tab.iconName)
      .resizable()
      .frame(width: 24, height: 24)
      .foregroundColor(selectedTab == tab ? selectedItemColor : unselectedItemColor)
      .padding()
      .background(
        ZStack {
          if selectedTab == tab {
            makeSelectorBackground()
          }
        }
      )
  }

  @ViewBuilder private func makeSelectorBackground() -> some View {
    Circle()
      .fill(.black)
      .matchedGeometryEffect(
        id: backgroundID,
        in: namespace)
  }
}

// MARK: - Event Handlers

extension TabBarView {
  private func switchToTab(tab: TabBarItem) {
    withAnimation {
      selectedTab = tab
    }
  }
}
