//
//  ViewController.swift
//  TableHeaderViewDemo
//
//  Created by admin on 4/27/21.
//

import UIKit
import MAAutoLayout

class ViewController: UIViewController {

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.tableHeaderView = MAHeaderView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 120))
        tableView.rowHeight = 44
        return tableView
    }()
    
    var string: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        self.tableView.ma_makeConstraints { (make) in
            make.edge.equalTo(self.view)
        }
        self.refreshAction(self.navigationItem.rightBarButtonItem!)
    }

    @IBAction func refreshAction(_ sender: UIBarButtonItem) {
        self.string += Date.init().description
        (tableView.tableHeaderView as? MAHeaderView)?.title = self.string
        self.refreshTableHeaderViewFrame()
    }
    
    func refreshTableHeaderViewFrame() {
        if let headerView = tableView.tableHeaderView {// 获取headerView
            let smallSize =  headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)  //获取到基于Autolayout布局控件尽可能小的大小
            var tempFrame = headerView.frame
            tempFrame.size.height = smallSize.height
            headerView.frame = tempFrame           //  直接更改frame无效
            tableView.tableHeaderView = headerView // 【重点】重新为 TableView 赋值 Header
            self.tableView.reloadData()
        }
    }
    
}


extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = "\(Date().description)-\(indexPath.row)"
        return cell
    }
    
}
