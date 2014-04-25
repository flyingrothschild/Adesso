//
//  CVTViewController.m
//  OpenCVTest
//
//  Created by Fei Pan on 22/04/14.
//  Copyright (c) 2014 LS1 TUM. All rights reserved.
//

#import "CVTViewController.h"

@interface CVTViewController ()

@end

@implementation CVTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed: @"Default.png"]];
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Hello" message:@"Welcom to OpenCV" delegate:self cancelButtonTitle:@"Continue" otherButtonTitles:nil, nil];
    [alert show];
    
    self.videoCamera = [[CvVideoCamera alloc] initWithParentView:self.imageView];
    self.videoCamera.defaultAVCaptureDevicePosition = AVCaptureDevicePositionFront;
    self.videoCamera.defaultAVCaptureSessionPreset = AVCaptureSessionPreset640x480;
    self.videoCamera.defaultAVCaptureVideoOrientation = AVCaptureVideoOrientationPortrait;
    self.videoCamera.defaultFPS = 30;
    self.videoCamera.grayscaleMode = NO;
    self.videoCamera.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)startButton:(id)sender {
    [self.videoCamera start];
}

#pragma mark - Protocol CvVideoCameraDelegate
#ifdef __cplusplus

-(void) processImage:(Mat&) image;
{
    Mat frame_gray;
    cvtColor(image, frame_gray , COLOR_BGR2GRAY);
    equalizeHist(frame_gray, frame_gray);
    std::vector<cv::Rect> faces;
    
    //bitwise_not(image_copy, image_copy);
    //cvtColor(image_copy, image, CV_BGR2BGRA);
    
    
    CascadeClassifier face_cascade = CascadeClassifier("haarcascade_frontalface_default.xml");
    CascadeClassifier eyes_cascade = CascadeClassifier("haarcascade_eye.xml");
    
    face_cascade.detectMultiScale(frame_gray, faces, 1.1, 2, 0|CASCADE_SCALE_IMAGE, cv::Size(30, 30));
    
    for (size_t i = 0; i < faces.size(); i++){
        cv::Point center (faces[i].x + faces[i].width/2, faces[i].y+faces[i].height/2);
        ellipse(image, center, cv::Size(faces[i].width/2, faces[i].height/2), 0, 0, 360, cv::Scalar(255, 0, 255), 4, 8, 0);
        
        Mat faceROI = frame_gray(faces[i]);
        std::vector<cv::Rect> eyes;
        
        eyes_cascade.detectMultiScale(faceROI, eyes, 1.1, 2, 0 | CASCADE_SCALE_IMAGE, cv::Size(30, 30));
        
        for (size_t j = 0 ; j < eyes.size(); j++){
            cv::Point eye_center (faces[i].x + eyes[j].x + eyes[j].width/2, faces[i].y + eyes[j].y + eyes[j].height/2);
            int radius = cvRound((eyes[j].width + eyes[j].height)*0.25);
            circle(image, eye_center, radius, Scalar(255, 0, 0), 4, 8, 0);
        }
    }
    
}

#endif


@end
