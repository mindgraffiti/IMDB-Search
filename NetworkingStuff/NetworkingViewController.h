//
//  NetworkingViewController.h
//  NetworkingStuff
//
//  Created by Thuy Copeland on 4/9/13.
//  Copyright (c) 2013 Thuy Copeland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NetworkingViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong,nonatomic) NSArray *movies;
@property (weak, nonatomic) IBOutlet UITableView *movieTable;

-(IBAction)search:(id)sender;


@end
