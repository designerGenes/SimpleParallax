//
//  ViewController.swift
//  SimpleParallax
//
//  Created by Jaden Nation on 3/4/17.
//  Copyright © 2017 Jaden Nation. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	// MARK: - outlets
	@IBOutlet weak var tableView: UITableView!
	
	// MARK: - properties
	var dataArr = [String]()
	
	// MARK: - UITableViewDataSource methods
	func scrollViewDidScroll(_ scrollView: UIScrollView) {
		if let visibleRowIndexPaths = tableView.indexPathsForVisibleRows {
			for indexPath in visibleRowIndexPaths {
				setCellImageOffset(cell: tableView.cellForRow(at: indexPath) as! ParallaxCell, atIndexPath: indexPath)
			}
		}
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return dataArr.count
	}
	
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return ((UIScreen.main.bounds.width / 9) * 16) / 2
	}
	
	func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		var imageCell = cell as! ParallaxCell
		self.setCellImageOffset(cell: imageCell, atIndexPath: indexPath)
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: "ParallaxCell", for: indexPath) as? ParallaxCell else {
			return UITableViewCell()
		}
		
		let imgTag = indexPath.row % 5
		cell.offsetImageView.image = UIImage(named: "bground\(imgTag)")
		cell.offsetImageView.contentMode = .scaleAspectFill
		cell.headlineLabel.text = dataArr[indexPath.row]
		return cell
	}
	
	// MARK: - methods
	func setCellImageOffset(cell: ParallaxCell, atIndexPath indexPath: IndexPath) {
		let cellFrame = tableView.rectForRow(at: indexPath)
		let cellFrameInTable = tableView.convert(cellFrame, to: tableView.superview)
		let cellOffset = cellFrameInTable.origin.y + cellFrameInTable.size.height
		let tableHeight = tableView.bounds.height + cellFrameInTable.size.height
		let cellOffsetFactor = cellOffset / tableHeight
		cell.setBackgroundOffset(factor: cellOffsetFactor)
	}
	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let nib = UINib(nibName: "ParallaxCell", bundle: Bundle.main)
		tableView.register(nib, forCellReuseIdentifier: "ParallaxCell")
		tableView.delegate = self
		tableView.dataSource = self
		
		for i in 0..<30 {
			dataArr.append("headline \(i)")
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

