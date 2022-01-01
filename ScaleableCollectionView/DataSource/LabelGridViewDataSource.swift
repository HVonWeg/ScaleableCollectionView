//
//  LabelGridViewDataSource.swift
//  Kachel
//
//  Created by Heiko von Wegerer on 22.12.21.
//

import UIKit

class LabelGridViewDataSource: NSObject {
    
    private let numberOfRows = 3
    private let numberOfColumns = 3
    private let minScaleValue = 0.0
    
    private let viewModel = [
        "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam",
        "Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.",
        "You can scale in and out, let´s try!",
        "Short text"
    ]
    
    init(with collectionView: ScaleableCollectionView) {
        // Configure collection view
        collectionView.config = ScalableCollectionViewConfig(
            minScaleValue: minScaleValue,
            numberOfRows: numberOfRows,
            numberOfColumns: numberOfColumns
        )
        
        // Register Cells
        collectionView.register(LabelCollectionViewCell.nib, forCellWithReuseIdentifier: LabelCollectionViewCell.reuseIdentifier)
    }
}

// MARK: - UICollectionViewDataSource

extension LabelGridViewDataSource: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        numberOfColumns * numberOfRows
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LabelCollectionViewCell.reuseIdentifier, for: indexPath) as! LabelCollectionViewCell
        cell.configure(withViewModel: LabelCollectionViewCellModel(text: viewModel[Int.random(in: 0..<viewModel.count)]))
        cell.accessibilityIdentifier = "collectionViewCell-\(indexPath.row)"
        
        return cell
    }
    
}
