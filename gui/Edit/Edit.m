/*
   Edit.m
   
   Copyright (C) 1996 Free Software Foundation, Inc.
   
   Author:  Felipe A. Rodriguez <far@ix.netcom.com>
   Date: July 1998
   
   This file is part of the GNUstep GUI X/RAW Library.
   
   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.
   
   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.
   
   You should have received a copy of the GNU Library General Public
   License along with this library; if not, write to the Free
   Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#import <Foundation/NSAutoreleasePool.h>
#import <AppKit/AppKit.h>
#import "Controller.h"
#import "Document.h"

void createMenu();


int
main(int argc, char **argv, char** env)
{
id pool = [NSAutoreleasePool new];
NSApplication *theApp;

#if LIB_FOUNDATION_LIBRARY
  	[NSProcessInfo initializeWithArguments: argv count: argc environment: env];
#endif
#ifndef NX_CURRENT_COMPILER_RELEASE
  	initialize_gnustep_backend();
#endif

	theApp = [NSApplication sharedApplication];
	[theApp setDelegate: [[Controller alloc] init]];
	createMenu();									// create a generic menu
	[theApp run];

	[pool release];
	
	return 0;
}
//*****************************************************************************
//
// 		create interface modeller's menu 
//
//*****************************************************************************

void createMenu()
{
  NSMenu* menu;
  NSMenu* info;
  NSMenu* file;
  NSMenu* edit;
  NSMenu* util;
  NSMenu* services;
  NSMenu* windows;
  SEL action = @selector(method:);

  /*
   *	Create the app menu
   */
  menu = [[NSMenu alloc] initWithTitle: @"Edit"];

  [menu addItemWithTitle: @"Info"
		  action: action
	   keyEquivalent: @""];

  [menu addItemWithTitle: @"File"
		  action: action
	   keyEquivalent: @""];

  [menu addItemWithTitle: @"Edit"
		  action: action
	   keyEquivalent: @""];

  [menu addItemWithTitle: @"Format"
		  action: action
	   keyEquivalent: @""];

  [menu addItemWithTitle: @"Utilities"
		  action: action
	   keyEquivalent: @""];

  [menu addItemWithTitle: @"Windows"
		  action: action
	   keyEquivalent: @""];

  [menu addItemWithTitle: @"Print"
		  action: action
	   keyEquivalent: @"p"];

  [menu addItemWithTitle: @"Services"
		  action: action
	   keyEquivalent: @""];

  [menu addItemWithTitle: @"Hide"
		  action: @selector(hide:)
	   keyEquivalent: @"h"];

  [menu addItemWithTitle: @"Quit"
		  action: @selector(terminate:)
	   keyEquivalent: @"q"];

  /*
   * Create the info submenu
   */
  info = [NSMenu new];
  [menu setSubmenu: info
	   forItem: [menu itemWithTitle: @"Info"]];

  [info addItemWithTitle: @"Info Panel..."
		  action: action
	   keyEquivalent: @""];

  [info addItemWithTitle: @"Preferences..."
		  action: action
	   keyEquivalent: @""];

  [info addItemWithTitle: @"Help"
		  action: action
	   keyEquivalent: @"?"];

  /*
   * Create the file submenu
   */
  file = [NSMenu new];
  [menu setSubmenu: file
	   forItem: [menu itemWithTitle: @"File"]];

  [file addItemWithTitle: @"Open..."
		  action: action
	   keyEquivalent: @"o"];

  [file addItemWithTitle: @"New Application"
		  action: action 
	   keyEquivalent: @"n"];

  [file addItemWithTitle: @"New Module"
		  action: action
	   keyEquivalent: @""];

  [file addItemWithTitle: @"Save"
		  action: action
	   keyEquivalent: @"s"];

  [file addItemWithTitle: @"Save As..."
		  action: action
	   keyEquivalent: @"S"];

  [file addItemWithTitle: @"Save All"
		  action: action
	   keyEquivalent: @""];

  [file addItemWithTitle: @"Revert to Saved"
		  action: action 
	   keyEquivalent: @"u"];

  [file addItemWithTitle: @"Test Interface"
		  action: action
	   keyEquivalent: @"O"];

  [file addItemWithTitle: @"Close"
		  action: action
	   keyEquivalent: @""];


  /*
   * Create the edit submenu
   */
  edit = [NSMenu new];
  [menu setSubmenu: edit
	   forItem: [menu itemWithTitle: @"Edit"]];

  [edit addItemWithTitle: @"Cut"
		  action: action
	   keyEquivalent: @"x"];

  [edit addItemWithTitle: @"Copy"
		  action: @selector(copy:)
	   keyEquivalent: @"c"];

  [edit addItemWithTitle: @"Paste"
		  action: @selector(paste:)
	   keyEquivalent: @"v"];

  [edit addItemWithTitle: @"Delete"
		  action: action
	   keyEquivalent: @""];

  [edit addItemWithTitle: @"Undelete"
		  action: NULL
	   keyEquivalent: @""];

  [edit addItemWithTitle: @"Select All"
		  action: action
	   keyEquivalent: @"a"];

  /*
   * Create the edit submenu
   */
  util = [NSMenu new];
  [menu setSubmenu: util
	   forItem: [menu itemWithTitle: @"Utilities"]];

  [util addItemWithTitle: @"Inspector"
		  action: @selector(showInspectorPanel:)
	   keyEquivalent: @""];

  [util addItemWithTitle: @"Palettes"
		  action: @selector(showPalettePanel:) 
	   keyEquivalent: @""];

  [util addItemWithTitle: @"Load Palette"
		  action: action
	   keyEquivalent: @""];

  /*
   * Create the windows submenu
   */
  windows = [NSMenu new];
  [menu setSubmenu: windows
	   forItem: [menu itemWithTitle: @"Windows"]];

  [windows addItemWithTitle: @"Arrange"
		     action: @selector(arrangeInFront:)
	      keyEquivalent: @""];

  [windows addItemWithTitle: @"Miniaturize"
		     action: @selector(performMiniaturize:)
	      keyEquivalent: @"m"];

  [windows addItemWithTitle: @"Close"
		     action: @selector(performClose:)
	      keyEquivalent: @"w"];

  /*
   * Create the windows submenu
   */
  services = [NSMenu new];
  [menu setSubmenu: services
	   forItem: [menu itemWithTitle: @"Services"]];

  [[NSApplication sharedApplication] setMainMenu: menu];

  [[NSApplication sharedApplication] setServicesMenu: services];

  NSLog (@"start displaying the menu...");
  [menu update];
  [menu display];
}
