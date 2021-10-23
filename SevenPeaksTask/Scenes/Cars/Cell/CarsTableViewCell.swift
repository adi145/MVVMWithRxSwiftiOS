//
//  CarsTableViewCell.swift
//  SevenPeaksTask
//
//  Created by Adinarayana Machavarapu on 23/10/21.
//

import UIKit
import RxSwift
import RxCocoa
import Kingfisher

class CarsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var transparentView   : GradientLayer!
    @IBOutlet weak var bgView            : UIView!
    @IBOutlet weak var carImageView      : UIImageView!
    @IBOutlet weak var titleLabel          : UILabel!
    @IBOutlet weak var dateLabel           : UILabel!
    @IBOutlet weak var ingressLabel        : UILabel!
    
    var carListViewModel : CarsDisplayViewModel! {
        didSet {
            if carListViewModel.imageUrl != nil {
                self.carImageView.downloadImage(url: carListViewModel.imageUrl!)
            }
            self.titleLabel.text   = carListViewModel.title
            self.dateLabel.text    = carListViewModel.dateTime
            self.ingressLabel.text = carListViewModel.ingress
        }
    }
}
