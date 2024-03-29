/**
 * Your Copyright Here
 *
 * Appcelerator Titanium is Copyright (c) 2009-2010 by Appcelerator, Inc.
 * and licensed under the Apache Public License (version 2)
 */
#import "OrgAdamantioKmlModule.h"
#import "TiBase.h"
#import "TiHost.h"
#import "TiUtils.h"

@implementation OrgAdamantioKmlModule

#pragma mark Internal

// this is generated for your module, please do not change it
-(id)moduleGUID
{
	return @"9aba42ab-843e-41b7-9e76-6eee3de7c9f5";
}

// this is generated for your module, please do not change it
-(NSString*)moduleId
{
	return @"org.adamantio.kml";
}

#pragma mark Lifecycle

-(void)startup
{
	// this method is called when the module is first loaded
	// you *must* call the superclass
	[super startup];
	
	NSLog(@"[INFO] %@ loaded",self);
}

-(void)shutdown:(id)sender
{
	// this method is called when the module is being unloaded
	// typically this is during shutdown. make sure you don't do too
	// much processing here or the app will be quit forceably
	
	// you *must* call the superclass
	[super shutdown:sender];
}

#pragma mark Cleanup 

-(void)dealloc
{
	// release any resources that have been retained by the module
	[super dealloc];
}

#pragma mark Internal Memory Management

-(void)didReceiveMemoryWarning:(NSNotification*)notification
{
	// optionally release any resources that can be dynamically
	// reloaded once memory is available - such as caches
	[super didReceiveMemoryWarning:notification];
}

#pragma mark Listener Notifications

-(void)_listenerAdded:(NSString *)type count:(int)count
{
	if (count == 1 && [type isEqualToString:@"credentials_saved"])
	{
		// the first (of potentially many) listener is being added 
		// for event named 'my_event'
	}
}

-(void)_listenerRemoved:(NSString *)type count:(int)count
{
	if (count == 0 && [type isEqualToString:@"credentials_saved"])
	{
		// the last listener called for event named 'my_event' has
		// been removed, we can optionally clean up any resources
		// since no body is listening at this point for that event
	}
}

#pragma Public APIs


-(id)saveCredentialForHost:(id)args
{
  ENSURE_SINGLE_ARG(args,NSDictionary);
  NSString *result = @"OK";
  
  @try {
    NSString *thehost = [TiUtils stringValue:[args objectForKey:@"host"]];
    NSInteger port = [TiUtils intValue:[args objectForKey:@"port"]];
    NSString *username = [TiUtils stringValue:[args objectForKey:@"username"]];
    NSString *password= [TiUtils stringValue:[args objectForKey:@"password"]];
    
    NSURLCredential *authenticationCredentials = [NSURLCredential credentialWithUser:username 
                                                                            password:password 
                                                                         persistence:NSURLCredentialPersistenceForSession];

    NSURLProtectionSpace *protectionSpace = [[NSURLProtectionSpace alloc] initWithHost:thehost
                                                                                   port:port
                                                                               protocol:@"http"
                                                                                  realm:@"nil" 
                                                                  authenticationMethod:nil];
    
    [[NSURLCredentialStorage sharedCredentialStorage] setDefaultCredential:authenticationCredentials
                                                          forProtectionSpace:protectionSpace];
    
    
    if ([self _hasListeners:@"credentials_saved"])
    {
    
      NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:@"OK", @"result", nil];
      [self fireEvent:@"credentials_saved" withObject:event];
    }
    
  } 
  @catch (id exception) {
    result = [NSString stringWithFormat:@"[INFO] %@ ", exception];
    
    if ([self _hasListeners:@"credentials_error"])
      {
      
      NSDictionary *event = [NSDictionary dictionaryWithObjectsAndKeys:result, @"result", nil];
      [self fireEvent:@"credentials_error" withObject:event];
      }
    
  }
  
	return result;
}

-(id)example:(id)args
{
	// example method
	return @"hello world";
}

-(id)exampleProp
{
	// example property getter
	return @"hello world";
}

-(void)exampleProp:(id)value
{
	// example property setter
}

@end
