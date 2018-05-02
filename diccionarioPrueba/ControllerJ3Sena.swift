//
//  ControllerJ3Sena.swift
//  diccionarioPrueba
//
//  Created by Valeria Rocha Sepulveda  on 26/03/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit
import AVKit

class ControllerJ3Sena: UIViewController {
    
    var senaCorrecta : Sena!
    var senas =  [Sena]()
    var velCrear = 0.0
    var velCaida = 0.0
    var didLoad = false
    var puntos = 0
    var vidas = 5
    
    @IBOutlet weak var btSalir: UIButton!
    @IBOutlet weak var btJugar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view did load")
        didLoad = true
        velCaida = 0.01
        velCrear = 1.5
        puntos = 0
        vidas = 5
        
        self.title = "Seña Correcta"
        
        escogerSenas()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        print("view did appear")
        
        if !didLoad{
            if velCrear > 1{
                velCaida -= 0.003 //0.002
                velCrear -= 0.3 //0.2
            }
            escogerSenas()
        }
         didLoad = false
    }
    
    func escogerSenas(){
        let aprendidas = Usuario.user.aprendidas()
        let noAprendidas = Usuario.user.noAprendidas()
        
        print("No Aprendidas count " + String(noAprendidas.count))
        
        //escoger 1 seña correcta
        if noAprendidas.count > 0 {
            let indice = Int(arc4random_uniform(UInt32(noAprendidas.count - 1)))
            senaCorrecta = noAprendidas[indice]
            senas.append(senaCorrecta)
            print(senaCorrecta.nombre)
        } else {
            let indice = Int(arc4random_uniform(UInt32(aprendidas.count - 1)))
            senaCorrecta = aprendidas[indice]
            // senas.append(senaCorrecta)
        }
        
        //escoger señas incorrectas que apareceran en la pantalla
        if noAprendidas.count > 14 { //ver si hay suficientes senas no aprendidas para escoger de manera random
            var indice = 0
            for _ in 0 ... 7 {
                repeat{
                    indice = Int(arc4random_uniform(UInt32(noAprendidas.count - 1)))
                }while(noAprendidas[indice].nombre == senaCorrecta.nombre)
                senas.append(noAprendidas[indice])
            }
        } else {
            var i = 0
            var limit = 7
            while i < limit && i < noAprendidas.count{ // si no, agarrar las primeras 7 o menos segun las que haya
                if(noAprendidas[i].nombre == senaCorrecta.nombre){ // si es la sena correcta
                    limit += 1 //no la agrega y sube 1 al limite para que se sigan agregando 7 señas
                } else {
                    senas.append(noAprendidas[i]) //si no si la agrega
                }
                i += 1
            }
            while i < limit {
                var indice = 0
                repeat{
                    indice = Int(arc4random_uniform(UInt32(aprendidas.count - 1))) //checar que no se escoga la sena correcta?
                }while(aprendidas[indice].nombre == senaCorrecta.nombre)
                
                senas.append(aprendidas[indice]) //completar con señas aprendidas
                i += 1
            }
        }
        desplegarVideo()
    }
    
    func desplegarVideo(){
        //desplegar video de la seña
        if senaCorrecta.path.hasSuffix(".m4v") {
            let player = AVPlayer(url: URL(fileURLWithPath: senaCorrecta.path))
            let controller = AVPlayerViewController()
            controller.player = player
            self.addChildViewController(controller)
            let screenSize = UIScreen.main.bounds.size
            //width = 300    height = 270
            let videoFrame = CGRect(x: self.view.center.x - 250, y: screenSize.height/2 - (470/2 + 20), width: 500 , height: 470)
            controller.view.frame = videoFrame
            controller.view.tag = 100
            self.view.addSubview(controller.view)
            player.play()
            
        } else {
            let imagen = UIImage(contentsOfFile: senaCorrecta.path)!
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as? UIButton) == btJugar {
            let destination = segue.destination as! ViewControllerJuego3
            print("Velocidad CAIDA:" + String(velCaida))
            print("Velocidad Crear:" + String(velCrear))
            destination.senaCorrecta = senaCorrecta
            destination.senas = senas
            destination.velCrear = velCrear
            destination.velCaida = velCaida
            destination.puntos = puntos
            destination.vidas = vidas
            
            if let viewWithTag = self.view.viewWithTag(100) {
                viewWithTag.removeFromSuperview()
            }
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }
}


//poner unas como ya aprendidas
//        for c in 0 ..< Usuario.user.model.arrTotal.count - 1{
//            for s in 0 ..< Usuario.user.model.arrTotal[c].arrSena.count{
//                Usuario.user.setSignLearned(named:  Usuario.user.model.arrTotal[c].arrSena[s].nombre, value: true)
//            }
//        }


//if noAprendidas.count > 10 {
//    for _ in 0 ... 7 {
//        let indice = Int(arc4random_uniform(UInt32(noAprendidas.count - 1))) //checar que no se escoga la sena correcta!!!
//        senas.append(noAprendidas[indice])
//    }
//} else {
//    for _ in 0 ... 7 {
//        let indice = Int(arc4random_uniform(UInt32(aprendidas.count - 1)))
//        senas.append(aprendidas[indice])
//    }
//}


//        var animales = Category(nombre: "hola", arrSena: [Sena]())
//        for i in 0 ... (Usuario.user.model.arrTotal.count - 1){
//            if Usuario.user.model.arrTotal[i].nombre == "Animales"{
//                animales = Usuario.user.model.arrTotal[i]
//            }
//        }
//        senas.removeAll()
//        senas += [animales.arrSena[0], animales.arrSena[3], animales.arrSena[6], animales.arrSena[10]]

//
