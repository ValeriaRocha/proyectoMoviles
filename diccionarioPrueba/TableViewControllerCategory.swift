//
//  TableViewControllerCategory.swift
//  diccionarioPrueba
//
//  Created by Clarissa Miranda on 13/03/18.
//  Copyright © 2018 Valeria Rocha Sepulveda . All rights reserved.
//

import UIKit

class TableViewControllerCategory: UITableViewController, UISearchBarDelegate {
//class TableViewControllerCategory: UITableViewController, UISearchResultsUpdating{
    
    
    @IBOutlet weak var sbBuscador: UISearchBar! //Outlet SearchBar
    let searchController = UISearchController(searchResultsController: nil)
    var modelX : Modelo!
    var buscar = false //Variable con la que nos dice si esta buscando una palabra el usuario
    var modelFiltro : Modelo!
    
    override func viewDidLoad() {
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        
        super.viewDidLoad()
        modelX = Modelo()
        modelFiltro = Modelo()
        
        
        self.title = "Categorías"
        modelX.ordenar()
        
        //SearchBar
        sbBuscador.delegate = self
        sbBuscador.returnKeyType = UIReturnKeyType.done
        sbBuscador.placeholder = "Buscar Categorías"
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
            return modelFiltro.arrTotal.count
        }
        else{
            return modelX.arrTotal.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!

        if buscar{
            cell.textLabel?.text = modelFiltro.arrTotal[indexPath.row].nombre
        }
        else{
            cell.textLabel?.text = modelX.arrTotal[indexPath.row].nombre
        }
        return cell
    }
    
    // MARK: - Table view data source
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vista = segue.destination as! TableViewControllerSena
        let indexrow = tableView.indexPathForSelectedRow!
        vista.bEdit = false
        vista.sSegue = "normal"
        if segue.identifier == "normal"
        {
            if(buscar){
                vista.datoMostrar = modelFiltro.arrTotal[indexrow.row].arrSena
            } else {
                vista.datoMostrar = modelX.arrTotal[indexrow.row].arrSena
            }
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
//            modelFiltro.arrTotal = modelX.arrTotal.filter({$0.nombre.lowercased().contains(searchText.lowercased())})
            
             modelFiltro.arrTotal = modelX.arrTotal.filter({$0.nombre.lowercased().hasPrefix(searchText.lowercased())})
            
            tableView.reloadData()
        }
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.landscape
    }
    override var shouldAutorotate: Bool {
        return false
    }
 
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    /*override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }*/

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
