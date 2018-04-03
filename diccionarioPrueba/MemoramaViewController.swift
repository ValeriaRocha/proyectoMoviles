//
//  MemoramaViewController.swift
//  diccionarioPrueba
//
//  Created by Mickey Rocha on 4/2/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit

class MemoramaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //Parametros del ViewController
    @IBOutlet weak var lbPuntos: UILabel!
    @IBOutlet weak var lbTiempo: UILabel!
    @IBOutlet weak var cvMemorama: UICollectionView!
    //Parametros
    let ArrSenas = [Sena]()
    let prueba = ["1", "2","3", "4","5", "6","7", "8","9", "10","11", "12"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Definiendo el delegate y datasource del collectionview
        self.cvMemorama.delegate = self
        self.cvMemorama.dataSource = self
        
        //Registro de celdas
        self.cvMemorama.register(UINib(nibName: "cartaMemo", bundle: nil), forCellWithReuseIdentifier: "cartaMemo")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Collection View Caracteristicas
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return ArrSenas.count
        return prueba.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //print(collectionView.dequeueReusableCell(withReuseIdentifier: "cartaMemo", for: indexPath))
        //ERROR checar el identifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartaMemo", for: indexPath) as! MemoramaCollectionViewCell
        cell.setData(text: prueba[indexPath.row])
        return cell
    }
    
    // MARK: - Reiniciar Juego
    @IBAction func ReiniciarJuego(_ sender: UIButton) {
    }
    
    /*
     //MARK: - Desplegar Video o Seña
     
     if senaCorrecta.path.hasSuffix(".m4v"){
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
     }
     else{
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
     */
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
