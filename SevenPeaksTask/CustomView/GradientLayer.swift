//
//  GradientLayer.swift
//  SevenPeaksTask
//
//  Created by Adinarayana Machavarapu on 23/10/21.
//

import Foundation
import UIKit

/**
 * GradientLayer:
 *
 * This class is used handle the image overlay with gradient colors
 */
class GradientLayer: UIView {

    override public class var layerClass : AnyClass {
        return CAGradientLayer.self
    }
    override public func awakeFromNib() {
        super.awakeFromNib()
        let colors = [ UIColor.black0.cgColor, UIColor.black82.cgColor, UIColor.black.cgColor ]
        if let gradient = self.layer as? CAGradientLayer {
            gradient.colors = colors
        }
    }
}
