//
//  MovieDetailViewController.swift
//  RottenTomatoes
//
//  Created by Nguyen Duy Hung on 8/30/15.
//  Copyright (c) 2015 Nguyen Duy Hung. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {

    var movie : NSDictionary?
    @IBOutlet weak var backgroundPosterImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundPosterImage.setImageWithURL(NSURL(string: movie!.valueForKeyPath("posters.thumbnail") as! String)!)
        titleLabel.text = movie!["title"] as? String
        synopsisLable.text = movie!["synopsis"] as? String
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
