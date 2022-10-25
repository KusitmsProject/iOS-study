//
//  ViewController.swift
//  KakaoLogin
//
//  Created by 오예진 on 2022/10/25.
//

import UIKit
import KakaoSDKCommon
import KakaoSDKAuth
import KakaoSDKUser


class ViewController: UIViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func tappedButton(_ sender: Any) {
        
        // 카카오톡 설치 여부 확인
        if UserApi.isKakaoTalkLoginAvailable() {
            // 카카오톡 로그인. api 호출 결과를 클로저로 전달.
            loginWithApp()
        } else {
            // 만약, 카카오톡이 깔려있지 않을 경우에는 웹 브라우저로 카카오 로그인함.
            loginWithWeb()
        }
        
    }

}

// login extensions
extension ViewController {
    
    // 카카오 앱으로 로그인
    func loginWithApp() {
        UserApi.shared.loginWithKakaoTalk {(_, error) in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoTalk() success.")
                
                UserApi.shared.me {(user, error) in
                    if let error = error {
                        print(error)
                    } else {
                        print("카카오톡으로 로그인 성공")
                    }
                }
            }
        }
    }
        
    // 카카오 웹으로 로그인
    func loginWithWeb() {
        UserApi.shared.loginWithKakaoAccount {(_, error) in
            if let error = error {
                print(error)
            } else {
                print("loginWithKakaoAccount() success.")
                
                UserApi.shared.me {(user, error) in
                    if let error = error {
                        print(error)
                    } else {
                        print("카카오톡으로 로그인 성공")
                    }
                }
            }
        }
    }

}
