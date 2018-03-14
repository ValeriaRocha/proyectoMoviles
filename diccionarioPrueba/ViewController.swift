//
//  ViewController.swift
//  diccionarioPrueba
//
//  Created by Valeria Rocha Sepulveda  on 12/03/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    var path : String!
    
    @IBAction func click(_ sender: UIButton) {

        //let urlVideo = Bundle.main.url(forResource: "Arana_Web", withExtension: "m4v", subdirectory: path)
        
        let urlVideo = URL(fileURLWithPath: path)
        
        let video = AVPlayer(url: urlVideo) //aqui borre un !
        let videoPlayer = AVPlayerViewController()
        videoPlayer.player = video
        
        present(videoPlayer, animated: true, completion: {
            video.play()
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let urlVideo = Bundle.main.url(forResource: "Arana_Web", withExtension: "m4v", subdirectory: path)
        
        let urlVideo = URL(fileURLWithPath: path)
        
        let video = AVPlayer(url: urlVideo) //aqui borre un !
        let videoPlayer = AVPlayerViewController()
        videoPlayer.player = video
        
        present(videoPlayer, animated: true, completion: {
            video.play()
        })
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

