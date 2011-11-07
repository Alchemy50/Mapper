//
//  RegionViewController.h
//  Mapper
//
//  Created by Josh Klobe on 11/7/11.
//  Copyright 2011 Alchemy50. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VectorGeographicView.h"

@interface RegionViewController : UIViewController {
	VectorGeographicView *vectorGeographicView;
}


-(void)loadMap;


@property (nonatomic, retain) VectorGeographicView *vectorGeographicView;


@end
