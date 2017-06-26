
import UIKit

class PMGwentCarousel: UIView {

    var descrStr: String?
    var picRef: String?
    
    var currentCard: UIView?
    var nextCard: UIView?
    
    public var cardTextField = UITextField(frame: CGRect(x:0, y:0, width:70, height:30))
    var cardFrameView: UIImageView?
    var cardImageView: UIImageView?

    
    init(frame: CGRect, frameType: String, imageURL: URL, cardText: String) {
        
        super.init(frame: CGRect(x:50, y:100, width:frame.size.width - 95, height:frame.size.height - 270))
        let currCard: UIView = initCard(coordX: 0, coordY: 0, frameImage: UIImage(named: frameType), imageURL: imageURL, cardText: cardText)
        self.currentCard = currCard
        self.addSubview(currCard)
    }
    
    func initCard (coordX: CGFloat, coordY: CGFloat, frameImage: UIImage?, imageURL: URL, cardText: String?) -> UIView {
        
        let cardView: UIView = UIView(frame: CGRect(x: coordX, y: coordY, width:self.frame.width, height:self.frame.height))
        
        cardFrameView = UIImageView(frame: cardView.frame)
        cardFrameView?.image = frameImage
        
        cardImageView = UIImageView(frame: cardView.frame)
        cardImageView?.downloadedFrom(url: imageURL)
        cardImageView?.backgroundColor = UIColor.gray
        
        let strokeTextAttributes = [
            NSStrokeColorAttributeName : UIColor .black,
            NSForegroundColorAttributeName : UIColor .white,
            NSStrokeWidthAttributeName : -5.0,
        ] as [String : Any]
        
        
        cardTextField.center = CGPoint(x:211, y:44)
        cardTextField.textAlignment = .right
        cardTextField.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        cardTextField.attributedText = NSAttributedString(string: cardText!, attributes: strokeTextAttributes)
        cardTextField.isEnabled = false
        
        
        cardView.addSubview(cardImageView!)
        cardView.addSubview(cardFrameView!)
        cardView.addSubview(cardTextField)
        
        return cardView
    }
    
    //true - right; left - false
    func endOfListAnimation(flag: Bool) {

        let currCard: UIView = currentCard!
        
        var transform: CATransform3D = CATransform3DIdentity
        
        if(flag) {
            transform = CATransform3DTranslate(transform, 40, 0, 0)
        } else {
            transform = CATransform3DTranslate(transform, -40, 0, 0)
        }
        
        UIView.animate(withDuration: 0.05,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: {
                        
            currCard.layer.transform = transform
                        
        }, completion: { (finished:Bool) in
            
            self.endOfListBounce()
            
        })
    }
    
    func endOfListBounce() {

        let currCard: UIView = currentCard!
        
        var transform: CATransform3D = CATransform3DIdentity
        
        transform = CATransform3DTranslate(transform, 0, 0, 0)
        
        UIView.animate(withDuration: 0.6,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 50,
                       options: .curveEaseIn,
                       animations: {
                
            currCard.layer.transform = transform
                
        }, completion: { (finished:Bool) in
            
            
        })
    }
    
    public func showNextCard(frameType: String, imageURL: URL, cardText: String) {
        
        var currCard: UIView = currentCard!
        nextCard = initCard(coordX: 0, coordY: 0, frameImage: UIImage(named: frameType), imageURL: imageURL, cardText: cardText)
        self.currentCard = nextCard
        self.addSubview(currentCard!)
        
        var transform: CATransform3D = CATransform3DIdentity
        transform.m34 = 1.0 / -500.0
        transform = CATransform3DRotate(transform, CGFloat(90.0 * M_PI / 180), 0, -1, 0)
        transform = CATransform3DTranslate(transform, 300, 0, 130)

        UIView.animate(withDuration: 0.4,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: {
            
            currCard.layer.transform = transform
            
        }, completion: { (finished:Bool) in
            
            currCard.removeFromSuperview()
            
        })
    }
    
    public func showPreviousCard(frameType: String, imageURL: URL, cardText: String) {
        
        let currCard: UIView = currentCard!
        let prevCard = initCard(coordX: 0, coordY: 0, frameImage: UIImage(named: frameType), imageURL: imageURL, cardText: cardText)
        self.currentCard = prevCard
        self.addSubview(currentCard!)
        
        placePreviousCard(card: prevCard, currCard: currCard)
        
    }
    
    func placePreviousCard(card: UIView, currCard: UIView) {
        
        card.frame = (CGRect(x: -400, y: 0, width: self.frame.width, height: self.frame.height)) 
        var transform: CATransform3D = CATransform3DIdentity
        transform.m34 = 1.0 / -500.0
        transform = CATransform3DRotate(transform, CGFloat(90.0 * M_PI / 180), 0, -1, 0)
        transform = CATransform3DTranslate(transform, 170, 0, 300)
        
        UIView.animate(withDuration: 0.01,
                       delay: 0,
                       options: .curveLinear,
                       animations: {
                        
            card.layer.transform = transform
                        
        }, completion: { (finished:Bool) in
            
            self.animatePreviousCard(card: card, currCard: currCard)
            
        })
    }
    
    func animatePreviousCard(card: UIView, currCard: UIView) {
        
        var transform: CATransform3D = CATransform3DIdentity
        transform.m34 = 1.0 / -500.0
        transform = CATransform3DRotate(transform, 0, 0, -1, 0)
        transform = CATransform3DTranslate(transform, 400, 0, 0)
        
        UIView.animate(withDuration: 0.3,
                       delay: 0,
                       options: .curveEaseOut,
                       animations: {
            
            card.layer.transform = transform
                        
        }, completion: { (finished:Bool) in
            
            card.layer.transform = CATransform3DIdentity 
            card.frame = (CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)) 
            currCard.removeFromSuperview()
        })
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
