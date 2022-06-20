//
//  PieceViewController.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 18.05.2022.
//

import UIKit

class PieceViewController: UIViewController {
    private let mainView = PieceView()
    private let viewModel: PieceViewModel
    
    init(viewModel: PieceViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        view.addSubview(mainView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(mainView.leadingAnchor.constraint(equalTo: view.leadingAnchor))
        view.addConstraint(mainView.trailingAnchor.constraint(equalTo: view.trailingAnchor))
        view.addConstraint(mainView.topAnchor.constraint(equalTo: view.topAnchor))
        view.addConstraint(mainView.bottomAnchor.constraint(equalTo: view.bottomAnchor))
        
        mainView.posterImageView.image = UIImage(named: viewModel.posterName)
        mainView.nameTextField.text = viewModel.name
        mainView.authorTextField.text = viewModel.author
        mainView.descriptionTextView.text = viewModel.description
        
        let saveButton = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveAction))
        navigationItem.rightBarButtonItem = saveButton
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavBar()
    }
    
    @objc private func saveAction() {
        guard let name = mainView.nameTextField.text else { return }
        guard let author = mainView.authorTextField.text else { return }
        guard let description = mainView.descriptionTextView.text else { return }
        
        viewModel.save(title: name, author: author, description: description)
    }
    
    private func setNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.backgroundImage = UIImage.init(named: viewModel.posterName)
        navBarAppearance.backgroundImageContentMode = .scaleToFill
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
}
