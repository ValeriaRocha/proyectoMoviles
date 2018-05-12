//
//  PopOverMemoViewController.swift
//  diccionarioPrueba
//
//  Created by Mickey Rocha on 4/21/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit
import AVKit

class PopOverViewController: UIViewController {
    
    var carta = MemoramaCollectionViewCell()
    var player = AVPlayer()
    var controller = AVPlayerViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        
        //mostrar seña
        if carta.sena.path.hasSuffix(".m4v"){ //si es video mostrar video
//            let player = AVPlayer(url: URL(fileURLWithPath: carta.sena.path))
//            let controller = AVPlayerViewController()
//            controller.player = player
//
            player.replaceCurrentItem(with: AVPlayerItem(url: URL(fileURLWithPath: carta.sena.path)))
            //  player = AVPlayer(url: URL(fileURLWithPath: carta.sena.path))
            controller.player = player
            self.addChildViewController(controller)
            let screenSize = UIScreen.main.bounds.size
            //width = 300    height = 270
            let videoFrame = CGRect(x: self.view.center.x - 250, y: screenSize.height/2 - (470/2 + 20), width: 500 , height: 470)
            controller.view.frame = videoFrame
            self.view.addSubview(controller.view)
            player.play()
        }
        else{ //si es imagen mostrar imagen
            let imagen = UIImage(contentsOfFile: carta.sena.path)!
            let imageView = UIImageView(image: imagen)
            let screenSize = UIScreen.main.bounds.size
            //let imageFrame =  CGRect(x: 0, y: 10, width: screenSize.width , height: (screenSize.height - 10) * 0.5)
            let imageFrame =  CGRect(x: (self.view.center.x) - ((imagen.size.width * 0.8)/2), y: (screenSize.height/2) - ((imagen.size.height * 0.8)/2 + 25), width: imagen.size.width * 0.8 , height: imagen.size.height * 0.8)
            imageView.frame = imageFrame
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            imageView.tag = 100
            self.view.addSubview(imageView)
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func botonListo(_ sender: UIButton) {
        //dismiss(animated: true, completion: nil)
        self.removeAnimate()
    }
    
    func removeAnimate()
    {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
        }, completion:{(finished : Bool)  in
            if (finished)
            {
                self.view.removeFromSuperview()
            }
        });
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
