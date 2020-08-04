import Foundation
import CoreLocation

/// Makes URL for Waze.
struct WazeUrlMaker {

    /// Makes a link to start navigation on Waze.
    ///
    /// https://developers.google.com/waze/deeplinks
    ///
    /// - Parameters:
    ///   - location: The location.
    ///   - startImmediately: If Waze should strat navigation immediately.
    /// - Returns: A URL.
    public static func makeNavigationLink(location: CLLocationCoordinate2D, startImmediately: Bool) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "waze.com"
        components.path = "/ul"
        components.queryItems = [
            URLQueryItem(name: "ll", value: "\(location.latitude),\(location.longitude)"),
            URLQueryItem(name: "navigate", value: startImmediately ? "yes" : nil),
        ]
        return components.url
    }
}
