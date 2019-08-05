//
//  ViewController.swift
//  WHOMI
//
//  Created by Amaury A V A Souza on 24/07/19.
//  Copyright © 2019 Amaury A V A Souza. All rights reserved.
//

import UIKit
import CoreData

class ValoresController: UITableViewController {

    
    //variável para a tableview
    var valores:[Valor] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.valores = CoreDataManager.shared.fetchValores()
        

        
        navigationItem.title = "Valores Pessoais"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Novo Valor", style: .plain, target: self, action: #selector(handleAddValue))

        tableView.backgroundColor = UIColor(red: 142/255, green: 179/255, blue: 250/255, alpha: 1)
        

        tableView.separatorStyle = .singleLine
//        tableView.separatorColor = UIColor(red: 97/255, green: 0/255, blue: 245/255, alpha: 1)
        tableView.separatorColor = .white
        tableView.register(ValorCell.self, forCellReuseIdentifier: "CellID")
        tableView.tableFooterView = UIView()
    }
    //função que chama criarvalorViewController (cria um obj dessa classe, aí entra o delegate e me perco)
    @objc func handleAddValue(){
        
        let criarValorDiretoController = CriarValorViewController()

        
        let criarValorNavController = CustomNavigationController(rootViewController: criarValorDiretoController)
        
        criarValorDiretoController.delegate = self
        
        present(criarValorNavController, animated: true, completion: nil)
        
        
    }

}

