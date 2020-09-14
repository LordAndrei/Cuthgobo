//
//  DrawView.swift
//  Cuthgobo
//
//  Created by Andrei Freeman on 8/23/20.
//

import UIKit

class DrawView: UIView {
    
    weak var wothcocu: Wothcocu?

    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        guard wothcocu != nil else {
            return
        }
        let world = wothcocu!

        // draw border
        UIColor.black.set()
        let bc = UIBezierPath(rect: rect)
        bc.stroke()
        
        // draw cells
        let cellCount = world.maxSize
        let width = rect.width / CGFloat(cellCount)
        let height = rect.height / CGFloat(cellCount)
        for count in 1...cellCount {
            let bcLine = UIBezierPath()
            bcLine.move(to: CGPoint(x: CGFloat(count) * width, y: 0))
            bcLine.addLine(to: CGPoint(x: CGFloat(count) * width, y: rect.height))
            
            bcLine.move(to: CGPoint(x: 0, y: CGFloat(count) * height))
            bcLine.addLine(to: CGPoint(x: rect.width, y: CGFloat(count) * height))
            bcLine.stroke()
        }

        for row in 0..<world.maxSize {
            for section in 0..<world.maxSize {

                // draw cell at row, section
                // get box for cell
                let cell = NSIndexPath(row: row, section: section)
                let rect = getBoundsForCell(rect: rect,
                                            cell: cell)
                // get contents of cell
                let cellContents = world.population[cell]
                if cellContents?.count == 0 {
                    UIColor.green.set()
                } else if cellContents!.contains(.wacusi) {
                    UIColor.blue.set()
                } else if cellContents!.contains(.focumu) {
                    UIColor.red.set()
                }
                
                if cellContents!.contains(.focumu) &&
                        cellContents!.contains(.wacusi) {
                            UIColor.systemPurple.set()
                }

                let bcCell = UIBezierPath(rect: rect)
                bcCell.fill()
                
                // if there is a cuthgobo... draw it.
                if cellContents!.contains(.cuthgobo) {
                    UIColor.white.set()
                    let insetRect = rect.insetBy(dx: 15, dy: 15)
                    let insetRectBC = UIBezierPath(roundedRect: insetRect, cornerRadius: 5)
                    insetRectBC.fill()
                    UIColor.black.set()
                    insetRectBC.stroke()
                }
            }
        }

    }
    
    func getBoundsForCell(rect: CGRect, cell: NSIndexPath) -> CGRect {
        let cellCount = wothcocu!.maxSize
        let width = rect.width / CGFloat(cellCount)
        let height = rect.height / CGFloat(cellCount)

        let origin = CGPoint(x: width * CGFloat(cell.row),
                             y: height * CGFloat(cell.section))
        let size = CGSize(width: width, height: height)
        let returnRect = CGRect(origin: origin, size: size)
        
        return returnRect // NYI
    }

}
