//
//  Password_GeneradorAppDelegate.h
//  Password Generador
//
//  Created by MC on 10/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Password_GeneradorAppDelegate : NSObject <NSApplicationDelegate> {
@private
    NSWindow *window;
    IBOutlet NSTextField *txtLenght;
    IBOutlet NSButton *btnGenerate;
    IBOutlet NSButton *btnCopy;
    
    IBOutlet NSButton *chkNumber;
    IBOutlet NSButton *chkLetters;
    IBOutlet NSButton *chkUppercase;
    IBOutlet NSButton *chkSymbols;
    
    IBOutlet NSTextField *txtPassword;

    
}

-(IBAction )GeneratePassword:(id)sender;
-(IBAction )CopyPassword:(id)sender;
-(NSString *) genRandStringLength: (int) len;

@property (assign) IBOutlet NSWindow *window;

@end
