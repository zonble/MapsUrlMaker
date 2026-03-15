# MapsUrlMaker

MapsUrlMaker is a Swift package that helps you build deep-link URLs for navigation apps — currently **Google Maps** and **Waze**. It handles URL scheme construction so you can open the relevant app (or a web fallback) with minimal boilerplate.

## Requirements

- Swift 5.2+
- iOS 13.0+ / macOS 10.15+ (any Apple platform that ships `CoreLocation`)

## Installation

### Swift Package Manager

Add the dependency to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/zonble/MapsUrlMaker.git", from: "1.0.0"),
],
```

Then add `"MapsUrlMaker"` to the target that needs it:

```swift
.target(
    name: "MyTarget",
    dependencies: ["MapsUrlMaker"]
),
```

## Usage

### Google Maps

#### Universal link (open in browser or app)

```swift
import CoreLocation
import MapsUrlMaker

let coordinate = CLLocationCoordinate2D(latitude: 25.0478, longitude: 121.5318)
if let url = GoogleMapsUrlMaker.makeUniversalLink(location: coordinate, zoomLevel: 15) {
    UIApplication.shared.open(url)
}
```

#### Open Google Maps app at a specific location

```swift
let coordinate = CLLocationCoordinate2D(latitude: 25.0478, longitude: 121.5318)
if let url = GoogleMapsUrlMaker.makeMapLink(
    center: coordinate,
    zoomLevel: 16,
    mode: .standard,
    view: [.satellite, .traffic]
) {
    UIApplication.shared.open(url)
}
```

Available `GoogleMapMode` values:

| Value | Description |
|-------|-------------|
| `.standard` | The standard map view (default) |
| `.streetview` | Street View mode |

Available `GoogleMapViews` option-set values:

| Value | Description |
|-------|-------------|
| `.satellite` | Satellite imagery layer |
| `.traffic` | Live traffic layer |
| `.transit` | Public-transit layer |

#### Start turn-by-turn navigation

```swift
if let url = GoogleMapsUrlMaker.makeNavigationLink(
    address: "1600 Amphitheatre Parkway, Mountain View, CA",
    callbackUrl: "myapp://",   // optional — return to your app when done
    startImmediately: true
) {
    UIApplication.shared.open(url)
}
```

### Waze

```swift
let coordinate = CLLocationCoordinate2D(latitude: 25.0478, longitude: 121.5318)
if let url = WazeUrlMaker.makeNavigationLink(
    location: coordinate,
    zoomLevel: 16,
    startImmediately: true
) {
    UIApplication.shared.open(url)
}
```

## References

- [Google Maps URL Scheme for iOS](https://developers.google.com/maps/documentation/urls/ios-urlscheme)
- [Waze Deep Links](https://developers.google.com/waze/deeplinks)

## License

MapsUrlMaker is available under the MIT license.
