//
//  ViewController.swift
//  Practic2
//
//  Created by лізушка лізушкіна on 24.02.2023.
//
import UIKit

class PostDetailsViewController: UIViewController {
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var upperLabel: UILabel!
    @IBOutlet private weak var imageWeb: UIImageView!
    @IBOutlet private var mainView: UIView!
    @IBOutlet private weak var savingButton: UIButton!
    @IBOutlet private weak var likeButton: UIButton!
    @IBOutlet private weak var commentsButton: UIButton!
    @IBOutlet private weak var shareButton: UIButton!
    @IBOutlet private weak var background: UIView!
    var reddit:[String:String] = [:]
    
    override func viewDidLoad() {
        setUpPage()
        super.viewDidLoad()
    }
    
    public func redditMake(redditCurrent:[String:String])
    {
        self.reddit = redditCurrent
    }
    
    func setUpPage()
    {
        if let saved = reddit["Saved"]{
            if saved == "true"
            {
                self.savingButton.setImage(UIImage(systemName:"bookmark"), for: .normal)
            }
            else
            {
                self.savingButton.setImage(UIImage(systemName:"bookmark.fill"), for: .normal)
            }
        }

        if let upper = reddit["UpperLabel"],
        let comms = reddit ["Comments"],
        let title = reddit["Title"],
        let likes = reddit ["Rating"]
     {
            self.upperLabel.text = upper
            self.titleLabel.text = title
            self.titleLabel.numberOfLines=0
            
            if let urlimg = reddit["Image"]{
                if let url = URL(string: urlimg) {
                    let task = URLSession.shared.dataTask(with: url) { data, response, error in
                        guard let data = data, error == nil else { return }
                        DispatchQueue.main.async {
                            self.imageWeb.image = UIImage(data: data)
                        }
                    }
                    task.resume()
                }
                self.titleLabel.font = UIFont(name: self.titleLabel.font.fontName, size: 18)
                
            }
            else
            {
                let sizeText = self.titleLabel.sizeThatFits(CGSize(width: self.titleLabel.frame.size.width, height: self.titleLabel.frame.size.height))
                    if(sizeText.height > self.titleLabel.frame.size.height)
                    {
                        self.titleLabel.adjustsFontSizeToFitWidth = true
                    }
            }
             self.commentsButton.setTitle(comms, for: .normal)
             self.likeButton.setTitle(likes, for: .normal)
     }
    }
    @IBAction func onShareClickBtn(_ sender: Any) {
    }
    
    @IBAction func onCommentClickBtn(_ sender: Any) {
    }
    
    @IBAction func onSaveClickBtn(_ sender: Any) {
        if let saved = reddit["Saved"]{
            if saved == "true"
            {
                self.savingButton.setImage(UIImage(systemName:"bookmark"), for: .normal)
                reddit["Saved"] = "false"
            }
            else
            {
                self.savingButton.setImage(UIImage(systemName:"bookmark.fill"), for: .normal)
                reddit["Saved"] = "true"
            }
        }
    }
    
    @IBAction func onLikeClickBtn(_ sender: Any) {
    }
}
