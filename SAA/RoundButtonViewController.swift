import UIKit

class RoundButtonViewController: BaseViewController {
    var box:Roundbutton
    var label:UILabel
    var delegate: RoundButtonDelegate?;
    
    var text:String {
    get {
        return label.text!
    }
    set {
        label.text=newValue
        
    }
    }
    
    override init()
    {
        box=Roundbutton()
        box.translatesAutoresizingMaskIntoConstraints=false
        label=UILabel()
        label.textColor=Colors.checkboxSelectedColor
        
        label.translatesAutoresizingMaskIntoConstraints=false
        super.init()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        view.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(box)
        view.addSubview(label)
        box.translatesAutoresizingMaskIntoConstraints=false
        label.translatesAutoresizingMaskIntoConstraints=false
 
        let tapRecognizer=UITapGestureRecognizer(target: self, action:  #selector(RoundButtonViewController.buttonTouched(_:)))
        tapRecognizer.numberOfTapsRequired=1;
        tapRecognizer.numberOfTouchesRequired=1;
        view.addGestureRecognizer(tapRecognizer)
   
        box.addTarget(self, action: #selector(RoundButtonViewController.buttonTouched(_:)), forControlEvents: UIControlEvents.TouchDown)
        setConstraints()
    }
    
    func buttonTouched(c: AnyObject ) {
        
        Debug.print("View touched")
        
            delegate?.buttonClicked(self);
    }
    override func viewDidLayoutSubviews()
    {
        super.viewDidLayoutSubviews()
        Debug.print(" \(self.description) ---> View \(view.frame) box \(box.frame) label \(label.frame) ")
    }
    
    func setConstraints()
    {
        Debug.print("setConstraints in CheckboxViewController")
        var constraints:[NSLayoutConstraint] = [
            NSLayoutConstraint(item: box,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: box,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: box, attribute:NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem:nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 30),
            NSLayoutConstraint(item: box, attribute:NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem:nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 30),
            
            ]
        view.addConstraints(constraints)
            constraints = [
            NSLayoutConstraint(item: label,attribute: NSLayoutAttribute.CenterY,relatedBy: NSLayoutRelation.Equal,toItem: box,attribute: NSLayoutAttribute.CenterY,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: label,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: box,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: 10),
            NSLayoutConstraint(item: label, attribute:NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.GreaterThanOrEqual,toItem:nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 100),
            NSLayoutConstraint(item: label, attribute:NSLayoutAttribute.Height,relatedBy: NSLayoutRelation.Equal,toItem:nil,attribute: NSLayoutAttribute.NotAnAttribute,multiplier: 1,constant: 20),
            
            
        ]
        view.addConstraints(constraints)
        
    }
}