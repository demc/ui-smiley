import UIKit;

class Smiley: UIView
{
    var isTouchDown: Bool = false;
    var lastPoint: CGPoint?;
    
    override func drawRect(rect: CGRect)
    {
        let midX: CGFloat = rect.width / 2
        let midY: CGFloat = rect.height / 2;
        
        UIColor.whiteColor().setStroke();
        UIColor.whiteColor().setFill();
        
        let leftEyePath = UIBezierPath();
        leftEyePath.addArcWithCenter(
            CGPoint(x: midX - 100, y: midY - 100),
            radius: 20.0,
            startAngle: 0,
            endAngle: CGFloat(M_PI * 2),
            clockwise: true
        );
        leftEyePath.fill();
        
        let rightEyePath = UIBezierPath();
        rightEyePath.addArcWithCenter(
            CGPoint(x: midX + 100, y: midY - 100),
            radius: 20.0,
            startAngle: 0,
            endAngle: CGFloat(M_PI * 2),
            clockwise: true
        );
        rightEyePath.fill();
        
        let leftPupilPath = UIBezierPath();
        let rightPupilPath = UIBezierPath();
        
        var leftPupilOrigin: CGPoint = CGPoint(x: midX - 100, y: midY - 100);
        var rightPupilOrigin: CGPoint = CGPoint(x: midX + 100, y: midY - 100);
        
        if self.isTouchDown && self.lastPoint != nil
        {
            let uhOhMouth = UIBezierPath(ovalInRect: CGRect(x: midX - 25, y: midY + 50, width: 50, height: 50));
            UIColor.redColor().setFill();
            uhOhMouth.stroke();
            uhOhMouth.fill();
            
            let dleft = findSubpoint(leftPupilOrigin, destination: lastPoint!, magnitude: 15.0);
            let dright = findSubpoint(rightPupilOrigin, destination: lastPoint!, magnitude: 15.0);
            
            leftPupilOrigin.x = leftPupilOrigin.x + dleft.x;
            leftPupilOrigin.y = leftPupilOrigin.y + dleft.y;
            
            rightPupilOrigin.x = rightPupilOrigin.x + dright.x;
            rightPupilOrigin.y = rightPupilOrigin.y + dright.y;
        }
        else
        {
            let mouthPath = UIBezierPath(
                arcCenter: CGPoint(x: midX, y: midY),
                radius: 130.0,
                startAngle: CGFloat(0),
                endAngle: CGFloat(M_PI),
                clockwise: true
            );
            mouthPath.lineWidth = 3.0;
            mouthPath.stroke();
        }
        
        leftPupilPath.addArcWithCenter(
            leftPupilOrigin,
            radius: 5.0,
            startAngle: 0,
            endAngle: CGFloat(M_PI * 2),
            clockwise: true
        );
        
        rightPupilPath.addArcWithCenter(
            rightPupilOrigin,
            radius: 5.0,
            startAngle: 0,
            endAngle: CGFloat(M_PI * 2),
            clockwise: true
        );
        
        UIColor.blackColor().setFill();
        leftPupilPath.fill();
        rightPupilPath.fill();

    }

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.isTouchDown = true;
        
        if let touch = touches.first
        {
            lastPoint = touch.locationInView(self);
            self.setNeedsDisplay();
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if let touch = touches.first
        {
            lastPoint = touch.locationInView(self);
            self.setNeedsDisplay();
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.isTouchDown = false;
        self.setNeedsDisplay();
        self.lastPoint = nil;
    }
    
    func findSubpoint(origin: CGPoint, destination: CGPoint, magnitude: CGFloat) -> CGPoint
    {
        let deltaX = destination.x - origin.x;
        let deltaY = destination.y - origin.y;
        
        let signX: CGFloat = deltaX >= 0 ? 1.0 : -1.0;
        let signY: CGFloat = deltaY >= 0 ? 1.0 : -1.0;

        let angle = atan(CGFloat.abs(deltaY / deltaX));
        
        let x = cos(angle) * magnitude * signX;
        let y = sin(angle) * magnitude * signY;
        
        return CGPoint(x: x, y: y);
    }
}
