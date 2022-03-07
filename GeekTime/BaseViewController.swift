//
//  BaseViewController.swift
//  GeekTime
//
//  Created by pkwans on 2022/2/25.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.hexColor(0xf2f4f7)
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor:UIColor.hexColor(0x89f7fe)]
        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        
        
//        if #available(iOS 15.0, *) {
//                     let app = UINavigationBarAppearance()
//                     app.configureWithOpaqueBackground()  // 重置背景和阴影颜色
//                     app.titleTextAttributes = [
//                           NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
//                           NSAttributedString.Key.foregroundColor: UIColor.black
//                     ]
//                     app.backgroundColor = UIColor.hexColor(0x89f7fe)// 设置导航栏背景色
//                     app.shadowColor = .clear
//                     app.backgroundEffect = nil
//                     UINavigationBar.appearance().scrollEdgeAppearance = app  // 带scroll滑动的页面
//                     UINavigationBar.appearance().standardAppearance = app // 常规页面。描述导航栏以标准高度
//                }

        
        if #available(iOS 15.0, *) {
                     let app = UITabBarAppearance()
                     app.configureWithOpaqueBackground()  // 重置背景和阴影颜
                     app.backgroundColor = UIColor.hexColor(0x89f7fe)// 设置导航栏背景色
                     app.shadowColor = .clear
                     app.backgroundEffect = nil
                    self.tabBarItem.standardAppearance = app
                    self.tabBarItem.scrollEdgeAppearance = app
                }
    }
    

}
