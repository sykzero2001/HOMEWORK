//
//  FavoriteViewController.swift
//  WHOSCALL_WORK
//
//  Created by Dante on 2021/1/22.
//  Copyright © 2021 Dante. All rights reserved.
//

import UIKit

class FavoriteViewController: ParentListViewController {
    @IBOutlet weak var mainTableView: UITableView!
    var mainData:[Top]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableViewParent = mainTableView
        mainTableView.tableFooterView = UIView()
        mainTableView.estimatedRowHeight = 30
        mainTableView.rowHeight = UITableView.automaticDimension
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
         self.mainTableView.register(UINib(nibName: TopItemCell.CellIdentifier, bundle: nil), forCellReuseIdentifier: TopItemCell.CellIdentifier)
        mainData = Top.readFavoriteData()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
// MARK: TableViewDelegate

extension FavoriteViewController: UITableViewDelegate {

}
extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        mainData = Top.readFavoriteData()
        return self.mainData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let topCell = tableView.dequeueReusableCell(withIdentifier: TopItemCell.CellIdentifier, for: indexPath) as? TopItemCell
        topCell?.selectionStyle = .none
        if self.mainData != nil{
            let cellData = (self.mainData?[indexPath.row])!
            topCell?.parentView = self
            topCell?.initCell(data: cellData)
        }
        return topCell ?? TopItemCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let cellData = (self.mainData?[indexPath.row])!
           let webViewVc = OpenWebViewController()
        webViewVc.url = cellData.url
        self.navigationController?.pushViewController(webViewVc, animated: true)
    }
    

}
