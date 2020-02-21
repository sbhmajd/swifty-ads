//
//  SwiftyInterstitialAd.swift
//  SwiftyAd
//
//  Created by Dominik Ringler on 21/02/2020.
//  Copyright © 2020 Dominik. All rights reserved.
//

import GoogleMobileAds
#warning("use closures?")
protocol SwiftyInterstitialAdDelegate: AnyObject {
    func swiftyInterstitialAdDidOpen(_ bannerAd: SwiftyInterstitialAd)
    func swiftyInterstitialAdDidClose(_ bannerAd: SwiftyInterstitialAd)
}

protocol SwiftyInterstitialAdType: AnyObject {
    var isReady: Bool { get }
    func load()
    func show(for viewController: UIViewController)
    func stopLoading()
}

final class SwiftyInterstitialAd: NSObject {

    // MARK: - Properties
    
    private let adUnitId: String
    private let request: () -> GADRequest
    private unowned let delegate: SwiftyInterstitialAdDelegate
    
    private var interstitial: GADInterstitial?
    
    // MARK: - Init
    
    init(adUnitId: String,
         request: @escaping () -> GADRequest,
         delegate: SwiftyInterstitialAdDelegate) {
        self.adUnitId = adUnitId
        self.request = request
        self.delegate = delegate
    }
}

extension SwiftyInterstitialAd: SwiftyInterstitialAdType {
    
    /// Check if interstitial video is ready (e.g to show alternative ad like an in house ad)
    /// Will try to reload an ad if it returns false.
    var isReady: Bool {
        guard interstitial?.isReady == true else {
            print("AdMob interstitial ad is not ready, reloading...")
            load()
            return false
        }
        return true
    }
    
    func load() {
        interstitial = GADInterstitial(adUnitID: adUnitId)
        interstitial?.delegate = self
        interstitial?.load(request())
    }
    
    func show(for viewController: UIViewController) {
        interstitial?.present(fromRootViewController: viewController)
    }
    
    func stopLoading() {
        interstitial?.delegate = nil
        interstitial = nil
    }
}

// MARK: - GADInterstitialDelegate

extension SwiftyInterstitialAd: GADInterstitialDelegate {
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("AdMob interstitial did receive ad from: \(ad.responseInfo?.adNetworkClassName ?? "")")
    }
    
    func interstitialWillPresentScreen(_ ad: GADInterstitial) {
        delegate.swiftyInterstitialAdDidOpen(self)
    }
    
    func interstitialWillLeaveApplication(_ ad: GADInterstitial) {
        delegate.swiftyInterstitialAdDidOpen(self)
    }
    
    func interstitialWillDismissScreen(_ ad: GADInterstitial) {
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        delegate.swiftyInterstitialAdDidClose(self)
        load()
    }
    
    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
    }
    
    func interstitial(_ ad: GADInterstitial, didFailToReceiveAdWithError error: GADRequestError) {
        print(error.localizedDescription)
        // Do not reload here as it might cause endless loading loops if no/slow internet
    }
}