//
//  VectorGeographicView.h
//  UNHC
//
//  Created by Josh Klobe on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BaseViewController;

@interface VectorGeographicView : UIView {

	NSMutableDictionary *statesVerticiesDictionary;
	NSMutableDictionary *statesCenterpointDictionary;
	NSArray *statesArray;
	float xAnchor;
	float yAnchor;
	BOOL doStretch;
	BaseViewController *baseViewController;
	
	float minX;
	float minY;
	float maxX;
	float maxY;
	float xDiff;
	float yDiff;
	
}
@property (nonatomic, retain) NSArray *statesArray;
@property (nonatomic, retain) NSMutableDictionary *statesVerticiesDictionary;
@property (nonatomic, retain) NSMutableDictionary *statesCenterpointDictionary;
@property (nonatomic, assign) float xAnchor;
@property (nonatomic, assign) float yAnchor;
@property (nonatomic, assign) BOOL doStretch;
@property (nonatomic, retain) BaseViewController *baseViewController;

@property (nonatomic, assign)float minX;
@property (nonatomic, assign)float minY;
@property (nonatomic, assign)float maxX;
@property (nonatomic, assign)float maxY;
@property (nonatomic, assign)float xDiff;
@property (nonatomic, assign)float yDiff;

@end
