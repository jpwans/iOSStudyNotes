//
//  CommonCell.swift
//  GeekTime
//
//  Created by pkwans on 2022/2/28.
//

import Foundation
import UIKit


class CommonCell: UIControl {
    var title: String? {
        didSet {
            self.titleView.text = self.title
        }
    }
    
    var icon: UIImage? {
        
        didSet {
            self.iconView.image = self.icon
        }
    }
    
    var titleView: UILabel
    var iconView: UIImageView
    var bottonLine: UIView
    var arrowView: UIImageView
    
    var hilightView:UIView
    
    override init(frame: CGRect) {
        titleView = UILabel()
        iconView = UIImageView()
        bottonLine = UIView()
        arrowView = UIImageView(image: R.image.icon_right_arrow())
        hilightView = UIView()
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews(){
        
        self.addSubview(hilightView)
        
        hilightView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        hilightView.isHidden = true
        hilightView.alpha = 0
        hilightView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        self.addSubview(iconView)
        iconView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(32)
        }
        
        self.addSubview(titleView)
        titleView.textColor = UIColor.hexColor(0x333333)
        titleView.font = UIFont.systemFont(ofSize: 15)
        titleView.snp.makeConstraints { make in
            make.left.equalTo(iconView.snp.right).offset(10)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(arrowView)
        arrowView.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
        
        self.addSubview(bottonLine)
        bottonLine.backgroundColor = UIColor(white: 0.95, alpha: 1)
        bottonLine.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(1/UIScreen.main.scale)
        }
        
        
    }
    
    
    override var isHighlighted: Bool {
        didSet {
            super.isHighlighted = self.isHighlighted
            if self.isHighlighted {
                self.hilightView.alpha = 1
                self.hilightView.isHidden = false
            }
            else {
                UIView.animate(withDuration: 0.5) {
                    self.hilightView.alpha = 0
                } completion: { Bool in
                    self.hilightView.isHidden = true
                }

            }
        }
    }
    
}
