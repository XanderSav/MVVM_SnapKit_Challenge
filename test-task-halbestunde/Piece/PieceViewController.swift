//
//  PieceViewController.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 18.05.2022.
//

import UIKit
import RxSwift
import RxCocoa

class PieceViewController: UIViewController {
    private let mainView = PieceView()
    private let viewModel: PieceViewModel
    private let disposeBag = DisposeBag()
    
    private lazy var saveButton: UIBarButtonItem = {
        let saveButton = UIBarButtonItem(systemItem: UIBarButtonItem.SystemItem.done)
        saveButton.target = self
        saveButton.isEnabled = false
        return saveButton
    }()
    
    init(viewModel: PieceViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.nameTextField.text = viewModel.name
        mainView.authorTextField.text = viewModel.author
        mainView.descriptionTextView.text = viewModel.description
        viewModel.input.name.accept(viewModel.name)
        viewModel.input.author.accept(viewModel.author)
    }
    
    //MARK: - Lifecycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavBar()
    }
    
    //MARK: - PrivateMethods
    private func bind() {
        mainView.nameTextField.rx
            .text.orEmpty
            .bind(to: viewModel.input.name)
            .disposed(by: disposeBag)
        
        mainView.authorTextField.rx
            .text.orEmpty
            .bind(to: viewModel.input.author)
            .disposed(by: disposeBag)
        
        mainView.descriptionTextView.rx
            .text.orEmpty
            .bind(to: viewModel.input.description)
            .disposed(by: disposeBag)
        
        saveButton.rx.tap
            .bind(to: viewModel.output.save)
            .disposed(by: disposeBag)
        
        let nameChanged = mainView.nameTextField.rx
            .controlEvent([.editingChanged])
            .asObservable()
        let authorChanged = mainView.authorTextField.rx
            .controlEvent([.editingChanged])
            .asObservable()
        let descriptionChanged = mainView.descriptionTextView.rx
            .didChange
            .asObservable()
        let anythingChanged = Observable
            .of(nameChanged, authorChanged, descriptionChanged)
            .merge()
            .map { _ in return true }
        
        anythingChanged.bind(to: saveButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        viewModel.output.save.subscribe(onNext: ({
            self.navigationController?.popToRootViewController(animated: true)
        })).disposed(by: disposeBag)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(mainView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.layoutMargins)
        }
    }
    
    private func setNavBar() {
        navigationItem.rightBarButtonItem = saveButton
        
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.backgroundImage = UIImage.init(named: viewModel.posterName)
        navBarAppearance.backgroundImageContentMode = .scaleToFill
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
        navigationController?.navigationBar.tintColor = .white
    }
}
