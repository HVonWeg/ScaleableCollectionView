//
//  ViewController.swift
//  ScaleableCollectionView
//
//  Created by Heiko von Wegerer on 23.12.21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: ScaleableCollectionView!
    
    private lazy var dataSource = LabelGridViewDataSource(with: collectionView)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = dataSource
    }

}
