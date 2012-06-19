//
//  ViewController.m
//  FrameTransform
//
//  Created by xiss burg on 6/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController {
    float angle;
    float scale;
    CGPoint location;
}

@synthesize frontView;
@synthesize backView;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    angle = 0;
    scale = 1;
    
    UIRotationGestureRecognizer *rgr = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationAction:)];
    [self.view addGestureRecognizer:rgr];
    
    UIPinchGestureRecognizer *pinchgr = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchAction:)];
    [self.view addGestureRecognizer:pinchgr];
    
    UIPanGestureRecognizer *pangr = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.view addGestureRecognizer:pangr];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return interfaceOrientation == UIInterfaceOrientationPortrait;
}

#pragma mark - Gesture Recognition

- (void)rotationAction:(UIRotationGestureRecognizer *)rgr
{   
    CGAffineTransform r = CGAffineTransformMakeRotation(angle + rgr.rotation);
    CGAffineTransform s = CGAffineTransformMakeScale(scale, scale);
    self.frontView.transform = CGAffineTransformConcat(r, s);
    self.backView.frame = self.frontView.frame;
    
    if (rgr.state == UIGestureRecognizerStateEnded) {
        angle += rgr.rotation;
    }
}

- (void)pinchAction:(UIPinchGestureRecognizer *)pgr
{
    CGAffineTransform r = CGAffineTransformMakeRotation(angle);
    CGAffineTransform s = CGAffineTransformMakeScale(scale + pgr.scale - 1, scale + pgr.scale - 1);
    self.frontView.transform = CGAffineTransformConcat(r, s);
    self.backView.frame = self.frontView.frame;
    
    if (pgr.state == UIGestureRecognizerStateEnded) {
        scale += pgr.scale - 1;
    }
}

- (void)panAction:(UIPanGestureRecognizer *)pgr
{
    CGPoint t = [pgr translationInView:self.view];
    
    if (pgr.state == UIGestureRecognizerStateBegan) {
        location = self.frontView.center;;
    }
    
    self.frontView.center = CGPointMake(location.x + t.x, location.y + t.y);
    self.backView.frame = self.frontView.frame;
}

@end
