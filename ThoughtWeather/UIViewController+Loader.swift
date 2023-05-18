//
//  UIViewController+Loader.swift
//  ThoughtWeather
//
//  Created by Ephrem Beaino on 2023-05-18.
//

import Foundation
import UIKit

private class Loader: UIView {
    static let shared: Loader = Loader()
    private let activityIndicator = UIActivityIndicatorView(style: .large)
    
    private init() {
        super.init(frame: UIScreen.main.bounds)
        backgroundColor = UIColor.black.withAlphaComponent(0.35)
        
        addSubview(activityIndicator)
        activityIndicator.center = center
        activityIndicator.color = .white
    }
    private override convenience init(frame: CGRect) {
        self.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startAnimation() {
        activityIndicator.startAnimating()
    }
    
    func stopAnimation() {
        activityIndicator.stopAnimating()
    }
    
}

extension UIViewController {
    func showLoader() {
        if !Loader.shared.isDescendant(of: self.view) {
            self.view.addSubview(Loader.shared)
        }
        Loader.shared.startAnimation()
        self.view.bringSubviewToFront(Loader.shared)
    }
    
    func forceHideLoader() {
        Loader.shared.stopAnimation()
        Loader.shared.removeFromSuperview()
    }
}
