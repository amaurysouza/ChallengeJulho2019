//
//  CoreDataManager.swift
//  WHOMI
//
//  Created by Amaury A V A Souza on 29/07/19.
//  Copyright © 2019 Amaury A V A Souza. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataManager{
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "WHOMI")
        
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err{
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }()
        //função para atualizar table view com valores novos
    func fetchValores() -> [Valor]{
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<Valor>(entityName: "Valor")
        do{
            let valores = try context.fetch(fetchRequest)
            return valores

        } catch let fetchErr{
            print("Failed to fetch valores", fetchErr)
            return []
        }
    }
    
    func createMeta(nome: String, prazoMeta: Date, valor: Valor) -> (Meta?, Error?) {
        let context = persistentContainer.viewContext
        let meta = NSEntityDescription.insertNewObject(forEntityName: "Meta", into: context) as! Meta
        
        meta.valor = valor
            
//        let informacaoMeta = NSEntityDescription.insertNewObject(forEntityName: "Meta", into: context) as informacaoMeta
        meta.setValue(nome, forKey: "nome")
        
        
        let prazoData = NSEntityDescription.insertNewObject(forEntityName: "Prazo", into: context) as! Prazo
 
        prazoData.prazo = prazoMeta
        
        meta.prazo = prazoData
        
//        let valor = Valor(context: context)
//        valor.meta
//
//        meta.valor
        
        do{
            try context.save()
            return (meta, nil)
        } catch let err{
            
            print("Fail to save meta:", err)
            return (nil, err)
        }
        
    }
}
