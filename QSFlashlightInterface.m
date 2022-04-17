//
//  QSFlashlightInterface.m
//  QSFlashlightInterface
//
//  Created by Nicholas Jitkoff on 7/7/04.
//  Copyright __MyCompanyName__ 2004. All rights reserved.
//

#import "QSFlashlightInterface.h"

@implementation QSFlashlightInterface

- (id)init {
    self = [self initWithWindowNibName:@"Flashlight"];
    if (self) {
		
    }
    return self;
}


- (void)windowDidLoad{
    [super windowDidLoad];
    [menuButton setMenuOffset:NSMakePoint(0.0,1.0)];
	[[self window]setLevel:kCGMainMenuWindowLevel-1];
    [menuButton setImage:[[NSBundle mainBundle] imageNamed:@"QuicksilverMenuLight"]];
	[menuButton setAlternateImage:[[NSBundle mainBundle] imageNamed:@"QuicksilverMenuPressed"]];

	QSWindow *window = (QSWindow *)[self window];
	[window setFrameAutosaveName:@"FlashlightInterfaceWindow"];
	[window setShowEffect:[NSDictionary dictionaryWithObjectsAndKeys:@"QSVExpandEffect",@"transformFn",@"show",@"type",[NSNumber numberWithDouble:0.15],@"duration",nil]];
	//	[window setHideEffect:[NSDictionary dictionaryWithObjectsAndKeys:@"QSShrinkEffect",@"transformFn",@"hide",@"type",[NSNumber numberWithDouble:.25],@"duration",nil]];
	
	[window setWindowProperty:[NSDictionary dictionaryWithObjectsAndKeys:@"QSExplodeEffect",@"transformFn",@"hide",@"type",[NSNumber numberWithDouble:0.2],@"duration",nil]
					   forKey:kQSWindowExecEffect];
	
	[window setWindowProperty:[NSDictionary dictionaryWithObjectsAndKeys:@"hide",@"type",[NSNumber numberWithDouble:0.15],@"duration",nil]
					   forKey:kQSWindowFadeEffect];
	
	[window setWindowProperty:[NSDictionary dictionaryWithObjectsAndKeys:@"QSVContractEffect",@"transformFn",@"hide",@"type",[NSNumber numberWithDouble:0.333],@"duration",nil,[NSNumber numberWithDouble:0.25],@"brightnessB",@"QSStandardBrightBlending",@"brightnessFn",nil]
					   forKey:kQSWindowCancelEffect];
	
	
	NSArray *searchObjectViews = [NSArray arrayWithObjects:dSelector,aSelector,iSelector, nil];
	[(QSCollectingSearchObjectView *)dSelector setCollectionSpace:0.0f];
	[(QSCollectingSearchObjectView *)iSelector setCollectionSpace:0.0f];
	[(QSCollectingSearchObjectView *)dSelector setCollectionEdge:NSMinXEdge];
	[(QSCollectingSearchObjectView *)iSelector setCollectionEdge:NSMinXEdge];
	
    for (QSSearchObjectView *theSelector in searchObjectViews) {
        [[theSelector cell] setBezeled:YES];
        [[theSelector cell] setShowDetails:NO];
        [[theSelector cell] setTextColor:[NSColor textColor]];
        [[theSelector cell] setHighlightsBy:NSNoCellMask];
        [theSelector setPreferredEdge:NSMinYEdge];
        [theSelector setResultsPadding:5];
    }
    
    [[self window] setMovableByWindowBackground:NO];
	
    [self updateViewLocations];
	[[self window] display];
}

- (void)updateViewLocations{
    [super updateViewLocations];
	
    NSRect dFrame=[dSelector frame];
    NSRect aFrame=[aSelector frame];
    NSRect iFrame=[iSelector frame];
    dFrame.size.width=MIN(256,(NSInteger)[dSelector cellSize].width);
    aFrame.size.width=MIN(256,(NSInteger)[aSelector cellSize].width);
    iFrame.size.width=MIN(256,(NSInteger)[iSelector cellSize].width);
    aFrame.origin.x=NSMaxX(dFrame)-9;
    iFrame.origin.x=NSMaxX(aFrame)-9;
    [dSelector setFrame:dFrame];
    [aSelector setFrame:aFrame];
    [iSelector setFrame:iFrame];
	
	NSRect windowRect=[[self window]frame];
	windowRect.size.width=12+([iSelector superview]?NSMaxX([iSelector frame]):NSMaxX([aSelector frame]));
    [[self window]setFrame:windowRect display:YES];
	
	
    [[[self window]contentView]setNeedsDisplay:YES];
}


-(void) showInterface:(id)sender{
	NSScreen *screen=[NSScreen mainScreen];
	NSRect interfaceRect = [(NSWindow *)[sender window] frame];
	[[self window] setFrameTopLeftPoint:NSMakePoint(NSMaxX([screen frame])/2 - NSWidth(interfaceRect)/2, NSMaxY([screen visibleFrame])*0.9)];
    [super showInterface:sender];
}

- (NSSize)maxIconSize{
    return NSMakeSize(32,32);
}
- (NSRect)window:(NSWindow *)window willPositionSheet:(NSWindow *)sheet usingRect:(NSRect)rect{
	// logRect(rect);
    return NSOffsetRect(rect,0,-NSHeight([window frame]));
	
}
@end

