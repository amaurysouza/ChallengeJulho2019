//
//  ValorController+CriarValor.swift
//  WHOMI
//
//  Created by Amaury A V A Souza on 30/07/19.
//  Copyright © 2019 Amaury A V A Souza. All rights reserved.
//

import UIKit

extension ValoresController: CriarValorControllerDelegate{
    func didEditValor(valor: Valor) {
        let linha = valores.firstIndex(of : valor)
        let reloadIndexPath = IndexPath(row: linha!, section: 0)
        tableView.reloadRows(at: [reloadIndexPath], with: .automatic)
    }
    
    func didAddValor(valor: Valor) {
        valores.append(valor)
        let newIndexPath = IndexPath(row: valores.count - 1, section: 0)
        tableView.insertRows(at: [newIndexPath], with: .automatic)
    }
}
