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

  private let locationManager = CLLocationManager()
  private let mapSpan = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)

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
        images: [
          ImageSource.url(URL(string: "https://en.wikipedia.org/wiki/Matthias_Corvinus_Monument#/media/File:Oameni_si_lalele_-_Cluj-Napoca,_Piata_Unirii._Statuia_lui_Matei_Corvin.jpg")!)

        ],
        learnMoreLink: URL(string: "https://en.wikipedia.org/wiki/Matthias_Corvinus_Monument")!)
    ]
  }

  private func updateMapRegion(location: LocationUIModel) {
    userLocation = MKCoordinateRegion(center: location.coordinates, span: mapSpan)
  }

  func selectLocation(_ location: LocationUIModel) {
    selectedLocation = location
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
