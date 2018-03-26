//
//  Usuario.swift
//  diccionarioPrueba
//
//  Created by Valeria Rocha Sepulveda  on 25/03/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit

class Usuario: NSObject {
    
    var nombre : String
    var errores : [Sena]
    var favoritos : [Sena]
    var model : Modelo
    var estrellas : Int
    var puntos : Int
    
    init(nombre : String, errores : [Sena], favoritos : [Sena], model : Modelo, estrellas : Int, puntos :  Int){
        self.nombre = nombre
        self.errores = errores
        self.favoritos = favoritos
        self.model = model
        self.estrellas = estrellas
        self.puntos = puntos
    }
    
    func noAprendidas()-> [Sena]{
        var senas = [Sena]()
        
        for c in 0 ... (model.arrTotal.count - 1){
            for s in 0 ... (model.arrTotal[c].arrSena.count - 1){
                if !model.arrTotal[c].arrSena[s].aprendida{
                    senas.append(model.arrTotal[c].arrSena[s])
                }
            }
        }
        
        return senas
    }
    
    func aprendidas()-> [Sena]{
        var senas = [Sena]()
        
        for c in 0 ... (model.arrTotal.count - 1){
            for s in 0 ... (model.arrTotal[c].arrSena.count - 1){
                if model.arrTotal[c].arrSena[s].aprendida{
                    senas.append(model.arrTotal[c].arrSena[s])
                }
            }
        }
        return senas
    }

}
