//
//  ViewController.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 18.05.2022.
//

import UIKit
import RxSwift
import RxDataSources
import RxGesture

class MainViewController: UIViewController {

    private let mainView = MainView()
    private var viewModel: MainViewModel
    private let disposeBag = DisposeBag()
    
    //MARK: - Init
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.bind()
        title = "List"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        mainView.randomPieceView.rx.tapGesture()
            .when(.recognized)
            .bind(to: viewModel.input.addRandomPiece)
            .disposed(by: disposeBag)
        
        mainView.newPieceView.rx.tapGesture()
            .when(.recognized)
            .bind(to: viewModel.input.addNewPiece)
            .disposed(by: disposeBag)
        
        mainView.piecesTableView.rx.modelSelected(PieceModel.self)
            .subscribe(onNext: { [unowned self] piece in
                let vm = PieceViewModel(model: piece, saveSubject: self.viewModel.saveDataSubject)
                let controller = PieceViewController(viewModel: vm)
                self.navigationController?.pushViewController(controller, animated: true)
            }).disposed(by: disposeBag)
        
        mainView.piecesTableView.rx.itemSelected
            .subscribe(onNext: { [unowned self] row in
                self.mainView.piecesTableView.deselectRow(at: row, animated: true)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.contentUnavailable
            .subscribe { [unowned self] _ in
                self.showUnavailablePopUp()
            }
            .disposed(by: disposeBag)
        
        viewModel.output.pieces
            .map { [TableSection(items: $0)] }
            .bind(to: mainView.piecesTableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(mainView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.layoutMargins)
        }
        
        mainView.piecesTableView.register(PieceCell.self, forCellReuseIdentifier: "Cell")
        mainView.piecesTableView.rowHeight  = UITableView.automaticDimension
        mainView.piecesTableView.estimatedRowHeight = 80
    }
    
    private func setNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.backgroundColor = UIColor.init(named: "NavBarColor")
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    private func showUnavailablePopUp() {
        let alert = UIAlertController(title: "", message: "The feature is temporarily unavailable", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        self.present(alert, animated: true)
    }
    
    //MARK: - TableView
    private let dataSource = RxTableViewSectionedReloadDataSource<TableSection>(configureCell: {  (_, tableView, _, piece) -> UITableViewCell in
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! PieceCell
        cell.selectionStyle = .none
        cell.configure(viewModel: piece)
        return cell
    })
}
