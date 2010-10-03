//
//  main.m
//  EyesOn
//
//  Created by dav on 10/2/10.
//  Copyright 2010 Sekai No. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
  if(getenv("NSZombieEnabled") || getenv("NSAutoreleaseFreedObjectCheckEnabled")) {
		NSLog(@"NSZombieEnabled/NSAutoreleaseFreedObjectCheckEnabled enabled!");
	}
  
  NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
  int retVal = UIApplicationMain(argc, argv, nil, @"EyesOnAppDelegate");
  [pool release];
  return retVal;
}
