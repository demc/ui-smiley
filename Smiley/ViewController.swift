import UIKit

class ViewController: UIViewController
{

    override func viewDidLoad()
    {
        super.viewDidLoad();
        
        let frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: 400);
        let smiley = Smiley(frame: frame);
        smiley.backgroundColor = UIColor.blueColor();
        view.addSubview(smiley);
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning();
        
    }


}

