//
//  StatesMarkupManagerObject.m
//  UNHC
//
//  Created by Josh Klobe on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StatesMarkupManagerObject.h"
#import "CountryViewController.h"
#import "RegionViewController.h"
#import "StateViewController.h"


@interface StatesMarkupManagerObject (PrivateMethods)

-(void)loadOffsetValues;

@end


@implementation StatesMarkupManagerObject

static StatesMarkupManagerObject *sharedManager;

@synthesize statesStringArray, regionsDictionary, statesObjectsDictionary, statesMasterDictionary, statesOffsetDictionary;


-(id)init
{
	self = [super init];
	
	regionsDictionary = [[NSMutableDictionary alloc] initWithCapacity:5];
	
	NSArray *ar = [[NSArray alloc] initWithObjects:@"Hawaii", @"Oregon", @"Idaho", @"Montana", @"Washington", @"Nevada", @"Colorado", @"Wyoming", @"Utah", @"California", @"Arizona", @"NewMexico", nil ];
	[regionsDictionary setObject:ar forKey:@"North West"];
	[ar release];
	
	ar = [[NSArray alloc] initWithObjects:@"NorthDakota", @"SouthDakota", @"Nebraska", @"Oklahoma", @"Kansas", @"Minnesota", @"Texas", @"Iowa", @"Missouri", @"Michigan", @"Wisconsin", @"Illinois", @"Indiana", @"Ohio", @"Kentucky", nil];
	[regionsDictionary setObject:ar forKey:@"Central"];
	[ar release];
	
	ar = [[NSArray alloc] initWithObjects:@"WestVirginia",@"Virginia",@"Maryland", @"DC", @"Pennsylvania",@"Delaware",@"NewJersey",@"NewYork",@"Connecticut",@"RhodeIsland",@"Massachusetts",@"Vermont",@"NewHampshire",@"Maine",nil];
	[regionsDictionary setObject:ar forKey:@"North East"];
	[ar release];
	
	ar = [[NSArray alloc] initWithObjects:@"Arkansas",@"Louisiana",@"Florida",@"Mississippi",@"Alabama",@"Georgia",@"Tennessee",@"SouthCarolina",@"NorthCarolina",nil];
	[regionsDictionary setObject:ar forKey:@"South East"];
	[ar release];
		
	return self;
}

-(void)loadStatesValues
{
	[statesObjectsDictionary removeAllObjects];
	/*
	NSArray *ar = [UNHCReportManager getGeographicViewForGeography:sharedManager.statesStringArray];

	
	float minValue = 0.0;
	float maxValue = 0.0; 
	for (int i = 0; i < [ar count]; i++)
	{
		UNHDataObject *obj = [ar objectAtIndex:i];
		if ([obj.objectValue floatValue] < minValue)
			minValue = [obj.objectValue floatValue];
		if ([obj.objectValue floatValue] > maxValue)
			maxValue = [obj.objectValue floatValue];
		
		
	}

	for (int i = 0; i < [ar count]; i++)
	{
		UNHDataObject *obj = [ar objectAtIndex:i];
		float objectValue = [obj.objectValue floatValue];
		
		float pctValue = 0.0;
		if (objectValue < 0)
			pctValue = -(objectValue / minValue);
		else if (objectValue > 0)
			pctValue = objectValue / maxValue;
		
		[statesObjectsDictionary setObject:[NSNumber numberWithFloat:pctValue] forKey:obj.geography];		
		
	}

	 */
}

+ (StatesMarkupManagerObject *)statesMarkupManagerObject
{
	if (sharedManager == nil)
	{
		NSLog(@"do init");
		sharedManager = [[StatesMarkupManagerObject alloc] init];
		[sharedManager loadOffsetValues];
		sharedManager.statesMasterDictionary = [[NSMutableDictionary alloc] init];
		sharedManager.statesObjectsDictionary = [[NSMutableDictionary alloc] init];												 		
		sharedManager.statesStringArray  = [[NSArray arrayWithObjects:@"Montana", @"Idaho", @"Washington", @"NorthDakota", @"DC", @"Minnesota", @"Wisconsin", @"Colorado", @"California", @"Nevada", @"Arizona", @"NewMexico", @"Texas", @"Utah", @"Wyoming", @"SouthDakota", @"Nebraska", @"Kansas", @"Oklahoma",  @"Oregon", @"Louisiana", @"Arkansas", @"Missouri", @"Iowa", @"Illinois", @"Indiana", @"Kentucky", @"Tennessee", @"NorthCarolina", @"Georgia", @"SouthCarolina", @"Alabama", @"Florida", @"Virginia", @"WestVirginia", @"Ohio", @"Mississippi", @"Michigan", @"Maryland", @"Delaware", @"NewJersey", @"NewYork", @"Connecticut", @"RhodeIsland", @"Massachusetts", @"Vermont", @"NewHampshire", @"Maine", @"Michigan", @"Hawaii", @"Pennsylvania",     nil] retain];
		[sharedManager loadStatesValues];
	}
	
	
	
	
	return sharedManager;
	
}

-(void)loadMasterStatesDictionary
{	
		
	for (int i = 0; i < [statesStringArray count]; i++)
	{
		
		NSString *filePath = [[NSBundle mainBundle] pathForResource:[statesStringArray objectAtIndex:i] ofType:@"txt"];  
		NSData *myData = [NSData dataWithContentsOfFile:filePath];  	
		if (myData) {  
			
			NSString *content = [[[NSString alloc] initWithData:myData
													   encoding:NSUTF8StringEncoding] autorelease];
			
			NSMutableArray *separatedPointsArray = [NSMutableArray arrayWithCapacity:0];
			
			NSString *pointsString = @"points=\"";
			NSArray *pointsContentArray = [content componentsSeparatedByString:pointsString];
			for (int i = 1; i < [pointsContentArray count]; i++)
			{
				NSString *subContent = [pointsContentArray objectAtIndex:i];							
				subContent = [subContent substringToIndex:[subContent rangeOfString:@"\"/>"].location];
				subContent = [subContent stringByReplacingOccurrencesOfString:@"\n" withString:@""];
				subContent = [subContent stringByReplacingOccurrencesOfString:@"\t" withString:@""];		
				subContent = [subContent stringByReplacingOccurrencesOfString:@"\r" withString:@""];										
				[separatedPointsArray addObject:[subContent componentsSeparatedByString:@" "]];		
			}
			[self.statesMasterDictionary setObject:separatedPointsArray forKey:[statesStringArray objectAtIndex:i]];
			
		}		
		
	}	
}

-(void)loadOffsetValues
{
	
	self.statesOffsetDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
	
	
	NSMutableDictionary *alabamaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[alabamaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[alabamaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[alabamaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:alabamaDictionary forKey:@"Alabama"];

	//---------
	NSMutableDictionary *arizonaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[arizonaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[arizonaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[arizonaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:arizonaDictionary forKey:@"Arizona"];
	//--------
	
	
	NSMutableDictionary *arkansasDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[arkansasDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-5, 0)] forKey:[CountryViewController class]];
	[arkansasDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-8, 0)] forKey:[RegionViewController class]];
	[arkansasDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-15, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:arkansasDictionary forKey:@"Arkansas"];
	
	//---------
	NSMutableDictionary *californiaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[californiaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-13, 0)] forKey:[CountryViewController class]];
	[californiaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-15, 0)] forKey:[RegionViewController class]];
	[californiaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-20, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:californiaDictionary forKey:@"California"];
	//--------
	NSMutableDictionary *coloradoDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[coloradoDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[coloradoDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[coloradoDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:coloradoDictionary forKey:@"Colorado"];
	//--------
	NSMutableDictionary *connecticutDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	NSArray *ar = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(0, 0)],[NSValue valueWithCGPoint:CGPointMake(+6, +25)], nil];	
	[connecticutDictionary setObject:ar forKey:[CountryViewController class]];
	
	[connecticutDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[connecticutDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:connecticutDictionary forKey:@"Connecticut"];
	//--------
	NSMutableDictionary *delawareDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[delawareDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[delawareDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[delawareDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:delawareDictionary forKey:@"Delaware"];
	//--------
	NSMutableDictionary *floridaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[floridaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(30, 0)] forKey:[CountryViewController class]];
	[floridaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(48, 0)] forKey:[RegionViewController class]];
	[floridaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(46, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:floridaDictionary forKey:@"Florida"];
	//--------
	NSMutableDictionary *georgiaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[georgiaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[georgiaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[georgiaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:georgiaDictionary forKey:@"Georgia"];
	//--------
	NSMutableDictionary *hawaiiDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[hawaiiDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[hawaiiDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[hawaiiDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:hawaiiDictionary forKey:@"Hawaii"];
	//--------
	NSMutableDictionary *idahoDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[idahoDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 45)] forKey:[CountryViewController class]];
	[idahoDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 45)] forKey:[RegionViewController class]];
	[idahoDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 75)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:idahoDictionary forKey:@"Idaho"];
	//--------
	NSMutableDictionary *illinoisDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[illinoisDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(4, -5)] forKey:[CountryViewController class]];
	[illinoisDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(5, -5)] forKey:[RegionViewController class]];
	[illinoisDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(10, -10)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:illinoisDictionary forKey:@"Illinois"];
	//--------
	NSMutableDictionary *indianaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[indianaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(6, -6)] forKey:[CountryViewController class]];
	[indianaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(4, -3)] forKey:[RegionViewController class]];
	[indianaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(13, -6)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:indianaDictionary forKey:@"Indiana"];
	//--------
	NSMutableDictionary *iowaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[iowaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[iowaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[iowaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:iowaDictionary forKey:@"Iowa"];
	//--------
	NSMutableDictionary *kansasDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[kansasDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 3)] forKey:[CountryViewController class]];
	[kansasDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 3)] forKey:[RegionViewController class]];
	[kansasDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 3)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:kansasDictionary forKey:@"Kansas"];
	//--------
	NSMutableDictionary *kentuckyDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[kentuckyDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(10, 6)] forKey:[CountryViewController class]];
	[kentuckyDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(10, 5)] forKey:[RegionViewController class]];
	[kentuckyDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(20, 10)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:kentuckyDictionary forKey:@"Kentucky"];
	//--------
	NSMutableDictionary *louisianaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[louisianaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-13, 0)] forKey:[CountryViewController class]];
	[louisianaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-18, 0)] forKey:[RegionViewController class]];
	[louisianaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-24, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:louisianaDictionary forKey:@"Louisiana"];
	//--------
	NSMutableDictionary *maineDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[maineDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[maineDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[maineDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:maineDictionary forKey:@"Maine"];
	//--------
	NSMutableDictionary *marylandDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[marylandDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(6, -9)] forKey:[CountryViewController class]];
	[marylandDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(3, -6)] forKey:[RegionViewController class]];
	[marylandDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(5, -13)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:marylandDictionary forKey:@"Maryland"];
	//--------
	NSMutableDictionary *massachusettsDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[massachusettsDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[massachusettsDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[massachusettsDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:massachusettsDictionary forKey:@"Massachusetts"];
	//--------
	NSMutableDictionary *michiganDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[michiganDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(24, 34)] forKey:[CountryViewController class]];
	[michiganDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(20, 28)] forKey:[RegionViewController class]];
	[michiganDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(34, 40)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:michiganDictionary forKey:@"Michigan"];
	//--------
	NSMutableDictionary *minnesotaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[minnesotaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-10, 10)] forKey:[CountryViewController class]];
	[minnesotaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-10, 10)] forKey:[RegionViewController class]];
	[minnesotaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-20,10)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:minnesotaDictionary forKey:@"Minnesota"];
	//--------
	NSMutableDictionary *mississippiDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[mississippiDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(2, 0)] forKey:[CountryViewController class]];
	[mississippiDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(2, 0)] forKey:[RegionViewController class]];
	[mississippiDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(4, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:mississippiDictionary forKey:@"Mississippi"];
	//--------
	NSMutableDictionary *missouriDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[missouriDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[missouriDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[missouriDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:missouriDictionary forKey:@"Missouri"];
	//--------
	NSMutableDictionary *montanaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[montanaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[montanaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[montanaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:montanaDictionary forKey:@"Montana"];
	//--------
	NSMutableDictionary *nebraskaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[nebraskaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[nebraskaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[nebraskaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:nebraskaDictionary forKey:@"Nebraska"];
	//--------
	NSMutableDictionary *nevadaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[nevadaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[nevadaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[nevadaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:nevadaDictionary forKey:@"Nevada"];
	//--------
	NSMutableDictionary *newhampshireDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[newhampshireDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[newhampshireDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 15)] forKey:[RegionViewController class]];
	[newhampshireDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 20)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:newhampshireDictionary forKey:@"NewHampshire"];
	//--------
	NSMutableDictionary *newjerseyDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[newjerseyDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[newjerseyDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[newjerseyDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:newjerseyDictionary forKey:@"NewJersey"];
	//--------
	NSMutableDictionary *newmexicoDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[newmexicoDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[newmexicoDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[newmexicoDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:newmexicoDictionary forKey:@"NewMexico"];
	//--------
	NSMutableDictionary *newyorkDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[newyorkDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(10, 0)] forKey:[CountryViewController class]];
	[newyorkDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(15, 0)] forKey:[RegionViewController class]];
	[newyorkDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(15, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:newyorkDictionary forKey:@"NewYork"];
	//--------
	NSMutableDictionary *northcarolinaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[northcarolinaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(7, -2)] forKey:[CountryViewController class]];
	[northcarolinaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(15, -7)] forKey:[RegionViewController class]];
	[northcarolinaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(16, -3)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:northcarolinaDictionary forKey:@"NorthCarolina"];
	//--------
	NSMutableDictionary *northdakotaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[northdakotaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[northdakotaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[northdakotaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:northdakotaDictionary forKey:@"NorthDakota"];
	//--------
	NSMutableDictionary *ohioDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[ohioDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[ohioDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[ohioDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:ohioDictionary forKey:@"Ohio"];
	//--------
	NSMutableDictionary *oklahomaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[oklahomaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(10, 0)] forKey:[CountryViewController class]];
	[oklahomaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(10, 0)] forKey:[RegionViewController class]];
	[oklahomaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(20, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:oklahomaDictionary forKey:@"Oklahoma"];
	//--------
	NSMutableDictionary *oregonDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[oregonDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 5)] forKey:[CountryViewController class]];
	[oregonDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 5)] forKey:[RegionViewController class]];
	[oregonDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 10)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:oregonDictionary forKey:@"Oregon"];
	//--------
	NSMutableDictionary *pennsylvaniaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[pennsylvaniaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-5, 7)] forKey:[CountryViewController class]];
	[pennsylvaniaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-5, 7)] forKey:[RegionViewController class]];
	[pennsylvaniaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-5, 7)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:pennsylvaniaDictionary forKey:@"Pennsylvania"];
	//--------
	NSMutableDictionary *rhodeislandDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[rhodeislandDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[rhodeislandDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[rhodeislandDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:rhodeislandDictionary forKey:@"RhodeIsland"];
	//--------
	NSMutableDictionary *southcarolinaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[southcarolinaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, -5)] forKey:[CountryViewController class]];
	[southcarolinaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, -5)] forKey:[RegionViewController class]];
	[southcarolinaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, -5)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:southcarolinaDictionary forKey:@"SouthCarolina"];
	//--------
	NSMutableDictionary *southdakotaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[southdakotaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[southdakotaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[southdakotaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:southdakotaDictionary forKey:@"SouthDakota"];
	//--------
	NSMutableDictionary *tennesseeDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[tennesseeDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[tennesseeDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[tennesseeDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:tennesseeDictionary forKey:@"Tennessee"];
	//--------
	NSMutableDictionary *texasDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[texasDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(10, 0)] forKey:[CountryViewController class]];
	[texasDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(10, 0)] forKey:[RegionViewController class]];
	[texasDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(10, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:texasDictionary forKey:@"Texas"];
	//--------
	NSMutableDictionary *utahDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[utahDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 10)] forKey:[CountryViewController class]];
	[utahDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 10)] forKey:[RegionViewController class]];
	[utahDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 20)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:utahDictionary forKey:@"Utah"];
	//--------
	NSMutableDictionary *vermontDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	ar = [NSArray arrayWithObjects:[NSValue valueWithCGPoint:CGPointMake(-5, -2)],[NSValue valueWithCGPoint:CGPointMake(-15, -27)], nil];
	[vermontDictionary setObject:ar forKey:[CountryViewController class]];
	[vermontDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-6, -4)] forKey:[RegionViewController class]];
	[vermontDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-10, -15)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:vermontDictionary forKey:@"Vermont"];
	//--------
	NSMutableDictionary *virginiaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[virginiaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(10, 7)] forKey:[CountryViewController class]];
	[virginiaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(20, 10)] forKey:[RegionViewController class]];
	[virginiaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(11, 8)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:virginiaDictionary forKey:@"Virginia"];
	//--------
	NSMutableDictionary *washingtonDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[washingtonDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(7, 0)] forKey:[CountryViewController class]];
	[washingtonDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(9, 0)] forKey:[RegionViewController class]];
	[washingtonDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(11, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:washingtonDictionary forKey:@"Washington"];
	//--------
	NSMutableDictionary *westvirginiaDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[westvirginiaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[westvirginiaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[westvirginiaDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:westvirginiaDictionary forKey:@"WestVirginia"];
	//--------
	NSMutableDictionary *wisconsinDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[wisconsinDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[CountryViewController class]];
	[wisconsinDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[RegionViewController class]];
	[wisconsinDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:wisconsinDictionary forKey:@"Wisconsin"];
	//--------
	NSMutableDictionary *wyomingDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
	
	[wyomingDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-3, 0)] forKey:[CountryViewController class]];
	[wyomingDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-3, 0)] forKey:[RegionViewController class]];
	[wyomingDictionary setObject:[NSValue valueWithCGPoint:CGPointMake(-3, 0)] forKey:[StateViewController class]];
	
	
	[self.statesOffsetDictionary setObject:wyomingDictionary forKey:@"Wyoming"];
	//--------
	
	
}


@end
