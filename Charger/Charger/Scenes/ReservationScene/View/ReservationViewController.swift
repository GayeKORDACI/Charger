//
//  ReservationViewController.swift
//  Charger
//
//  Created by Gaye Kordacı Deprem on 14.07.2022.
//

import UIKit
import CoreLocation
class ReservationViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var viewModel: ReservationViewModel!
    
    private var datas: [ReservationAPIModel]?
    
    private var currentDatas: [ReservationAPIModel]?
    private var passedDatas: [ReservationAPIModel]?
    
    static func create(with viewModel: ReservationViewModel, datas: [ReservationAPIModel]?) -> ReservationViewController {
        let view = ReservationViewController.instantiateViewController()
        view.modalPresentationStyle = .fullScreen
        view.viewModel = viewModel
        view.datas = datas
        return view
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        passedDatas = datas?.filter({ model in
            model.hasPassed ?? true
        })
        
        currentDatas = datas?.filter({ model in
            !(model.hasPassed ?? true)
        })
        
    }
    
    private func setupUI() {
        
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.registerNib(ReservationTableViewCell.reuseId)
        tableView.backgroundColor = .clear
        self.navigationItem.title = "reservations".localized
        
        let menuButton = UIBarButtonItem(image: UIImage(named: "Users")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(navigateProfile))
        self.navigationItem.setLeftBarButton(menuButton, animated: true)
        
    }
    
    @objc
    private func navigateProfile() {
        self.navigationController?.pushViewController(AppBootstrap.createProfileViewController(), animated: true)
    }
    
    
}

extension ReservationViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        let currentDatasCount = (currentDatas?.count ?? 0 > 0) ? 1 : 0
        
        let passedDatasCount = (passedDatas?.count ?? 0 > 0) ? 1 : 0
        
        return currentDatasCount + passedDatasCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return currentDatas?.count ?? 0
        }else if section == 1 {
            return passedDatas?.count ?? 0
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if section == 0 {
            return "active_reservation".localized.localizedUppercase
        }else if section == 1 {
            return "past_reservation".localized.localizedUppercase
        }
        
        return ""
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        
        
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = .grayscale
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ReservationTableViewCell.reuseId, for: indexPath) as? ReservationTableViewCell
        
        //        var data = ReservationAPIModel()
        //        let currentDatasCount = currentDatas?.count ?? 0
        //        let passedDatasCount = passedDatas?.count ?? 0
        //
        //        if currentDatasCount > 0 && indexPath.row < currentDatasCount {
        //            data = currentDatas?[indexPath.row] ?? ReservationAPIModel()
        //        }else if passedDatasCount > 0 && indexPath.row < currentDatasCount + passedDatasCount && indexPath.row - currentDatasCount >= 0 {
        //            data = passedDatas?[indexPath.row - currentDatasCount] ?? ReservationAPIModel()
        //        }
        //        else {
        //            data = ReservationAPIModel()
        //        }
        
        if indexPath.section == 0 {
            if let currentDatas = currentDatas {
                let data = currentDatas[indexPath.row]
                cell?.setData(data)
            }
        }else if indexPath.section == 1 {
            if let passedDatas = passedDatas {
                let data = passedDatas[indexPath.row]
                cell?.setData(data)
            }
        }
        //
        //        if let datas = datas {
        //            let data = datas[indexPath.row]
        //            cell?.setData(data)
        //        }
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
    
}
