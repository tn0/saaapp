//
import UIKit

//class SentimentGraficViewController: BaseGraficViewController,NewDataDelegate {
class SentimentGraficViewController: BaseGraficViewController {
    
    var label:UILabel
    
    var content:UIView
    var graph:DonatView
    let legende:SentimentGrafikLegendeViewController=SentimentGrafikLegendeViewController()
    
    init(filter:Filter)
    {
        
        label=UILabel()
        label.translatesAutoresizingMaskIntoConstraints=false
        
        content=UIView()
        content.translatesAutoresizingMaskIntoConstraints=false
        graph=DonatView(pos: 0,neg: 0,neutr: 0)
        graph.translatesAutoresizingMaskIntoConstraints=false
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
        content.layer.borderColor=Colors.grafikBorderColor.CGColor
        content.layer.borderWidth=1
        content.layer.cornerRadius=5
        view.translatesAutoresizingMaskIntoConstraints=false
        view.addSubview(label)
        
        view.addSubview(content)
        addChildToSubView(legende, view: content)
        content.addSubview(graph)
        
        setConstraints()
    }
    
    func getData()
    {
            dataSource?.getData()
    }
    
    override func dataLoaded(sender: BasicNetwork)
    {
        let source:SentimentData=dataSource as! SentimentData
        
        Debug.print("SentimentGraficViewController::dataLoaded \(source)")
        graph.refresh(source.positive, neg: source.negative, neutr: source.neutral)
        
        
        
        
    }
    
    
    func setConstraints()
    {
        Debug.print("\(self.description)::setConstraints")
        var constraints:[NSLayoutConstraint] = [
            NSLayoutConstraint(item: label,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 0),
            NSLayoutConstraint(item: label,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 10),
            ]
        view.addConstraints(constraints)
        constraints = [
            NSLayoutConstraint(item:content,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: label,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 23),
            NSLayoutConstraint(item:content,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 2),
            NSLayoutConstraint(item:content,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: -3),
            NSLayoutConstraint(item:content,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: view,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: -18),
        ]
        view.addConstraints(constraints)
        constraints = [
            NSLayoutConstraint(item:legende.view,attribute: NSLayoutAttribute.Top,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Top,multiplier: 1,constant: 5),
            NSLayoutConstraint(item:legende.view,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Right,multiplier: 0.6,constant: 0),
            NSLayoutConstraint(item:legende.view,attribute: NSLayoutAttribute.Right,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Right,multiplier: 1,constant: -5),
            NSLayoutConstraint(item:legende.view,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: -20),
        ]
        view.addConstraints(constraints)
        constraints = [
            NSLayoutConstraint(item:graph,attribute: NSLayoutAttribute.CenterY,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.CenterY,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:graph,attribute: NSLayoutAttribute.Left,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Left,multiplier: 1,constant: 5),
            NSLayoutConstraint(item:graph,attribute: NSLayoutAttribute.Width,relatedBy: NSLayoutRelation.Equal,toItem: graph,attribute: NSLayoutAttribute.Height,multiplier: 1,constant: 0),
            NSLayoutConstraint(item:graph,attribute: NSLayoutAttribute.Bottom,relatedBy: NSLayoutRelation.Equal,toItem: content,attribute: NSLayoutAttribute.Bottom,multiplier: 1,constant: -5),
        ]
        view.addConstraints(constraints)
        
    }
    
    
}