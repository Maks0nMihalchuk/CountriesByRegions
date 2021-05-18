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
    
    private let main = UIStoryboard(name: "Main", bundle: nil)
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
        setupNavigationBar()
        loadData(by: currentRegion)
        //setupNavigationBar()
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        currentRegion = regionsArray[indexPath.item]
        title = currentRegion.stringNameRegion
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
        tableView.deselectRow(at: indexPath, animated: true)
        
        let detailViewController = setupDetailViewController()
        
        guard
            let viewController = detailViewController,
            let name = countryNames?[indexPath.row].name
        else { return }
        
        viewController.countryName = name
        
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MRK: - setup DetailViewController
private extension MainViewController {
    
    func setupDetailViewController() -> DetailViewController? {
        return main.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
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
        tableView.contentInset.bottom = 16
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.delegate = self
        tableView.dataSource = countryTableViewDataSource
        tableView.register(CountryTableViewCell.nib(),
                           forCellReuseIdentifier: CountryTableViewCell.identifier)
    }
    
    func setupNavigationBar() {
        let navBar = navigationController?.navigationBar
        title = currentRegion.stringNameRegion
        navBar?.setBackgroundImage(UIImage(), for: .default)
        navBar?.shadowImage = UIImage()
        navBar?.titleTextAttributes = [.foregroundColor: UIColor.black,
                                       .font: UIFont.boldSystemFont(ofSize: 25)]
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
