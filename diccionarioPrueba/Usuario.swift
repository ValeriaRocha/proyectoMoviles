//
//  Usuario.swift
//  diccionarioPrueba
//
//  Created by Valeria Rocha Sepulveda  on 25/03/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit

class Usuario: Codable {
    
    //esta es una prueba para crear un singleton de usuario para que se pueda acceder en todos los controllers del proyecto
    static var user = Usuario()
    
    var nombre : String
    var errores : [Sena]
    var favoritos : [Sena]
    var model : Modelo
    var estrellas : Int
    var puntos : Int
    
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("usuario")
    
    init(nombre : String, errores : [Sena], favoritos : [Sena], model : Modelo, estrellas : Int, puntos :  Int){
        self.nombre = nombre
        self.errores = errores
        self.favoritos = favoritos
        self.model = model
        self.estrellas = estrellas
        self.puntos = puntos
    }
    
    init(){
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
        
        for c in 0..<model.arrTotal.count{
            for s in 0..<model.arrTotal[c].arrSena.count{
                if model.arrTotal[c].arrSena[s].aprendida{
                    senas.append(model.arrTotal[c].arrSena[s])
                }
            }
        }
        return senas
    }
    
    //asigna el valor de aprendida de la seña llamada named para que sea igual a value
    func setSignLearned(named: String, value: Bool){
        for c in 0..<model.arrTotal.count{
            for s in 0..<model.arrTotal[c].arrSena.count{
                if model.arrTotal[c].arrSena[s].nombre == named{
                    model.arrTotal[c].arrSena[s].aprendida = value
                }
            }
        }
    }
    
    //quitar del arreglo de errores la seña pasada como parametro
    func quitarError(error: Sena){
        for i in 0 ..< errores.count{
            if errores[i].nombre == error.nombre{
                errores.remove(at: i)
                break
            }
        }
    }
    
    func quitarFav(fav: Sena){
        for i in 0 ..< favoritos.count{
            if favoritos[i].nombre == fav.nombre{
                favoritos.remove(at: i)
                break
            }
        }
    }
    
    func guardarError(error: Sena){
        if !errores.contains(where: {$0.nombre == error.nombre}){
            errores.append(error)
        }
    }
    
    func guardarFav(fav: Sena){
        if !favoritos.contains(where: {$0.nombre == fav.nombre}){
            favoritos.append(fav)
        }
    }
    
    // persistencia usuario
    func guardaUsuario(){
        do{
            let data = try PropertyListEncoder().encode(Usuario.user)
            let success = NSKeyedArchiver.archiveRootObject(data, toFile: Usuario.ArchiveURL.path)
            print(success ? "Successful save" : "Save Failed")
        } catch{
            print("Save  Failed")
        }
    }
    
    
    //recuperar informacion
    func retrieveUsuario(){
        guard let data = NSKeyedUnarchiver.unarchiveObject(withFile: Usuario.ArchiveURL.path) as? Data else {return}
        do{
            Usuario.user = try PropertyListDecoder().decode(Usuario.self, from: data)
        } catch {
            print("No se pudo recuperar la informacion del usuario")
        }
    }

}
