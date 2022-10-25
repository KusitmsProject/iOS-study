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
    
    let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
    
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
    
    @IBAction func logoutTapped(_ sender: Any) {
        let logout = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
        
        logout.addAction(UIAlertAction(title: "네", style: .destructive, handler: {_ in self.logoutAction()}))
        logout.addAction(UIAlertAction(title: "아니오", style: .cancel, handler: {_ in print("no")} ))
        
        present(logout, animated: true)
    }
    
    func logoutAction() {
        UserApi.shared.logout {(error) in
            if let error = error {
                print(error)
            }
            else {
                self.presentToMain()
            }
        }
    }
    
    // 화면 전환 함수
    func presentToMain() {
        guard let mainVC = mainStoryboard.instantiateViewController(withIdentifier: "ViewController") as? ViewController else { return }
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: false, completion: nil)

    }
    
}
