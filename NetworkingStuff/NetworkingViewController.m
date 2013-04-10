//
//  NetworkingViewController.m
//  NetworkingStuff
//
//  Created by Thuy Copeland on 4/9/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import "NetworkingViewController.h"
#import "AFNetworking.h"

@interface NetworkingViewController ()

@end

@implementation NetworkingViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *url = [NSURL URLWithString:@"http://o.onionstatic.com/images/7/7954/original/700.hq.jpg?3818"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    // sending a message to our class, with 3 arguments.
    
    // a caret ^ is obj.-c.'s marker for a block.
    /*AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        
        
        NSString *ipAddress = [JSON valueForKeyPath:@"origin"];
        
        self.ipAddressLabel.text = ipAddress;

    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        // this happens when the web service call doesn't work.
        NSLog(@"oops: %@", error);
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:error.localizedDescription delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alert show];
        
        self.ipAddressLabel.text = error.localizedDescription;
    }];*/
    
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request success:^(UIImage *image)
    {
        self.imageView.image = image;
    }];
    
    [operation start];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
