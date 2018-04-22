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
    var timer = Timer()
    var botones = [UIButton]()
    var velCaida : Double!  //0.01
    var velCrear : Double! //1.5
    var senaCorrecta : Sena!
    var learned = false
    var senas = [Sena]()
    var posX = 0
    var puntos = 0
    var vidas = 5
    var timeSenaCorrecta = 0
    var segundos = 0
    
    @IBOutlet weak var lbPuntos: UILabel!
    @IBOutlet weak var lbVidas: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //inicializar timers
        timerCrear = Timer.scheduledTimer(timeInterval: velCrear, target: self, selector: #selector(self.updateTimerCrear), userInfo: nil, repeats: true)
        timerCaida = Timer.scheduledTimer(timeInterval: velCaida, target: self, selector: #selector(self.updateTimerCaida), userInfo: nil, repeats: true)
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCadaSegundo), userInfo: nil, repeats: true)
        
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(aplicacionWillResignActive(notification:)), name: .UIApplicationWillResignActive, object: app)
        NotificationCenter.default.addObserver(self, selector: #selector(aplicacionDidBecomeActive(notification:)), name: .UIApplicationDidBecomeActive, object: app)
        
        
        //poner boton de salir
        self.navigationItem.hidesBackButton = true
        let newBackButton = UIBarButtonItem(title: "Salir", style: UIBarButtonItemStyle.plain, target: self, action: #selector(self.salir(sender:)))
        self.navigationItem.leftBarButtonItem = newBackButton
        
        //inicializar labels de puntos y vidas
        lbPuntos.text = "Puntos: " + String(puntos)
        lbVidas.text = "Vidas: " + String(vidas)
        
        timeSenaCorrecta = Int(arc4random_uniform(UInt32(5) + 2))
        
        print(senaCorrecta.nombre)
    }
    
    @objc func updateCadaSegundo(){
        segundos += 1
        
        if segundos >= 30{
            timerCrear.invalidate()
            timerCaida.invalidate()
            timer.invalidate()
            let alert = UIAlertController(title: "Nueva Seña!", message: "Vimos que ya aprendiste esa seña, asi que toca cambiar!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in print("Foo")
                self.navigationController?.popViewController(animated: true)
            }))
            present(alert, animated: true, completion: nil)
            
        }
    }
    
        @objc func aplicacionWillResignActive(notification: NSNotification){
            print("Will resign active")
            timerCrear.invalidate()
            timerCaida.invalidate()
            timer.invalidate()
        }
    
        @objc func aplicacionDidBecomeActive(notification: NSNotification){
            print("Will enter foreground")
            timerCrear = Timer.scheduledTimer(timeInterval: velCrear, target: self, selector: #selector(self.updateTimerCrear), userInfo: nil, repeats: true)
            timerCaida = Timer.scheduledTimer(timeInterval: velCaida, target: self, selector: #selector(self.updateTimerCaida), userInfo: nil, repeats: true)
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateCadaSegundo), userInfo: nil, repeats: true)
        }
    
    
    @objc func salir(sender: UIBarButtonItem) {
        timerCaida.invalidate()
        timerCrear.invalidate()
        
        //actualizar puntos
        Usuario.user.puntos += puntos
        
        //decir gracias por jugar
        let alert = UIAlertController(title: "Gracias por Jugar!", message: "Excelente jugada, ganaste \(puntos) puntos.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in print("Foo")
            let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
            self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
        }))
        present(alert, animated: true, completion: nil)
        
        //regresar a pantalla de instrucciones
        let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
        self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
    }
    
    @objc func updateTimerCrear(){
        
        let screen = UIScreen.main.bounds.size
        var coorX = Int(arc4random_uniform(UInt32(screen.width - 130)))
        
        //crear boton 1
        timeSenaCorrecta -= 1
        if timeSenaCorrecta <= 0{
            crearBoton(sena: senaCorrecta , coorX: coorX)
            timeSenaCorrecta = Int(arc4random_uniform(UInt32(5) + 2))
        } else {
            let indice = Int(arc4random_uniform(UInt32(senas.count - 1)))
            crearBoton(sena: senas[indice] , coorX: coorX)
        }
        
        //crear boton 2
        timeSenaCorrecta -= 1
        coorX = (coorX + 640) % (Int(screen.width) - 130)
        if timeSenaCorrecta <= 0{
            crearBoton(sena: senaCorrecta , coorX: coorX)
            timeSenaCorrecta = Int(arc4random_uniform(UInt32(5) + 2))
        } else {
            let indice = Int(arc4random_uniform(UInt32(senas.count - 1)))
            crearBoton(sena: senas[indice], coorX: coorX)
        }
        
    }
    
    func crearBoton(sena : Sena, coorX: Int){
        let screen = UIScreen.main.bounds.size
        
        posX = (posX + 840) % (Int(screen.width) - 65)  //para probar
        
        //instanciar nuevo boton y ponerle medidas
        let button = UIButton(frame: CGRect(x: coorX/*Int(arc4random_uniform(UInt32(screen.width)))*/, y: 80, width: 130, height: 130))
        
        //Asignar seña o imagen
        //Si tiene imagen
        if let imagen = UIImage(named: sena.nombre){
            button.setImage(imagen, for: .normal)
            button.setTitle(sena.nombre, for: .normal)
            button.setTitleColor(UIColor.clear, for: .normal)
           
        } else {
            //si no tiene imagen
            button.backgroundColor = #colorLiteral(red: 0.7886319331, green: 0.8695178572, blue: 0.9969008565, alpha: 1)
            button.setTitle(sena.nombre, for: .normal)
            button.setTitleColor(UIColor.black, for: .normal)
        }
        
        //estetica
        button.layer.cornerRadius = 0.07 * button.bounds.size.width
        button.layer.borderWidth = 1
        button.layer.borderColor = #colorLiteral(red: 0.6762949995, green: 0.6667861859, blue: 0.8172390546, alpha: 1)
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        //agregarle el target al boton
        button.addTarget(self, action: #selector(clickBoton(sender:)), for: UIControlEvents.touchUpInside)
        self.view.addSubview(button)
        
        //poner tag, los botones con sena correcta tienen tag de 1
        if sena.nombre == senaCorrecta.nombre {
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
                if botones[i].tag == 1{
                    restaVida()
                }
                botones[i].removeFromSuperview()
                botones.remove(at: i)
            }
            i += 1
        }
        
    }
    
    @objc func clickBoton(sender: UIButton!){
        if sender.tag == 1 {
            learned = true //con una vez que le haya picado a la sena correcta, se considera como aprendida
            
            //poner como aprendida
            Usuario.user.setSignLearned(named: senaCorrecta.nombre, value: true)
            Usuario.user.quitarError(error: senaCorrecta)
            
            for i in 0..<botones.count { //quitar del arreglo de botones
                if sender == botones[i]{
                    botones.remove(at: i)
                    break
                }
            }
            sender.removeFromSuperview() //desaparecer imagen
            puntos += 5
            lbPuntos.text = "Puntos: \(puntos)"
        } else {
            let senaErronea = getSign(forButton: sender)!
            
            //todas las senas incorrectas que haya seleccionado despues de haberle picado a la sena correcta
            //se consideran como errores de dedo
            if !learned{
                Usuario.user.guardarError(error: senaCorrecta)
                Usuario.user.setSignLearned(named: senaCorrecta.nombre, value: false)
                Usuario.user.guardarError(error: senaErronea)
                Usuario.user.setSignLearned(named: senaErronea.nombre, value: false)
            }
            restaVida()
        }
        
    }
    
    //regresa la seña que coincide con el boton forButton
    func getSign(forButton: UIButton)-> Sena? {
        for i in senas {
            if forButton.titleLabel?.text! == i.nombre{
                return i
            }
        }
        return nil
    }
    
    func restaVida(){
        vidas -= 1
        lbVidas.text = "Vidas: " + String(vidas)
        if vidas <= 0{
            timerCaida.invalidate()
            timerCrear.invalidate()

            Usuario.user.puntos += puntos
            let alert = UIAlertController(title: "Perdiste!", message: "Excelente jugada, ganaste \(puntos) puntos.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: {(alert: UIAlertAction!) in print("Foo")
                let viewControllers: [UIViewController] = self.navigationController!.viewControllers as [UIViewController]
                self.navigationController!.popToViewController(viewControllers[viewControllers.count - 3], animated: true)
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


// coorX = (coorX + Int(screen.width)/3) % (Int(screen.width) - 130) //sumarle un cacho del screen width

// let imagen = Bundle.main.url(forResource: senas[indice].nombre, withExtension: "png", subdirectory: "/Assets.xcassets")
//        image.center = CGPointMake(image.center.x+position.x, image.center.y+position.y);
//        position = CGPointMake(0.0, 0.15);


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

//        do {
//
//            let ruta = Bundle.main.executablePath!.appending("/Assets.car")
//            let paths = try FileManager.default.contentsOfDirectory(atPath:  ruta)
//
//            for i in 0 ... paths.count - 1{
//                print(paths[i])
//            }
//        } catch {
//            print("error")
//        }
//

//            if botones[i].frame.origin.y > (screen.height - botones[i].frame.height/2) {
//                if botones[i].currentImage != nil {
//                    botones[i].backgroundColor = #colorLiteral(red: 1, green: 0.2432638497, blue: 0.2501392129, alpha: 1)
//                    botones[i].layer.borderColor = #colorLiteral(red: 1, green: 0.2432638497, blue: 0.2501392129, alpha: 1)
//                    botones[i].setImage(nil, for: .normal)
//                } else {
//                    botones[i].backgroundColor = #colorLiteral(red: 1, green: 0.2432638497, blue: 0.2501392129, alpha: 1)
//                    botones[i].layer.borderColor = #colorLiteral(red: 1, green: 0.2432638497, blue: 0.2501392129, alpha: 1)
//                }
//            }

