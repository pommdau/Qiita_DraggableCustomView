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
@property BOOL isUsing;
@end

@implementation DraggingView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
    
}

#pragma mark Events
- (void)mouseDown:(NSEvent *)event
{
    _downPoint = [event locationInWindow];
    _currentPoint = _downPoint;
    [self setNeedsDisplay:YES];
}
- (void)mouseDragged:(NSEvent *)event
{
    NSPoint previousPoint = _currentPoint;
    _currentPoint = [event locationInWindow];
    
    NSLog(@"\n%.2f, %.2f\n%.2f, %.2f", _currentPoint.x, _currentPoint.y , previousPoint.x, previousPoint.y);
    
    // ウィンドウの位置を移動させる
    double offset_x = _currentPoint.x - previousPoint.x;
    double offset_y = _currentPoint.y - previousPoint.y;
    NSRect windowFrame = self.window.frame;
    NSPoint windowOrigin = windowFrame.origin;
    
    windowOrigin.x += offset_x;
    windowOrigin.y += offset_y;
    _currentPoint.x -= offset_x;    // ウィンドウの位置が変わったので、相対的に現在のマウスの位置を変更してやる
    _currentPoint.y -= offset_y;
    [self.window setFrameOrigin:windowOrigin];
    
    [self autoscroll:event];
    [self setNeedsDisplay:YES];
}
- (void)mouseUp:(NSEvent *)event
{
    _currentPoint = [event locationInWindow];
    [self setNeedsDisplay:YES];
}

@end
