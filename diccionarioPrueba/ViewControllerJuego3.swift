//
//  ViewControllerJuego3.swift
//  diccionarioPrueba
//
//  Created by Valeria Rocha Sepulveda  on 22/03/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit
import Foundation

class ViewControllerJuego3: UIViewController {
    
    var timer = Timer()
    var seconds = 10.0
    var botones = [UIButton]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        seconds -= 1
        
        //instanciar nuevo boton y conectarlo a la funcion clickBoton
        let button = UIButton(frame: CGRect(x: 10, y: 60, width: 100, height: 30))
        button.backgroundColor = UIColor.green
        button.addTarget(self, action: #selector(clickBoton(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        
        botones.append(button)
        
        for i in 0 ... (botones.count - 1) {
            botones[i].frame.origin.y += 65
        }
        
//        image.center = CGPointMake(image.center.x+position.x, image.center.y+position.y);
//        position = CGPointMake(0.0, 0.15);
        
        
        //
//        if seconds <= 0 {
//            timer.invalidate()
//        }
    }
    
    @objc func clickBoton(sender: UIButton!){
        print("Button tapped")
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
