Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D113278782
	for <lists+linux-iio@lfdr.de>; Fri, 25 Sep 2020 14:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727248AbgIYMq7 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 25 Sep 2020 08:46:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:50680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgIYMq7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 25 Sep 2020 08:46:59 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47A1321741;
        Fri, 25 Sep 2020 12:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601038017;
        bh=0uOGRkN6n0m+gj8Lc37bBPi7l0BX1R44gv/c+nI3e0w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=t4WkH08lGnrm1ERhux67BmYV4/h7hv77fxPQGCbHAFvad13DUv2kGKK6J2nJQJFCM
         rM7W0l/o/VrEKOgwalIgxmmXa+MIhqCJKDPvu68ZBJnB7ccPmXOGGayKgmCz31dtup
         wtXnNkoEUmux7pMA4Wm0mDSZuVLlFQpIMexsz3/w=
Date:   Fri, 25 Sep 2020 13:46:51 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Evan Green <evgreen@chromium.org>
Subject: Re: [PATCH] dt-bindings: iio: sx9310: Add various settings as DT
 properties
Message-ID: <20200925134651.1b1bf20c@archlinux>
In-Reply-To: <160090354388.310579.2465697259775252128@swboyd.mtv.corp.google.com>
References: <20200903221828.3657250-1-swboyd@chromium.org>
        <20200906150247.3aaef3a3@archlinux>
        <159963232334.454335.9794130058200265122@swboyd.mtv.corp.google.com>
        <20200909121550.00005ede@Huawei.com>
        <160090354388.310579.2465697259775252128@swboyd.mtv.corp.google.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, 23 Sep 2020 16:25:43 -0700
Stephen Boyd <swboyd@chromium.org> wrote:

> Quoting Jonathan Cameron (2020-09-09 04:15:50)
> > On Tue, 8 Sep 2020 23:18:43 -0700
> > Stephen Boyd <swboyd@chromium.org> wrote:  
> > > >     
> > > > > +
> > > > > +  semtech,cs0-gain-factor:
> > > > > +    allOf:
> > > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > > +      - enum: [1, 2, 4, 8]
> > > > > +    default: 1
> > > > > +    description:
> > > > > +      Gain factor for CS0 (and combined if any) sensor.    
> > > > 
> > > > Why is this something that should be in DT as opposed to via
> > > > a userspace control?  We have hardwaregain for this purpose (I think)    
> > > 
> > > Thanks I'm not aware of hardwaregain. That looks like it should work.  
> 
> One weird thing I notice is that the channels can share some settings
> like this hardware gain factor. Is there support for a subset of
> channels sharing the same gain? I see there is mask_separate and
> shared_by_all, type, etc. but I don't see how I can make the setting
> apply to some subset of channels. I guess just do proper locking and
> make sure when one is changed it changes the other channel too?

Exactly.  It's impossible to describe ever combination of shared
attributes so we just do the big versions.  For everything else the
ABI relies on the fact that any change to a value can in theory impact
any other attribute in the same IIO device.

> 
> > >   
> > > >   
> > > >     
> > > > > +
> > > > > +  semtech,compensate-common:
> > > > > +    description: Any sensor triggers compensation of all channels.
> > > > > +    type: boolean    
> > > > 
> > > > Compensation for what?    
> > > 
> > > This is for RegProxCtrl6 bit 6 AVGCOMPMETHOD. 
> > > 
> > >       Defines the average compensation method:
> > > 
> > >       0: Individual. Each sensor triggers only its own compensation
> > >       1: Common. Any sensor triggers compensation of all channels. 
> > > 
> > > I believe this is for the offset compensation.  
> > 
> > I wonder if anyone will actually care which choice we make on that?
> > Perhaps just pick one and don't make it controllable?
> > 
> > Reading that it sounds like a control that is there because it was easy
> > to do in hardware rather than necessarily making any sense from
> > a usecase point of view.  Do we have any info on how it is used?  
> 
> Fair enough. I will try to contact Semtech to understand how it is used.
> This bit is different between two products I'm aware of but for all I
> know it doesn't actually matter. Given that we detect proximity of each
> channel individually it feels like we should leave this as 0. I'll try
> that out and see how it works.

Great.

> 
> >   
> > >   
> > > >     
> > > > > +
> > > > > +  semtech,avg-pos-strength:
> > > > > +    allOf:
> > > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > > +      - enum: [0, 16, 64, 128, 256, 512, 1024, 4294967295]
> > > > > +    default: 16
> > > > > +    description:
> > > > > +      Average positive filter strength. A value of 0 represents off and
> > > > > +      UINT_MAX (4294967295) represents infinite. Other values
> > > > > +      represent 1-1/N.    
> > > > 
> > > > I'm not sure about using UINT_MAX to represent infinity. Rob any thoughts on
> > > > this?
> > > > 
> > > > Again, why does it make sense to have the filter controls in DT?    
> > > 
> > > Is there an IIO property for this? Seems OK to move it to userspace.  
> > 
> > I'm not sure enough of what it means, but we have filter controls in
> > terms of 3db point and oversampling. If you can figure out a match to
> > those or something that seems more generic than the above to propose
> > as new ABI that would be great.  
> 
> Ok let me see what I can do.
> 
> > >   
> > > >     
> > > > > +
> > > > > +  semtech,cs1-prox-threshold:
> > > > > +    allOf:
> > > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > > +      - enum: [2, 4, 6, 8, 12, 16, 20, 24, 28, 32, 40,
> > > > > +               48, 56, 64, 72, 80, 88, 96, 112, 128, 144,
> > > > > +               160, 192, 224, 256, 320, 384, 512, 640,
> > > > > +               768, 1024, 1536]
> > > > > +    default: 12
> > > > > +    description:
> > > > > +      Proximity detection threshold for CS1 sensor.
> > > > > +
> > > > > +  semtech,cs2-prox-threshold:
> > > > > +    allOf:
> > > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > > +      - enum: [2, 4, 6, 8, 12, 16, 20, 24, 28, 32, 40,
> > > > > +               48, 56, 64, 72, 80, 88, 96, 112, 128, 144,
> > > > > +               160, 192, 224, 256, 320, 384, 512, 640,
> > > > > +               768, 1024, 1536]
> > > > > +    default: 12
> > > > > +    description:
> > > > > +      Proximity detection threshold for CS2 sensor.
> > > > > +
> > > > > +  semtech,cs0-body-threshold:
> > > > > +    allOf:
> > > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > > +      - enum: [0, 300, 600, 900, 1200, 1500, 1800, 30000]
> > > > > +    default: 1800
> > > > > +    description:
> > > > > +      Body detection threshold for CS0 (and combined if any) sensor.    
> > > > 
> > > > As before, why DT plus child nodes    
> > > 
> > > How should I differentiate body vs. proximity thresholds in userspace?
> > > Or should I make it /sys/.../events/in_proximity0_thresh_falling_value
> > > vs. /sys/.../events/in_proximity0_thresh_rising_value?  
> > 
> > I'm not sure what they actually are. A problem with IIO that may be relevant
> > is that we have never supported multiple events of the same type for a channel.
> > Unfortunately that is hard to change now as we'd have to redefine the event
> > codes.
> > 
> > It feels like these are potentially a bit smarter however. If they are we
> > could handle them as a different event type.  Or potentially an event
> > on a different channel (arguably they are some result of some sort of
> > processing of more than a simple single value).  There is a patent but I've
> > not read it in detail.  
> 
> Hmm.. ok. It looks like the driver doesn't enable the "smart sensor"
> mode where the body threshold would matter. If I'm reading the datasheet
> properly, the only threshold we need to configure is the proximity one.
> If/when the driver supports the body threshold we can look into adding
> the second threshold. So, let's punt this one? I'll implement a
> threshold for the proximity in userspace via the IIO_EV_TYPE_THRESH.

Great. That makes life easier.

> 
> >   
> > >   
> > > >     
> > > > > +
> > > > > +  semtech,cs1-body-threshold:
> > > > > +    allOf:
> > > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > > +      - enum: [0, 300, 600, 900, 1200, 1500, 1800, 30000]
> > > > > +    default: 12
> > > > > +    description:
> > > > > +      Body detection threshold for CS1 sensor.
> > > > > +
> > > > > +  semtech,cs2-body-threshold:
> > > > > +    allOf:
> > > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > > +      - enum: [0, 300, 600, 900, 1200, 1500, 1800, 30000]
> > > > > +    default: 12
> > > > > +    description:
> > > > > +      Body detection threshold for CS2 sensor.
> > > > > +
> > > > > +  semtech,hysteresis:
> > > > > +    allOf:
> > > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > > +      - enum: [0, 6, 12, 25]
> > > > > +    default: 0
> > > > > +    description:
> > > > > +      The percentage of hysteresis +/- applied to proximity/body samples.    
> > > > 
> > > > Is this hysteresis on an event?  If so we have defined ABI to control that
> > > > from userspace, though as an absolute value rather than a precentage so some
> > > > magic will be needed.  Hysteresis is usually defined only the 'not event'
> > > > direction rather than +/-    
> > > 
> > > Is this IIO_EV_INFO_HYSTERESIS? It looks like it is applied to the
> > > threshold by shifting it right by 4, 3, or 2. I think the +/- is
> > > actually dependent on the RegProxCtrl10 bit 6 FARCOND value, so maybe
> > > that isn't a problem. We could make another value like hysteresis shift
> > > or hysteresis percentage?  
> > 
> > I'd rather avoid extra ABI if we can make it work as it stands, even if it
> > is a little involved to do so.  Extra ABI just means we end up with more
> > incompatible userspace code over time.  
> 
> Alright. I will attempt to make this work with the
> IIO_EV_INFO_HYSTERESIS knob.
Great
> 
> >   
> > >   
> > > >     
> > > > > +
> > > > > +  semtech,close-debounce-samples:
> > > > > +    allOf:
> > > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > > +      - enum: [0, 2, 4, 8]
> > > > > +    default: 0
> > > > > +    description:
> > > > > +      The number of close samples debounced for proximity/body thresholds.    
> > > > 
> > > > This feels like something that has more to do with the object motion than
> > > > the sensor setup, so perhaps should be controlled from userspace?    
> > > 
> > > Sure. Is there an IIO sample property? Or I should make a custom
> > > knob for this?  
> > 
> > It's kind of close to in_proximity0_thresh_period and that may be how they
> > have implemented it.
> > 
> > That control specifies a number of samples for which a condition should be true
> > before it is reported.  
> 
> Sounds good. I can do that. It looks like the driver reports close/far
> via an event and these debounce values are the same for me so I can
> write both fields (close and far) with the same thresh_period value from
> userspace. If they need to be different between the two then this can be
> reevaluated?

Not totally sure I followed that, but sounds fine.
If close and far are different events, you can have a separate
controls.

Jonathan


> 
> >   
> > >   
> > > >     
> > > > > +
> > > > > +  semtech,far-debounce-samples:
> > > > > +    allOf:
> > > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > > +      - enum: [0, 2, 4, 8]
> > > > > +    default: 0
> > > > > +    description:
> > > > > +      The number of far samples debounced for proximity/body thresholds.
> > > > > +
> > > > >  required:
> > > > >    - compatible  

