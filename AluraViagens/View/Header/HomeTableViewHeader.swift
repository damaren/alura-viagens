//
//  HomeTableViewHeader.swift
//  AluraViagens
//
//  Created by Jose Luis Damaren Junior on 17/04/23.
//

import UIKit

class HomeTableViewHeader: UIView {

    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var bannerView: UIView!
    
    func configureView() {
        bannerView.layer.cornerRadius = 10
        bannerView.layer.masksToBounds = true
        headerView.layer.cornerRadius = 100
        headerView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
    }
}
