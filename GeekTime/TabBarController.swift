//
//  ViewController.swift
//  GeekTime
//
//  Created by pkwans on 2022/2/25.
//

import UIKit
import SnapKit
class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
     
        
        
        let homeVC = HomeViewController()
        homeVC.tabBarItem.image = R.image.home()?.scaleImage(scaleSize: 0.3)
        homeVC.tabBarItem.selectedImage = R.image.home_selected()?.scaleImage(scaleSize: 0.3).withRenderingMode(.alwaysOriginal)
        homeVC.tabBarItem.title = "首页"
        homeVC.title = "首页"
        homeVC.tabBarItem.setTitleTextAttributes([.foregroundColor:UIColor.hexColor(0xfeada6)], for: .selected)
        let navigationHomeVC =  UINavigationController(rootViewController: homeVC)
        self.addChild(navigationHomeVC)
        
        let mineVC = MineViewController()
        mineVC.tabBarItem.image = R.image.mine()?.scaleImage(scaleSize: 0.3)
        mineVC.tabBarItem.selectedImage = R.image.mine_selected()?.scaleImage(scaleSize: 0.3).withRenderingMode(.alwaysOriginal)
        mineVC.tabBarItem.title = "我的"
        mineVC.title = "我的"
        mineVC.tabBarItem.setTitleTextAttributes([.foregroundColor:UIColor.hexColor(0xfeada6)], for: .selected)
   
        let navigationMineVC = UINavigationController(rootViewController: mineVC)
        self.addChild(navigationMineVC)
        
        if #available(iOS 15.0, *) {
                     let app = UINavigationBarAppearance()
                     app.configureWithOpaqueBackground()  // 重置背景和阴影颜色
                     app.titleTextAttributes = [
//                           NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                           NSAttributedString.Key.foregroundColor: UIColor.black
                     ]
                     app.backgroundColor = UIColor.hexColor(0x89f7fe)// 设置导航栏背景色
                     app.shadowColor = .clear
                     app.backgroundEffect = nil
                     UINavigationBar.appearance().scrollEdgeAppearance = app  // 带scroll滑动的页面
                     UINavigationBar.appearance().standardAppearance = app // 常规页面。描述导航栏以标准高度
                }
        
    

    }
}

