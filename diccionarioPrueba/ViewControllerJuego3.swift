//
//  ViewControllerJuego3.swift
//  diccionarioPrueba
//
//  Created by Valeria Rocha Sepulveda  on 22/03/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit
import Foundation
import AVKit

class ViewControllerJuego3: UIViewController {
    
    var timerCrear = Timer()
    var timerCaida = Timer()
    var seconds = 10.0
    var botones = [UIButton]()
    var velCaida = 0.008
    var velCrear = 0.7
    var senaCorrecta : Sena!
    var senas = [Sena]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //inicializar timers
        timerCrear = Timer.scheduledTimer(timeInterval: velCrear, target: self, selector: #selector(self.updateTimerCrear), userInfo: nil, repeats: true)
        timerCaida = Timer.scheduledTimer(timeInterval: velCaida, target: self, selector: #selector(self.updateTimerCaida), userInfo: nil, repeats: true)
        
//        do {
//            let paths = try FileManager.default.contentsOfDirectory(atPath: Bundle.main.bundlePath + "/diccionarioPrueba")
//            for i in 0 ... paths.count - 1{
//                print(paths[i])
//            }
//        } catch {
//            print("error")
//        }
    }
    
    @objc func updateTimerCrear(){
        seconds -= 1
        let indice = Int(arc4random_uniform(UInt32(senas.count - 1)))
        
        
        //instanciar nuevo boton y conectarlo a la funcion clickBoton
        let screen = UIScreen.main.bounds.size
        let button = UIButton(frame: CGRect(x: Int(arc4random_uniform(UInt32(screen.width))), y: 10, width: 150, height: 150))
        
        //Si tiene imagen
        
        if let imagen = Bundle.main.path(forResource: senas[indice].nombre, ofType: "imageset", inDirectory: "Assets.xcassets"){
            print(imagen)
            let image = UIImage(contentsOfFile: imagen)!
            button.setImage(image, for: .normal)
        } else {
            
            //si no tiene imagen
            button.backgroundColor = #colorLiteral(red: 0.7886319331, green: 0.8695178572, blue: 0.9969008565, alpha: 1)
            button.setTitle(senas[indice].nombre, for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
        }
        
        
        
        button.addTarget(self, action: #selector(clickBoton(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        
        //agregar boton al arreglo de botones
        botones.append(button)
        
    }
     //button.setImage(#imageLiteral(resourceName: "Chango"), for: .normal)
    //        let image = #imageLiteral(resourceName: "Chango")
    //        let imageW = Int(image.size.width * 0.20)
    //        let imageH = Int(image.size.height * 0.20)
    //        let button = UIButton(frame: CGRect(x: Int(arc4random_uniform(UInt32(screen.width))), y: 60, width: imageW, height: imageH))
    
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
// let imagen = Bundle.main.url(forResource: senas[indice].nombre, withExtension: "png", subdirectory: "/Assets.xcassets")
//        image.center = CGPointMake(image.center.x+position.x, image.center.y+position.y);
//        position = CGPointMake(0.0, 0.15);


//
//        if seconds <= 0 {
//            timer.invalidate()
//        }
