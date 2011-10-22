//
//  Password_GeneradorAppDelegate.m
//  Password Generador
//
//  Created by MC on 10/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Password_GeneradorAppDelegate.h"

@implementation Password_GeneradorAppDelegate

@synthesize window;

NSString *letters = @"abcdefghijklmnopqrstuvwxyz";
NSString *Symbols=@"~!@#$^&*()_-+={}[]:;<>,.?/\\";
NSString *Uppercase=@"ABCDEFGHIJKLMNOPQRSTUVWXYZ";
NSString *Numbers=@"0123456789";

-(NSString *) genRandStringLength: (int) len {
    NSString *ConcatRand=@"";
    if([chkLetters state]==NSOnState){
        ConcatRand=[ConcatRand  stringByAppendingString:letters];
        //NSLog(@"%@",ConcatRand);
    }
    
    if([chkNumber state]==NSOnState){
        ConcatRand=[ConcatRand  stringByAppendingString:Numbers];
        //NSLog(@"%@",ConcatRand);
    }
    
    if([chkUppercase state]==NSOnState){
        ConcatRand=[ConcatRand  stringByAppendingString:Uppercase];
        //NSLog(@"%@",ConcatRand);
    }
    
    if([chkSymbols state]==NSOnState){
        ConcatRand=[ConcatRand  stringByAppendingString:Symbols];
        //NSLog(@"%@",ConcatRand);
    }
    
    NSMutableString *randomString = [NSMutableString stringWithCapacity: len];
    
    for (int i=0; i<len; i++) {
        [randomString appendFormat: @"%c", [ConcatRand characterAtIndex: random()%[ConcatRand length]]] ;
        //NSLog(@"%a",[letters characterAtIndex: rand()%[letters length]]);
    }
    
    return randomString;
}

-(IBAction)GeneratePassword:(id)sender{
    NSString *Password;
    NSInteger Lenght;
    
    if([chkLetters state]==NSOffState && [chkNumber state]==NSOffState && [chkUppercase state]==NSOffState && [chkSymbols state]==NSOffState){
        NSAlert *alert = [[[NSAlert alloc] init] autorelease];
        [alert addButtonWithTitle:@"OK"];
        [alert setMessageText:@"Selección invalida."];
        [alert setInformativeText:@"Necesitas seleccionar al menos una opcion para generar la contraseña."];
        [alert setAlertStyle:NSWarningAlertStyle];
        [alert beginSheetModalForWindow:window modalDelegate:self didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:) contextInfo:nil];
    }else{
        
        
        Lenght=[txtLenght integerValue];
        
        if(Lenght>100){
            NSAlert *alert = [[[NSAlert alloc] init] autorelease];
            [alert addButtonWithTitle:@"OK"];
            [alert setMessageText:@"Longitud invalida."];
            [alert setInformativeText:@"La contraseña no puede ser mayor a 100 caracteres, ingresa un numero entre 1 y 100."];
            [alert setAlertStyle:NSWarningAlertStyle];
            [alert beginSheetModalForWindow:window modalDelegate:self didEndSelector:@selector(alertDidEnd:returnCode:contextInfo:) contextInfo:nil];
        }else{
            Password= [self genRandStringLength: (int)Lenght];
            [txtPassword setStringValue:Password];
        }
        
         
    }
}

-(IBAction)CopyPassword:(id)sender{
    NSPasteboard *pasteboard = [NSPasteboard generalPasteboard];
    [pasteboard clearContents];
    [pasteboard setString:[txtPassword stringValue] forType:NSStringPboardType];
}

- (void) alertDidEnd:(NSAlert *)alert returnCode:(int)returnCode contextInfo:(void *)contextInfo
{
	if(returnCode == NSAlertFirstButtonReturn)
	{
		// Do something
	}
}

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    srandom((int)time(NULL));
    
    [[NSNotificationCenter defaultCenter] 
     addObserver:self 
     selector:@selector(textDidChange:)
                        name:NSControlTextDidChangeNotification 
                        object:txtLenght];

}
- (void)textDidChange:(NSNotification *)aNotification

{
	NSText *countText = [[aNotification userInfo] objectForKey:@"NSFieldEditor"];
    NSTextField *countTextField = [aNotification object];
    
    NSScanner *scanner;
	NSString *scanString;
	NSMutableString *returnString;
    
	if ([countText string]==NULL
		|| [countText string]==@""
		|| [[countText string] length]==0)
	{
        
		[countTextField setStringValue:@"0"];
		return;	
	}
    
    returnString=[[NSMutableString alloc] initWithCapacity:1000];
    
	scanner=[[NSScanner alloc] initWithString:[countText string]];
    
	do
	{
        scanString=NULL;
		[scanner scanCharactersFromSet: [NSCharacterSet decimalDigitCharacterSet] 
                            intoString:&scanString];
		if (scanString!=NULL && scanString!=@"" && [scanString length]!=0)
            
			[returnString appendString:scanString];
        if (![scanner isAtEnd])
            
			[scanner setScanLocation:([scanner scanLocation]+1)];
        
    }while(![scanner isAtEnd]);
    
    if ([returnString intValue]<0)
        [returnString setString:@"0"];
    
    if ([returnString intValue]>100)
        [returnString setString:@"100"];
    
	if ([returnString length]==0)
        [returnString setString:@"0"];
    
    [countTextField setStringValue:returnString];
    [returnString release];
    
	[scanner release];
    
}
/*- (void)controlTextDidChange:(NSNotification *)aNotification {
    if ([[txtLenght stringValue] length] > 4) {
        // choose a method based on what you want the user to see; e.g.:
        [txtLenght setStringValue:@"999"];
        // restore the previous state here
    }
}*/
         
@end