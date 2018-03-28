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
    var botones = [UIButton]()
    var velCaida = 0.01
    var velCrear = 1.5
    var senaCorrecta : Sena!
    var senas = [Sena]()
    var posX = 0
    var puntos = 0
    var vidas = 5
    
    @IBOutlet weak var lbPuntos: UILabel!
    @IBOutlet weak var lbVidas: UILabel!
    

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
        
        print(senaCorrecta.nombre)
    }
    
    @objc func updateTimerCrear(){
            let screen = UIScreen.main.bounds.size
            var indice = Int(arc4random_uniform(UInt32(senas.count - 1)))
            var coorX = Int(arc4random_uniform(UInt32(screen.width - 130)))
            crearBoton(indice: indice, coorX: coorX)
            
            coorX = (coorX + 640) % (Int(screen.width) - 130)
            indice = Int(arc4random_uniform(UInt32(senas.count - 1)))
            
            crearBoton(indice: indice, coorX: coorX)
        
    }
    
    func crearBoton(indice : Int, coorX: Int){
        let screen = UIScreen.main.bounds.size
        
        posX = (posX + 840) % (Int(screen.width) - 65)  //para probar
        
        //instanciar nuevo boton y ponerle medidas
        let button = UIButton(frame: CGRect(x: coorX/*Int(arc4random_uniform(UInt32(screen.width)))*/, y: 80, width: 130, height: 130))
        
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
        
        //button.setImage(#imageLiteral(resourceName: "Araña"), for: .normal) //para probar el tamaño de la iamgen
        
        //agregarle el target al boton
        button.addTarget(self, action: #selector(clickBoton(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        
        //poner tag, los botones con sena correcta tienen tag de 1
        if senas[indice].nombre == senaCorrecta.nombre {
            button.tag = 1
        }
        
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
        if sender.tag == 1 {
            puntos += 5
            lbPuntos.text = "Puntos: \(puntos)"
        } else {
            vidas -= 1
            lbVidas.text = "Vidas: \(vidas)"
        }
        
        if vidas <= 0 {
            timerCaida.invalidate()
            timerCrear.invalidate()
            //desplegar mensaje que perdio y hacer unwind
            
            let alert = UIAlertController(title: "Perdiste!", message: "Excelente jugada, ganaste \(puntos) puntos.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in print("Foo")
//                performSegue(withIdentifier: "salirJuego", sender: )
            }))
            present(alert, animated: true, completion: nil)

        }
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

//button.setImage(#imageLiteral(resourceName: "Chango"), for: .normal)
//        let image = #imageLiteral(resourceName: "Chango")
//        let imageW = Int(image.size.width * 0.20)
//        let imageH = Int(image.size.height * 0.20)
//        let button = UIButton(frame: CGRect(x: Int(arc4random_uniform(UInt32(screen.width))), y: 60, width: imageW, height: imageH))



//        posX = (posX + 140) % (Int(screen.width) - 65)  //para probar
//
//        //instanciar nuevo boton y ponerle medidas
//        let button = UIButton(frame: CGRect(x: Int(arc4random_uniform(UInt32(screen.width))), y: 10, width: 130, height: 130))
//
//        //Si tiene imagen
//        if let imagen = Bundle.main.path(forResource: senas[indice].nombre, ofType: "imageset", inDirectory: "Assets.xcassets"){
//            print(imagen)
//            let image = UIImage(contentsOfFile: imagen)!
//            button.setImage(image, for: .normal)
//        } else {
//            //si no tiene imagen
//            button.backgroundColor = #colorLiteral(red: 0.7886319331, green: 0.8695178572, blue: 0.9969008565, alpha: 1)
//            button.setTitle(senas[indice].nombre, for: .normal)
//            button.setTitleColor(UIColor.black, for: .normal)
//        }
//
//        button.setImage(#imageLiteral(resourceName: "Araña"), for: .normal) //para probar el tamaño de la iamgen
//
//        //agregarle el target al boton
//        button.addTarget(self, action: #selector(clickBoton(sender:)), for: UIControlEvents.touchUpInside)
//        self.view.addSubview(button)
//
//        //agregar boton al arreglo de botones
//        botones.append(button)
