//
//  LocationsViewModel.swift
//  ARTouristGuide
//
//  Created by Tarciziu Gologan on 20.09.2022.
//

import Foundation
import MapKit

class LocationsViewModel: NSObject, ObservableObject, CLLocationManagerDelegate {
  // MARK: - Published Properties

  @Published var locations: [LocationUIModel] = []
  @Published var locationStatus: CLAuthorizationStatus?
  @Published var selectedLocationIndex = -1
  @Published var selectedLocation: LocationUIModel? {
    didSet {
      if let selectedLocation = selectedLocation {
        updateMapRegion(location: selectedLocation)
      }
    }
  }
  @Published var userLocation = MKCoordinateRegion()

  // MARK: - Public Properties

  let locationPlaceholder = "Select a location"

  // MARK: - Private Properties

  private enum Constants {
    static let selectedLocationSpan = 0.001
    static let defaultSpan = 0.1
  }

  private let locationManager = CLLocationManager()
  private let mapSpan = MKCoordinateSpan(
    latitudeDelta: Constants.defaultSpan,
    longitudeDelta: Constants.defaultSpan
  )
  private let selectedLocationSpan = MKCoordinateSpan(
    latitudeDelta: Constants.selectedLocationSpan,
    longitudeDelta: Constants.selectedLocationSpan
  )

  // MARK: - Init

  override init() {
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.startUpdatingLocation()

    locations = [
      LocationUIModel(
        name: "Matthias Corvinus Monument",
        cityName: "Cluj-Napoca",
        coordinates: CLLocationCoordinate2D(latitude: 46.76955, longitude: 23.58984),
        description: "The Matthias Corvinus Monument is a monument in Cluj-Napoca, Romania. This classified historic monument, conceived by Janos Fadrusz and opened in 1902, represents Matthias Corvinus.",
        images: [URL(string: "https://upload.wikimedia.org/wikipedia/commons/9/95/Statuia_lui_Matei_Corvin_la_apus.jpg")!
        ],
        learnMoreLink: URL(string: "https://en.wikipedia.org/wiki/Matthias_Corvinus_Monument")!),
      LocationUIModel(
        name: "Botanical Garden",
        cityName: "Cluj-Napoca",
        coordinates: CLLocationCoordinate2D(latitude: 46.762671, longitude: 23.588542),
        description: "The Cluj-Napoca Botanical Garden, officially Alexandru Borza Cluj-Napoca University Botanic Garden, is a botanical garden located in the south part of Cluj-Napoca, Romania. It was founded in 1872 by Brassai Samuel. Its director in 1905 was Aladár Richter, than Páter Béla, Győrffy István and than overtaken 1920 by the local university, and by Alexandru Borza.",
        images: [
          URL(string: "https://upload.wikimedia.org/wikipedia/commons/f/fb/Botanic_Garden_Cluj-Napoca_4.jpg")!,
          URL(string: "https://cdn.knd.ro/media/521/2863/554/20015389/1/cluj.jpg?width=900&height=666&quality=80")!
        ],
        learnMoreLink: URL(string: "https://en.wikipedia.org/wiki/Cluj-Napoca_Botanical_Garden")!)
    ]
  }

  private func updateMapRegion(location: LocationUIModel) {
    userLocation = MKCoordinateRegion(
      center: location.coordinates,
      span: selectedLocationSpan
    )
    selectedLocationIndex = locations.firstIndex(where: { place in
      place == location
    }) ?? -1
  }

  func selectLocation(_ location: LocationUIModel) {
    selectedLocation = location
  }

  func selectNextLocation() {
    selectedLocationIndex = locations.count - 1 > selectedLocationIndex ? selectedLocationIndex + 1 : 0
    selectedLocation = locations[selectedLocationIndex]
  }

  func getLocationString() -> String {
    let url = "maps://?daddr=\(selectedLocation?.coordinates.latitude ?? 0),\(selectedLocation?.coordinates.longitude ?? 0)"
    return url
  }

  var statusString: String {
    guard let status = locationStatus else {
      return "unknown"
    }

    switch status {
    case .notDetermined: return "notDetermined"
    case .authorizedWhenInUse: return "authorizedWhenInUse"
    case .authorizedAlways: return "authorizedAlways"
    case .restricted: return "restricted"
    case .denied: return "denied"
    default: return "unknown"
    }
  }

  internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    locationStatus = status
    print(#function, statusString)
  }

  internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    userLocation = MKCoordinateRegion(
      center: location.coordinate,
      span: mapSpan
    )
    print(#function, location)
    locationManager.stopUpdatingLocation()
  }
}
