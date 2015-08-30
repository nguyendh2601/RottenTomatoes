//
//  MoviesViewController.swift
//  RottenTomatoes
//
//  Created by Nguyen Duy Hung on 8/30/15.
//  Copyright (c) 2015 Nguyen Duy Hung. All rights reserved.
//

import UIKit
import AFNetworking
import SwiftLoader

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var movies : [NSDictionary]?
    var refreshControl: UIRefreshControl!
    let url = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.addSubview(refreshControl)
        
        var config : SwiftLoader.Config = SwiftLoader.Config()
        config.size = 150
        config.spinnerColor = UIColor.whiteColor()
        config.backgroundColor = UIColor.blackColor()
        config.titleTextColor = UIColor.whiteColor()
        config.spinnerLineWidth = 5
        SwiftLoader.setConfig(config)
        SwiftLoader.show(title: "Loading...", animated: true)
        
        loadMoviesData() {
            SwiftLoader.hide()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let movies = movies {
            return movies.count
        }
        else
        {
            return 0
        }
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("MovieCell", forIndexPath: indexPath) as! MovieCell
        let movie = movies![indexPath.row]
        cell.posterImage.setImageWithURL(NSURL(string: movie.valueForKeyPath("posters.thumbnail") as! String)!)
        cell.titleLabel.text = movie["title"] as? String
        cell.synopsisLabel.text = movie["synopsis"] as? String
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPathForCell(cell)!
        let selectedMovie = movies![indexPath.row]
        
        let movieDetailViewController = segue.destinationViewController as! MovieDetailViewController
        movieDetailViewController.movie = selectedMovie
        
    }
    
    func loadMoviesData(completion: (() -> Void)!) {
        let request = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {
            (response: NSURLResponse!, data: NSData!, error: NSError!) -> Void in
            let json = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: nil) as? NSDictionary
            if let json = json {
                self.movies = json["movies"] as? [NSDictionary]
                self.tableView.reloadData()
            }
            self.tableView.dataSource = self
            self.tableView.delegate = self
            if completion != nil {
                completion()
            }
        }

    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        loadMoviesData() {
            self.fakeGetNewMovies()
            self.refreshControl.endRefreshing()
        }
    }
    
    //move random movie to top for feeling as loaded new - because data static at the moment
    func fakeGetNewMovies() {
        if self.movies?.count > 1 {
            //                let lastIndex = self.movies!.count
            let lastIndex = Int(arc4random_uniform(10)) + 9
            let lastMovie = self.movies![lastIndex - 1]
            self.movies!.insert(lastMovie, atIndex: 0)
            self.movies!.removeAtIndex(lastIndex)
        }
    }
}
