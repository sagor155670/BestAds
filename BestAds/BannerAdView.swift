//
//  BannerAdView.swift
//  BestAds
//
//  Created by Saiful Islam Sagor on 19/10/23.
//

import Foundation
import SwiftUI
import GoogleMobileAds

// Define a SwiftUI view that displays a banner ad using Google AdMob
struct BannerAdView: View {
    let adUnit: AdUnit // The ad unit to be used
    let adFormat: AdFormat // The ad format to be used
    @State var adStatus: AdStatus = .loading // The status of the ad (loading, success, or failure)
    @State var showAd: Bool = true // Whether to show the ad or not
    
    // Define the body of the view
    var body: some View {
        HStack {
            if showAd {
                // Reserve the ad space while the ad is loading
                if adStatus != .failure {
                    ZStack {
                        // Use a BannerViewController to load and display the ad
                        BannerViewController(adUnitID: adUnit.unitID, adSize: adFormat.adSize, adStatus: $adStatus)
                            .frame(width: adFormat.size.width, height: adFormat.size.height)
                            .zIndex(1)
                        Text("Ad is loading...")
                            .zIndex(0)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

// Define a UIViewControllerRepresentable that wraps a GADBannerView and handles the loading and displaying of the ad
struct BannerViewController: UIViewControllerRepresentable {
    let adUnitID: String // The ad unit ID to be used
    let adSize: GADAdSize // The ad size to be used
    @Binding var adStatus: AdStatus // The status of the ad (loading, success, or failure)
    
    // Define a Coordinator class that handles the delegate methods of the GADBannerView
    class Coordinator: NSObject, GADBannerViewDelegate {
        var bannerViewController: BannerViewController
        
        init(bannerViewController: BannerViewController) {
            self.bannerViewController = bannerViewController
        }
        
        // Called when the ad fails to load
        func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
            bannerViewController.adStatus = .failure
        }
        
        // Called when the ad is successfully loaded
        func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
            bannerViewController.adStatus = .success
        }
    }
    
    // Create a Coordinator instance
    func makeCoordinator() -> Coordinator {
        Coordinator(bannerViewController: self)
    }
    
    // Create a UIViewController instance
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        
        // Set the test device identifiers (you should add your own test device ID)
        GADMobileAds.sharedInstance().requestConfiguration.testDeviceIdentifiers = [GADSimulatorID]
        
        // Create a GADBannerView instance
        let view = GADBannerView(adSize: self.adSize)
        view.delegate = context.coordinator
        view.adUnitID = self.adUnitID
        view.rootViewController = viewController
        view.load(GADRequest())
        
        // Add the GADBannerView to the view controller's view
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(origin: .zero, size: self.adSize.size)
        
        return viewController
    }
    
    // Update the UIViewController instance
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

// Define an enum that specifies the status of the ad (loading, success, or failure)
enum AdStatus {
    case loading
    case success
    case failure
}
// An enumeration of different types of ad units
enum AdUnit {
    // Ad unit for the main view
    case mainView
    // Ad unit for a sub view
    case subView
    // Ad unit for another view
    case anotherView
    
    // Returns the ad unit ID for the corresponding AdUnit case
    var unitID: String {
        switch self {
// here you can add several ad units
            // Replace with your ad unit ID here
            case .mainView: return "ca-app-pub-3940256099942544/5662855259"
            // Replace with your ad unit ID here
            case .subView: return "ca-app-pub-3940256099942544/5662855259"
            // Replace with your ad unit ID here
            case .anotherView: return "ca-app-pub-3940256099942544/5662855259"
        }
    }
}

// An enumeration of different types of ad formats
enum AdFormat {
    // Large banner ad format
    case largeBanner
    // Medium rectangle ad format
    case mediumRectangle
    // Adaptive banner ad format
    case adaptiveBanner
    
    // Returns the ad size for the corresponding AdFormat case
    var adSize: GADAdSize {
        switch self {
            // Large banner ad size
            case .largeBanner: return GADAdSizeLargeBanner
            // Medium rectangle ad size
            case .mediumRectangle: return GADAdSizeMediumRectangle
            // Adaptive banner ad size that fits the screen width
            case .adaptiveBanner:
                return GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(
                    UIScreen.main.bounds.size.width)
        }
    }
    
    // Returns the size of the ad format
    var size: CGSize {
        adSize.size
    }
}
