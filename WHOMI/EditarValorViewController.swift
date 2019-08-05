//
//  CriarValorViewController.swift
//  WHOMI
//
//  Created by Amaury A V A Souza on 28/07/19.
//  Copyright © 2019 Amaury A V A Souza. All rights reserved.
//

import UIKit
import CoreData
//criação do delegate (????)


class EditarValorViewController: UIViewController{
    //criação de objeto valor do tipo Valor??
    var valor: Valor?{
        didSet{
            nomeTextField.text = valor?.nome
        }
    }
    //criação do delegate
    var delegate: CriarValorControllerDelegate?
   
    

    //criação da lable nome
    let labelNome: UILabel = {
        let label = UILabel()
        label.text = "Meu valor pessoal é:"
        label.textColor = .white
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    //criação do texfield
    let nomeTextField: UITextField = {
        let texField = UITextField()
        texField.placeholder = "Digite seu valor pessoal"
        texField.translatesAutoresizingMaskIntoConstraints = false
        texField.backgroundColor =  UIColor(red: 204/255, green: 214/255, blue: 251/255, alpha: 1)
        texField.layer.cornerRadius = 15
        texField.textAlignment = .center
        texField.clearButtonMode = .always
        //        texField.clearButtonMode = .whileEditing
        
        return texField
    }()
    
    
    override func viewDidLoad() {
     

        setupUI()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(handleCancelar))
        view.backgroundColor = UIColor(red: 142/255, green: 179/255, blue: 250/255, alpha: 1)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(handleSalvar))
    }
    //criação de view background para a a label nome e o textfield que pulam quando se clica em adicionar valor
    private func setupUI(){
        

            let bgView = UIView()
            bgView.backgroundColor = UIColor(red: 139/255, green: 161/255, blue: 255/255, alpha: 1)
            bgView.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview(bgView)
            bgView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            bgView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            bgView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
            bgView.heightAnchor.constraint(equalToConstant: 140).isActive = true
            
            
            
            //constraints da label
            view.addSubview(labelNome)
            labelNome.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            labelNome.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
            labelNome.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
            labelNome.heightAnchor.constraint(equalToConstant: 60).isActive = true
            
            //constraints do texfield
            view.addSubview(nomeTextField)
            nomeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
            nomeTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
            nomeTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
            nomeTextField.topAnchor.constraint(equalTo: labelNome.bottomAnchor).isActive = true
            
            
            
       
        
        //constraints da label
        view.addSubview(labelNome)
        labelNome.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        labelNome.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        labelNome.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        labelNome.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //constraints do texfield
        view.addSubview(nomeTextField)
        nomeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nomeTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        nomeTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        nomeTextField.topAnchor.constraint(equalTo: labelNome.bottomAnchor).isActive = true
        
        

    }
    
    @objc func handleSalvar(){
        if valor == nil{
            criarValor()
        }else{
            salvarMudancasValor()
        }
    }
    
    private func salvarMudancasValor(){
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        
        valor?.nome = nomeTextField.text
        
        do{
            try context.save()
            dismiss(animated: true) {
                self.delegate?.didEditValor(valor: self.valor!)
            }
        } catch let saveErr{
            print("Falha em salvar mudanças", saveErr)
        }
        
        
        
    }
    private func criarValor(){
        
        
        let context = CoreDataManager.shared.persistentContainer.viewContext
        let valor = NSEntityDescription.insertNewObject(forEntityName: "Valor", into: context)
        
        valor.setValue(nomeTextField.text, forKey: "nome")
        
        
        do {
            try context.save()
            dismiss(animated: true) {
                self.delegate?.didAddValor(valor: valor as! Valor)
            }
            
        } catch let saveErr {
            print("Falha ao salvar valor", saveErr)
        }
        
        
        
    }
    @objc func handleCancelar(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = valor == nil ? "Novo Valor" : "Editar Valor"
    }
}
