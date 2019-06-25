//
//  DraggingView.m
//  MyDraggingView
//
//  Created by HIROKI IKEUCHI on 2019/06/25.
//  Copyright © 2019年 hikeuchi. All rights reserved.
//

#import "DraggingView.h"

@interface DraggingView()
@property NSPoint currentPoint;
@end

@implementation DraggingView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    // Drawing code here.
    // 分かりやすいようにビューに色を付ける
    NSRect bounds = [self bounds];
    [[[NSColor blueColor] colorWithAlphaComponent:0.1] set];
    [NSBezierPath fillRect:bounds];
}

#pragma mark Events
- (void)mouseDown:(NSEvent *)event {
    NSPoint p = [event locationInWindow];
    _currentPoint = [self convertPoint:p fromView:nil]; // viewの座標系に変換
    [self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)event {
    NSPoint previousPoint = _currentPoint;
    NSPoint p = [event locationInWindow];
    _currentPoint = [self convertPoint:p fromView:nil]; // viewの座標系に変換
    
    // 移動したマウスの距離だけウィンドウの位置を移動させる
    double  distance_x   = _currentPoint.x - previousPoint.x;
    double  distance_y   = _currentPoint.y - previousPoint.y;
    NSRect  windowFrame  = self.window.frame;
    NSPoint windowOrigin = windowFrame.origin; // 現在のウィンドウ位置
    windowOrigin.x  += distance_x;
    windowOrigin.y  += distance_y;
    _currentPoint.x -= distance_x;             // ウィンドウの位置が変わったので、次のマウス移動の計算のために補正を行う
    _currentPoint.y -= distance_y;
    [self.window setFrameOrigin:windowOrigin]; // ウィンドウの位置を移動
    [self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)event {
    NSPoint p = [event locationInWindow];
    _currentPoint = [self convertPoint:p fromView:nil]; // viewの座標系に変換
    [self setNeedsDisplay:YES];
}

@end
