//
//  LoginViewController.swift
//  GeekTime
//
//  Created by pkwans on 2022/2/25.
//

import UIKit
import SnapKit
import Toast_Swift

protocol ValidatesPhoneNumber {
    func validatesPhoneNumber(_ phoneNumber: String) -> Bool
}

protocol ValidatesPassword {
    func validatesPassword(_ password: String) -> Bool
}

extension ValidatesPhoneNumber {
    func validatesPhoneNumber(_ phoneNumber: String) -> Bool {
        let pattern = "^1+[3578]+\\d{9}"
        let pred =  NSPredicate(format: "SELF MATCHES %@", pattern)
        let isMatch = pred.evaluate(with: phoneNumber)
        return isMatch;
    }
}

extension ValidatesPassword {
    func validatesPassword(_ password: String) -> Bool {
        let pattern = "^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}"
        let pred = NSPredicate(format:"SELF MATCHES %@",pattern)
        let isMatch = pred.evaluate(with: password)
         return isMatch;
    }
}



class LoginViewController: BaseViewController, ValidatesPhoneNumber, ValidatesPassword {
    
    var phoneTextField: UITextField!
    var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let logoView = UIImageView(image: R.image.logo())
        view.addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(30)
            make.centerX.equalToSuperview()
        }
        
        let phoneIconView = UIImageView(image: R.image.phone())
        phoneIconView.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        phoneTextField = UITextField()
        phoneTextField.leftView = phoneIconView
        phoneTextField.leftViewMode = .always
        phoneTextField.layer.borderColor = UIColor.hexColor(0x333333).cgColor
        phoneTextField.layer.borderWidth = 1
        phoneTextField.textColor = UIColor.hexColor(0x333333)
        phoneTextField.layer.cornerRadius = 5
        phoneTextField.layer.masksToBounds = true
        phoneTextField.placeholder = "请输入手机号"
        view.addSubview(phoneTextField)
        phoneTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(logoView.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        let passwordIconView = UIImageView(image: R.image.password())
        passwordIconView.snp.makeConstraints { make in
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        passwordTextField = UITextField()
        passwordTextField.leftView = passwordIconView
        passwordTextField.leftViewMode = .always
        passwordTextField.layer.borderColor = UIColor.hexColor(0x333333).cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.textColor = UIColor.hexColor(0x333333)
        passwordTextField.layer.cornerRadius = 5
        passwordTextField.layer.masksToBounds = true
        passwordTextField.placeholder = "请输入密码"
        passwordTextField.isSecureTextEntry = true
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(phoneTextField.snp.bottom).offset(15)
            make.height.equalTo(50)
        }
        
        let loginButton = UIButton(type: .custom)
        loginButton.setTitle("登录", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 30)
        loginButton.setBackgroundImage(UIColor.hexColor(0xf8892e).toImage(), for: .normal)
        loginButton.layer.cornerRadius = 5
        loginButton.layer.masksToBounds = true
        view.addSubview(loginButton)
        loginButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
            make.top.equalTo(passwordTextField.snp.bottom).offset(20)
            make.height.equalTo(50)
        }
        
        loginButton.addTarget(self, action: #selector(didClickLoginButton), for: .touchUpInside)
    }

    
    @objc func didClickLoginButton()  {
        if validatesPhoneNumber(phoneTextField.text ?? "") &&  validatesPassword(passwordTextField.text ?? ""){
            
        }
        else {
            self.showToast()
        }
    }
    
    
    func showToast()  {
        self.view.makeToast("用户名或密码错误", duration: 3.0, position: .center)
     }
    
}




//#pragma 正则匹配手机号
//+ (BOOL)checkTelNumber:(NSString *) telNumber
//{
//    NSString *pattern = @"^1+[3578]+\\d{9}";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
//    BOOL isMatch = [pred evaluateWithObject:telNumber];
//    return isMatch;
//}
//
//
//#pragma 正则匹配用户密码6-18位数字和字母组合
//+ (BOOL)checkPassword:(NSString *) password
//{
//    NSString *pattern = @"^(?![0-9]+$)(?![a-zA-Z]+$)[a-zA-Z0-9]{6,18}";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
//    BOOL isMatch = [pred evaluateWithObject:password];
//    return isMatch;
//
//}
//
//#pragma 正则匹配用户姓名,20位的中文或英文
//+ (BOOL)checkUserName : (NSString *) userName
//{
//    NSString *pattern = @"^[a-zA-Z\u4E00-\u9FA5]{1,20}";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
//    BOOL isMatch = [pred evaluateWithObject:userName];
//    return isMatch;
//
//}
//
//
//#pragma 正则匹配用户身份证号15或18位
//+ (BOOL)checkUserIdCard: (NSString *) idCard
//{
//    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X)$)";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
//    BOOL isMatch = [pred evaluateWithObject:idCard];
//    return isMatch;
//}
//
//#pragma 正则匹员工号,12位的数字
//+ (BOOL)checkEmployeeNumber : (NSString *) number
//{
//    NSString *pattern = @"^[0-9]{12}";
//
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
//    BOOL isMatch = [pred evaluateWithObject:number];
//    return isMatch;
//
//}
//
//#pragma 正则匹配URL
//+ (BOOL)checkURL : (NSString *) url
//{
//    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
//    BOOL isMatch = [pred evaluateWithObject:url];
//    return isMatch;
//}
