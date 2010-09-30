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

#import "Target.h"

SPEC_BEGIN(ExampleSpec)

describe(@"Target", ^{
    __block Target* model;

  beforeEach(^{
    model = [Target new];
    model.name = @"Sutro Tower";
    model.latitude = [NSNumber numberWithFloat:37.755278];
    model.longitude = [NSNumber numberWithFloat:122.45277];
  });

  describe(@"name", ^{
      it(@"should be 'Sutro Tower'", ^{
          assertThat(model.name, equalTo(@"Sutro Tower"));
      });
  });
  
  describe(@"latitude", ^{
    it(@"should be 37.755278", ^{
      assertThat(model.latitude, equalTo([NSNumber numberWithFloat:37.755278]));
    });
  });

  describe(@"longitude", ^{
    it(@"should be 122.45277", ^{
      assertThat(model.longitude, equalTo([NSNumber numberWithFloat:122.45277]));
    });
  });
  
});

SPEC_END
