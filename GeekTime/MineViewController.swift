//
//  MineViewController.swift
//  GeekTime
//
//  Created by pkwans on 2022/2/26.
//

import UIKit

class MineViewController: BaseViewController {
//
    var accountCell: CommonCell!
    var purchasedCell: CommonCell!
    var dealCell: CommonCell!
    var groupCell: CommonCell!
    
    var avatarView: UIImageView!
//    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.createTopViews()
    }
    
    private func createTopViews(){
        let topView = UIView(frame: .zero)
        topView.backgroundColor = .white
        view.addSubview(topView)
        topView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(160)
        }
        
        avatarView = UIImageView(image: R.image.logo())
        avatarView.layer.cornerRadius = 60
        avatarView.layer.masksToBounds = true
        topView.addSubview(avatarView)
        avatarView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(20)
            make.width.height.equalTo(120)
        }
    }

}
