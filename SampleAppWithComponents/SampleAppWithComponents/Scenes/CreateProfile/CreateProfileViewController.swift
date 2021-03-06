//
//  CreateProfileViewController.swift
//  SampleAppWithComponents
//
//  Created by Rahul Mane on 16/10/19.
//  Copyright (c) 2019 developer. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol CreateProfileDisplayLogic: class
{
    func displaySomething(viewModel: CreateProfile.Something.ViewModel)
    func displayUI(viewModel: CreateProfile.UI.ViewModel)
}

class CreateProfileViewController: UIViewController, CreateProfileDisplayLogic, UITableViewDataSource, UITableViewDelegate
{
    var interactor: CreateProfileBusinessLogic?
    var router: (NSObjectProtocol & CreateProfileRoutingLogic & CreateProfileDataPassing)?
    
    @IBOutlet weak var tableview: UITableView!
    private var cellConfigs : [(uiComponent : CreateProfile.UIComponents,config: BaseCellConfig)]?
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = CreateProfileInteractor()
        let presenter = CreateProfilePresenter()
        let router = CreateProfileRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad(){
        super.viewDidLoad()
        doSomething()
        setUpUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.unHideNavigationBar()
    }
    
    
    //MARK: Setup
    func setUpUI(){
        hideKeyboardWhenTappedAround()
        registerNibs()
        self.tableview.backgroundColor = UIColor.clear
        askForUI()
    }
    
    func askForUI(){
        let request = CreateProfile.UI.Request()
        interactor?.requiredUIForScreen(request: request)
    }
    
    func registerNibs(){
        tableview.register(UINib(nibName: "TextfieldTableViewCell", bundle: nil), forCellReuseIdentifier: "firstName")
        tableview.register(UINib(nibName: "TextfieldTableViewCell", bundle: nil), forCellReuseIdentifier: "lastName")
        tableview.register(UINib(nibName: "TextfieldTableViewCell", bundle: nil), forCellReuseIdentifier: "phone")
        tableview.register(UINib(nibName: "TextfieldTableViewCell", bundle: nil), forCellReuseIdentifier: "address")
        tableview.register(UINib(nibName: "LabelTableViewCell", bundle: nil), forCellReuseIdentifier: "info")
        tableview.register(UINib(nibName: "ButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "submit")
        tableview.rowHeight = UITableView.automaticDimension
        tableview.estimatedRowHeight = 140
    }
    
    // MARK: Do something
    
    //@IBOutlet weak var nameTextField: UITextField!
    
    func doSomething()
    {
        let request = CreateProfile.Something.Request()
        interactor?.doSomething(request: request)
    }
    
    func displaySomething(viewModel: CreateProfile.Something.ViewModel)
    {
        //nameTextField.text = viewModel.name
    }
    
    func displayUI(viewModel: CreateProfile.UI.ViewModel){
        cellConfigs = viewModel.cellConfigs
        tableview.reloadData()
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return cellConfigs?.count ?? 0 //viewmoDel.getNumberOfRows()
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        guard let cellDetails = cellConfigs?[indexPath.row]  else {
            return UITableViewCell()
        }
        
        switch cellDetails.uiComponent {
        case .firstName :
            let cell = tableView.dequeueReusableCell(withIdentifier: "firstName", for: indexPath) as! TextfieldTableViewCell
            cell.configureCell(config: cellDetails.config as? TextfieldTableViewCellConfig)
            cell.backgroundColor = UIColor.clear
            return cell
        case .lastName :
            let cell = tableView.dequeueReusableCell(withIdentifier: "lastName", for: indexPath) as! TextfieldTableViewCell
            cell.configureCell(config: cellDetails.config as? TextfieldTableViewCellConfig)
            cell.backgroundColor = UIColor.clear
            return cell
        case .phoneNumber :
            let cell = tableView.dequeueReusableCell(withIdentifier: "phone", for: indexPath) as! TextfieldTableViewCell
            cell.configureCell(config: cellDetails.config as? TextfieldTableViewCellConfig)
            cell.backgroundColor = UIColor.clear
            return cell
        case .address :
            let cell = tableView.dequeueReusableCell(withIdentifier: "address", for: indexPath) as! TextfieldTableViewCell
            cell.configureCell(config: cellDetails.config as? TextfieldTableViewCellConfig)
            cell.backgroundColor = UIColor.clear
            return cell
        case .infoOfScreen:
            let cell = tableView.dequeueReusableCell(withIdentifier: "info", for: indexPath) as! LabelTableViewCell
            cell.backgroundColor = UIColor.clear
            cell.configureCell(config: cellDetails.config as? LabelTableViewCellConfig)
            return cell
        case .submit:
            let cell = tableView.dequeueReusableCell(withIdentifier: "submit", for: indexPath) as! ButtonTableViewCell
            cell.configureCell(config: cellDetails.config as? ButtonTableViewCellConfig)
            return cell
        }
    }
}
