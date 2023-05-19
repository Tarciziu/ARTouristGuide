# Proof of Concept - Using MapKit

# Introduction
MapKit is a framework developed by Apple and used to display map or satellite imagery within your app, call out points of interest, and determine placemark information for map coordinates.

MapKit gives your app a sense of place with maps and location information. You can use MapKit framework to:
Embed maps directly into your app’s windows and views.
Add annotations and overlays to a map to call out points of interest.
Add LookAround capabilities to enable users to explore locations at street level.
Respond to user interactions with well known points of interest, geographical features, and boundaries.
Provide text completion to make it easy for users to search for a destination or point of interest.
To showcase the usability of this framework, I created a new project using Xcode as IDE. I also used the MVVM pattern to separate the UI and the logic components. The following diagram shows how this pattern is applied in this proof of concept application.

<img width="706" alt="Screenshot 2023-05-19 at 16 44 02" src="https://github.com/Tarciziu/ARTouristGuide/assets/50876642/3148b81e-d17e-4b97-8376-480182195358">

# Usage
To use MapKit, I have to import the framework in a swift file and place the Map struct inside a SwiftUI view as in the following example:
```
Map(
      coordinateRegion: $viewModel.userLocation,
      annotationItems: viewModel.locations
    ) { location in
      MapAnnotation(coordinate: location.coordinates) {
        MapPinView()
          .shadow(radius: 10)
          .onTapGesture {
            viewModel.selectedLocation = location
          }
      }
    }
```
In the code snippet displayed above, we can see that we set the current coordinate region using the user location from the view model and the annotation items which are the location that will be displayed on the map.

# UI Components
Using the MapAnnotation’s view builder parameter, we can place an item on the map based on the coordinates passed. This will add our MapPinView to the in application map. The MapPinView is a small circle with an arrow at its bottom which points to the coordinates that were passed to the annotation view.

<img width="100" src="https://github.com/Tarciziu/ARTouristGuide/blob/main/Screenshot%202023-05-19%20at%2009.51.54.png">

Other than the MapPinView, there is a LocationPrevieView which is displayed on the bottom of the screen and it looks like the one with the Bánffy Palace in the following image.

<img width="250" src="https://github.com/Tarciziu/ARTouristGuide/blob/main/Screenshot%202023-05-19%20at%2009.57.28.png">

# Location (CLLocationManager)
To get the current location, we need to implement the CLLocationManagerDelegate protocol with its locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) and locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) methods. The implementation of these methods is presented in the following code snippet:
```
internal func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
    locationStatus = status
  }

  internal func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    userLocation = MKCoordinateRegion(
      center: location.coordinate,
      span: mapSpan
    )
    locationManager.stopUpdatingLocation()
  }
```
The first method is invoked when the authorization status changes for this application. The second one is invoked when new locations are available. It is required for delivery of deferred locations. We can access the actual positions of the user using locations which is an array of CLLocation objects ordered chronologically.


# Screenshots from the app

<img width="250" src="https://github.com/Tarciziu/ARTouristGuide/blob/main/20DBDAA7-869A-4B12-9F68-260B9A52CBF2.png">

<img width="250" src="https://github.com/Tarciziu/ARTouristGuide/blob/main/F86E6171-7AB8-4715-8147-45A0F89D19EA.png">




