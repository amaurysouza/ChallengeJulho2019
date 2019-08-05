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
protocol CriarValorControllerDelegate{
    func didAddValor(valor: Valor)
    func didEditValor(valor: Valor)
}

class CriarValorViewController: UIViewController{
    //criação de objeto valor do tipo Valor??
    var valor: Valor?{
        didSet{
            nomeTextField.text = valor?.nome
        }
    }
    //criação do delegate
    var delegate: CriarValorControllerDelegate?
    
    let comoDesejaLabel:UILabel = {
        let label = UILabel()
        label.text = "Como deseja criar seu valor?"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 17)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
   let botaoGuiado: UIButton = {
        let botao = UIButton()
        botao.setTitle("Utilizando a técnica dos porquês", for: .normal)
        botao.tintColor = .white
        botao.backgroundColor = UIColor(red: 135/255, green: 106/255, blue: 255/255, alpha: 1)
        botao.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        botao.layer.cornerRadius = 15
//        botao.layer.borderWidth = 0.5
//        botao.layer.borderColor = UIColor.white.cgColor
        botao.layer.borderWidth = 1
        botao.layer.borderColor = UIColor(red: 115/255, green: 80/255, blue: 230/255, alpha: 1).cgColor
        botao.setTitleColor(.white, for: .normal)
        botao.translatesAutoresizingMaskIntoConstraints = false
        botao.addTarget(self, action: #selector(guiarValor), for: .touchUpInside)
        return botao
    }()
    
    @objc func guiarValor(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(handleSalvar))
        let bgView = UIView()
//        bgView.backgroundColor = UIColor(red: 142/255, green: 179/255, blue: 250/255, alpha: 1)
        bgView.backgroundColor = UIColor(red: 139/255, green: 161/255, blue: 255/255, alpha: 1)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgView)
        
        bgView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bgView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bgView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bgView.heightAnchor.constraint(equalToConstant: 440).isActive = true
        
        
        //constraints da label
        view.addSubview(euQueroLabel)
        euQueroLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        euQueroLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        euQueroLabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        euQueroLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        //constraints do texfield
        view.addSubview(metaTextField)
        metaTextField.leftAnchor.constraint(equalTo: euQueroLabel.rightAnchor).isActive = true
        metaTextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        metaTextField.bottomAnchor.constraint(equalTo: euQueroLabel.bottomAnchor).isActive = true
        metaTextField.topAnchor.constraint(equalTo: euQueroLabel.topAnchor).isActive = true
        
        view.addSubview(pq1Label)
        pq1Label.topAnchor.constraint(equalTo: euQueroLabel.bottomAnchor).isActive = true
        pq1Label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        pq1Label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        pq1Label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(motivo1TextField)
        motivo1TextField.leftAnchor.constraint(equalTo: pq1Label.rightAnchor).isActive = true
        motivo1TextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        motivo1TextField.bottomAnchor.constraint(equalTo: pq1Label.bottomAnchor).isActive = true
        motivo1TextField.topAnchor.constraint(equalTo: pq1Label.topAnchor).isActive = true
        
        view.addSubview(pq2Label)
        pq2Label.topAnchor.constraint(equalTo: pq1Label.bottomAnchor).isActive = true
        pq2Label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        pq2Label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        pq2Label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(motivo2TextField)
        motivo2TextField.leftAnchor.constraint(equalTo: pq2Label.rightAnchor).isActive = true
        motivo2TextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        motivo2TextField.bottomAnchor.constraint(equalTo: pq2Label.bottomAnchor).isActive = true
        motivo2TextField.topAnchor.constraint(equalTo: pq2Label.topAnchor).isActive = true
        
        view.addSubview(pq3Label)
        pq3Label.topAnchor.constraint(equalTo: pq2Label.bottomAnchor).isActive = true
        pq3Label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        pq3Label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        pq3Label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(motivo3TextField)
        motivo3TextField.leftAnchor.constraint(equalTo: pq3Label.rightAnchor).isActive = true
        motivo3TextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        motivo3TextField.bottomAnchor.constraint(equalTo: pq3Label.bottomAnchor).isActive = true
        motivo3TextField.topAnchor.constraint(equalTo: pq3Label.topAnchor).isActive = true
        
        view.addSubview(pq4Label)
        pq4Label.topAnchor.constraint(equalTo: pq3Label.bottomAnchor).isActive = true
        pq4Label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        pq4Label.widthAnchor.constraint(equalToConstant: 100).isActive = true
        pq4Label.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(motivo4TextField)
        motivo4TextField.leftAnchor.constraint(equalTo: pq4Label.rightAnchor).isActive = true
        motivo4TextField.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        motivo4TextField.bottomAnchor.constraint(equalTo: pq4Label.bottomAnchor).isActive = true
        motivo4TextField.topAnchor.constraint(equalTo: pq4Label.topAnchor).isActive = true
        
        view.addSubview(meuValorLabel)
        meuValorLabel.topAnchor.constraint(equalTo: pq4Label.bottomAnchor).isActive = true
        meuValorLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        meuValorLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        meuValorLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(nomeTextField)
        nomeTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        nomeTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        nomeTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        nomeTextField.topAnchor.constraint(equalTo: meuValorLabel.bottomAnchor).isActive = true
    }
    
    let botaoDireto: UIButton = {
        let botao = UIButton()
        botao.setTitle("Sem utilizar a técnica dos porquês", for: .normal)
        botao.tintColor = .white
        botao.backgroundColor = UIColor(red: 135/255, green: 106/255, blue: 255/255, alpha: 1)
        botao.translatesAutoresizingMaskIntoConstraints = false
        botao.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        botao.layer.cornerRadius = 15
        botao.layer.borderWidth = 1
        botao.layer.borderColor = UIColor(red: 125/255, green: 90/255, blue: 240/255, alpha: 1).cgColor
        botao.setTitleColor(.white, for: .normal)
        botao.addTarget(self, action: #selector(naoGuiarValor), for: .touchUpInside)
        return botao
    }()
    @objc func naoGuiarValor(){
        botaoDireto.removeFromSuperview()
        botaoGuiado.removeFromSuperview()
        bgTeste.removeFromSuperview()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(handleSalvar))
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
        
        

    }
    
    let euQueroLabel:UILabel = {
        let label = UILabel()
        label.text = "Eu quero:"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let pq1Label:UILabel = {
        let label = UILabel()
        label.text = "Porque:"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let pq2Label:UILabel = {
        let label = UILabel()
        label.text = "Porque:"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let pq3Label:UILabel = {
        let label = UILabel()
        label.text = "Porque:"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let pq4Label:UILabel = {
        let label = UILabel()
        label.text = "Porque:"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let meuValorLabel:UILabel = {
        let label = UILabel()
        label.text = "Portanto, meu valor é:"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let metaTextField: UITextField = {
        let texField = UITextField()
        texField.placeholder = "Meta"
        texField.translatesAutoresizingMaskIntoConstraints = false
        return texField
    }()
    let motivo1TextField: UITextField = {
        let texField = UITextField()
        texField.placeholder = "Digite sua razão"
        texField.translatesAutoresizingMaskIntoConstraints = false
        
        return texField
    }()
    let motivo2TextField: UITextField = {
        let texField = UITextField()
        texField.placeholder = "Digite sua razão"
        texField.translatesAutoresizingMaskIntoConstraints = false
        return texField
    }()
    let motivo3TextField: UITextField = {
        let texField = UITextField()
        texField.placeholder = "Digite sua razão"
        texField.translatesAutoresizingMaskIntoConstraints = false
        return texField
    }()
    let motivo4TextField: UITextField = {
        let texField = UITextField()
        texField.placeholder = "Digite sua razão"
        texField.translatesAutoresizingMaskIntoConstraints = false
        texField.clearButtonMode = .always
        return texField
    }()

    let bgTeste: UIView = {
        let bgBotoes = UIView()
        
        bgBotoes.backgroundColor = UIColor(red: 139/255, green: 161/255, blue: 255/255, alpha: 1)
        //        bgBotoes.backgroundColor = UIColor(red: 255/255, green: 244/255, blue: 116/255, alpha: 1)
        bgBotoes.translatesAutoresizingMaskIntoConstraints = false
        return bgBotoes
    }()
    
    
    //criação da lable nome
    let labelNome: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Meu valor pessoal é:"
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
        
        view.addSubview(bgTeste)
        bgTeste.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bgTeste.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bgTeste.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bgTeste.heightAnchor.constraint(equalToConstant: 260).isActive = true

        setupUI()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(handleCancelar))
//        view.backgroundColor = UIColor(red: 48/2555, green: 164/255, blue: 182/255, alpha: 1)
        view.backgroundColor = UIColor(red: 142/255, green: 179/255, blue: 250/255, alpha: 1)
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(handleSalvar))
        
    }
    //criação de view background para a a label nome e o textfield que pulam quando se clica em adicionar valor
    private func setupUI(){
        
      

        
        view.addSubview(comoDesejaLabel)
        comoDesejaLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        comoDesejaLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        comoDesejaLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        comoDesejaLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(botaoGuiado)
        botaoGuiado.topAnchor.constraint(equalTo: comoDesejaLabel.bottomAnchor, constant: 20).isActive = true
        botaoGuiado.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        botaoGuiado.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        botaoGuiado.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(botaoDireto)
        botaoDireto.topAnchor.constraint(equalTo: botaoGuiado.bottomAnchor, constant: 20).isActive = true
        botaoDireto.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        botaoDireto.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        botaoDireto.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        
        

        
        

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
