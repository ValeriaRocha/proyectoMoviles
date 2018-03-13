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
    
    
    @IBAction func click(_ sender: UIButton) {
        
        if let path = Bundle.main.path(forResource: "Domingo_Web", ofType: "m4v"){
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true, completion: {
                video.play()
            })
        } else {
            print("No jalo")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

