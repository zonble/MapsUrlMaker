import XCTest
import CoreLocation
@testable import MapsUrlMaker

final class MapsUrlMakerTests: XCTestCase {
    func testGoogleMapsNavigation() {
        let url = GoogleMapsUrlMaker.makeNavigationLink(address: "My Home", callbackUrl: "test://", startImmediately: true)
        XCTAssert(url?.absoluteString == "comgooglemaps-x-callback://?daddr=My+Home&x-success=test://&navigate=yes")
    }

    func testWazeMapsNavigation() {
        let url = WazeUrlMaker.makeNavigationLink(location: CLLocationCoordinate2D(latitude: 0, longitude: 1), startImmediately: true)
        XCTAssert(url?.absoluteString == "https://waze.com/ul?ll=0.0,1.0&navigate=yes")
    }

    static var allTests = [
        ("testGoogleMapsNavigation", testGoogleMapsNavigation),
    ]
}
