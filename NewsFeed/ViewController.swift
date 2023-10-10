//
//  ViewController.swift
//  NewsFeed
//
//  Created by Aset Bakirov on 09.10.2023.
//

import UIKit

class ViewController: UIViewController {
    
    var time = 0
    var starTime = 0
    var timer = Timer()
    
//    var newsArray:[String] = ["News 1", "News 2", "News 3", "News 4", "News 5"]
    var newsArray:[NewsItem] = []
  
    
    @objc func addNews() {
//     newsArray.append("New test news")
// Использую UUID так как не нашел быстрее способа генерировать рандомный текст в swift
        newsArray.append(NewsItem(title: "\( UUID().uuidString)", postedTime: "\(currentDate())"))
        newsTableView.reloadData()
    }

//Первоначально через кнопку сделал, но потом убрал чтобы было ближе к условиям задачи
//    @IBAction func updateNewsFeed(_ sender: Any) {
//        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(addNews), userInfo: nil, repeats: true)
//    }
    
    @IBOutlet var newsTableView: UITableView!
    

    struct Constants {
        static let cellIdentifier = "NewsCell"
    }
    
    func currentDate() -> String {
        let getDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: getDate)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        newsTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.cellIdentifier)
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(addNews), userInfo: nil, repeats: true)
        
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableViewCell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        var cellContentConfiguration = tableViewCell.defaultContentConfiguration()
        let newsText = newsArray.sorted(by: {
            $0.postedTime > $1.postedTime
        })[indexPath.row]
        cellContentConfiguration.text = newsText.title
        cellContentConfiguration.secondaryText = String(newsText.postedTime)
        tableViewCell.contentConfiguration = cellContentConfiguration
        return tableViewCell
    }
    
   
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
//    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            newsArray.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
//    }
}

