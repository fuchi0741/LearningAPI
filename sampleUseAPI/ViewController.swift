//
//  ViewController.swift
//  sampleUseAPI
//
//  Created by 渕一真 on 2021/03/09.
//

import UIKit
//Almofireやmoyaを使用して書いてみる

class ViewController: UIViewController {
    
    private let cellId = "cellId"
    
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.register(QiitaTableViewCell.self, forCellReuseIdentifier: cellId)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        headerTitle()
        QiitaManager.getQiitaApi {
            self.tableView.reloadData()
        }
    }
    
    private func headerTitle() {
        navigationItem.title = "Qiitaの記事"
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return QiitaManager.qiitas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! QiitaTableViewCell
        cell.qiita = QiitaManager.qiitas[indexPath.row]
        return cell
    }
}
