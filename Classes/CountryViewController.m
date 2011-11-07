
#import "CountryViewController.h"
#import "StatesMarkupManagerObject.h"


@implementation CountryViewController

@synthesize vectorGeographicView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
	//	self.circleDiameter = 100;
		self.view.autoresizesSubviews = NO;
	//	self.frontView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"national_view_background.png"]];
    }
    return self;
}
		
-(void)loadMap
{	
	NSArray *keysArray = [[StatesMarkupManagerObject statesMarkupManagerObject].statesMasterDictionary allKeys];

	
	
	NSMutableArray *statesAr = [NSMutableArray arrayWithCapacity:0];
	for (int i = 0; i < [keysArray count]; i++)
	{
		NSDictionary *stateObject = [NSDictionary dictionaryWithObject:[[StatesMarkupManagerObject statesMarkupManagerObject].statesMasterDictionary objectForKey:[keysArray objectAtIndex:i]] forKey:[keysArray objectAtIndex:i]];
		[statesAr addObject:stateObject];
	}
	
	
	if (vectorGeographicView)
	{
		[vectorGeographicView removeFromSuperview];
		[vectorGeographicView release];
	}
	self.vectorGeographicView = [[VectorGeographicView alloc] initWithFrame:CGRectMake(0,0,self.view.frame.size.width, self.view.frame.size.height)];
	self.vectorGeographicView.backgroundColor = [UIColor clearColor];
	self.vectorGeographicView.statesArray = statesAr;
	self.vectorGeographicView.doStretch = YES;
	self.vectorGeographicView.xAnchor = 5;
	self.vectorGeographicView.yAnchor = 1;
	[self.view addSubview:vectorGeographicView];	
}
		

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.view.backgroundColor = [UIColor clearColor];
	self.view.autoresizesSubviews = NO;	
	[super viewDidLoad];

}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
