//    The MIT License (MIT)
//
//    Copyright (c) 2015-2023 Dominik Ringler
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

import Foundation

public struct SwiftyAdsConfiguration: Decodable, Equatable {
    public init(bannerAdUnitId: String? = nil,
                interstitialAdUnitId: String? = nil,
                interstitialVideoAdUnitId: String? = nil,
                rewardedAdUnitId: String? = nil,
                rewardedInterstitialAdUnitId: String? = nil,
                nativeAdUnitId: String? = nil,
                isTaggedForChildDirectedTreatment: Bool? = nil,
                isTaggedForUnderAgeOfConsent: Bool? = nil,
                isUMPDisabled: Bool? = nil) {
        self.bannerAdUnitId = bannerAdUnitId
        self.interstitialAdUnitId = interstitialAdUnitId
        self.interstitialVideoAdUnitId = interstitialVideoAdUnitId
        self.rewardedAdUnitId = rewardedAdUnitId
        self.rewardedInterstitialAdUnitId = rewardedInterstitialAdUnitId
        self.nativeAdUnitId = nativeAdUnitId
        self.isTaggedForChildDirectedTreatment = isTaggedForChildDirectedTreatment
        self.isTaggedForUnderAgeOfConsent = isTaggedForUnderAgeOfConsent
        self.isUMPDisabled = isUMPDisabled
    }
    let bannerAdUnitId: String?
    let interstitialAdUnitId: String?
    let interstitialVideoAdUnitId: String?
    let rewardedAdUnitId: String?
    let rewardedInterstitialAdUnitId: String?
    let nativeAdUnitId: String?
    let isTaggedForChildDirectedTreatment: Bool? // COPPA
    let isTaggedForUnderAgeOfConsent: Bool?  // GDPR
    let isUMPDisabled: Bool? // Disables User Messaging Platform (UMP) SDK
}

extension SwiftyAdsConfiguration {
    static func production(bundle: Bundle = .main) -> SwiftyAdsConfiguration {
        guard let url = bundle.url(forResource: "SwiftyAds", withExtension: "plist") else {
            fatalError("SwiftyAds could not find SwiftyAds.plist in the main bundle.")
        }

        do {
            let data = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            return try decoder.decode(SwiftyAdsConfiguration.self, from: data)
        } catch {
            fatalError("SwiftyAds decoding SwiftyAds.plist error: \(error).")
        }
    }

    // https://developers.google.com/admob/ios/test-ads
    static func debug(isUMPDisabled: Bool) -> SwiftyAdsConfiguration {
        SwiftyAdsConfiguration(
            bannerAdUnitId: "ca-app-pub-3940256099942544/2934735716",
            interstitialAdUnitId: "ca-app-pub-3940256099942544/4411468910",
            interstitialVideoAdUnitId: "ca-app-pub-3940256099942544/5135589807",
            rewardedAdUnitId: "ca-app-pub-3940256099942544/1712485313",
            rewardedInterstitialAdUnitId: "ca-app-pub-3940256099942544/6978759866",
            nativeAdUnitId: "ca-app-pub-3940256099942544/3986624511",
            isTaggedForChildDirectedTreatment: nil,
            isTaggedForUnderAgeOfConsent: nil,
            isUMPDisabled: isUMPDisabled
        )
    }
}
