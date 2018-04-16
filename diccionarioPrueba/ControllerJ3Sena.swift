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
    
    @IBOutlet weak var btSalir: UIButton!
    @IBOutlet weak var btJugar: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //escoger una seña
        let aprendidas = Usuario.user.aprendidas()
        let noAprendidas = Usuario.user.noAprendidas()
        
        if noAprendidas.count > 0 {
            let indice = Int(arc4random_uniform(UInt32(noAprendidas.count - 1)))
            senaCorrecta = noAprendidas[indice]
            senas.append(senaCorrecta)
            print(senaCorrecta.nombre)
        } else {
            let indice = Int(arc4random_uniform(UInt32(aprendidas.count - 1)))
            senaCorrecta = aprendidas[indice]
            senas.append(senaCorrecta)
        }
        
        //escoger señas incorrectas que apareceran en la pantalla !!!!FALTA!!!!!!!
        if noAprendidas.count > 10 {
            for i in 0 ... 7 {
                 let indice = Int(arc4random_uniform(UInt32(noAprendidas.count - 1))) //checar que no se escoga la sena correcta!!!
                senas.append(noAprendidas[indice])
            }
        } else {
            for i in 0 ... 7 {
                let indice = Int(arc4random_uniform(UInt32(aprendidas.count - 1)))
                senas.append(aprendidas[indice])
            }
        }
        
        
//        var animales = Category(nombre: "hola", arrSena: [Sena]())
//        for i in 0 ... (Usuario.user.model.arrTotal.count - 1){
//            if Usuario.user.model.arrTotal[i].nombre == "Animales"{
//                animales = Usuario.user.model.arrTotal[i]
//            }
//        }
//        senas.removeAll()
//        senas += [animales.arrSena[0], animales.arrSena[3], animales.arrSena[6], animales.arrSena[10]]
//
//
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
            self.view.addSubview(imageView)
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindSalirSena(unwindSegue : UIStoryboardSegue){
        //performSegue(withIdentifier: "salir", sender: self)
        print("Hola estoy en el unwind de salir sena")
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as? UIButton) == btJugar {
            let destination = segue.destination as! ViewControllerJuego3
            destination.senaCorrecta = senaCorrecta
            destination.senas = senas
        }
    }
    

}
