/* NSWindowStyleMask-test.m: NSWindow styleMasks test

   Copyright (C) 1999, 2000 Free Software Foundation, Inc.

   Author:  Nicola Pero <n.pero@mi.flashnet.it>
   Date: 1999, July 2000
   
   This file is part of GNUstep.
   
   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2 of the License, or
   (at your option) any later version.
   
   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.
   
   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA. */

#include <Foundation/Foundation.h>
#include <AppKit/AppKit.h>
#include <AppKit/GSHbox.h>
#include <AppKit/GSTable.h>
#include <AppKit/GSVbox.h>
#include "../GSTestProtocol.h"

#define STYLE_NUMBER 6

struct 
{ 
  NSString *name; unsigned int styleMask;
} styles[STYLE_NUMBER] = 
{
  { @"NSMiniWindowMask",           NSMiniWindowMask           },
  { @"NSIconWindowMask",           NSIconWindowMask           },
  { @"NSResizableWindowMask",      NSResizableWindowMask      },
  { @"NSMiniaturizableWindowMask", NSMiniaturizableWindowMask },
  { @"NSClosableWindowMask",       NSClosableWindowMask       },
  { @"NSTitledWindowMask",         NSTitledWindowMask         }
};


@interface NSWindowStyleMaskTest: NSObject <GSTest>
{
  NSButton *styleButton[6];
  NSWindow *win;
}
-(void) restart;
-(void) newWindow: (id)sender;
@end

@implementation NSWindowStyleMaskTest: NSObject
{
  // for instance variables see above
}
-(id) init
{
  int i;
  GSVbox *styleVbox;
  NSButton *newWindowButton;
  GSVbox *mainVbox;
  NSBox *optionsBox;
  NSRect winFrame;

  mainVbox = AUTORELEASE ([GSVbox new]);
  [mainVbox setDefaultMinYMargin: 5];
  [mainVbox setBorder: 5];

  newWindowButton = AUTORELEASE ([NSButton new]);
  [newWindowButton setTitle: @"Create Window"];
  [newWindowButton sizeToFit];
  // Stand-alone buttons look better slighlty bigger
  [newWindowButton setFrameSize: 
		     NSMakeSize ([newWindowButton frame].size.width + 6, 
				 [newWindowButton frame].size.height + 4)];
  [newWindowButton setAutoresizingMask: NSViewMinXMargin];
  [newWindowButton setTarget: self];
  [newWindowButton setAction: @selector (newWindow:)];
  [mainVbox addView: newWindowButton  enablingYResizing: NO];

  [mainVbox addSeparator];
  
  styleVbox = AUTORELEASE ([GSVbox new]);
  [styleVbox setDefaultMinYMargin: 5];
  [styleVbox setBorder: 5];

  for (i = 0; i < STYLE_NUMBER; i++)
    {
      styleButton[i] = AUTORELEASE ([NSButton new]);
      [styleButton[i] setTitle: styles[i].name];
      [styleButton[i] setButtonType: NSSwitchButton];
      [styleButton[i] setBordered: NO];
      [styleButton[i] sizeToFit];
      [styleButton[i] setAutoresizingMask: NSViewMaxXMargin];
      [styleVbox addView: styleButton[i]];
    }
  
  optionsBox = AUTORELEASE ([NSBox new]);
  [optionsBox setTitle: @"Window Style Mask"];
  [optionsBox setTitlePosition: NSAtTop];
  [optionsBox addSubview: styleVbox];
  [optionsBox sizeToFit];
  [optionsBox setAutoresizingMask: NSViewWidthSizable | NSViewHeightSizable];

  [mainVbox addView: optionsBox];
  
  winFrame.size = [mainVbox frame].size;
  winFrame.origin = NSMakePoint (100, 100);

  win = [[NSWindow alloc] initWithContentRect: winFrame
			  styleMask: (NSTitledWindowMask 
				      | NSClosableWindowMask 
				      | NSMiniaturizableWindowMask)
			  backing: NSBackingStoreBuffered
			  defer: NO];
  [win setReleasedWhenClosed: NO];  
  [win setContentView: mainVbox];
  [win setTitle: @"NSWindowStyleMask Test"];
  
  [self restart];
  return self;
}
-(void) dealloc
{
  RELEASE (win);
  [super dealloc];
}
-(void) restart
{
  [win orderFront: nil]; 
  [[NSApplication sharedApplication] addWindowsItem: win
				     title: @"NSWindowStyleMask Test"
				     filename: NO];
}
-(void) newWindow: (id) sender 
{
  NSWindow *newWindow;
  unsigned int styleMask;
  int i;
  
  styleMask = 0;
  for (i = 0; i < STYLE_NUMBER; i++)
    {
      if ([styleButton[i] state] == 1)
	{
	  styleMask |= styles[i].styleMask;
	}      
    }

  newWindow = [NSWindow alloc];
  newWindow = [newWindow initWithContentRect: NSMakeRect (100, 100, 200, 200)
			 styleMask: styleMask
			 backing: NSBackingStoreBuffered
			 defer: NO];
  [newWindow setReleasedWhenClosed: YES];
  [newWindow orderFront: self]; 
}
@end