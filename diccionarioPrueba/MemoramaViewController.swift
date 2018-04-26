//
//  MemoramaViewController.swift
//  diccionarioPrueba
//
//  Created by Mickey Rocha on 4/2/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit
import AVKit

class MemoramaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    //Outlets del MemoramaCollectionController
    @IBOutlet weak var lbTiempo: UILabel!
    @IBOutlet weak var lbPuntos: UILabel!
    @IBOutlet weak var lbIntentos: UILabel!
    @IBOutlet weak var cvMemorama: UICollectionView!
    
    
    //Parametro Puntos
    var puntos = 0
    var intentos = 0
    //Parametros de tiempo
    var tiempo = Timer()
    var segundos = 0
    //Parametro para obtener los recursos
    var baraja = [Category]()
    var ArrSenas = [Sena]()
    //Parametros para dar dorma a las cartas del memorama
    var deck = [MemoramaCollectionViewCell.Carta]()
    var deckRandom = [MemoramaCollectionViewCell.Carta]()
    var card: MemoramaCollectionViewCell.Carta!
    var selectIndexes = [IndexPath]()
    var cartasSeleccionadas = [MemoramaCollectionViewCell]()
    var cartasObtenidas = [MemoramaCollectionViewCell]() //baraja donde se tiene el par de cartas para volverlas a desplegar al momento de seleccionar reiniciar
    var cartasTemas = [String]()
    var iguales = Bool()
    
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
        intentos = 0
        lbIntentos.text = "Intentos: 0"
        iguales = false
        
        //Correr tiempo
        runTime()
        
        //Obtener las señas para la baraja (la primera mitad)
        for index in 0...11{
            var randCategoria = Int(arc4random_uniform(UInt32(baraja.count)))
            var randSena = Int(arc4random_uniform(UInt32(baraja[randCategoria].arrSena.count)))
            //baraja[randCategoria].arrSena.remove(at: randSena)
            //baraja.remove(at: randCategoria) //Para borrar categoria
            if index != 0{
                for var chequeo in 0...index - 1{
                    print("============================")
                    print(baraja[randCategoria].arrSena[randSena].nombre)
                    print("============================")
                    while(ArrSenas[chequeo].nombre == baraja[randCategoria].arrSena[randSena].nombre){
                        randCategoria = Int(arc4random_uniform(UInt32(baraja.count)))
                        randSena = Int(arc4random_uniform(UInt32(baraja[randCategoria].arrSena.count)))
                        chequeo = 0
                    }
                }
            }
            ArrSenas.append(baraja[randCategoria].arrSena[randSena])
            print(ArrSenas[index].nombre)
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
        
        //        print("=================================")
        //        for index6 in 0...(deck.count / 2) - 1{
        //            print(deck[index6].sena.path)
        //            if index6 == 11{
        //                print("=======================")
        //            }
        //        }
        
        for index in 0...deck.count - 1{
            let randCategoria = Int(arc4random_uniform(UInt32(deck.count - 1)))
            deckRandom.append(deck[randCategoria])
            deck.remove(at: randCategoria)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Collection View Caracteristicas
    //Funcion para obtener la cantidad de objetos en el collection view
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 24
    }
    
    //Funcion para desplegar detalles en las celdas del collection view
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cartaMemo", for: indexPath) as! MemoramaCollectionViewCell
        
        let carta = deckRandom[indexPath.row]
        
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
        
        if iguales{
            if selectIndexes[0] == indexPath{
                if carta.senaImg == false{
                    let popOver = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopOver") as! PopOverViewController
                    popOver.carta = carta
                    self.addChildViewController(popOver)
                    popOver.view.frame = self.view.frame
                    self.view.addSubview(popOver.view)
                    popOver.didMove(toParentViewController: self)
                }
                selectIndexes.remove(at: 1)
                return
            }
        }
        cartasSeleccionadas.append(carta)
        cartasObtenidas.append(carta)
        cartasTemas.append(carta.lbCarta.text!)
        if carta.lbCarta.text == "Imagen"{
            let popOver = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopOver") as! PopOverViewController
            popOver.carta = carta
            self.addChildViewController(popOver)
            popOver.view.frame = self.view.frame
            self.view.addSubview(popOver.view)
            popOver.didMove(toParentViewController: self)
        }
        else{
            carta.lbCarta.text = carta.sena.nombre
        }
       iguales = true
        carta.lbCarta.text = carta.sena.nombre
        
        if selectIndexes.count < 2{
            return
        }
        
        let carta1 = deckRandom[selectIndexes[0].row]
        let carta2 = deckRandom[selectIndexes[1].row]
        
        print("Cartas Seleccionadas")
        print(carta1.sena.nombre)
        print(carta2.sena.nombre)
        
        intentos += 1
        lbIntentos.text = "Intentos: \(intentos)"
        Validar(carta1: carta1, carta2: carta2)
        selectIndexes.removeAll()
        cartasSeleccionadas.removeAll()
        cartasTemas.removeAll()
        iguales = false
    }
    
    func Validar(carta1: MemoramaCollectionViewCell.Carta, carta2: MemoramaCollectionViewCell.Carta){
        if carta1.sena.nombre == carta2.sena.nombre && carta1.senaImg != carta2.senaImg{
            
            let alerta = UIAlertController(title: "Tus cartas selecciconadas", message: "Carta #1: " + carta1.sena.nombre + "\nes igual \nCarta #2: " + carta2.sena.nombre, preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            puntos += 5
            lbPuntos.text = "Puntos: \(puntos)"
            for index4 in 0...1{
                cartasSeleccionadas[index4].isHidden = true
            }
            
            if puntos == 60{
                //Creacion de alerta
                let alerta = UIAlertController(title: "Ganaste!!!", message: "Terminaste en \(timeFormat(time: TimeInterval(segundos))) con \(puntos) puntos", preferredStyle: .alert)
                
                alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alerta: UIAlertAction!) in self.navigationController?.popViewController(animated: true)}))
                
                //Para mostrarlo
                present(alerta, animated: true, completion: nil)
                
                //Para detener el tiempo
                tiempo.invalidate()
                
                //El juego deja de ser interactivo
                cvMemorama.isUserInteractionEnabled = false
                
                //Guardar los puntos del usuario
                Usuario.user.puntos += puntos
                return
            }
            present(alerta, animated: true, completion: nil)
        }
        else{
            let alerta = UIAlertController(title: "Tus cartas selecciconadas", message: "Carta #1: " + carta1.sena.nombre + " \nno es igual \nCarta #2: " + carta2.sena.nombre, preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            present(alerta, animated: true, completion: nil)
            for index5 in 0...1{
                //carta.lbCarta.text = cartasTemas[index5]
                cartasSeleccionadas[index5].lbCarta.text = cartasTemas[index5]
                //cartasSeleccionadas[index5].lbCarta.backgroundColor = UIColor.init(red: CGFloat(102), green: CGFloat(153), blue: CGFloat(255), alpha: 0)
            }
        }
        //sleep(UInt32(1.75))
    }
    
    // MARK: - Reiniciar Juego
    @IBAction func ReiniciarJuego(_ sender: UIButton) {
        if cartasObtenidas.count != 0{
            for index6 in 0...cartasObtenidas.count - 1{
                cartasObtenidas[index6].isHidden = false
            }
        }
        tiempo.invalidate() //Desactiva el tiempo
        deckRandom.removeAll()
        ArrSenas.removeAll()
        viewDidLoad()
        cvMemorama.reloadData()
        selectIndexes.removeAll()
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
            
            alerta.addAction(UIAlertAction(title: "OK", style: .default, handler: {(alerta: UIAlertAction!) in self.navigationController?.popViewController(animated: true)}))
            
            //Para mostrarlo
            present(alerta, animated: true, completion: nil)
            
            //Para detener el tiempo
            tiempo.invalidate()
            
            //El juego deja de ser interactivo
            cvMemorama.isUserInteractionEnabled = false
            
            //Guardar los puntos del usuario
            Usuario.user.puntos += puntos
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
}
