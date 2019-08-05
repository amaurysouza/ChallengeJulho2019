//
//  CriarMetaController.swift
//  WHOMI
//
//  Created by Amaury A V A Souza on 30/07/19.
//  Copyright © 2019 Amaury A V A Souza. All rights reserved.
//

import UIKit
import UserNotifications
protocol CreateMetaControllerDelegate{
    func didAddMeta(meta: Meta)
}

class CriarMetaController: UIViewController {
    
    var valor: Valor?
   
    
    var delegate: CreateMetaControllerDelegate?
    
    let dataLabel:UILabel = {
        let label = UILabel()
        label.text = "Prazo estimado para cumprimento da meta:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    
    let metaLabel:UILabel = {
        let label = UILabel()
        label.text = "Minha meta é:"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
        
    }()
    
    let metaTextField: UITextField = {
        let texField = UITextField()
        texField.placeholder = "Digite sua meta"
        texField.translatesAutoresizingMaskIntoConstraints = false
        texField.backgroundColor =  UIColor(red: 204/255, green: 214/255, blue: 251/255, alpha: 1)
        texField.layer.cornerRadius = 15
        texField.textAlignment = .center
        texField.clearButtonMode = .always

//        texField.clearButtonMode = .whileEditing
        return texField
    }()
    
    let dataTextField: UITextField = {
        let texField = UITextField()
        texField.placeholder = "dd/mm/aaaa"
        texField.backgroundColor =  UIColor(red: 204/255, green: 214/255, blue: 251/255, alpha: 1)
        texField.layer.cornerRadius = 15
        texField.textAlignment = .center
        texField.clearButtonMode = .always
        texField.translatesAutoresizingMaskIntoConstraints = false
        return texField
    }()
    
    let specificLabel:UILabel = {
        let label = UILabel()
        label.text = "Esta meta é específica?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let measurableLabel:UILabel = {
        let label = UILabel()
        label.text = "Esta meta é mensurável?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let attainableLabel:UILabel = {
        let label = UILabel()
        label.text = "Esta meta é alcançável?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let relevantLabel:UILabel = {
        let label = UILabel()
        label.text = "Esta meta é relevante?"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    let switchSpecific: UISwitch = {
        let switchGeral = UISwitch()
        switchGeral.translatesAutoresizingMaskIntoConstraints = false
//        switchGeral.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
        
        
        return switchGeral
    }()
    var switchMeasurable: UISwitch = {
        let switchGeral = UISwitch()
        switchGeral.translatesAutoresizingMaskIntoConstraints = false
//        switchGeral.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
        
        return switchGeral
    }()
    var switchAttainable: UISwitch = {
        let switchGeral = UISwitch()
        switchGeral.translatesAutoresizingMaskIntoConstraints = false
//        switchGeral.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
        
        return switchGeral
    }()
    var switchRelevant: UISwitch = {
        let switchGeral = UISwitch()
        switchGeral.translatesAutoresizingMaskIntoConstraints = false
//        switchGeral.addTarget(self, action: #selector(handleSwitch), for: .valueChanged)
        
        return switchGeral
    }()
    

    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Criar Meta"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(handleCancelar))
        
        view.backgroundColor = UIColor(red: 142/255, green: 179/255, blue: 250/255, alpha: 1)
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(tap)
        
        setupUI()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Salvar", style: .plain, target: self, action: #selector(handleSalvar))
    }
    @objc func handleSalvar(){
        guard let nome = metaTextField.text else {return}
        guard let valor = self.valor else {return}
        
        guard let dataText = dataTextField.text else {return}
        
        if dataText.isEmpty{
            let alertController = UIAlertController(title: "Erro de preenchimento", message: "Todos os campos devem estar preenchidos e todas as chaves devem estar ativadas para continuar", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }

        
        let dateFormatter = DateFormatter()
//        dateFormatter.locale = Locale(identifier: "pt_BR")
        dateFormatter.dateFormat = "dd/MM/yyyy"
        guard let dataPrazo = dateFormatter.date(from: dataText) else{
            let alertController = UIAlertController(title: "Data inválida", message: "A data deve ser preenchida no formato indicado", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }
//        print (dataPrazo)
        if !switchRelevant.isOn || !switchSpecific.isOn || !switchAttainable.isOn || !switchMeasurable.isOn{
            let alertController = UIAlertController(title: "Erro de preenchimento", message: "Todos os campos devem estar preenchidos e todas as chaves devem estar ativadas para continuar", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }
        
//
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.getNotificationSettings { (settings) in
            if settings.authorizationStatus == .authorized {
                let content = UNMutableNotificationContent()
                content.title = NSString.localizedUserNotificationString(forKey: "Meta completa", arguments: nil)
                content.body = NSString.localizedUserNotificationString(forKey: "Uma meta está agendada para ser completada hoje!", arguments: nil)
                content.sound = UNNotificationSound.default
                
                //                let dateFormNotification = DateFormatter()
                //                dateFormNotification.dateFormat = "dd/MM/yyyy"
                //                let date = dateFormNotification.date(from: self.dataTextField.text ?? "10/10/2010")
                //                let dataNotificacao = Date(timeIntervalSinceNow: 5)
                let triggerMeta = Calendar.current.dateComponents([.weekday, .hour, .minute, .second], from: dataPrazo)
                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerMeta, repeats: true)
                let request = UNNotificationRequest(identifier: "meta", content: content, trigger: trigger)
                
                let center = UNUserNotificationCenter.current()
                center.add(request) { (error : Error?) in
                    if let error = error {
                        print(error.localizedDescription)
                    }
                }
                
            } else {
                print("Impossível mandar notificação - permissão negada")
            }
        }
        let tuple = CoreDataManager.shared.createMeta(nome: nome, prazoMeta: dataPrazo, valor: valor)
        
        if let error = tuple.1{
            print(error)
        } else {
       
            dismiss(animated: true) {
            self.delegate?.didAddMeta(meta: tuple.0!)
            }
        }
        
        
        
    }
    
//
//    func notificacao() {
//        let notificationCenter = UNUserNotificationCenter.current()
//        notificationCenter.getNotificationSettings { (settings) in
//            if settings.authorizationStatus == .authorized {
//                let content = UNMutableNotificationContent()
//                content.title = NSString.localizedUserNotificationString(forKey: "Meta completa", arguments: nil)
//                content.body = NSString.localizedUserNotificationString(forKey: "Uma meta está agendada para ser completada hoje!", arguments: nil)
//                content.sound = UNNotificationSound.default
//
////                let dateFormNotification = DateFormatter()
////                dateFormNotification.dateFormat = "dd/MM/yyyy"
////                let date = dateFormNotification.date(from: self.dataTextField.text ?? "10/10/2010")
////                let dataNotificacao = Date(timeIntervalSinceNow: 5)
//                let triggerMeta = Calendar.current.dateComponents([.weekday, .hour, .minute, .second], from: date!)
//                let trigger = UNCalendarNotificationTrigger(dateMatching: triggerMeta, repeats: true)
//                let request = UNNotificationRequest(identifier: "meta", content: content, trigger: trigger)
//
//                let center = UNUserNotificationCenter.current()
//                center.add(request) { (error : Error?) in
//                    if let error = error {
//                        print(error.localizedDescription)
//                    }
//                }
//
//            } else {
//                print("Impossível mandar notificação - permissão negada")
//            }
//        }
//    }
    
    @objc func handleCancelar(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupUI(){
        let bgView = UIView()
        bgView.backgroundColor =  UIColor(red: 139/255, green: 161/255, blue: 255/255, alpha: 1)
        bgView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bgView)
        bgView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        bgView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        bgView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        bgView.heightAnchor.constraint(equalToConstant: 500).isActive = true
        
        view.addSubview(metaLabel)
        metaLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        metaLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        metaLabel.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        metaLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(metaTextField)
        metaTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        metaTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        metaTextField.topAnchor.constraint(equalTo: metaLabel.bottomAnchor).isActive = true
        metaTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(specificLabel)
        specificLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        specificLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        specificLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        specificLabel.topAnchor.constraint(equalTo: metaTextField.bottomAnchor).isActive = true
        
        view.addSubview(switchSpecific)
        switchSpecific.widthAnchor.constraint(equalToConstant: 50).isActive = true
        switchSpecific.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        switchSpecific.topAnchor.constraint(equalTo: metaTextField.bottomAnchor, constant: 10).isActive =  true
        switchSpecific.heightAnchor.constraint(equalTo: specificLabel.heightAnchor).isActive = true
        
        view.addSubview(measurableLabel)
        measurableLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        measurableLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        measurableLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        measurableLabel.topAnchor.constraint(equalTo: specificLabel.bottomAnchor).isActive = true
        
        view.addSubview(switchMeasurable)
        switchMeasurable.widthAnchor.constraint(equalToConstant: 50).isActive = true
        switchMeasurable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        switchMeasurable.topAnchor.constraint(equalTo: switchSpecific.bottomAnchor).isActive = true
        switchMeasurable.heightAnchor.constraint(equalTo: measurableLabel.heightAnchor).isActive = true
        
        view.addSubview(attainableLabel)
        attainableLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        attainableLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        attainableLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        attainableLabel.topAnchor.constraint(equalTo: measurableLabel.bottomAnchor).isActive = true
        
        view.addSubview(switchAttainable)
        switchAttainable.widthAnchor.constraint(equalToConstant: 50).isActive = true
        switchAttainable.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        switchAttainable.topAnchor.constraint(equalTo: switchMeasurable.bottomAnchor).isActive = true
        switchAttainable.heightAnchor.constraint(equalTo: attainableLabel.heightAnchor).isActive = true
        
        view.addSubview(relevantLabel)
        relevantLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        relevantLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
        relevantLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        relevantLabel.topAnchor.constraint(equalTo: attainableLabel.bottomAnchor).isActive = true
        
        view.addSubview(switchRelevant)
        switchRelevant.widthAnchor.constraint(equalToConstant: 50).isActive = true
        switchRelevant.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        switchRelevant.topAnchor.constraint(equalTo: switchAttainable.bottomAnchor).isActive = true
        switchRelevant.heightAnchor.constraint(equalTo: relevantLabel.heightAnchor).isActive = true
        
        view.addSubview(dataLabel)
        dataLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        dataLabel.topAnchor.constraint(equalTo: relevantLabel.bottomAnchor).isActive = true
        dataLabel.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        dataLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        view.addSubview(dataTextField)
        dataTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        dataTextField.topAnchor.constraint(equalTo: dataLabel.bottomAnchor).isActive = true
        dataTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        dataTextField.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
}
