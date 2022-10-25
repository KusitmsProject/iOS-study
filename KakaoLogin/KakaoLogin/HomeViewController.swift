//
//  HomeViewController.swift
//  KakaoLogin
//
//  Created by 오예진 on 2022/10/25.
//

import UIKit
import KakaoSDKUser
import KakaoSDKAuth

class HomeViewController: UIViewController {
    
    @IBOutlet weak var userName: UILabel!

    var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getUserInfo()
    }
    
    // user 정보 가져오기
    func getUserInfo() {
        UserApi.shared.me { user, error in
            if let error = error {
                print(error)
            } else {
                let name = user?.kakaoAccount?.profile?.nickname
                guard let name = name else {return}
                self.user.name = name
                self.setUI()
            }
        }
    }
    
    func setUI() {
        userName.text = user.name+"님"
    }
    
}
