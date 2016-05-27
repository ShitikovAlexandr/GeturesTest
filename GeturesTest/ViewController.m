//
//  ViewController.m
//  GeturesTest
//
//  Created by MacUser on 31.03.16.
//  Copyright © 2016 Shitikov.net. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIGestureRecognizerDelegate>

@property (weak, nonatomic) UIView* testView;

@property (assign, nonatomic) CGFloat testViewScale;
@property (assign, nonatomic) CGFloat testViewRotation;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView* view = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMidX(self.view.bounds)-50,
                                                           CGRectGetMidY(self.view.bounds)-50, 100, 100)];
    
    view.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin |
                            UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
    view.backgroundColor = [UIColor greenColor];
    [self.view addSubview:view];
    
    self.testView = view;
    

    UITapGestureRecognizer* tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:
                                          self action:@selector(handleTap:)];
    
    [self.view addGestureRecognizer:tapGesture];
    
    
    UITapGestureRecognizer* doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:
                                                self action:@selector(handleDoubleTap:)];
    
    doubleTapGesture.numberOfTapsRequired = 2;
    
    [self.view addGestureRecognizer:doubleTapGesture];

    [tapGesture requireGestureRecognizerToFail:doubleTapGesture];
    
    UITapGestureRecognizer* doubleTapDoubleTouchGesture = [[UITapGestureRecognizer alloc] initWithTarget:
                                                self action:@selector(handleDoubleTapDoubleTouch:)];
    
    doubleTapDoubleTouchGesture.numberOfTapsRequired = 2;
    doubleTapDoubleTouchGesture.numberOfTouchesRequired = 2;
    
    [self.view addGestureRecognizer:doubleTapDoubleTouchGesture];
    
    
    UIPinchGestureRecognizer* pinchGesture = [[UIPinchGestureRecognizer alloc] initWithTarget:self
action:@selector(handlePinch:)];
    
    pinchGesture.delegate = self;
    [self.view addGestureRecognizer:pinchGesture];
    
    
    
    UIRotationGestureRecognizer *rotationGesture = [[UIRotationGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(handleRotation:)];
    rotationGesture.delegate = self;
    [self.view addGestureRecognizer:rotationGesture];
    
    
    UISwipeGestureRecognizer* verticalSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                 action:@selector(handleVerticalSwipe:)];
    verticalSwipeGesture.direction = UISwipeGestureRecognizerDirectionUp | UISwipeGestureRecognizerDirectionDown;
    
    [self.view addGestureRecognizer:verticalSwipeGesture];
    
    
    
    UISwipeGestureRecognizer* horizontalSwipeGesture = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                               action:@selector(handleHorizontaleSwipe:)];
    
    horizontalSwipeGesture.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
    
    [self.view addGestureRecognizer:horizontalSwipeGesture];

    
    }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Methods



- (UIColor*) randomColor {
    CGFloat r = (float)(arc4random() % 256) / 255.f;
    CGFloat g = (float)(arc4random() % 256) / 255.f;
    CGFloat b = (float)(arc4random() % 256) / 255.f;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.f];

}

#pragma mark - UIGestureRecognizerDelegate

- (void) handleVerticalSwipe: (UISwipeGestureRecognizer*) verticalSwipeGesture {
    
    NSLog(@"handleVerticalSwipe");
    
}

- (void) handleHorizontaleSwipe: (UISwipeGestureRecognizer*) horizontalSwipeGesture {
    
     NSLog(@"handleHorizontaleSwipe");
    
}

- (void) handlePan: (UIPanGestureRecognizer*) panGesture {
   NSLog(@"Pan ");
    self.testView.center = [panGesture locationInView:self.view];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    return YES;
}



#pragma mark - Gestures

- (void) handleRotation: (UIRotationGestureRecognizer*) rotationGesture {
    
    NSLog(@"handle rotation %f", rotationGesture.rotation);
    if (rotationGesture.state == UIGestureRecognizerStateBegan) {
        self.testViewRotation = 0.f;
    }

    
    CGFloat newRotation = rotationGesture.rotation - self.testViewRotation;
    
    CGAffineTransform currentTransform = self.testView.transform;
    CGAffineTransform newTransform = CGAffineTransformRotate(currentTransform, newRotation);
    
    self.testView.transform = newTransform;
    self.testViewRotation = rotationGesture.rotation;
    
}

- (void) handlePinch:(UIPinchGestureRecognizer*) pinchGesture {
    
    NSLog(@"pinch %f", pinchGesture.scale);
    
    if (pinchGesture.state == UIGestureRecognizerStateBegan) {
        self.testViewScale = 1.f;
    }
    CGFloat newScale = 1.f + pinchGesture.scale - self.testViewScale;
    
    CGAffineTransform currentTransform = self.testView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, newScale, newScale);
    
    self.testView.transform = newTransform;
    self.testViewScale = pinchGesture.scale;

}

- (void) handleTap: (UITapGestureRecognizer*) tapGesture {
    
    NSLog(@"Tap: %@", NSStringFromCGPoint([tapGesture locationInView:self.view]));
    
    self.testView.backgroundColor = [self randomColor];
    
}

- (void) handleDoubleTap: (UITapGestureRecognizer*) doubleTapGesture {
    
    NSLog(@"Double Tap: %@", NSStringFromCGPoint([doubleTapGesture locationInView:self.view]));
    
    CGAffineTransform currentTransform = self.testView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, 1.2f, 1.2f);
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.testView.transform = newTransform;
                     }];
    
    self.testViewScale = 1.2f;

}

- (void) handleDoubleTapDoubleTouch: (UITapGestureRecognizer*) doubleTapDoubleTouchGesture {
    NSLog(@"Double Tap and double touch: %@", NSStringFromCGPoint([doubleTapDoubleTouchGesture locationInView:self.view]));
    
    CGAffineTransform currentTransform = self.testView.transform;
    CGAffineTransform newTransform = CGAffineTransformScale(currentTransform, 0.8f, 0.8f);
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         self.testView.transform = newTransform;

                     }];
    self.testViewScale = 0.8f;

}


@end
