//
//  ViewController.swift
//  test-task-halbestunde
//
//  Created by Iurii Gubanov on 18.05.2022.
//

import UIKit

class MainViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let mainView = MainView()
    private var viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        title = "List"
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
    
        view.addSubview(mainView)
        
        mainView.translatesAutoresizingMaskIntoConstraints = false
        mainView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.layoutMargins)
        }
        
        mainView.piecesTableView.delegate = self
        mainView.piecesTableView.dataSource = self
        mainView.piecesTableView.register(PieceCell.self, forCellReuseIdentifier: "Cell")
        mainView.piecesTableView.rowHeight  = UITableView.automaticDimension
        mainView.piecesTableView.estimatedRowHeight = 80
        
        let newPieceTapRec = UITapGestureRecognizer(target: self, action: #selector(addNewPieceAction))
        mainView.newPieceView.addGestureRecognizer(newPieceTapRec)
        
        let randomPieceTapRec = UITapGestureRecognizer(target: self, action: #selector(addRandPiectAction))
        mainView.randomPieceView.addGestureRecognizer(randomPieceTapRec)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let navBarHeight = navigationController?.navigationBar.frame.size.height,
           let statusBarHeight = view.window?.windowScene?.statusBarManager?.statusBarFrame.height {
            mainView.update(topOffset: navBarHeight + statusBarHeight, bottomOffset: view.layoutMargins.bottom)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setNavBar()
    }
    
    @objc func addNewPieceAction() {
        
    }
    
    @objc private func addRandPiectAction() {
        let piece = viewModel.randPiece()
        viewModel.pieces.append(piece)
        mainView.piecesTableView.reloadData()
    }
    
    private func setNavBar() {
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        navBarAppearance.backgroundColor = UIColor.init(named: "NavBarColor")
        
        navigationController?.navigationBar.standardAppearance = navBarAppearance
        navigationController?.navigationBar.scrollEdgeAppearance = navBarAppearance
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.pieces.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let pieceVM = viewModel.pieces[indexPath.section]
       
        (cell as! PieceCell).configure(viewModel: pieceVM)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let piece = viewModel.pieces[indexPath.section]
        let viewModel = PieceViewModel(viewModel: piece) { [weak self] result in
            self?.viewModel.pieces[indexPath.section] = result
            self?.mainView.piecesTableView.reloadData()
        }
        let viewController = PieceViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = .clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return Padding.spacing
    }
}
