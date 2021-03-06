//
//  CamerasListViewController.swift
//  ErlyVideo
//
//  Created by Dmitry on 18/06/2019.
//  Copyright © 2019 Personal. All rights reserved.
//

import UIKit
import FlussonicSDK

class CamerasListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    
    var allCamerasArray:[CameraModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadData()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        
    }
    
    //MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allCamerasArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CameraListTableViewCell", for: indexPath) as! CameraListTableViewCell
        cell.customizeCell(camera: allCamerasArray[indexPath.row])
        return cell
    }
    
    //MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if allCamerasArray[indexPath.row].isOnline == false {
            return
        } else {
            CameraRouting.showCameraScreen(fromVC: self, camera: allCamerasArray[indexPath.row])
        }
    }
    
    func loadData() {
        CameraService.shared.requestCamerasList { (allCameras, error) in
            self.allCamerasArray = allCameras
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    //MARK: - Navigation
    @IBAction func logoutButtonTouched(sender: AnyObject) {
        AuthorizationRouting.showAuthorizationScreen(fromVC: self)
    }
    
}
