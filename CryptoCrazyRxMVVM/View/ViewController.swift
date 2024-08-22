//
//  ViewController.swift
//  CryptoCrazyRxMVVM
//
//  Created by Mark Santoro on 8/21/24.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    let cryptoVM = CryptoViewModel()
    var cryptoList = [Crypto]()
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        setupBindings()
        cryptoVM.requestData()
 
    }
    
    private func setupBindings() {
        cryptoVM
            .error
            .observe(on: MainScheduler.asyncInstance)
            .subscribe {errorString in
                print(errorString)
            }
            .disposed(by: disposeBag)
        
        cryptoVM
            .cryptos
            .observe(on: MainScheduler.asyncInstance)
            .subscribe { cryptos in
                self.cryptoList = cryptos
                self.tableView.reloadData()
            }
            .disposed(by: disposeBag)
        
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptoList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = cryptoList[indexPath.row].currency
        content.secondaryText = cryptoList[indexPath.row].price
        cell.contentConfiguration = content
        return cell
        
    }

}

