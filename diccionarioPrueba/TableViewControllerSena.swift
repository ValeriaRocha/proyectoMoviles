//
//  TableViewControllerSena.swift
//  diccionarioPrueba
//
//  Created by Clarissa Miranda on 13/03/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit
import AVKit

class TableViewControllerSena: UITableViewController, UISearchBarDelegate {
    @IBOutlet weak var sbBuscadorSena: UISearchBar!
    var datoMostrar : [Sena]!
    var datoMostrarFiltro: [Sena]!
    var buscar = false
    var bEdit = false
    var sSegue : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        if bEdit
        {
            self.navigationItem.rightBarButtonItem = self.editButtonItem
        }
        
        self.title = "Señas"
        //SearchBar
        sbBuscadorSena.delegate = self
        sbBuscadorSena.returnKeyType = UIReturnKeyType.done
        sbBuscadorSena.placeholder = "Buscar Señas"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if buscar{
            return datoMostrarFiltro.count
        }else{
            return datoMostrar.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        
        if buscar{
            cell.textLabel?.text = datoMostrarFiltro[indexPath.row].nombre
        }
        else{
            cell.textLabel?.text = datoMostrar[indexPath.row].nombre
        }
        return cell
    }    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vista = segue.destination as! ViewController
        let indexrow = tableView.indexPathForSelectedRow!
        
        if(buscar){
            vista.sena = datoMostrarFiltro[indexrow.row]
        } else{
            vista.sena = datoMostrar[indexrow.row]
        }
    }
    
    // MARK: SearchBar
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == "" || searchBar.text == nil{
            buscar = false
            view.endEditing(true)
            tableView.reloadData()
        }
        else{
            buscar = true
            datoMostrarFiltro = datoMostrar.filter({$0.nombre.lowercased().hasPrefix(searchText.lowercased())})
            tableView.reloadData()
        }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let indexPathR = indexPath.row
        if editingStyle == .delete {
            // Delete the row from the data source
            if(!buscar)
            {
                if(sSegue=="errores")
                {
                    Usuario.user.quitarError(error: datoMostrar[indexPathR])
                }
                if(sSegue=="favoritos")
                {
                    Usuario.user.quitarFav(fav: datoMostrar[indexPathR])
                }
                datoMostrar.remove(at: indexPathR)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            else{
                if(sSegue=="errores")
                {
                    Usuario.user.quitarError(error: datoMostrarFiltro[indexPathR])
                }
                if(sSegue=="favoritos")
                {
                    Usuario.user.quitarFav(fav: datoMostrarFiltro[indexPathR])
                }
                datoMostrarFiltro.remove(at: indexPathR)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
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
