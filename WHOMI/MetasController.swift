//
//  MetasController.swift
//  WHOMI
//
//  Created by Amaury A V A Souza on 30/07/19.
//  Copyright © 2019 Amaury A V A Souza. All rights reserved.
//
import CoreData
import UIKit

class MetasController: UITableViewController, CreateMetaControllerDelegate {
   
    func didAddMeta(meta: Meta) {
        metas.append(meta)
        tableView.reloadData()
    }
    
    
    
    var valor: Valor?
    var metas = [Meta]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = UIColor(red: 142/255, green: 179/255, blue: 250/255, alpha: 1)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Adicionar Meta", style: .plain, target: self, action: #selector(handleAdd))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        fetchMetas()
        tableView.separatorStyle = .none
        tableView.separatorStyle = .singleLine

        tableView.separatorColor = .white
        tableView.tableFooterView = UIView()
        
    }
    let cellId = "cellIdd"
    
    private func fetchMetas(){
        
        guard let metasDoValor = valor?.metas?.allObjects as? [Meta] else {return}
        
        self.metas = metasDoValor

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = valor?.nome
        
    }
    
    @objc private func handleAdd(){
        let criarMetaController = CriarMetaController()
        criarMetaController.delegate = self
        criarMetaController.valor = valor
        let navController = UINavigationController(rootViewController: criarMetaController)
        present(navController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let meta = metas[indexPath.row]
        
        cell.textLabel?.text = meta.nome
//        cell.textLabel?.text = meta.prazo
        
        if let metaData = meta.prazo?.prazo{
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "d MMMM yyyy"
            cell.textLabel?.text = "\(meta.nome ?? "")     \(dateFormatter.string(from: metaData))"
        }
        
        cell.backgroundColor = UIColor(red: 93/255, green: 149/255, blue: 255/255, alpha: 1)
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .boldSystemFont(ofSize: 17)
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return metas.count
    }
    

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Apagar") { (action, indexPath) in
            let meta = self.metas[indexPath.row]
            let dialogMessage = UIAlertController(title: "Apagar meta", message: "Deseja mesmo apagar esta meta?", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Sim", style: .default) {[unowned self] action in
                self.metas.remove(at: indexPath.row)
                self.tableView.deleteRows(at: [indexPath], with: .automatic)
                //deletar do coredata
                let context = CoreDataManager.shared.persistentContainer.viewContext
                
                context.delete(meta)
                
                do{
                    
                    try context.save()
                } catch let saveErr {
                    print("Falha ao deletar meta", saveErr)
                }
                
            }
            let naoApagar = UIAlertAction(title: "Não", style: .default, handler: nil)
            dialogMessage.addAction(ok)
            dialogMessage.addAction(naoApagar)
            self.present(dialogMessage, animated: true, completion: nil)

        }
        
        
        return [deleteAction]
    }
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Sem metas a serem exibidas."
        label.textColor = .white
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
        
    }
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return metas.count == 0 ? 150 : 0
    }

}
