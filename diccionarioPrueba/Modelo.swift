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
    
    init(){
        
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
                arrSenas.removeAll()
                
                do{
                    //pathSenas obtiene los nombres de los receursos adentro de la categoria paths2[i]
                    let pathsSenas = try FileManager.default.contentsOfDirectory(atPath: path1 + "/" + paths2[i])
                    
                    //loop que recorre la lista de las señas de una dada categoria
                    for s in 0 ... (pathsSenas.count - 1){
                        //ya agrega el path completo
                        string = pathsSenas[s]
                        
                        //checa si es imagen o video
                        if(string.hasSuffix(".m4v")){
                            string = String(string.dropLast(8))
                        } else {
                            string = String(string.dropLast(4))
                        }
                        
                        sena1 = Sena(nombre: string, path: Bundle.main.bundlePath + "/LenguajeSenasMexicano_Web/" + paths2[i] + "/" + pathsSenas[s], aprendida: false)
                        arrSenas.append(sena1)
                    }
                    
                } catch {
                    print("Error:  No se pudieron obtener las señas")
                }
                string = paths2[i]
                string = String(string.dropFirst(4))
                string = String(string.dropLast(4))
                cat = Category(nombre: string, arrSena: arrSenas)
                arrCat.append(cat)
            }
            
        } catch {
            print("Error: No se pudo obtener el contenido del directorio Lenguaje de Señas")
        }
        
        
        self.arrTotal = arrCat

    }
    
    func ordenar(){
        self.arrTotal.sort(by: { $0.nombre < $1.nombre })
        for i in 0 ... (self.arrTotal.count - 1){
            
            //si es la categoria numero se tiene que convertir a int primero para poder comparar
            if self.arrTotal[i].nombre == "Numero"{
                self.arrTotal[i].arrSena.sort(by:  { Int($0.nombre)! < Int($1.nombre)! })
            } else {
                self.arrTotal[i].arrSena.sort(by:  { $0.nombre < $1.nombre })
            }
        }
    }
    
    
}
