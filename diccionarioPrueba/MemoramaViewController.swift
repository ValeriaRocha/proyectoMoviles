//
//  MemoramaViewController.swift
//  diccionarioPrueba
//
//  Created by Mickey Rocha on 4/2/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit
import AVKit

class MemoramaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //Outlets del MemoramaCollectionController
    @IBOutlet weak var lbPuntos: UILabel!
    @IBOutlet weak var lbTiempo: UILabel!
    @IBOutlet weak var cvMemorama: UICollectionView!
    
    //Parametro Puntos
    var puntos = 0
    //Parametros de tiempo
    var tiempo = Timer()
    var segundos = 0
    //Parametro para obtener los recursos
    var baraja = [Category]()
    var ArrSenas = [Sena]()
    //Parametros para dar dorma a las cartas del memorama
    var deck = [MemoramaCollectionViewCell.Carta]()
    var card: MemoramaCollectionViewCell.Carta!
    var selectIndexes = [IndexPath]()
    
    //var ArrPathSenas = [String]()
    //var deck = [Carta]()
    //var card: Carta!
    //Contadores para el shuffle de las celdas
    //var contSen = 0
    //var contImg = 0
    //var iContSen = 0
    //var iContImg = 0
    //var barajaShuffle1 = [Sena]()
    //var barajaShuffle2 = [String]()
    //var validar: Bool!
    //var cartasSelec = [MemoramaCollectionViewCell]()
    //var barajaShuffle = [String]()
    //var carta1 = String()
    //var carta2 = String()
    //let prueba = ["1", "2","3", "4","5", "6","7", "8","9", "10","11", "12","1", "2","3", "4","5", "6","7", "8","9", "10","11", "12"] //prueba
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Definiendo el delegate y datasource del collectionview
        self.cvMemorama.delegate = self
        self.cvMemorama.dataSource = self
        cvMemorama.isUserInteractionEnabled = true
        
        baraja = Usuario.user.model.arrTotal
        segundos = 300
        puntos = 0
        card = MemoramaCollectionViewCell.Carta(senaImg: true, sena: baraja[0].arrSena[0])
        lbPuntos.text = "Puntos: 0"
        
        //Correr tiempo
        runTime()
        
        //Obtener las señas para la baraja (la primera mitad)
        for index in 0...11{
            let randCategoria = Int(arc4random_uniform(UInt32(baraja.count - 1)))
            let randSena = Int(arc4random_uniform(UInt32(baraja[randCategoria].arrSena.count - 1)))
            
            ArrSenas.append(baraja[randCategoria].arrSena[randSena])
            baraja[randCategoria].arrSena.remove(at: randSena)
            //baraja.remove(at: randCategoria) //Para borrar categoria
        }
        
        for index2 in 0...11{
            card = MemoramaCollectionViewCell.Carta(senaImg: true, sena: ArrSenas[index2])
            deck.append(card)
        }
        
        for index3 in 0...11{
            card = MemoramaCollectionViewCell.Carta(senaImg: false, sena: ArrSenas[index3])
            deck.append(card)
        }
        
        for index5 in 0...deck.count - 1{
            print(deck[index5].sena.nombre)
            if index5 == 11{
                print("=======================")
            }
        }
        
        print("=================================")
        for index6 in 0...(deck.count / 2) - 1{
            print(deck[index6].sena.path)
            if index6 == 11{
                print("=======================")
            }
        }
        
        //Definir valores
        //contSen = 12
        //contImg = 12
        //validar = true
        //card = Carta(senaImg: true, sena: baraja[0].arrSena[0])
        //        for index2 in 0...11{
        //            card = Carta(senaImg: true, sena: ArrSenas[index2])
        //            deck.append(card)
        //        }
        //
        //        for index3 in 0...11{
        //            card = Carta(senaImg: false, sena: ArrSenas[index3])
        //            deck.append(card)
        //        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Collection View Caracteristicas
    //Funcion para obtener la cantidad de objetos en el collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return self.ArrSenas.count
        return 24
    }
    
    //Funcion para desplegar detalles en las celdas del collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartaMemo", for: indexPath) as! MemoramaCollectionViewCell
        
        let carta = deck[indexPath.row]
        
        if (carta.senaImg){
            cell.lbCarta.text = "Seña"
        }else{
            cell.lbCarta.text = "Imagen"
        }
        cell.renderCarta(senaImg: carta.senaImg, sena: carta.sena)
        return cell
    }
    
    //Funcion para seleccionar objetos del collection view
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectIndexes.count == 2{
            return
        }
        
        selectIndexes.append(indexPath)
        
        let carta = collectionView.cellForItem(at: indexPath) as! MemoramaCollectionViewCell
        
        //Codigo para motrar la primera carta
        if carta.sena.path.hasSuffix(".m4v"){
            let player = AVPlayer(url: URL(fileURLWithPath: carta.sena.path))
            let controller = AVPlayerViewController()
            controller.player = player
            self.addChildViewController(controller)
            let screenSize = UIScreen.main.bounds.size
            //            let boton = UIButton()
            //            boton.target(forAction: #selector(handleExit), withSender: <#T##Any?#>)
            
            //width = 300    height = 270
            let videoFrame = CGRect(x: self.view.center.x - 250, y: screenSize.height/2 - (470/2 + 20), width: 500 , height: 470)
            controller.view.frame = videoFrame
            self.view.addSubview(controller.view)
            
            player.play()
            
        }
        else{
            let imagen = UIImage(contentsOfFile: carta.sena.path)!
            let imageView = UIImageView(image: imagen)
            let screenSize = UIScreen.main.bounds.size
            //let imageFrame =  CGRect(x: 0, y: 10, width: screenSize.width , height: (screenSize.height - 10) * 0.5)
            let imageFrame =  CGRect(x: (self.view.center.x) - ((imagen.size.width * 0.8)/2), y: (screenSize.height/2) - ((imagen.size.height * 0.8)/2 + 25), width: imagen.size.width * 0.8 , height: imagen.size.height * 0.8)
            imageView.frame = imageFrame
            imageView.contentMode = UIViewContentMode.scaleAspectFit
            self.view.addSubview(imageView)
        }
        
        if selectIndexes.count < 2{
            return
        }
        
        let carta1 = deck[selectIndexes[0].row]
        let carta2 = deck[selectIndexes[1].row]
        
        if carta1.sena.nombre == carta2.sena.nombre && carta1.senaImg != carta2.senaImg{
            puntos += 5
            lbPuntos.text = "Puntos: \(puntos)"
            //            for index4 in 0...1{
            //                //carta.isHidden = true
            //                deck.remove(at: selectIndexes[index4].row)
            //            }
            if puntos == 60{
                //Creacion de alerta
                let alerta = UIAlertController(title: "Ganaste!!!", message: "Terminaste en \(timeFormat(time: TimeInterval(segundos))) con \(puntos) puntos", preferredStyle: .alert)
                
                alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                
                //Para mostrarlo
                present(alerta, animated: true, completion: nil)
                
                //Para detener el tiempo
                tiempo.invalidate()
                
                //El juego deja de ser interactivo
                cvMemorama.isUserInteractionEnabled = false
            }else{
                cvMemorama.reloadData()
            }
        }
        
        selectIndexes.removeAll()
    }
    
    
    // MARK: - Reiniciar Juego
    @IBAction func ReiniciarJuego(_ sender: UIButton) {
        tiempo.invalidate() //Desactiva el tiempo
        deck.removeAll()
        ArrSenas.removeAll()
        viewDidLoad()
        cvMemorama.reloadData()
    }
    
    // MARK: - Tiempo
    
    //Funcion para correr el tiempo, utliza la funcion UpdateTime() para actualizar el outlet label de puntos
    func runTime(){
        tiempo = Timer.scheduledTimer(timeInterval: 1, target: self, selector: (#selector(MemoramaViewController.updateTime)), userInfo: nil, repeats: true)
    }
    
    //Funcion que actualiza el tiempo en el label y verifica cuando se acabo el tiempo para desplegar el fin del juego con los puntos obtenidos
    @objc func updateTime(){
        if segundos == 0{
            //Creacion de alerta
            let alerta = UIAlertController(title: "Fin del juego", message: "Obtuviste \(puntos) puntos", preferredStyle: .alert)
            
            alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            //Para mostrarlo
            present(alerta, animated: true, completion: nil)
            
            //Para detener el tiempo
            tiempo.invalidate()
            
            //El juego deja de ser interactivo
            cvMemorama.isUserInteractionEnabled = false
        }
        else{
            segundos -= 1
            lbTiempo.text = "Tiempo: " + timeFormat(time: TimeInterval(segundos)) // <- Con formato (Despliega los minutos y segundos)
            //        lbTiempo.text = "Tiempo: " + "\(segundos)" <- Sin formato (solo despliega los segundos)
        }
    }
    
    //Funcion que da el formato al tiempo
    func timeFormat(time: TimeInterval) -> String{
        let minutos = Int(time) / 60 % 60
        let segundos = Int(time) % 60
        
        return String(format: "%02i:%02i", minutos, segundos)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    /*
     // MARK: UICollectionViewDelegate
     
     
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
    /*
     
     
     */
    
    /*
     override func viewDidLoad() {
     super.viewDidLoad()
     
     //Definiendo el delegate y datasource del collectionview
     self.cvMemorama.delegate = self
     self.cvMemorama.dataSource = self
     
     //Definir valores
     contSen = 12
     contImg = 12
     validar = true
     baraja = Usuario.user.model.arrTotal
     segundos = 300
     //card = Carta(senaImg: true, sena: baraja[0].arrSena[0])
     
     
     //Correr tiempo
     runTime()
     
     //Obtener las señas para la baraja (la primera mitad)
     for index in 0...11{
     let randCategoria = Int(arc4random_uniform(UInt32(baraja.count - 1)))
     let randSena = Int(arc4random_uniform(UInt32(baraja[randCategoria].arrSena.count - 1)))
     
     ArrSenas.append(baraja[randCategoria].arrSena[randSena])
     baraja[randCategoria].arrSena.remove(at: randSena)
     //baraja.remove(at: randCategoria)
     
     }
     
     for index in 0...11{
     //            deck[index].sena = ArrSenas[index]
     //            deck[index].senaImg = true
     card.sena = ArrSenas[index]
     card.senaImg = true
     deck.append(card)
     }
     
     for index in 0...11{
     card.sena = ArrSenas[index]
     card.senaImg = false
     deck.append(card)
     
     }
     
     /*
     //        //Obtener las señas para la baraja (la segunda mitad)
     //        for index in 0...11{
     //            ArrSenas.append(ArrSenas[index])
     //        }
     
     //Validar la baraja
     for index in 0...ArrSenas.count - 1{
     print("\(index): " + ArrSenas[index].nombre)
     
     }
     
     for index in 0...ArrSenas.count - 1{
     ArrPathSenas.append(ArrSenas[index].path)
     print("\(index): " + ArrSenas[index].nombre)
     }
     
     print("===================================================")
     for index in 0...ArrSenas.count - 1{
     let random = Int(arc4random_uniform(UInt32(ArrSenas.count - 1)))
     
     barajaShuffle1.append(ArrSenas[random])
     ArrSenas.remove(at: random)
     }
     
     for index in 0...ArrPathSenas.count - 1{
     let random = Int(arc4random_uniform(UInt32(ArrPathSenas.count - 1)))
     
     barajaShuffle2.append(ArrPathSenas[random])
     ArrPathSenas.remove(at: random)
     }
     
     //Validar la baraja
     for index in 0...barajaShuffle1.count - 1{
     print("\(index): " + barajaShuffle1[index].nombre)
     }
     
     for index in 0...barajaShuffle2.count - 1{
     print("\(index): " + barajaShuffle2[index])
     }
     
     print("===================================================")
     */
     */
    
    /*
     //Funcion para desplegar detalles en las celdas del collection view
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartaMemo", for: indexPath) as! MemoramaCollectionViewCell
     
     
     //cell.lbCarta.text = self.prueba[indexPath.row]
     
     if validar{
     let random = arc4random_uniform(UInt32(2)) + 1
     if (random == 1 && contSen != 0){
     cell.lbCarta.text = "Seña"
     cell.Carta(nombre: barajaShuffle1[iContSen].nombre, imagen: "")
     iContSen += 1
     contSen -= 1
     if contSen == 0{
     validar = false
     }
     }
     else if (random == 2 && contImg != 0){
     cell.lbCarta.text = "Imagen"
     cell.Carta(nombre: "", imagen: barajaShuffle2[iContImg])
     iContImg += 1
     contImg -= 1
     if contImg == 0{
     validar = false
     }
     }
     }
     else if contSen != 0{
     contSen -= 1
     cell.lbCarta.text = "Seña"
     cell.Carta(nombre: barajaShuffle1[iContSen].nombre, imagen: "")
     iContSen += 1
     }
     else{
     contImg -= 1
     cell.lbCarta.text = "Imagen"
     cell.Carta(nombre: "", imagen: barajaShuffle2[iContImg])
     iContImg += 1
     }
     
     //        print("contSen: \(contSen)")
     //        print("contImg: \(contImg)")
     //        print("contImg: \(iContSen)")
     //        print("contImg: \(iContImg)")
     
     return cell
     
     
     }
     */
    /*
     //Funcion para seleccionar objetos del collection view
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
     /*
     if selectIndexes.count == 2{
     return
     }
     
     selectIndexes.append(indexPath)
     
     let carta = collectionView.cellForItem(at: indexPath) as! MemoramaCollectionViewCell
     
     if selectIndexes.count < 2{
     return
     }
     
     if carta.imagen != ""{
     carta1 = carta.imagen!
     }
     else if carta.nombre != ""{
     carta1 = carta.nombre!
     }
     */
     }
     */
}
