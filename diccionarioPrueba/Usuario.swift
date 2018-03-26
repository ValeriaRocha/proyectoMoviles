//
//  Usuario.swift
//  diccionarioPrueba
//
//  Created by Valeria Rocha Sepulveda  on 25/03/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit

class Usuario: NSObject {
    
    //esta es una prueba para crear un singleton de usuario para que se pueda acceder en todos los controllers del proyecto
    static var user = Usuario()
    
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
    
    override init(){
        self.nombre = ""
        self.errores = [Sena]()
        self.favoritos = [Sena]()
        self.model = Modelo()
        self.estrellas = 0
        self.puntos = 0
    }
    
    //regresa un arreglo de las señas que no se ha aprendido el usuario
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
    
    //regresa un arreglo de las señas aprendidas por el usuario
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
