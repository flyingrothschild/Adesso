//
//  CVTViewController.h
//  OpenCVTest
//
//  Created by Fei Pan on 22/04/14.
//  Copyright (c) 2014 LS1 TUM. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <opencv2/highgui/cap_ios.h>

using namespace std;
using namespace cv;

@interface CVTViewController : UIViewController <CvVideoCameraDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) CvVideoCamera* videoCamera;

- (IBAction)startButton:(id)sender;

@end
