//
//  ViewController.swift
//  YoutubeEmbeded
//
//  Created by 오예진 on 2022/10/21.
//

import UIKit
import youtube_ios_player_helper

class ViewController: UIViewController, YTPlayerViewDelegate {
    
    
    @IBOutlet weak var playerView: YTPlayerView!
    
    // 전체화면이 아닌 view안에서만 영상이 재생되게 하기 위해
    let playVarsDic = ["playsinline": 1]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playerView.delegate = self
        playerView.load(withVideoId: "WfA47O-Fb_M", playerVars: playVarsDic)
    }
    
    // 자동 재생
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
    
}

