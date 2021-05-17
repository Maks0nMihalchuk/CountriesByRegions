//
//  ViewController.swift
//  CountriesByRegions
//
//  Created by MaksOn on 17.05.2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    private let regionsCollectionViewDataSource = RegionsCollectionViewDataSource()
    private let countryTableViewDataSource = CountryTableViewDataSource()
    private let networkManager = NetworkManager.shared
    private let horizontalIndent: CGFloat = 20
    private let verticalIndent: CGFloat = 10
    private let fontSize: CGFloat = 20
    private var countryNames: [CountryModel]? {
        didSet {
            guard let requireCountryModel = countryNames else { return }
            
            countryTableViewDataSource.countryNames = requireCountryModel
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupTableView()
        loadData(by: currentRegion)
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentRegion = regionsArray[indexPath.item]
        loadData(by: currentRegion)
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

// MARK: - UITableViewDelegate
extension MainViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
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
    
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = countryTableViewDataSource
        tableView.register(CountryTableViewCell.nib(),
                           forCellReuseIdentifier: CountryTableViewCell.identifier)
    }
}

// MARK: - load data and setup error alert
private extension MainViewController {
    
    func loadData(by region: RegionsModel) {
        setupActivityIndicatorView(isHidden: true)

        networkManager.getCountryNames(by: region) { [weak self] result in
            guard let self = self else { return }

            DispatchQueue.main.async {

                switch result {
                
                case .success(let countryNames):
                    self.countryNames = countryNames
                case .failure(let error):
                    self.setupAndShowErrorAlert(with: error.errorDescription)
                }

                self.setupActivityIndicatorView(isHidden: false)
            }
        }
    }
    
    func setupActivityIndicatorView(isHidden: Bool) {
        activityIndicatorView.isHidden = !isHidden
        
        if isHidden {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
    
    func setupAndShowErrorAlert(with message: String) {
        let alertTitle = "Error"
        let actionTitle = "Okey"
        
        let alertController = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: actionTitle, style: .cancel, handler: nil)
        
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
}
