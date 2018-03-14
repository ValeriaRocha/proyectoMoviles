//
//  Modelo.swift
//  diccionarioPrueba
//
//  Created by Clarissa Miranda on 13/03/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit

class Modelo {
    var arrTotal : [Category]
//    var fav : [String]
//    var mal : [String]
    
    init(){
//        fav = [String]();
//        mal = [String]();
//        let sena1 = Sena(nombre: "Arana_web", path: "LenguajeSenasMexicano_Web/LSM_Animales_Web")
//        var arrSena = [Sena]()
//        arrSena.append(sena1)
//        let cat = Category(nombre: "Animales", arrSena: arrSena)
//        var arrCat = [Category]()
//        arrCat.append(cat)
//        self.arrTotal = arrCat
        
        
        var sena1 : Sena
        var cat : Category
        var arrSenas = [Sena]()
        var arrCat = [Category]()
        var string = ""
        let paths2 : [String]
        
        do{
            let path1 = Bundle.main.bundlePath + "/LenguajeSenasMexicano_Web"
            paths2 = try FileManager.default.contentsOfDirectory(atPath: path1) //paths2 tiene la lista de los folders adentro del path1
            
            //loop que recorre la lista de las categorias
            for i in 0 ... (paths2.count - 1){
                print(paths2[i])
                arrSenas.removeAll()
                
                do{
                    //pathSenas obtiene los nombres de los receursos adentro de la categoria paths2[i]
                    let pathsSenas = try FileManager.default.contentsOfDirectory(atPath: path1 + "/" + paths2[i])
                    
                    //loop que recorre la lista de las señas de una dada categoria
                    for s in 0 ... (pathsSenas.count - 1){
                        //ya agrega el path completo
                        string = pathsSenas[s]
                        string = String(string.dropLast(8))
                         sena1 = Sena(nombre: string, path: Bundle.main.bundlePath + "/LenguajeSenasMexicano_Web/" + paths2[i] + "/" + pathsSenas[s])
                         arrSenas.append(sena1)
                         print(pathsSenas[s])
                    }
                    
                } catch {
                     print("Error obteniendo las señas")
                }
                string = paths2[i]
                string = String(string.dropFirst(4))
                string = String(string.dropLast(4))
                cat = Category(nombre: string, arrSena: arrSenas)
                arrCat.append(cat)
            }
            
        } catch {
            print("Error")
        }
        
        
        self.arrTotal = arrCat

    }
    
    
}
