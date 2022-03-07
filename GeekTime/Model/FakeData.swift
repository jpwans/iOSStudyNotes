//
//  FakeData.swift
//  GeekTime
//
//  Created by pkwans on 2022/2/25.
//

import Foundation

class FakeData {
    
    private static var bannerList = [String]()
    private static var products = [Product]()
    private static var deals = [Deal]()
    
    static func crateBanners () -> [String]{
        if bannerList.count == 0 {
            bannerList = [
                "https://static001.geekbang.org/resource/image/ce/45/ce71ab50394c3bb95068073d0c682245.jpg?x-oss-process=image/resize,m_fill,h_800,w_1636",
                "https://static001.geekbang.org/resource/image/e5/4f/e5608bfbea4c90c9ba6e7549e328924f.png?x-oss-process=image/resize,m_fill,h_800,w_1636",
                "https://static001.geekbang.org/resource/image/94/5b/942f498349d71b93b60d569f4a33b65b.jpg?x-oss-process=image/resize,m_fill,h_800,w_1636"
            ]
        }
        
        return bannerList
    }
    
    
    static func createProducts() -> [Product] {
        if products.count == 0
        {
            
            let p1 = Product(imageUrl: "https://static001.geekbang.org/resource/image/29/bc/29c73836ea3fd4ffe7a302f9345cb8bc.jpg?x-oss-process=image/resize,m_fill,h_304,w_230",
                             name: "零基础学 Java",
                             desc: "PayPal 数据处理组技术负责人",
                             price: 129.00,
                             teacher: "臧萌",
                             total: 47, update: 9,
                             studentCount: 2205,
                             detail: "你将获得： 全面掌握 Java 核心语法； 玩转 Java 常用类库及工具； 攻克面向对象、多线程等技术难点； 独立用 Java 编写一款小游戏。",
                             courseList: "第一章节：认识iOS系统")
            let p2 = Product(imageUrl: "https://static001.geekbang.org/resource/image/bb/10/bb6a81aa9ca9e902b2be8e4b94eebc10.png?x-oss-process=image/resize,m_fill,h_304,w_230",
                             name: "玩转 Git 三剑客",
                             desc: "携程代码平台负责人",
                             price: 129.00,
                             teacher: "苏玲",
                             total: 47, update: 9,
                             studentCount: 2205,
                             detail: "你将获得：深入理解Git工作原理；掌握Git的高级使用技巧；用GitHub进行团队项目代码管理；通过GitLab完成简单的DevOps流程。",
                             courseList: "第一章节：认识iOS系统")

            let p3 = Product(imageUrl: "https://static001.geekbang.org/resource/image/e5/2c/e5042ed8eab283f02b4892e94cb5cf2c.png?x-oss-process=image/resize,m_fill,h_304,w_230",
                             name: "SQL 必知必会",
                             desc: "清华大学计算机博士",
                             price: 129.00,
                             teacher: "陈旸",
                             total: 47, update: 9,
                             studentCount: 2205,
                             detail: "你将获得： 熟练掌握SQL语法； 实战SQL性能优化； 玩转6大常用数据库； 基于SQL分析王者荣耀数据。",
                             courseList: "第一章节：认识iOS系统")
            
            let p4 = Product(imageUrl: "https://static001.geekbang.org/resource/image/c6/e4/c608e01399afab04686b993fae6186e4.jpg?x-oss-process=image/resize,m_fill,h_304,w_230",
                             name: "正则表达式入门课",
                             desc: "高级研发工程师",
                             price: 129.00,
                             teacher: "涂伟忠",
                             total: 47, update: 9,
                             studentCount: 2205,
                             detail: "你将获得：正则表达式的系统学习路径；事半功倍的分类记忆法；常见正则问题及解决方案；多场景案例实操正则应用。",
                             courseList: "第一章节：认识iOS系统")
            
            products = [p1,p2,p3,p4]
        }
        
        return products;
    }
    
    static func createDeals () -> [Deal] {
        if deals.count == 0 {
            deals = FakeData.createProducts().map{
                Deal(product: $0, progress: 1)
            }
        }
        return deals
    }
}
