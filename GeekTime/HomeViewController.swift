//
//  HomeViewController.swift
//  GeekTime
//
//  Created by pkwans on 2022/2/26.
//

import UIKit
import Kingfisher

class HomeViewController: BaseViewController, BannerViewDataSource, ProductListDelegate{
    func numberOfBanners(_ bannerView: BannerView) -> Int {
        return FakeData.crateBanners().count
    }
    
    func viewForBanner(_ bannerView: BannerView, index: Int, convertView: UIView?) -> UIView {
        if let view = convertView as? UIImageView {
            view.kf.setImage(with:URL(string: FakeData.crateBanners()[index]))
            return view
        }
        else {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.kf.setImage(with:URL(string: FakeData.crateBanners()[index]))
//            imageView.backgroundColor = UIColor.white
            return imageView
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let bannerView = BannerView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 176))
        bannerView.autoScrollInterval = 2
        bannerView.isInfinite = true
        bannerView.dataSource = self
        view.addSubview(bannerView)
        
        
        let productList = ProductList(frame: .zero)
        productList.items = FakeData.createProducts()
        productList.delegate = self
        view.addSubview(productList)
        productList.snp.makeConstraints { make in
            make.left.right.bottom.equalToSuperview()
            make.top.equalTo(bannerView.snp.bottom).offset(5)
            
        }
    }
    
    func didSelectProduct(pruduct: Product) {
        let detailVC = DetailViewController()
        detailVC.product = pruduct
        detailVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hidesBottomBarWhenPushed = false
    }

}
