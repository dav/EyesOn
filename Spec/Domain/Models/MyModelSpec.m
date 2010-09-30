//
//  MyModelSpec.m
//  EyesOn
//
//  Created by dav on 9/30/10.
//  Copyright 2010 Sekai No. All rights reserved.
//

#import <Cedar/SpecHelper.h>
#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>
#import <OCMock/OCMock.h>

#import "MyModel.h"

SPEC_BEGIN(ExampleSpec)

describe(@"MyModel", ^{
    __block MyModel *model;

    beforeEach(^{
        model = [[MyModel alloc] init];
    });

    describe(@"name", ^{
        it(@"should be 'foo'", ^{
            assertThat([model name], equalTo(@"foo"));
        });
    });
});

SPEC_END
