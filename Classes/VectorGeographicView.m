//
//  VectorGeographicView.m
//  UNHC
//
//  Created by Josh Klobe on 5/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "VectorGeographicView.h"



@implementation VectorGeographicView

@synthesize statesArray, statesVerticiesDictionary, statesCenterpointDictionary, xAnchor, yAnchor, doStretch, baseViewController;

@synthesize minX, minY, maxX, maxY, xDiff, yDiff;
- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
		self.statesArray = [[NSArray alloc] init];
		self.statesVerticiesDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];	
		self.statesCenterpointDictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
		
		
        // Initialization code.
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
	

	float multiplierFactor = 1;		
	self.minX = 10000;
	self.minY = 10000;
	self.maxX = 0;
	self.maxY = 0;
	for (int j = 0; j < [self.statesArray count]; j++)
	{
		NSDictionary *dict = [self.statesArray objectAtIndex:j];
		NSString *key = [[dict allKeys] objectAtIndex:0];
		NSArray *pointsArray = [dict objectForKey:key];
		
		
		for (int k = 0; k < [pointsArray count]; k++)
		{
			NSArray *set = [pointsArray objectAtIndex:k];
			
			for (int z = 0; z < [set count]; z++)
			{	
				NSString *setPointsArray = [set objectAtIndex:z];				
				NSArray *pointAr = [setPointsArray componentsSeparatedByString:@","];
				
				if ([pointAr count] == 2)
				{
					CGPoint point = CGPointMake([[pointAr objectAtIndex:0] floatValue], [[pointAr objectAtIndex:1] floatValue]);
					if (point.x < self.minX)
						self.minX = point.x;
					if (point.y < self.minY)
						self.minY = point.y;
					if (point.x > self.maxX)
						self.maxX = point.x;
					if (point.y > self.maxY)
						self.maxY = point.y;
				}
			}
			
		}
		
	}
	self.xDiff = maxX - minX;
	self.yDiff = maxY - minY;
	
	if (doStretch)
	{
		/*	NSLog(@"width: % f", self.frame.size.width);
		 NSLog(@"minX: %f", minX);
		 NSLog(@"minY: %f", minY);
		 NSLog(@"maxX: %f", maxX);
		 NSLog(@"maxY: %f", maxY);
		 NSLog(@"xDiff: %f", xDiff);
		 NSLog(@"yDiff: %f", yDiff);
		 NSLog(@"width: % f", self.frame.size.width);
		 */	
		
		
		float xDesiredSpace = self.frame.size.width - (2 * xAnchor);
		float xExtend = xDesiredSpace / self.xDiff;
		float yDesiredSpace = self.frame.size.height - (2 * yAnchor);
		float yExtend = yDesiredSpace / self.yDiff;		
		
		if (yExtend > xExtend)
			multiplierFactor = xExtend;
		else
			multiplierFactor = yExtend;
		/*		NSLog(@"parent: %@", baseViewController);		
		 NSLog(@"xDesiredSpace: %f", xDesiredSpace);
		 NSLog(@"xExtend: %f", xExtend);
		 NSLog(@"yDesiredSpace: %f", yDesiredSpace);
		 NSLog(@"yExtend: %f", yExtend);
		 NSLog(@"multiplierFactor: %f", multiplierFactor);
		 NSLog(@" ");
		 NSLog(@" ");
		 NSLog(@" ");		
		 */		
	}
	
	for (int j = 0; j < [self.statesArray count]; j++)
	{
		float stateMinX = 10000;
		float stateMaxX = 0;
		float stateMinY = 10000;
		float stateMaxY = 0;
		
		NSDictionary *dict = [self.statesArray objectAtIndex:j];
		NSString *key = [[dict allKeys] objectAtIndex:0];
		
		NSArray *set =	[dict objectForKey:key];
		for (int z = 0; z < [set count]; z++)
		{	NSString *theKey = [key stringByAppendingString:[NSString stringWithFormat:@"_%d", z]];
			NSArray *pointsArray = [set objectAtIndex:z];
			
			CGMutablePathRef path = CGPathCreateMutable();
			
			CGContextRef context = UIGraphicsGetCurrentContext();
			CGContextBeginPath(UIGraphicsGetCurrentContext());
			

			CGContextSetFillColorWithColor(context, [UIColor colorWithRed:150/255.0f green:156/255.0f blue:170/255.0f alpha:1].CGColor);				
				

			CGContextSetStrokeColorWithColor(context, [UIColor clearColor].CGColor);
			
			
			
			NSMutableArray *vertAr = [[NSMutableArray alloc] initWithCapacity:0];
			if ([pointsArray count] > 0)
			{
				
				CGPoint pointA;
				
				for (int z = 0; z < 2; z++)
				{
					if (z == 0)
						CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
					
						CGContextSetFillColorWithColor(context, [UIColor colorWithRed:150/255.0f green:156/255.0f blue:170/255.0f alpha:1].CGColor);				
						

					
					
					for (int i = 0; i < [pointsArray count]; i++)
					{
						NSArray *pointAR = [[pointsArray objectAtIndex:i] componentsSeparatedByString:@","];
						
						
						if ([pointAR count] == 2)
						{
							float x = [[pointAR objectAtIndex:0] floatValue];
							float y = [[pointAR objectAtIndex:1] floatValue];
							if (xAnchor > 0)
								x = xAnchor + (x * multiplierFactor) - (self.minX * multiplierFactor);	
							if (yAnchor > 0)
								y = yAnchor + (y * multiplierFactor) - (self.minY * multiplierFactor);
							
							if (i == 0)
							{							
								pointA = CGPointMake(x, y);
								CGPathMoveToPoint(path, nil,pointA.x , pointA.y);	
							}
							else
							{
								CGPoint pointB = CGPointMake(x, y);										
								CGPathAddLineToPoint(path, nil, pointB.x, pointB.y);			
								pointA = CGPointMake(pointB.x, pointB.y);
							}
							if (z == 1)
								[vertAr addObject:[NSValue valueWithCGPoint:pointA]];
							
							if (x < stateMinX)
								stateMinX = x;
							if (x > stateMaxX)
								stateMaxX = x;
							if (y < stateMinY)
								stateMinY = y;
							if (y > stateMaxY)
								stateMaxY = y;
							
						}					
					}
					
					CGContextAddPath(context, path);
					CGContextStrokePath(context);
					CGContextAddPath(context, path);
					CGContextFillPath(context);
					
				}
				
			}
			
			[statesVerticiesDictionary setObject:vertAr forKey:theKey];
			[vertAr release];
			
		}
		NSValue *centerPt = [NSValue valueWithCGPoint:CGPointMake((stateMinX + stateMaxX) / 2, (stateMinY + stateMaxY) / 2)];
		
		[self.statesCenterpointDictionary setObject:centerPt forKey:key];
		
	}
//	[self.baseViewController drawRectDone];
}


- (void)dealloc {
	

	[self.statesArray release];
	[self.statesVerticiesDictionary release];
	[self.statesCenterpointDictionary release];
	[self.baseViewController release];

	
    [super dealloc];
}


@end
