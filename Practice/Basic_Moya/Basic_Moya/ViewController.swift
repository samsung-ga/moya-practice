//
//  ViewController.swift
//  Basic_Moya
//
//  Created by Wody on 2022/01/18.
//

import UIKit
import Moya

final class ViewController: UIViewController {
  @IBOutlet weak var tableView: UITableView!
  private lazy var loading: UIActivityIndicatorView = {
    let indicator = UIActivityIndicatorView()
    indicator.hidesWhenStopped = true
    indicator.translatesAutoresizingMaskIntoConstraints = false
    return indicator
  }()
  
  private let repositoryProvider = MoyaProvider<RepositoryAPI>()
  var repositories = [RepositoryModel]()
  
  @IBAction func fetchButtonPressed(_ sender: Any) {
    view.addSubview(loading)
    NSLayoutConstraint.activate([
      loading.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      loading.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
    loading.startAnimating()
    fetchRepository(with: "wody27")
  }
  
  func fetchRepository(with userID: String) {
    repositoryProvider.request(.repository(userID)) { [weak self] result in
      self?.loading.stopAnimating()
      switch result {
      case .success(let response):
        do {
          let decoded = try JSONDecoder().decode([RepositoryModel].self, from: response.data)
          self?.repositories = decoded
          self?.tableView.reloadData()
        } catch(let error) {
          print(error.localizedDescription)
        }
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return repositories.count
  }
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(RepositoryTableViewCell.self, forIndexPath: indexPath) else { return UITableViewCell() }
    cell.nameLabel.text = repositories[indexPath.row].name
    return cell
  }
  
  
}
