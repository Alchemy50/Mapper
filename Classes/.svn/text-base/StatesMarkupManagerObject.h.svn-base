//
//  StatesMarkupManagerObject.h
//  UNHC
//
//  Created by Josh Klobe on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface StatesMarkupManagerObject : NSObject {

	NSMutableDictionary *regionsDictionary;
	NSMutableDictionary *statesObjectsDictionary;
	NSMutableDictionary *statesMasterDictionary;
	NSMutableDictionary *statesOffsetDictionary;
	NSArray *statesStringArray;
}

+ (StatesMarkupManagerObject *)statesMarkupManagerObject;
-(void)loadMasterStatesDictionary;
-(void)loadStatesValues;

@property (nonatomic, retain) NSMutableDictionary *regionsDictionary;
@property (nonatomic, retain) NSMutableDictionary *statesObjectsDictionary;
@property (nonatomic, retain) NSMutableDictionary *statesMasterDictionary;
@property (nonatomic, retain) NSMutableDictionary *statesOffsetDictionary;
@property (nonatomic, retain) NSArray *statesStringArray;
@end
