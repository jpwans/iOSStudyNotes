//
//  DetailViewController.swift
//  GeekTime
//
//  Created by pkwans on 2022/2/27.
//

import UIKit
import Kingfisher
import SnapKit

class DetailViewController: BaseViewController {

    var product: Product!
    var avatarView: UIImageView!
    var nameLabel: UILabel!
    var descLabel: UILabel!
    var teacherLabel: UILabel!
    var courseCountLabel: UILabel!
    var studuntCountLabel: UILabel!
    var tab: Tap!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "详情"
    
        
        self.createBottom()
    }
    
    func createTop() {
        
    }
    
    func createMiddle() {
        
    }
    
    func createBottom() {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("购买 ￥\(product.price)", for: .normal)
        button.setBackgroundImage(UIColor.hexColor(0xf8892e).toImage(), for:.normal)
        button.addTarget(self, action: #selector(didClickBuyButton), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(50)
        }
        
//        RoundCornerImageProcessor(cornerRadius: 10)
    }
    
    
    @objc func didClickBuyButton() {
        
    }

}
