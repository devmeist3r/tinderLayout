//
//  UIImage+Extensions.swift
//  tinderLayout
//
//  Created by P21 Sistemas on 12/03/20.
//  Copyright © 2020 Lucas Inocencio. All rights reserved.
//

import UIKit

extension UIImageView {
    
    static func fotoImageView(named: String? = nil) -> UIImageView {
        let imageView = UIImageView()
        if let named = named {
            imageView.image = UIImage(named: named)
        }
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }
    
    static func iconCard (named: String) -> UIImageView {
        let imageView = UIImageView()
        imageView.image = UIImage(named: named)
        imageView.alpha = 0.0
        return imageView
    }
    
}
