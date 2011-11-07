//
//  CountryViewController.h
//  UNHC
//
//  Created by Josh Klobe on 4/26/11.
//  Copyright 2011 Alchemy50. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "VectorGeographicView.h"

@class UNHCViewController;

@interface CountryViewController : UIViewController  {
		
	VectorGeographicView *vectorGeographicView;
}


-(void)loadMap;


@property (nonatomic, retain) VectorGeographicView *vectorGeographicView;


@end
