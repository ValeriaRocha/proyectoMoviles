//
//  ViewControllerRuleta.swift
//  diccionarioPrueba
//
//  Created by Valeria Rocha Sepulveda  on 13/03/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit
import Foundation

class ViewControllerRuleta: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var juegos = [#imageLiteral(resourceName: "memoNI3"),#imageLiteral(resourceName: "respondeNI"), #imageLiteral(resourceName: "gravedadNI")]
    var seconds = 3.0
    var timer = Timer()
    var indice = 0
    var juego = 0
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var lbSelectedGame: UILabel!
    @IBOutlet weak var btObtener: UIButton!
    
    @IBOutlet weak var btJugar: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
         lbSelectedGame.backgroundColor = UIColor.clear
        lbSelectedGame.text = ""
        // Do any additional setup after loading the view.
        
        pickerView.layer.cornerRadius = 0.01 * pickerView.bounds.size.width
        lbSelectedGame.layer.cornerRadius = 0.01 * lbSelectedGame.bounds.size.width
    }
    
    
    @IBAction func clickRuleta(_ sender: UIButton) {
        lbSelectedGame.text = ""
         lbSelectedGame.backgroundColor = UIColor.clear
        seconds = Double(Int(arc4random_uniform(5) + 1)) //poner random
        btObtener.isEnabled = false
        btJugar.isEnabled = false
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer(){
        indice = (indice + 1) % 3
        seconds -= 0.3
        
        pickerView.selectRow(indice, inComponent: 0, animated: true)
        
        if(seconds <= 0){
            timer.invalidate()
            
            lbSelectedGame.backgroundColor = #colorLiteral(red: 0.7241656184, green: 0.8897604942, blue: 0.9486973882, alpha: 1)
            
            switch indice {
            case 0:
                lbSelectedGame.text = "Te toco el juego Memorama!"
                juego = 1
                break;
            case 1:
                lbSelectedGame.text = "Te toco el juego Responde Rápido!"
                juego = 2
                break;
            case 2:
                lbSelectedGame.text = "Te toco el juego Gravedad!"
                juego = 3
                break;
            default:
                break;
                
            }
            btObtener.isEnabled = true
            btJugar.isEnabled = true
        }
    }
    
    
    @IBAction func clickJugar(_ sender: UIButton) {
        switch(juego){
        case 1:
            performSegue(withIdentifier: "memorama", sender: self)
            break;
        case 2:
            performSegue(withIdentifier: "responde", sender: self)
            break;
        case 3:
            performSegue(withIdentifier: "juego3", sender: self)
            break;
        default:
            break;
        }
    }
    
    @IBAction func unwind(unwindSegue : UIStoryboardSegue){
        
    }
    
    
     // MARK: - Picker view
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return juegos.count
    }
    
    //regresa la imagen para cada renglon del pickerview
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let img = UIImageView(image: juegos[row])
        return img
    }
    
    //Ajusta la altura de los renglones del pickerview
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        // let selected = pickerView.selectedRow(inComponent: 0)
        return juegos[0].size.height + 10
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
