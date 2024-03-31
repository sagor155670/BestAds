//
//  ContentView.swift
//  BestAds
//
//  Created by Saiful Islam Sagor on 19/10/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Spacer()
        Text("Adaptive Banner")
         .font(.largeTitle)
         .fontWeight(.heavy)
        BannerAdView(adUnit: .mainView, adFormat: .adaptiveBanner)
//        Text("Large Banner")
//         .font(.largeTitle)
//         .fontWeight(.heavy)
//        BannerAdView(adUnit: .mainView, adFormat: .largeBanner)
//        Text("Medium Rectangle")
//         .font(.largeTitle)
//         .fontWeight(.heavy)
//        BannerAdView(adUnit: .mainView, adFormat: .mediumRectangle)
//        Spacer()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
