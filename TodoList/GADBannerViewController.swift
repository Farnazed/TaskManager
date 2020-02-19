//
//  GADBannerViewController.swift
//  TodoList
//
//  Created by farnaz on 2020-02-11.
//  Copyright © 2020 farnaz. All rights reserved.
//

import SwiftUI
import UIKit
import GoogleMobileAds

final class GADBannerViewController: UIViewControllerRepresentable  {

    func makeUIViewController(context: Context) -> UIViewController {
        let view = GADBannerView(adSize: GADAdSizeFromCGSize(CGSize(width: 370, height: 50)))
        let viewController = UIViewController()
        view.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        view.rootViewController = viewController
        view.delegate = viewController
        viewController.view.addSubview(view)
        viewController.view.frame = CGRect(x: 0, y: 0, width: 370, height: 50)
            //CGRect(origin: .zero, size: kGADAdSizeFullBanner.size)
            
           
        view.load(GADRequest())
        return viewController
    }
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
}

extension UIViewController: GADBannerViewDelegate {
    public func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("ok ad")
    }

    public func adView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: GADRequestError) {
       print("fail ad")
       print(error)
    }
}

