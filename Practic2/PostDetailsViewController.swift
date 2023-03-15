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
    
    @IBOutlet private weak var imageView: UIView!
    
    private var post: Post = Post()
    private var savedPosts : SavedPostsManager = SavedPostsManager()
    
    override func viewDidLoad() {
        setUpPage()
        super.viewDidLoad()
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(doubleTapped))
           tap.numberOfTapsRequired = 2
        self.imageView.addGestureRecognizer(tap)
    }
    
    @objc func doubleTapped()
    {
        if let _ = post.reddit["Saved"]
        {
            self.savingButton.setImage(UIImage(systemName:"bookmark.fill"), for: .normal)
                post.reddit["Saved"] = "true"
            self.savedPosts.savePost(post: post)
        }
        drawBookMark()
    }
    
    func drawBookMark()
    {
        
        let bookmarkLayer = CAShapeLayer()
        imageView.layer.addSublayer(bookmarkLayer)
        let bookmarkPath = UIBezierPath()
        bookmarkPath.move(to: CGPoint(x: imageView.center.x-40, y: 0))
        bookmarkPath.addLine(to: CGPoint(x: imageView.center.x+40, y: 0))
        bookmarkPath.addLine(to: CGPoint(x: imageView.center.x+50, y: 10))
        bookmarkPath.addLine(to: CGPoint(x: imageView.center.x+50, y: 150))
        bookmarkPath.addLine(to: CGPoint(x: imageView.center.x, y: 110))
        bookmarkPath.addLine(to: CGPoint(x: imageView.center.x-50, y: 150))
        bookmarkPath.addLine(to: CGPoint(x: imageView.center.x-50, y: 10))
        bookmarkPath.close()
        
        bookmarkLayer.path = bookmarkPath.cgPath
        bookmarkLayer.fillColor = UIColor.white.cgColor
        bookmarkLayer.strokeColor = UIColor.lightGray.cgColor
        bookmarkLayer.lineWidth = 2.0
        bookmarkLayer.opacity = 0.0
        imageView.layer.addSublayer(bookmarkLayer)
        CATransaction.begin()
        let animation = CABasicAnimation(keyPath: "opacity")
        animation.fromValue = 0.0
        animation.toValue = 1.0
        animation.duration = 0.5
        bookmarkLayer.opacity = 1.0
        bookmarkLayer.add(animation, forKey: "opacityAnimation")
        let bookmarkAnimation = CABasicAnimation(keyPath: "opacity")
        bookmarkAnimation.fromValue = 1.0
        bookmarkAnimation.toValue = 0.0
        bookmarkAnimation.duration = 0.7
        bookmarkAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        bookmarkLayer.add(bookmarkAnimation, forKey: "opacity")
        bookmarkLayer.opacity = 0.0
        CATransaction.commit()
    }
 
    public func redditMake(redditCurrent:Post, saved: SavedPostsManager)
    {
        self.savedPosts = saved
        self.post = redditCurrent
    }
    
    func setUpPage()
    {
        if let saved = post.reddit["Saved"]{
            if saved == "true"
            {
                self.savingButton.setImage(UIImage(systemName:"bookmark.fill"), for: .normal)
            }
            else
            {
                self.savingButton.setImage(UIImage(systemName:"bookmark"), for: .normal)
            }
        }

        if let upper = post.reddit["UpperLabel"],
        let comms = post.reddit ["Comments"],
        let title = post.reddit["Title"],
        let likes = post.reddit ["Rating"]
     {
            self.upperLabel.text = upper
            self.titleLabel.text = title
            self.titleLabel.numberOfLines=0
            
            if let urlimg = post.reddit["Image"]{
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
    
    @IBAction func onShareClickBtn(_ sender: Any)
    {
        if let url = self.post.reddit["Url"] {
                let items = [URL(string:url)!]
                let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
                DispatchQueue.main.async {
                    self.present(ac, animated: true)
                }
            }
    }
    
    @IBAction func onCommentClickBtn(_ sender: Any) {
    }
    
    @IBAction func onSaveClickBtn(_ sender: Any) {
        if let saved = post.reddit["Saved"]{
            if saved == "true"
            {
                self.savingButton.setImage(UIImage(systemName:"bookmark"), for: .normal)
                post.reddit["Saved"] = "false"
                self.savedPosts.deletePost(post: post)
            }
            else
            {
                self.savingButton.setImage(UIImage(systemName:"bookmark.fill"), for: .normal)
                post.reddit["Saved"] = "true"
                self.savedPosts.savePost(post: post)
            }
        }
    }
    
    @IBAction func onLikeClickBtn(_ sender: Any)
    {
        
    }
}
