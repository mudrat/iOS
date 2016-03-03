//
//  WNXReadyGoView.m
//  Hardest
//
//  Created by sfbest on 16/3/3.
//  Copyright © 2016年 维尼的小熊. All rights reserved.
//

#import "WNXReadyGoView.h"

@interface WNXReadyGoView ()

@property (nonatomic, strong) UIImageView *readyView;
@property (nonatomic, strong) UIImage *readyImage;
@property (nonatomic, strong) UIImage *goImage;

@end

@implementation WNXReadyGoView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.readyView = [[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth - 250) * 0.5, 0, 250, 85)];
        self.readyImage = [UIImage imageNamed:@"ready"];
        self.goImage = [UIImage imageNamed:@"go"];
        self.readyView.image = self.readyImage;
        [self addSubview:self.readyView];
    }
    
    return self;
}

+ (void)showReadyGoViewWithSuperView:(UIView *)superView completion:(void (^)(void))completion {
    CGFloat startY = 200;
    if (!iPhone5) {
        startY = 150;
    }
    WNXReadyGoView *readyGoView = [[WNXReadyGoView alloc] initWithFrame:CGRectMake(ScreenWidth, startY, ScreenWidth, 85)];
    [superView addSubview:readyGoView];
    [superView bringSubviewToFront:readyGoView];
    
    [[WNXSoundToolManager sharedSoundToolManager] playSoundWithSoundName:kSoundReadyGoName];
    
    [UIView animateWithDuration:0.6 animations:^{
        readyGoView.frame = CGRectMake(0, startY, ScreenWidth, 85);
        
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            readyGoView.readyView.image = readyGoView.goImage;
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [UIView animateWithDuration:0.3 animations:^{
                    readyGoView.frame = CGRectMake(-ScreenWidth, startY, ScreenWidth, 85);
                } completion:^(BOOL finished) {
                    
                    if (completion) {
                        completion();
                    }
                    [readyGoView removeFromSuperview];
                }];
            });
        });
    
    }];
    
}

@end
