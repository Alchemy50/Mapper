//
//  MapperViewController.m
//  Mapper
//
//  Created by Josh Klobe on 11/7/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MapperViewController.h"
#import "CountryViewController.h"

@implementation MapperViewController

@synthesize countryViewController, stateViewController, regionViewController;


//-(void)loadStateViewController 

-(void)loadCountryViewController
{
	
	countryViewController = [[CountryViewController alloc] initWithNibName:@"CountryViewController" bundle:nil];	
	stateViewController = [[StateViewController alloc] initWithNibName:nil bundle:nil];
	regionViewController = [[RegionViewController alloc] initWithNibName:nil bundle:nil];
	
	
	switch ([UIApplication sharedApplication].statusBarOrientation) {
		case UIInterfaceOrientationPortrait:
		case UIInterfaceOrientationPortraitUpsideDown: 				
			self.countryViewController.view.frame = CGRectMake(0,0,768, 1024 / 2);
			self.stateViewController.view.frame = CGRectMake(0,countryViewController.view.frame.size.height,768/2, 885 / 2);
			self.regionViewController.view.frame = CGRectMake(self.stateViewController.view.frame.size.width, self.stateViewController.view.frame.origin.y, self.stateViewController.view.frame.size.width, self.stateViewController.view.frame.size.height);
			break;
			
		case UIInterfaceOrientationLandscapeLeft:
		case UIInterfaceOrientationLandscapeRight:
			self.countryViewController.view.frame = CGRectMake(0,0,1024, 748 /2 );
			self.stateViewController.view.frame = CGRectMake(0,countryViewController.view.frame.size.height,1024/2, 718 /2 );
			self.regionViewController.view.frame = CGRectMake(self.stateViewController.view.frame.size.width, self.stateViewController.view.frame.origin.y, self.stateViewController.view.frame.size.width, self.stateViewController.view.frame.size.height);
			break;
			
			
	}
	
	[self.view addSubview:countryViewController.view];
	[countryViewController loadMap];
	
	[self.view addSubview:stateViewController.view];
	[stateViewController loadMap];

	[self.view addSubview:regionViewController.view];
	[regionViewController loadMap];

	NSLog(@"regionViewController: %@", regionViewController.view);
	
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
		
	self.view.backgroundColor = [UIColor colorWithRed:.8 green:.8 blue:.8 alpha:.9];
	[self loadCountryViewController];
}


- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation
{


	
	if (countryViewController != nil)
	{
		[countryViewController.view removeFromSuperview];
		[countryViewController release];
	}

	if (stateViewController != nil)
	{
		[stateViewController.view removeFromSuperview];
		[stateViewController release];
	}
	
	if (regionViewController != nil)
	{
		[regionViewController.view removeFromSuperview];
		[regionViewController release];
	}
	

	
	[self loadCountryViewController];
	

}


// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	
    return YES;
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
