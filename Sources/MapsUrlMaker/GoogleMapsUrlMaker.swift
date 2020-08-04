
import Foundation
import CoreLocation


/// Modes for Google Maps/
public enum GoogleMapMode: String {
    /// The standard mode.
    case standard = "standard"
    /// The street view mode.
    case streetview = "streetview"
}

public struct GoogleMapViews: OptionSet, Sequence {
    public init(rawValue: Int) {
        self.rawValue = rawValue
        self.name = ""
    }


    /// Creates a new GoogleMapViews with given parameters.
    ///
    /// - Parameters:
    ///   - rawValue: The raw value.
    ///   - name: The name of the option.
    public init(rawValue: Int, name: String) {
        self.rawValue = rawValue
        self.name = name
    }

    public var rawValue: Int

    /// The name of the option.
    public var name: String

    /// The satellite view
    public static let satellite = GoogleMapViews(rawValue: 1 << 0, name: "satellite")
    /// The traffic view.
    public static let traffic = GoogleMapViews(rawValue: 1 << 1, name: "traffic")
    /// The transit view.
    public static let transit = GoogleMapViews(rawValue: 1 << 2, name: "transit")
    /// All available options.
    public static let all: GoogleMapViews = [.satellite, .traffic, .transit]

    func stringRrepresentation() -> String {
        GoogleMapViews.all.filter { view in
            self.contains(view)
        }.map {view in view.name}.joined(separator: ",")
    }
}

/// Makes URLs for Google Maps.
public struct GoogleMapsUrlMaker {

    /// Makes a universal link for Google Maps.
    ///
    /// See https://developers.google.com/maps/documentation/urls/ios-urlscheme#universal_links_and_google_maps
    /// - Parameters:
    ///   - location: The location of the center of the map.
    ///   - zoomLevel: The zoom level.
    /// - Returns: A URL.
    public static func makeUniversalLink(location: CLLocationCoordinate2D, zoomLevel: Int) -> URL? {
        let str = "https://www.google.com/maps/@\(location.latitude),\(location.longitude),\(zoomLevel)z"
        return URL(string: str)
    }

    /// Makes a link for Google Map.
    ///
    /// See https://developers.google.com/maps/documentation/urls/ios-urlscheme#add_navigation_to_your_app
    ///
    /// - Parameters:
    ///   - center: Center of the map.
    ///   - zoomLevel: The zoom level.
    ///   - mode: The map mode.
    ///   - view: Turns various views on or off.
    ///   - callbackUrl: The callback URL.
    /// - Returns: A URL.
    public static func makeMapLink(center: CLLocationCoordinate2D, zoomLevel: Int = 16, mode: GoogleMapMode = .standard, view: GoogleMapViews = [], callbackUrl: String? = nil) -> URL? {

        var components = URLComponents()
        components.scheme = callbackUrl != nil ? "comgooglemaps-x-callback" : "comgooglemaps"
        components.host = ""
        var queryItems = [
            URLQueryItem(name: "center", value: "\(center.latitude),\(center.longitude)"),
            URLQueryItem(name: "zoom", value: "\(zoomLevel)"),
            URLQueryItem(name: "views", value: view.stringRrepresentation()),
            URLQueryItem(name: "mapmode", value: mode.rawValue),
        ]
        if callbackUrl != nil {
            queryItems.append(URLQueryItem(name: "x-success", value: callbackUrl))
        }
        components.queryItems = queryItems
        return components.url
    }

    /// Makes a link to start navigation on Google Maps app.
    ///
    /// See https://developers.google.com/maps/documentation/urls/ios-urlscheme#add_navigation_to_your_app
    ///
    /// - Parameters:
    ///   - address: The address.
    ///   - callbackUrl: The callback URL.
    ///   - startImmediately: If Google Maps should strat navigation immediately.
    /// - Returns: A URL.
    public static func makeNavigationLink(address: String, callbackUrl: String? = nil, startImmediately: Bool = true) -> URL? {
        let addressText = address.replacingOccurrences(of: " ", with: "+")
        var components = URLComponents()
        components.scheme = callbackUrl != nil ? "comgooglemaps-x-callback" : "comgooglemaps"
        components.host = ""
        var queryItems = [
            URLQueryItem(name: "daddr", value: addressText),
            URLQueryItem(name: "navigate", value: startImmediately ? "yes" : nil),
        ]
        if callbackUrl != nil {
            queryItems.append(URLQueryItem(name: "x-success", value: callbackUrl))
        }
        components.queryItems = queryItems
        return components.url
    }
}
