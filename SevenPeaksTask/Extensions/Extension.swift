//
//  Extension.swift
//  SevenPeaksTask
//
//  Created by Adinarayana Machavarapu on 23/10/21.
//

import Foundation
import UIKit
import Kingfisher

/**
 This is used to return font name base on condition
 */
public enum FontStyle: String {
    case sfuiDisplayMedium = "SFUIDisplay-Medium"
    case sfuiDisplayRegular = "SFUIDisplay-Regular"
}

extension UIViewController {
    /**
     This is used to display alert with title and message with multiple button based on requirement
     
     - parameter title:   title string
     - parameter message: message string
     */
    func popupAlert(title: String?, message: String?, actionTitles:[String?], actions:[((UIAlertAction) -> Void)?]) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for (index, title) in actionTitles.enumerated() {
            let action = UIAlertAction(title: title, style: .default, handler: actions[index])
            alert.addAction(action)
        }
        self.present(alert, animated: true, completion: nil)
    }
}

extension UIImageView {
    
    /// Get the url  from TableViewCell and passing to kingfisher framework to download images asynchronously and set image to cell image.
    /// - Parameter url: image url
    func downloadImage(url:String) {
        let url = URL(string: url)
        self.kf.indicatorType = .activity
        self.kf.setImage(with: url)
    }
}

extension UIColor {
    static let black82  = UIColor(white: 0.0, alpha: 0.82)
    static let black = UIColor(white: 0.0, alpha: 1.0)
    static let black0 = UIColor(white: 0.0, alpha: 0.0)
}

extension UIFont {
    static func customFont(_ type: FontStyle = .sfuiDisplayMedium, size: CGFloat = UIFont.systemFontSize) -> UIFont {
          return UIFont(name: "\(type.rawValue)", size: size)!
      }
}
