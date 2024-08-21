//
//  ViewController.swift
//  CryptoCrazyRxMVVM
//
//  Created by Mark Santoro on 8/21/24.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var cryptoList = [Crypto]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        let url = URL(string: "https://raw.githubusercontent.com/atilsamancioglu/K21-JSONDataSet/master/crypto.json")!
        
        Webservice().downloadCurrencies(url: url) {result in
            switch result {
            case .success(let cryptos):
                self.cryptoList = cryptos
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
                
            }
            
        }
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

