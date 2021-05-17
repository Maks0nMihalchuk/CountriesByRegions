//
//  ViewController.swift
//  CountriesByRegions
//
//  Created by MaksOn on 17.05.2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    private let regionsCollectionViewDataSource = RegionsCollectionViewDataSource()
    private let horizontalIndent: CGFloat = 20
    private let verticalIndent: CGFloat = 10
    private let fontSize: CGFloat = 20

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        regionsCollectionViewDataSource.selectedRegion = regionsArray[indexPath.item]
        self.collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let font = UIFont.boldSystemFont(ofSize: fontSize)
        let width = regionsArray[indexPath.item].stringNameRegion.widthOfString(usingFont: font)
        let height = collectionView.bounds.height
        return CGSize(width: width + horizontalIndent, height: height - verticalIndent)
    }
}

// MARK: - setup view
private extension MainViewController {
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = regionsCollectionViewDataSource
        collectionView.register(RegionCollectionViewCell.nib(),
                                forCellWithReuseIdentifier: RegionCollectionViewCell.identifier)
    }
}
