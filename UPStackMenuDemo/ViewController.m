//
//  ViewController.m
//  UPStackMenuDemo
//
//  Created by Paul Ulric on 28/01/2015.
//  Copyright (c) 2015 Paul Ulric. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    UIView *contentView;
    UPStackMenu *stack;
    
    UIView *hiddenContentView;
    UPStackMenu *horizontalStack;
    bool showBoth;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    [contentView setBackgroundColor:[UIColor colorWithRed:112./255. green:47./255. blue:168./255. alpha:1.]];
    [contentView.layer setCornerRadius:6.];
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cross"]];
    [icon setContentMode:UIViewContentModeScaleAspectFit];
    [icon setFrame:CGRectInset(contentView.frame, 10, 10)];
    [contentView addSubview:icon];
    
    hiddenContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];

    [self changeDemo:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)changeDemo:(id)sender
{
    if(stack) {
        [stack removeFromSuperview];
        [horizontalStack removeFromSuperview];
    }
    showBoth = NO;
    stack = [[UPStackMenu alloc] initWithContentView:contentView];
    [stack setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 + 20)];
    [stack setCenter:CGPointMake(self.view.frame.size.width - 50, self.view.frame.size.height - 50)];
    [stack setDelegate:self];
        
    horizontalStack = [[UPStackMenu alloc] initWithContentView:hiddenContentView];
    [horizontalStack setCenter:CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2 + 20)];
    [horizontalStack setCenter:CGPointMake(self.view.frame.size.width - 50, self.view.frame.size.height - 50)];

    
    UPStackMenuItem *squareItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"square"] highlightedImage:nil title:@"Square"];
    UPStackMenuItem *circleItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"circle"] highlightedImage:nil title:@"Circle"];
    UPStackMenuItem *triangleItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"triangle"] highlightedImage:nil title:@"Triangle"];
    UPStackMenuItem *crossItem = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"cross"] highlightedImage:nil title:@"Cross"];
    NSMutableArray *items = [[NSMutableArray alloc] initWithObjects:squareItem, circleItem, triangleItem, crossItem, nil];
    [items enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitleColor:[UIColor whiteColor]];
    }];

    
    UIImage *img = [UIImage imageNamed:@"square"];
    UIGraphicsBeginImageContextWithOptions(img.size, NO, 0.0);
    UIImage *blank = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    UPStackMenuItem *squareItem2 = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"square"] highlightedImage:nil title:@""];
    UPStackMenuItem *circleItem2 = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"circle"] highlightedImage:nil title:@""];
    UPStackMenuItem *triangleItem2 = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"triangle"] highlightedImage:nil title:@""];
    UPStackMenuItem *crossItem2 = [[UPStackMenuItem alloc] initWithImage:[UIImage imageNamed:@"cross"] highlightedImage:nil title:@""];
    UPStackMenuItem *blankItem = [[UPStackMenuItem alloc] initWithImage:blank highlightedImage:nil title:@""];

    
    NSMutableArray *horizontalItems = [NSMutableArray array];
    [horizontalItems addObject:squareItem2];
    int numPlaceholders = (self.view.frame.size.width - 100) / (img.size.width + 25.0);
    NSLog(@"Num Placeholders = %d",numPlaceholders);
    for (int i = 0; i < numPlaceholders/2; i++) {
        [horizontalItems addObject:blankItem];
    }
    [horizontalItems addObject:circleItem2];
    
    
    
//    NSMutableArray *horizontalItems = [[NSMutableArray alloc] initWithObjects:squareItem2, circleItem2, nil];
    [horizontalItems enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
        [item setTitleColor:[UIColor whiteColor]];
    }];

    NSUInteger index = sender ? [(UISegmentedControl*)sender selectedSegmentIndex] : 0;
    switch (index) {
        case 0:
            [stack setAnimationType:UPStackMenuAnimationType_progressive];
            [stack setStackPosition:UPStackMenuStackPosition_up];
            [stack setOpenAnimationDuration:.4];
            [stack setCloseAnimationDuration:.4];
            [items enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
                [item setLabelPosition:UPStackMenuItemLabelPosition_right];
                [item setLabelPosition:UPStackMenuItemLabelPosition_left];
            }];
            break;
            
        case 1:
            [stack setAnimationType:UPStackMenuAnimationType_linear];
            [stack setStackPosition:UPStackMenuStackPosition_down];
            [stack setOpenAnimationDuration:.3];
            [stack setCloseAnimationDuration:.3];
            [items enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
                [item setLabelPosition:UPStackMenuItemLabelPosition_right];
            }];
            break;
            
        case 2:
            [stack setAnimationType:UPStackMenuAnimationType_progressiveInverse];
            [stack setStackPosition:UPStackMenuStackPosition_up];
            [stack setOpenAnimationDuration:.4];
            [stack setCloseAnimationDuration:.4];
            [items enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
                if(idx%2 == 0)
                    [item setLabelPosition:UPStackMenuItemLabelPosition_left];
                else
                    [item setLabelPosition:UPStackMenuItemLabelPosition_right];
            }];
            break;

        case 3:
            [stack setAnimationType:UPStackMenuAnimationType_progressive];
            [stack setStackPosition:UPStackMenuStackPosition_up];
            [stack setItemsSpacing:25.0];
            [stack setOpenAnimationDuration:.4];
            [stack setCloseAnimationDuration:.4];
            [items enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
                [item setLabelPosition:UPStackMenuItemLabelPosition_left];
            }];

            
            [horizontalStack setAnimationType:UPStackMenuAnimationType_progressiveInverse];
            [horizontalStack setStackPosition:UPStackMenuStackPosition_left];
            [horizontalStack setOpenAnimationDuration:.4];
            [horizontalStack setCloseAnimationDuration:.4];
            [horizontalStack setItemsSpacing:25.0];
            [horizontalItems enumerateObjectsUsingBlock:^(UPStackMenuItem *item, NSUInteger idx, BOOL *stop) {
                    [item setLabelPosition:UPStackMenuItemLabelPosition_none];
            }];
            
            [horizontalStack addItems:horizontalItems];
            [self.view insertSubview:horizontalStack belowSubview:stack];
            showBoth = YES;
            break;

            
        default:
            break;
    }
    
    [stack addItems:items];
//    [horizontalStack setUserInteractionEnabled:NO];
    [self.view addSubview:stack];
    
    [self setStackIconClosed:YES];
}


- (void)setStackIconClosed:(BOOL)closed
{
    UIImageView *icon = [[contentView subviews] objectAtIndex:0];
    float angle = closed ? 0 : (M_PI * (135) / 180.0);
    [UIView animateWithDuration:0.3 animations:^{
        [icon.layer setAffineTransform:CGAffineTransformRotate(CGAffineTransformIdentity, angle)];
    }];
}


#pragma mark - UPStackMenuDelegate

- (void)stackMenuWillOpen:(UPStackMenu *)menu
{    
    if([[contentView subviews] count] == 0)
        return;
    if (showBoth) {
        [horizontalStack openStack];
    }
    [self setStackIconClosed:NO];
}

- (void)stackMenuDidOpen:(UPStackMenu *)menu {
    
//    [horizontalStack openStack];
}

- (void)stackMenuWillClose:(UPStackMenu *)menu
{
    if([[contentView subviews] count] == 0)
        return;
    if (showBoth) {
        [horizontalStack closeStack];
    }
    [self setStackIconClosed:YES];
}

- (void)stackMenuDidClose:(UPStackMenu *)menu {
    
//    [horizontalStack closeStack];
}


- (void)stackMenu:(UPStackMenu *)menu didTouchItem:(UPStackMenuItem *)item atIndex:(NSUInteger)index
{
    NSString *message = [NSString stringWithFormat:@"Item touched : %@", item.title];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:message
                                                    message:nil
                                                   delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
