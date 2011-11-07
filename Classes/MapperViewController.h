//
//  MapperViewController.h
//  Mapper
//
//  Created by Josh Klobe on 11/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryViewController.h"
#import "StateViewController.h"
#import "RegionViewController.h"



@interface MapperViewController : UIViewController {

	CountryViewController *countryViewController;
	StateViewController *stateViewController;
	RegionViewController *regionViewController;
}
@property (nonatomic, retain) CountryViewController *countryViewController;
@property (nonatomic, retain) StateViewController *stateViewController;
@property (nonatomic, retain) RegionViewController *regionViewController;
@end

