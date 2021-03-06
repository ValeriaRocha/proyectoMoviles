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
    
    @IBOutlet weak var btFav: UIButton!
    var sena : Sena!
    @IBOutlet weak var lbNombreSena: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.title = sena.nombre
        lbNombreSena.text = sena.nombre

        //poner el corazon de favoritos azul si el usuario lo tiene como favorito
        if Usuario.user.hasFav(fav: sena){
            btFav.setImage(#imageLiteral(resourceName: "heartBlue2"), for: .normal)
        } else {
            btFav.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        }
        
        
        //desplegar seña
        if(sena.path.hasSuffix(".m4v")){
            //hacer lo necesario para mostrar el video
            let player = AVPlayer(url: URL(fileURLWithPath: sena.path))
            let controller = AVPlayerViewController()
            controller.player = player
            self.addChildViewController(controller)
            let screenSize = UIScreen.main.bounds.size
            let videoFrame = CGRect(x: self.view.center.x - 250, y: screenSize.height/2 - (470/2 + 55), width: 500 , height: 470)
            controller.view.frame = videoFrame
            self.view.addSubview(controller.view)
            player.play()
        
            
        } else {
            //hacer lo necesario para mostrar la foto
            let imagen = UIImage(contentsOfFile: sena.path)!
            let imageView = UIImageView(image: imagen)
            let screenSize = UIScreen.main.bounds.size
            //let imageFrame =  CGRect(x: 0, y: 10, width: screenSize.width , height: (screenSize.height - 10) * 0.5)
            let imageFrame =  CGRect(x: (self.view.center.x) - ((imagen.size.width * 0.8)/2), y: (screenSize.height/2) - ((imagen.size.height * 0.8)/2 + 25), width: imagen.size.width * 0.8 , height: imagen.size.height * 0.8)
            imageView.frame = imageFrame
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            self.view.addSubview(imageView)
            
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if Usuario.user.hasFav(fav: sena){
            btFav.setImage(#imageLiteral(resourceName: "heartBlue2"), for: .normal)
        } else {
            btFav.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        }
        
    }

    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }

    //cuando el usuario da click en el corazon, agregar o borrar de favoritos
    @IBAction func click(_ sender: UIButton) {
        if Usuario.user.hasFav(fav: sena){
            Usuario.user.quitarFav(fav: sena)
            btFav.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
        } else {
            Usuario.user.guardarFav(fav: sena)
            btFav.setImage(#imageLiteral(resourceName: "heartBlue2"), for: .normal)
        }
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

//let urlVideo = Bundle.main.url(forResource: "Arana_Web", withExtension: "m4v", subdirectory: path)
//Esto que esta abajo era para mostrar el video en pantalla completa
//            let urlVideo = URL(fileURLWithPath: sena.path)
//            let video = AVPlayer(url: urlVideo) //aqui borre un !
//            let videoPlayer = AVPlayerViewController()
//            videoPlayer.player = video
//            present(videoPlayer, animated: true, completion: {
//                video.play()
//            })

