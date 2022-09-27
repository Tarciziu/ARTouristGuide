//
//  CameraView.swift
//  ARTouristGuide
//
//  Created by Tarciziu Gologan on 20.09.2022.
//

import SwiftUI
import CodeScanner

struct CameraView: View {
  // MARK: - Nested Types

  private enum Constants {
    static let arCameraImageString = "Camera"
    static let qrCameraImageString = "QRCamera"
    static let imageHeight: CGFloat = 40
    static let imageWidth: CGFloat = 40
  }

  // MARK: - State Properties

  @StateObject private var arViewModel : ARViewModel = ARViewModel()
  @State var isPresentingQRScannerView = true
  @Environment(\.openURL) var openURL

  // MARK: - Body

  var body: some View {
    ZStack {
      if isPresentingQRScannerView{
        CodeScannerView(codeTypes: [.qr], completion: handleQRCodeScan)
      } else {
        ARViewContainer(arViewModel: arViewModel)
          .edgesIgnoringSafeArea(.all)
      }
      switchCameraView
    }
  }

  // MARK: - View Builders

  private var switchCameraView: some View {
    VStack {
      HStack {
        Spacer()
        Button {
          isPresentingQRScannerView.toggle()
        } label: {
          cameraImage
        }
      }
      .frame(maxWidth: .infinity)
      Spacer()
    }
    .padding(SpacingCatalog.spacingXL)
  }

  private var cameraImage: some View {
    VStack {
      if isPresentingQRScannerView {
        Image(Constants.arCameraImageString)
          .resizable()
          .foregroundColor(ColorsCatalog.dark)
      } else {
        Image(Constants.qrCameraImageString)
          .resizable()
          .foregroundColor(ColorsCatalog.dark)
      }
    }
    .frame(width: Constants.imageWidth, height: Constants.imageHeight)
  }

  // MARK: - Event Handlers

  private func handleQRCodeScan(result: Result<ScanResult, ScanError>) {
    switch result {
    case .success(let value):
      if let url = URL(string: value.string) {
        openURL(url)
      }
    case .failure(let error):
      debugPrint(error)
    }
  }
}
