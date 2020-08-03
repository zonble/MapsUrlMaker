import Foundation

struct MapsUrlMaker {

    /// Makes a link to start navigation on Google Maps app.
    ///
    /// See https://developers.google.com/maps/documentation/urls/ios-urlscheme#add_navigation_to_your_app
    /// 
    /// - Parameters:
    ///   - address: The address.
    ///   - callbackUrl: The callback URL.
    ///   - startImmediately: If Google Maps should strat navigation immediately.
    /// - Returns: A URL.
    static func makeNavigationUrl(address: String, callbackUrl: String?, startImmediately: Bool) -> URL? {
        let addressText = address.replacingOccurrences(of: " ", with: "+")
        var components = URLComponents()
        components.scheme = "comgooglemaps-x-callback"
        components.host = ""
        components.queryItems = [
            URLQueryItem(name: "daddr", value: addressText),
            URLQueryItem(name: "x-success", value: callbackUrl),
            URLQueryItem(name: "navigate", value: startImmediately ? "yes" : nil),
        ]
        return components.url
    }
}
