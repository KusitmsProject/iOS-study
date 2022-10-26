//
//  ViewController.swift
//  PushAlarm
//
//  Created by 오예진 on 2022/10/26.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var pushButton: UIButton!
    
    // UNUserNotificationCenter 싱글톤 객체 이용
    /// 들어온 알림들을 처리 해주는 진짜 " Center " 같은 개념 !
    let userNotiCenter = UNUserNotificationCenter.current()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestAuthNoti()
    }
    
    // 사용자에게 알림 권한 요청 메소드 : UNAuthorizationOptions() 이용
    func requestAuthNoti() {
        let notiAuthOption = UNAuthorizationOptions(arrayLiteral: [.alert, .badge, .sound])
        userNotiCenter.requestAuthorization(options: notiAuthOption, completionHandler: { (success, error) in
            if let error = error {
                print(#function, error)
            }
        })
    }
    
    // 푸시 알림 전송
    // 푸시알림에 들어갈 컨텐츠 구성 클래스 : UNMutableNotificationContent()
    func requestSendNoti(seconds: Double) {
        let notiContent = UNMutableNotificationContent()
        notiContent.title = "Title"
        notiContent.body = "Descriptions"
//        notiContent.userInfo = ["sdf":"sdf"]    // 알림과 함께 오는 데이터
        
        // 알림이 trigger 되는 시간 설정
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        
        // 알림요청 : UNNotificationRequest
        let request = UNNotificationRequest(
            identifier: UUID().uuidString,  // 보류중인 알림 요청 또는 전달 된 알림을 바꾸거나 제거하는 데 사용
            content: notiContent,   // 알림에 들어갈 내용
            trigger: trigger
        )
        
        // UNNotificationRequest를 통해 만든 알림을 UNUserNotificationCenter를 사용해 예약!
        userNotiCenter.add(request, withCompletionHandler: nil)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        requestSendNoti(seconds: 1.0)
    }
    


}

