//
//  TopItemCell.swift
//  WHOSCALL_WORK
//
//  Created by Dante on 2021/1/14.
//  Copyright © 2021 Dante. All rights reserved.
//

import UIKit
import SDWebImage

class TopItemCell: UITableViewCell {
    @IBOutlet weak var theFavoriteButton: UIButton!
    static let CellIdentifier = "TopItemCell"
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var endDate: UILabel!
    @IBOutlet weak var startDate: UILabel!
    @IBOutlet weak var topRank: UILabel!
    @IBOutlet weak var topType: UILabel!
    @IBOutlet weak var topTitle: UILabel!
    var topData:Top?
    var favoriteArray = [Top]()
    var isFavorite = [Top]()
    var parentView = ParentListViewController()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func initCell(data:Top){
        topData = data
        topTitle.text = data.title
        topType.text = data.type
        topRank.text = String(data.rank ?? 0)
        startDate.text = data.startDate
        endDate.text = data.endDate ?? ""
        let imageUrlString = URL.init(string: data.imageUrl ?? "")
        self.topImage.sd_setImage(with:imageUrlString, placeholderImage: UIImage(named: ""), options: .refreshCached, completed: nil)
        self.theFavoriteButton.layer.cornerRadius = 10.0
        self.setFavoriteButton(data:data)
    }
    func setFavoriteButton(data:Top){
        let favoriteData = Top.readFavoriteData()
        self.favoriteArray = favoriteData ?? []
        let favoriteArrayTmp
            = favoriteData?.filter {
            $0.mal_id == data.mal_id
        }
        isFavorite = favoriteArrayTmp ?? []
        if favoriteArrayTmp?.count ?? 0 > 0 {
            theFavoriteButton.setTitle("移除最愛", for: .normal)
        }else{
            theFavoriteButton.setTitle("加入最愛", for: .normal)

        }
    }
    
    
    @IBAction func favoriteButton(_ sender: UIButton) {
        
        if isFavorite.count > 0 {
            let oldFavorite = isFavorite.first
            let favoriteSaveArray = self.favoriteArray.filter {
                $0.mal_id != oldFavorite?.mal_id
            }
            self.favoriteArray = favoriteSaveArray
        }else{
            self.favoriteArray.append(topData!)
        }
        Top.setFavoriteData(data:self.favoriteArray)
        self.parentView.mainTableViewParent?.reloadData()        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
