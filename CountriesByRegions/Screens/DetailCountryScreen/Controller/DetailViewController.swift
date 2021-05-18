//
//  DetailViewController.swift
//  CountriesByRegions
//
//  Created by MaksOn on 18.05.2021.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    private let tableViewDataSource = TableViewDataSource()
    private let networkManager = NetworkManager.shared
    private var countryDetailInfo: DetailInfoModel? {
        didSet {
            guard let requireCountryModel = countryDetailInfo else { return }
            
            tableViewDataSource.countryDetailInfo = requireCountryModel.self
            tableView.reloadData()
        }
    }
    
    var countryName: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBar()
        loadData(by: countryName)
    }
}

// MARK: - UITableViewDelegate
extension DetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

// MARK: - setup view
private extension DetailViewController {
    
    func setupTableView() {
        tableView.contentInset.bottom = 16
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.delegate = self
        tableView.dataSource = tableViewDataSource
        tableView.register(CountryDetailInfoTableViewCell.nib(),
                           forCellReuseIdentifier: CountryDetailInfoTableViewCell.identifier)
    }
    
    func setupNavigationBar() {
        let navBar = navigationController?.navigationBar
        title = countryName
        navBar?.setBackgroundImage(UIImage(), for: .default)
        navBar?.shadowImage = UIImage()
        navBar?.titleTextAttributes = [.foregroundColor: UIColor.black,
                                       .font: UIFont.boldSystemFont(ofSize: 25)]
    }
}

// MARK: - load data and setup error alert
private extension DetailViewController {
    
    func loadData(by countryName: String) {
        setupActivityIndicatorView(isHidden: true)

        networkManager.getDetailedInfoAboutCountry(by: countryName) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                
                case .success(let countryDetailInfo):
                    self.countryDetailInfo = countryDetailInfo
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
