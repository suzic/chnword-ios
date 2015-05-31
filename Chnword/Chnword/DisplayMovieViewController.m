//
//  DisplayMovieViewController.m
//  Chnword
//
//  Created by khtc on 15/5/9.
//  Copyright (c) 2015年 chnword. All rights reserved.
//

#import "DisplayMovieViewController.h"
#import "CoverFlowView.h"
#import "SDWebImageManager.h"
#import "SDImageCache.h"
#import "UIButton+WebCache.h"
#import <MediaPlayer/MediaPlayer.h>
#import <ImageIO/ImageIO.h>

@interface DisplayMovieViewController ()

@property (nonatomic, retain) CoverFlowView *gifCoverFlowView;
@property (nonatomic, retain) MPMoviePlayerController *movieController;

@property (nonatomic, retain) NSArray *gifImages;


@end

@implementation DisplayMovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initViews];
    [self initGifImagesWith:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) initGifImagesWith:(NSURL *) url {
    
//    UIImage *image = [[SDWebImageManager sharedManager] downloadImageWithURL:url options:nil progress:^(NSInteger receivedSize, NSInteger expectedSize) {
//        
//    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
//        
//    }];
    
    NSString *name = @"sample.gif";
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.backgroundColor = [UIColor clearColor];
//    imageView.image = [UIImage sd_animatedGifWithData:imageData];
//    imageView.image = [UIImage sd_animatedGifNamed:name];
    
    //SCGIFimage
    CGImageSourceRef source = CGImageSourceCreateWithData((CFDataRef) imageData, NULL);
    size_t count = CGImageSourceGetCount(source);
    
    NSMutableArray *tempArray = [NSMutableArray array];
    
    for (size_t i = 0; i < count; i ++) {
        CGImageRef imageRef = CGImageSourceCreateImageAtIndex(source, i, NULL);
        [tempArray addObject:[UIImage imageWithCGImage:imageRef]];
        CGImageRelease(imageRef);
    }
    CFRelease(source);
    
    self.gifCoverFlowView.images = tempArray;
    
    
}


- (void) initViews {
    self.gifCoverFlowView = [[CoverFlowView alloc] initWithFrame:self.gifView.bounds];
    NSArray *images = [[NSArray alloc] init];
    self.gifCoverFlowView.images = images;
    [self.gifView addSubview:self.gifCoverFlowView];
    
    
    NSURL *videoUrl = [NSURL URLWithString:@""];
//    self.movieController = [[MPMoviePlayerController alloc] initWithContentURL:videoUrl];
    self.movieController = [[MPMoviePlayerController alloc] init];
    
    self.movieController.contentURL = videoUrl;
    [self.videoView addSubview:self.movieController.view];
    
}

- (void) showVideo {
    self.videoView.hidden = NO;
    self.gifView.hidden = YES;
}

- (void) showGif {
    self.videoView.hidden = YES;
    self.gifView.hidden = NO;
}
@end
