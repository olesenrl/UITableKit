//
//  EditingSampleViewController.m
//  TableKitSample
//
//  Created by onegray on 4/11/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditingSampleViewController.h"
#import "TKSection.h"
#import "TKTextFieldCell.h"
#import "TKStaticCell.h"
#import "TKSwitchCell.h"
#import "TKTextViewCell.h"

#import "TKDefaultTheme.h"

@interface EditingSampleViewController ()
@property (nonatomic, retain) TKTextFieldCell* addCityCell;
@property (nonatomic, retain) TKSection* citiesSection;
@end

@implementation EditingSampleViewController
@synthesize citiesSection, addCityCell;

-(void) dealloc
{
	[citiesSection release];
	[addCityCell release];
	[super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];

	TKDefaultTheme* defaultTheme = [[[TKDefaultTheme alloc] init] autorelease];
	[self.tableView applyTheme:defaultTheme];
	
	if(self.sections==nil)
	{
		self.citiesSection = [[[TKSection alloc] init] autorelease];
		citiesSection.preventIndentationWhileEditing = YES;
		citiesSection.headerTitle = @"Cities";

		[citiesSection addCell:[TKStaticCell cellWithTitle:@"Minsk"]];
		[citiesSection addCell:[TKStaticCell cellWithTitle:@"Brest"]];
		[citiesSection addCell:[TKStaticCell cellWithTitle:@"Homel"]];

		self.addCityCell = [TKTextFieldCell cellWithText:nil placeholder:@"Add New"];
		addCityCell.delegate = (id)self;
		[addCityCell setPreventEditing:YES];
		[citiesSection addCell:addCityCell];

		TKSwitchCell* editingModeCell = [TKSwitchCell cellWithTitle:@"Editing Mode" state:NO];
		editingModeCell.delegate = (id)self;
		TKSection* editingModeSection = [TKSection sectionWithCells:editingModeCell, nil];
		editingModeSection.preventEditing = YES;
		

		self.sections = [NSArray arrayWithObjects:citiesSection, editingModeSection, nil];
	}
}

-(void)textFieldCellDidEndEditing:(TKTextFieldCell*)cell
{
	if([cell.text length] > 0) 
	{
		TKStaticCell* cityCell = [TKStaticCell cellWithTitle:cell.text];
		[citiesSection insertCell:cityCell atIndex:[citiesSection cellCount]-1];
		cell.text = nil;
		[self.tableView reloadData];
	}
}


-(void)switchCell:(TKSwitchCell*)cell didSwitchState:(BOOL)state
{
	self.tableView.editing = state;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end