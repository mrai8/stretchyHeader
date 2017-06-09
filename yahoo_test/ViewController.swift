//
//  ViewController.swift
//  yahoo_test
//
//  Created by Mandeep on 2017-06-06.
//  Copyright © 2017 Mandeep. All rights reserved.
//

import UIKit


struct newsItem {
    var world = UIColor.red
    var america = UIColor.blue
    var europe = UIColor.green
    var middleEast = UIColor.yellow
    var africa = UIColor.orange
    var asiaPacific = UIColor.purple
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    
    private let newsTableHeaderHeight: CGFloat = 300.0
    private let newsCutAway: CGFloat = 80.0
    
    let regions:[String]=["world","europe","middle east","africa","asia pacific","americas","world","europe"]
    
    let articles:[String]=["Climate change protests, divestments meet fossil fuels realities","Scotland's 'Yes' leader says independence vote is 'once in a lifetime'","Airstrikes boost Islamic State, FBI director warns more hostages possible","Nigeria says 70 dead in building collapse; questions S. Africa victim claim","Despite UN ruling, Japan seeks backing for whale hunting","Officials: FBI is tracking 100 Americans who fought alongside IS in Syria","South Africa in $40 billion deal for Russian nuclear reactors", "'One million babies' created by EU student exchanges"]
    
    let cellReuseIdentifier = "newsCell"
    
    var headerView:UIView!
    var headerMaskLayer: CAShapeLayer!


    
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        tableView.delegate = self
        tableView.dataSource = self
        
        self.tableView.estimatedRowHeight = 125.0
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        
        headerView = self.tableView.tableHeaderView
        self.tableView.tableHeaderView = nil
        
        self.tableView.addSubview(headerView)
        
        self.tableView.contentInset = UIEdgeInsets(top: newsTableHeaderHeight, left: 0, bottom: 0, right: 0)
        self.tableView.contentOffset = CGPoint(x: 0, y: -newsTableHeaderHeight)
        updateHeaderView()
        
        /*headerMaskLayer = CAShapeLayer()
        headerMaskLayer.fillColor = UIColor.black.cgColor
        headerView.layer.mask = headerMaskLayer
        updateHeaderView()*/
        
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        updateHeaderView()
    }
    
    
    func updateHeaderView(){
        var headerRect = CGRect(x: 0, y: -newsTableHeaderHeight, width: self.tableView.bounds.width, height: newsTableHeaderHeight)
        
        if self.tableView.contentOffset.y < -newsTableHeaderHeight {
            headerRect.origin.y = self.tableView.contentOffset.y
            headerRect.size.height = -self.tableView.contentOffset.y
        }
        headerView.frame = headerRect
    }

    override var prefersStatusBarHidden: Bool{
        return true
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // create a new cell if needed or reuse an old one
        let cell:NewsTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! NewsTableViewCell!
        
        // set the text from the data model
        cell.categoryLabel.text = regions[indexPath.row]
        regionCellColor(cell: cell)
        cell.headlineLabel.text = articles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
    }

    
    
    func regionCellColor(cell:NewsTableViewCell){
        
        let color = newsItem()
        switch cell.categoryLabel.text {
        case "world"?:
            cell.categoryLabel.textColor = color.world
        case "europe"?:
            cell.categoryLabel.textColor = color.europe
        case "middle east"?:
            cell.categoryLabel.textColor = color.middleEast
        case "africa"?:
            cell.categoryLabel.textColor = color.africa
        case "asia pacific"?:
            cell.categoryLabel.textColor = color.asiaPacific
        case "americas"?:
            cell.categoryLabel.textColor = color.america
        default:
            cell.categoryLabel.textColor = UIColor.black
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    
    
}

