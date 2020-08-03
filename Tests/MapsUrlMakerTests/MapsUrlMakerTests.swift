import XCTest
@testable import MapsUrlMaker

final class MapsUrlMakerTests: XCTestCase {
    func testGoogleMapsNavigation() {
        let url = MapsUrlMaker.makeNavigationUrl(address: "My Home", callbackUrl: "test://", startImmediately: true)
        XCTAssert(url?.absoluteString == "comgooglemaps-x-callback://?daddr=My+Home&x-success=test://&navigate=yes")
    }

    static var allTests = [
        ("testExample", testGoogleMapsNavigation),
    ]
}
