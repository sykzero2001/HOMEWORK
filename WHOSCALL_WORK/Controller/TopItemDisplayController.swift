//
//  TopItemDisplayController.swift
//  WHOSCALL_WORK
//
//  Created by Dante on 2021/1/12.
//  Copyright © 2021 Dante. All rights reserved.
//

import UIKit
import MBProgressHUD

class TopItemDisplayController: ParentListViewController {
    @IBOutlet weak var maskView: UIView!
    @IBOutlet weak var pickerBackground: UIView!
    @IBOutlet weak var pickerHeight: NSLayoutConstraint!
    @IBOutlet weak var openConditionSubType: UIButton!
    @IBOutlet weak var openConditionType: UIButton!
    @IBOutlet weak var conditionPicker: UIPickerView!
    @IBOutlet weak var mainTableView: UITableView!
    var topModel:TopBody?
    var type = ""
    var subType = ""
    var typeValue = [TypeClass]()
    var page = 1
    enum TopType:Int {
        case  TheTypeEnum  = 0
        case  TheSubTypeEnum = 1
    }
    enum PickerHeight:CGFloat {
           case  Open = 150
           case  Close = 0
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableViewParent = mainTableView
        mainTableView.tableFooterView = UIView()
        mainTableView.estimatedRowHeight = 30
        mainTableView.rowHeight = UITableView.automaticDimension
        typeValue = [TypeClass.init(name: "anime"),TypeClass.init(name: "manga"),TypeClass.init(name: "people"),TypeClass.init(name: "characters")]
        self.conditionPicker.delegate = self
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        self.closePicker()
        self.mainTableView.register(UINib(nibName: TopItemCell.CellIdentifier, bundle: nil), forCellReuseIdentifier: TopItemCell.CellIdentifier)
    }
// MARK: 開關選單
    @IBAction func clickType(_ sender: UIButton) {
        self.openPicker()
    }
    @IBAction func clickSubType(_ sender: UIButton) {
        self.openPicker()
    }
    func openPicker(){
        self.maskView.isHidden = false
        self.pickerBackground.isHidden = false
        UIView.animate(withDuration: 3.0) {
            self.pickerHeight.constant = PickerHeight.Open.rawValue
        }
    }
    func closePicker()  {
        self.maskView.isHidden = true
        self.pickerBackground.isHidden = true
        UIView.animate(withDuration: 3.0) {
            self.pickerHeight.constant = PickerHeight.Close.rawValue
        }
    }
// MARK: 呼叫API
    func readApi(){
         MBProgressHUD.showAdded(to: self.view, animated: true)
        AppManager.requestAPI(url: URL.init(string: API_URL)!, paramaters:["type":openConditionType.titleLabel?.text ?? "" ,"subtype":openConditionSubType.titleLabel?.text ?? "","page":page], success: { (isSuccess, response, desc) in
            let dataJson = try! JSONSerialization.data(withJSONObject: response.value as Any, options: JSONSerialization.WritingOptions.prettyPrinted)
            self.topModel = try! JSONDecoder().decode(TopBody.self, from: dataJson)
            self.mainTableView.reloadData()
            MBProgressHUD.hide(for: self.view, animated: true)

        }
        
        ){ (error) in
        MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
// MARK: 按鈕區
    @IBAction func clickOK(_ sender: UIButton) {
        let typeData = typeValue[conditionPicker.selectedRow(inComponent:TopType.TheTypeEnum.rawValue)]
        var subTypeString = ""
        if typeData.subType?.count ?? 0 > 0 {
            subTypeString = typeData.subType?[conditionPicker.selectedRow(inComponent: TopType.TheSubTypeEnum.rawValue)] ?? ""
        }else{
            subTypeString = ""
        }
        self.openConditionType.setTitle(typeData.typeName, for: .normal)
        self.openConditionSubType.setTitle(subTypeString, for: .normal)
        self.closePicker()
        self.readApi()
    }
    
    @IBAction func clickCancel(_ sender: UIButton) {
        self.closePicker()
    }
    @IBAction func openFavoriteList(_ sender: UIButton) {
        let sb =  UIStoryboard.init(name: "Main", bundle: nil)
                let favoriteVc = sb.instantiateViewController(withIdentifier: "FavoriteView") as!  FavoriteViewController
        self.navigationController?.pushViewController(favoriteVc, animated: true)
    }
}


// MARK: TableViewDelegate
extension TopItemDisplayController: UITableViewDelegate {

}
extension TopItemDisplayController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.topModel?.top?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let topCell = tableView.dequeueReusableCell(withIdentifier: TopItemCell.CellIdentifier, for: indexPath) as? TopItemCell
        topCell?.selectionStyle = .none
        if self.topModel?.top != nil{
            let cellData = (self.topModel?.top?[indexPath.row])!
            topCell?.parentView = self
            topCell?.initCell(data: cellData)
        }
        return topCell ?? TopItemCell()
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let cellData = (self.topModel?.top?[indexPath.row])!
           let webViewVc = OpenWebViewController()
        webViewVc.url = cellData.url
        self.navigationController?.pushViewController(webViewVc, animated: true)
    }
    

}
// MARK: PickerDelegate
extension TopItemDisplayController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if component == TopType.TheTypeEnum.rawValue {
            let typeValueData = typeValue[row]
            return typeValueData.typeName
        }else{
           
            
            let index = pickerView.selectedRow(inComponent: TopType.TheTypeEnum.rawValue)
            let typeValueData = typeValue[index]
            if typeValueData.subType?.count == 0 {
                return ""
            }else{
                return typeValueData.subType?[row]
            }
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if component == TopType.TheTypeEnum.rawValue {
            self.conditionPicker.reloadComponent(1)
            self.conditionPicker.selectRow(0, inComponent: 1, animated: true)
        }
        
    }
}
extension TopItemDisplayController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == TopType.TheTypeEnum.rawValue {
            return typeValue.count
        }else{
           let index = pickerView.selectedRow(inComponent: TopType.TheTypeEnum.rawValue)
            let selectType = typeValue[index]
            return selectType.subType?.count ?? 0
        }
    }
}
