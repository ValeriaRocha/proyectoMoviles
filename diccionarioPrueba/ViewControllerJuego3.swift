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
    
    var timerCrear = Timer()
    var timerCaida = Timer()
    var seconds = 10.0
    var botones = [UIButton]()
    var velCaida = 0.003
    var velCrear = 0.5

    override func viewDidLoad() {
        super.viewDidLoad()
        
        timerCrear = Timer.scheduledTimer(timeInterval: velCrear, target: self, selector: #selector(self.updateTimerCrear), userInfo: nil, repeats: true)
        timerCaida = Timer.scheduledTimer(timeInterval: velCaida, target: self, selector: #selector(self.updateTimerCaida), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimerCrear(){
        seconds -= 1
        
        //instanciar nuevo boton y conectarlo a la funcion clickBoton
        let screen = UIScreen.main.bounds.size
//        let image = #imageLiteral(resourceName: "Chango")
//        let imageW = Int(image.size.width * 0.20)
//        let imageH = Int(image.size.height * 0.20)
//        let button = UIButton(frame: CGRect(x: Int(arc4random_uniform(UInt32(screen.width))), y: 60, width: imageW, height: imageH))
         let button = UIButton(frame: CGRect(x: Int(arc4random_uniform(UInt32(screen.width))), y: 60, width: 100, height: 30))
        button.backgroundColor = UIColor.green
        button.setTitle("Chango", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        //button.setImage(#imageLiteral(resourceName: "Chango"), for: .normal)
        button.addTarget(self, action: #selector(clickBoton(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        
        //agregar boton al arreglo de botones
        botones.append(button)
        
    }
    
    @objc func updateTimerCaida(){
        
        let screen = UIScreen.main.bounds.size
        
        //hacer que los botones caigan
        var i = 0
        while(i < botones.count) {
            botones[i].frame.origin.y += 1
            
            //quitar los botones que ya pasaron por la parte baja de la pantalla
            if botones[i].frame.origin.y > screen.height {
                botones[i].removeFromSuperview()
                botones.remove(at: i)
            }
            i += 1
        }
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

//        image.center = CGPointMake(image.center.x+position.x, image.center.y+position.y);
//        position = CGPointMake(0.0, 0.15);


//
//        if seconds <= 0 {
//            timer.invalidate()
//        }
