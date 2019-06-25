//
//  DraggingView.m
//  MyDraggingView
//
//  Created by HIROKI IKEUCHI on 2019/06/25.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import "DraggingView.h"

@interface DraggingView()
@property NSPoint downPoint;
@property NSPoint currentPoint;
@end

@implementation DraggingView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    // Drawing code here.
}

#pragma mark Events
- (void)mouseDown:(NSEvent *)event
{
    NSPoint p = [event locationInWindow];
    _downPoint = [self convertPoint:p fromView:nil];
    _currentPoint = _downPoint;
    [self setNeedsDisplay:YES];
}
- (void)mouseDragged:(NSEvent *)event
{
    NSPoint previousPoint = _currentPoint;
    NSPoint p = [event locationInWindow];
    _currentPoint = [self convertPoint:p fromView:nil];
    
    // ウィンドウの位置を移動させる
    double offset_x = _currentPoint.x - previousPoint.x;
    double offset_y = _currentPoint.y - previousPoint.y;
    NSRect windowFrame = self.window.frame;
    windowFrame.origin.x += offset_x;
    windowFrame.origin.y += offset_y;
    [self.window setFrame:windowFrame display:YES];
    
    NSLog(@"%f, %f", offset_x, offset_y );
    
//    NSLog(@"%@", _currentPoint);
    [self autoscroll:event];
    [self setNeedsDisplay:YES];
}
- (void)mouseUp:(NSEvent *)event
{
    NSPoint p = [event locationInWindow];
    _currentPoint = [self convertPoint:p fromView:nil];
    [self setNeedsDisplay:YES];
}

@end
