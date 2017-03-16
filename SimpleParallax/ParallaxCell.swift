//
//  ParallaxCell.swift
//  SimpleParallax
//
//  Created by Jaden Nation on 3/4/17.
//  Copyright © 2017 Jaden Nation. All rights reserved.
//

import UIKit

class ParallaxCell: UITableViewCell {
	// MARK: - outlets
	@IBOutlet weak var offsetImageView: UIImageView!
	@IBOutlet weak var headlineLabel: UILabel!
	@IBOutlet weak var imageViewTopConstraint: NSLayoutConstraint!
	@IBOutlet weak var imageViewBottomConstraint: NSLayoutConstraint!
	
	// MARK: - properties
	var parallaxFactor: CGFloat = 120
	var initialTopConstant: CGFloat = 0
	var initialBottomConstant: CGFloat = 0
	var guideBars = [UIView]()
	
	// MARK: - methods	
	func setBackgroundOffset(factor: CGFloat) {
		let boundOffset = max(0, min(factor, 1))
		let pixelOffset = (1-boundOffset) * (2 * parallaxFactor)
		imageViewTopConstraint.constant = initialTopConstant - pixelOffset
		imageViewBottomConstraint.constant = initialBottomConstant + pixelOffset
		headlineLabel.text = "Sig: \((factor * 100).rounded() / 100)"
		layoutSubviews()
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		for (z, bar) in guideBars.enumerated() {
			bar.frame = CGRect(x: 0, y: bounds.height * CGFloat(z), width: bounds.width, height: 8)
		}
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
		clipsToBounds = true
		offsetImageView.contentMode = .scaleAspectFill
		imageViewBottomConstraint.constant -= 2 * parallaxFactor
		initialTopConstant = imageViewTopConstraint.constant
		initialBottomConstant = imageViewBottomConstraint.constant
		
		for i in 0..<2 {
			let guideBar = UIView()
			guideBars.append(guideBar)
			guideBar.backgroundColor = UIColor.black.withAlphaComponent(0.8)
			guideBar.layer.anchorPoint = CGPoint(x: 0, y: i)
			addSubview(guideBar)
		}
		
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
