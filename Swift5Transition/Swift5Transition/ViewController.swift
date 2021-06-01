//
//  ViewController.swift
//  Swift5Transition
//
//  Created by 伊藤直輝 on 2021/04/28.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var countLabel: UILabel!
    
    var count = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func countUp(_ sender: Any) {
        
        count += 1
        countLabel.text = String(count)
        
        if (count == 10) {
            // Storyboard SegueのIdentifierを指定して遷移
            performSegue(withIdentifier: "countView", sender: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let countVC = segue.destination as! CountViewController
        countVC.count2 = count
    }
    
    @IBAction func showView(_ sender: Any) {
        let showVC = storyboard?.instantiateViewController(identifier: "show") as! ShowViewController
        
        navigationController?.pushViewController(showVC, animated: true)
    }
    
}

