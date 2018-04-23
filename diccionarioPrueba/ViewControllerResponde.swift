//
//  ViewControllerResponde.swift
//  diccionarioPrueba
//
//  Created by Clarissa Miranda on 29/03/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit
import AVKit

class ViewControllerResponde: UIViewController {
    var imageView : UIImageView!
    var controller : AVPlayerViewController!
    var senaCorrecta : Sena!
    var senaAux: Sena!
    var iRandCat : Int!
    var iRandSen : Int!
    var iCorrectaCat : Int!
    var iCorrectaSen : Int!
    var iTotalCat = Usuario.user.model.arrTotal.count - 1
    var iTotalSen : Int!
    var iBotCorrecto : Int!
    var iRandBot : Int!
    var puntos = 0
    var vidas = 3
    var iC = 1
    @IBOutlet weak var lbVidas: UILabel!
    @IBOutlet weak var lbPuntos: UILabel!
    @IBOutlet weak var btTopDer: UIButton!
    @IBOutlet weak var btAbDer: UIButton!
    @IBOutlet weak var btAbIzq: UIButton!
    @IBOutlet weak var btTopIzq: UIButton!
    var arrButton = [UIButton]()
    var arrSelec = [false,false,false,false]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "BgResponde"))
        puntos = 0
        vidas = 3
        
        // agregar target a botón
        btTopDer.addTarget(self, action: #selector(clickBoton(sender:)), for: UIControlEvents.touchUpInside)
        btTopIzq.addTarget(self, action: #selector(clickBoton(sender:)), for: UIControlEvents.touchUpInside)
        btAbDer.addTarget(self, action: #selector(clickBoton(sender:)), for: UIControlEvents.touchUpInside)
        btAbIzq.addTarget(self, action: #selector(clickBoton(sender:)), for: UIControlEvents.touchUpInside)
        
        
        //inicializar arreglo de botones
        arrButton.append(btTopDer)
        arrButton.append(btTopIzq)
        arrButton.append(btAbDer)
        arrButton.append(btAbIzq)
        
        generarNuevo()
    }
    
    func subraya(sString : String) -> NSAttributedString
    {
        let attrs = [
            NSAttributedStringKey.foregroundColor : UIColor.black,
            NSAttributedStringKey.underlineStyle : NSUnderlineStyle.styleSingle.rawValue
            ] as [NSAttributedStringKey : Any]

        let underlineAttributedString = NSAttributedString(string: sString, attributes:attrs)
        
        return underlineAttributedString
    }
    
    func generarNuevo()
    {
        iC = 1
        arrSelec = [false,false,false,false]
        
        // Almacenar seña correcta
        repeat{
            iCorrectaCat = Int(arc4random_uniform(UInt32(iTotalCat)))
            iTotalSen = Usuario.user.model.arrTotal[iCorrectaCat].arrSena.count - 1
            iCorrectaSen = Int(arc4random_uniform(UInt32(iTotalSen)))
            senaCorrecta = Usuario.user.model.arrTotal[iCorrectaCat].arrSena[iCorrectaSen]
        }while(senaCorrecta.aprendida==true)
        
        // Fijar seña en botón
        iBotCorrecto = Int(arc4random_uniform(4))
        // Formato de botón
        arrButton[iBotCorrecto].setAttributedTitle(subraya(sString: senaCorrecta.nombre), for: .normal)
        
        arrSelec[iBotCorrecto] = true
        
        // Fijar otros botones
        repeat{
            // Verificar que no aparezca la seña correcta como opción incorrecta
            repeat{
                iRandCat = Int(arc4random_uniform(UInt32(iTotalCat)))
                iTotalSen = Usuario.user.model.arrTotal[iRandCat].arrSena.count - 1
                iRandSen = Int(arc4random_uniform(UInt32(iTotalSen)))
            }while((iRandCat == iCorrectaCat) && (iCorrectaSen == iRandSen))
            
            // Fijar seña auxiliar
            senaAux = Usuario.user.model.arrTotal[iRandCat].arrSena[iRandSen]
            
            // Escoger el botón random
            repeat{
                iRandBot = Int(arc4random_uniform(4))
            }while(arrSelec[iRandBot]==true)
            
            // Formato de botón
            arrButton[iRandBot].setAttributedTitle(subraya(sString: senaAux.nombre), for: .normal)

            arrSelec[iRandBot] = true
            iC = iC + 1
        }while(iC<4)
        
        //desplegar video o imagen de la seña
        
        if senaCorrecta.path.hasSuffix(".m4v") {
            let player = AVPlayer(url: URL(fileURLWithPath: senaCorrecta.path))
            controller = AVPlayerViewController()
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
            imageView = UIImageView(image: imagen)
            let screenSize = UIScreen.main.bounds.size
            //let imageFrame =  CGRect(x: 0, y: 10, width: screenSize.width , height: (screenSize.height - 10) * 0.5)
            let imageFrame =  CGRect(x: (self.view.center.x) - ((imagen.size.width * 0.8)/2), y: (screenSize.height/2) - ((imagen.size.height * 0.8)/2 + 25), width: imagen.size.width * 0.8 , height: imagen.size.height * 0.8)
            imageView.frame = imageFrame
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            self.view.addSubview(imageView)
        }
    }
    
    @objc func clickBoton(sender: UIButton!){
        if sender == arrButton[iBotCorrecto] {
            puntos = puntos + 1
            lbPuntos.text = "Puntos: \(puntos)"
            if((imageView) != nil)
            {
                imageView.removeFromSuperview()
            }
            if(controller != nil)
            {
                controller.view.removeFromSuperview()
            }
            senaCorrecta.aprendida = true
            generarNuevo()
            
        } else {
            vidas -= 1
            lbVidas.text = "Vidas: \(vidas)"
            if vidas > 0
            {
                let alert = UIAlertController(title: "", message: "Perdiste una vida", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in print("Foo")
                }))
                present(alert, animated: true, completion: nil)
            }
            Usuario.user.guardarError(error: senaCorrecta)
            if(vidas != 0)
            {
                generarNuevo()
            }
        }
        
        if vidas <= 0 {
            // agregar puntos a usuario
            Usuario.user.puntos = Usuario.user.puntos + puntos
            
            //desplegar mensaje que perdio y hacer unwind
            let alert = UIAlertController(title: "Perdiste!", message: "Excelente jugada, ganaste \(puntos) puntos.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in print("Foo")
                self.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true, completion: nil)
            
            // registro de persistencia
            //Usuario.user.guardaUsuario()
        }
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
