//
import UIKit

class SentimentGraficViewController: BaseGraficViewController,NewDataDelegate {
    
    var label:UILabel
    
    var content:DonatView
    let legende=SentimentGrafikLegendeViewController()
    
    init(filter:Filter)
    {
        
        label=UILabel()
        label.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        
        content=DonatView(pos: 0,neg: 0,neutr: 0)
        content.setTranslatesAutoresizingMaskIntoConstraints(false)
        super.init()
        dataSource=SentimentData(filter: filter)
        dataSource!.delegate=self
        // content.backgroundColor=UIColor.redColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        label.text="Bewertung"
        label.textColor=Colors.leftMenuInactiveTextColor
        
        view.setTranslatesAutoresizingMaskIntoConstraints(false)
        view.addSubview(label)
        
        view.addSubview(content)
        addChild(legende)
        
        setConstraints()
    }
    
    func getData()
    {
            dataSource?.getData()
    }
    
    override func dataLoaded(sender: BasicNetwork)
    {
        var source:SentimentData=dataSource as SentimentData
        
        Debug.print("SentimentGraficViewController::dataLoaded \(source)")
        content.refresh(source.positive, neg: source.negative, neutr: source.neutral)
        
        
        
        
    }
    
    
    func setConstraints()
    {
        Debug.print("\(self.description)::setConstraints")
        var constraints = [
            
            
            NSLayoutConstraint(item: label,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: label,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 10),
            
            
            
            NSLayoutConstraint(item:content,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: label,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 25),
            NSLayoutConstraint(item:content,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 8),
            NSLayoutConstraint(item:content,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: -100),
            NSLayoutConstraint(item:content,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: -20),
            
            NSLayoutConstraint(item:legende.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: label,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 25),
            NSLayoutConstraint(item:legende.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 0.6,constant: 0),
            NSLayoutConstraint(item:legende.view,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: -10),
            NSLayoutConstraint(item:legende.view,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: -20),
            
        ]
        view.addConstraints(constraints)
        
    }
    
    
}