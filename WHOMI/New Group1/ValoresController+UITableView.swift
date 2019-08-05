//
//  ValoresController+UITableView.swift
//  WHOMI
//
//  Created by Amaury A V A Souza on 30/07/19.
//  Copyright © 2019 Amaury A V A Souza. All rights reserved.
//

import UIKit

extension ValoresController{
  
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Apagar") { (action, indexPath) in
            let valor = self.valores[indexPath.row]
            

            
            let dialogMessage = UIAlertController(title: "Apagar valor", message: "Deseja mesmo apagar este valor e todas as metas associadas e ele?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Sim", style: .default) {[unowned self] action in
                self.valores.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                //deletar do coredata
                let context = CoreDataManager.shared.persistentContainer.viewContext
                
                context.delete(valor)
                
                do{
                    
                    try context.save()
                } catch let saveErr {
                    print("Falha ao deletar valor", saveErr)
                }

            }
            let naoApagar = UIAlertAction(title: "Não", style: .default, handler: nil)
            dialogMessage.addAction(ok)
            dialogMessage.addAction(naoApagar)
            self.present(dialogMessage, animated: true, completion: nil)
           
        }

        
        let editAction = UITableViewRowAction(style: .normal, title: "Editar", handler: editHandlerFunction)

        return [deleteAction, editAction]
    }
    
    private func editHandlerFunction(action: UITableViewRowAction, indexPath: IndexPath){
        
        
        let editValorController = EditarValorViewController()
        editValorController.delegate = self
        editValorController.valor = valores[indexPath.row]
        let navController = CustomNavigationController(rootViewController: editValorController)
        present(navController, animated: true, completion: nil)
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CellID", for: indexPath)
        cell.separatorInset = UIEdgeInsets.zero
        
        cell.textLabel?.text = valores[indexPath.row].nome
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return valores.count
    }
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Sem valores pessoais a serem exibidos."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
        
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return valores.count == 0 ? 150 : 0
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let valor = self.valores[indexPath.row]
        let metasController = MetasController()
        metasController.valor = valor
        navigationController?.pushViewController(metasController, animated: true)
    }
}

