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
    
    var juegos = [#imageLiteral(resourceName: "memorama3"), #imageLiteral(resourceName: "responde"), #imageLiteral(resourceName: "catchem")]
    var seconds = 3.0
    var timer = Timer()
    var indice = 0
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var lbSelectedGame: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbSelectedGame.text = ""
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func clickRuleta(_ sender: UIButton) {
        lbSelectedGame.text = ""
        seconds = Double(Int(arc4random_uniform(2) + 1)) //poner random
        timer = Timer.scheduledTimer(timeInterval: 0.3, target: self, selector: #selector(self.updateTimer), userInfo: nil, repeats: true)
    }
    
    
    @objc func updateTimer(){
        indice = (indice + 1) % 3
        seconds -= 0.1
        
        pickerView.selectRow(indice, inComponent: 0, animated: true)
        
        if(seconds <= 0){
            timer.invalidate()
            
            switch indice {
            case 0:
                lbSelectedGame.text = "Te toco el juego Memorama!"
                break;
            case 1:
                lbSelectedGame.text = "Te toco el juego Responde Rapido!"
                break;
            case 2:
                lbSelectedGame.text = "Te toco el juego Catch'em!"
                break;
            default:
                break;
                
            }
        }
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
        return juegos[0].size.height
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
