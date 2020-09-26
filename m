Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80CAF279A77
	for <lists+linux-iio@lfdr.de>; Sat, 26 Sep 2020 17:51:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729699AbgIZPuz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 26 Sep 2020 11:50:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZPuz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 26 Sep 2020 11:50:55 -0400
Received: from archlinux (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B57921527;
        Sat, 26 Sep 2020 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601135454;
        bh=GGtbW08iYAq3dABsTkR+q7Zn9zvQs0mSLsGbG143KTA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mlMKeKWS77x59uv+Q8kZFNjrcFWFIx4wMaYxcVRi/YzzyLIzuGO/ZcxQMcw2rNfzO
         O46ctp9zUiKfPxaB3cwoJ/xRvLW/7kvjD6K2iFKe2wAZUCFPKoRBCTqfKK0dYDF69O
         esBfWLKj6mohFvfolRE6navNwjxCOuTFdYRpoAvk=
Date:   Sat, 26 Sep 2020 16:50:49 +0100
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
Message-ID: <20200926165049.4c314816@archlinux>
In-Reply-To: <160108304513.310579.9483266115343530431@swboyd.mtv.corp.google.com>
References: <20200903221828.3657250-1-swboyd@chromium.org>
        <20200906150247.3aaef3a3@archlinux>
        <159963232334.454335.9794130058200265122@swboyd.mtv.corp.google.com>
        <20200909121550.00005ede@Huawei.com>
        <160108304513.310579.9483266115343530431@swboyd.mtv.corp.google.com>
X-Mailer: Claws Mail 3.17.6 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 25 Sep 2020 18:17:25 -0700
Stephen Boyd <swboyd@chromium.org> wrote:

> Sorry this thread is deep! Good news is I have moved the proximity
> thresholds, hysteresis, hardware gain, and debounce to userspace. Now
> just to figure out this filter strength.

:) They get a lot deeper sometimes!

> 
> Quoting Jonathan Cameron (2020-09-09 04:15:50)
> > On Tue, 8 Sep 2020 23:18:43 -0700
> > Stephen Boyd <swboyd@chromium.org> wrote:
> >   
> > > Quoting Jonathan Cameron (2020-09-06 07:02:47)  
> >   
> > >   
> > > >     
> > > > > +
> > > > > +  semtech,proxraw-strength:
> > > > > +    allOf:
> > > > > +      - $ref: /schemas/types.yaml#definitions/uint32
> > > > > +      - enum: [0, 2, 4, 8]
> > > > > +    default: 2
> > > > > +    description:
> > > > > +      PROXRAW filter strength. A value of 0 represents off, and other values
> > > > > +      represent 1-1/N.    
> > > > 
> > > > Having looked at the datasheet I have little or now idea of what this filter
> > > > actually is.  However, what is the argument for it being in DT rather than
> > > > exposing a userspace control of some type.    
> > > 
> > > I only see this equation in the datasheet
> > > 
> > > F(PROXRAW ; PROXUSEFUL[n-1] ; RAWFILT) = (1 - RAWFILT).PROXRAW + RAWFILT.PROXUSEFUL[n-1] 
> > > 
> > > and it's talking about updating PROXUSEFUL. "PROXUSEFUL update consists
> > > of filtering PROXRAW upfront to remove its high frequencies components".
> > > So presumably this filter is used to make proxraw into proxuseful so
> > > that it is a meaningful number. Is this a new knob in userspace?  
> > 
> > It might fit with the various filter definitions, but there is so little info
> > it is hard to map it across.   Perhaps DT is the best we can do here even
> > though it would ideally be controlled from userspace.
> >   
> 
> Ok I read the datasheet a couple more times :)
> 
> This sensor seems to have multiple levels of processing on the signal.
> First the raw signal is there as PROXRAW. That gets turned into
> PROXUSEFUL with this calculation:
> 
>  F(PROXRAW ; PROXUSEFUL[n-1] ; RAWFILT) = (1 - RAWFILT) * PROXRAW + RAWFILT * PROXUSEFUL[n-1]
> 
> This semtech,proxraw-strength property is trying to set that RAWFILT
> variable to something like 2, 4, or 8. Or 0 for "off". Is that in terms
> of 3db?

Don't think so.  Looks like a very short IIR filter.
https://zipcpu.com/dsp/2017/08/19/simple-filter.html looks like it
has a good basic explanation.  To get the 3db point you'd need to
plot a graph like Fig 2 on there and read off the point 

http://www.dspguide.com/ch19/2.htm provides some relevant maths for
working out the value of RAW_FILT (which is probably 1/2, 1/4, 1/8?)
if we wanted a low pass filter with a particular cut off.
If f_c is in samples and I haven't made a silly error...

1/RAWFILT = e^(-2pi*f_c)

We want fc for each value of raw filt.

ln(1/RAWFILT) = -2pi*f_c
fc = -1/(2pi) * ln(1/RAWFILT)

Next problem is that IIO filter 3db point is in Hz, not samples.
So if we have fixed sampling rate we'll need to take that into
account.  The filter 3db point will need to change with that
sampling rate.

> A bigger question, does the useful value need to be a different
> channel so it can be configured from userspace? We don't get an
> interrupt when this changes but at least the value can be read out of
> the hardware from what I can tell.

Yes, it will have to be a separate value if we are exposing both
PROXRAW and PROXUSEFUL. 

> 
> The PROXUSEFUL value is turned into PROXAVG. There is a positive filter
> strength and a negative filter strength that is used to filter the
> PROXAVG value. I need to set the positive filter strength to be
> different than the default. That's what I'm trying to do with
> semtech,avg-pos-strength. It factors into this equation for PROXUSEFUL:
> 
> if (PROXUSEFUL - PROXAVG[n-1] >= 0)
>   F(PROXUSEFUL ; PROXAVG[n-1] ; AVGPOSFILT) = (1 - AVGPOSFILT) * PROXUSEFUL + AVGPOSFILT * PROXAVG[n-1] 
> else
>   F(PROXUSEFUL ; PROXAVG[n-1] ; AVGNEGFILT) = (1 - AVGNEGFILT) * PROXUSEFUL + AVGNEGFILT * PROXAVG[n-1] 

Gah. Whoever designed this was doing some nasty adhoc DSP hacks.
That is a second low pass IIR filter with a different parameter.

It's been 20 years since I learnt this stuff, so I'm going to sigh at this
point and stop doing the maths (z transform fun..)

It's probably a more complex IIR filter but beyond that...

> 
> so depending on how the historical average value is going we filter
> differently. Again, is this in 3db? This register has a setting of
> "infinite" which I guess is used to make the above equation come out to
> be just PROXAVG[n - 1]? Otherwise 0 is "off" which seems to make the
> above equation boil down to:
> 
>   PROXAVG = PROXUSEFUL
> 
> when you do substitution.
> 
> I agree it looks like some sort of filter, so maybe I need to introduce
> some proximity.*filter ABI? I don't know the units though.

A control with no strict definition becomes a unitless wiggle dial.
Not actually possible to set other than by guessing and see if it works.

> 
> To complete the story, the PROXAVG value gets compared to a threshold
> AVGTHRESH (settable in a register) and that can be debounced with
> another register setting (AVGDEB). That results in PROXUSEFUL which goes
> into this PROXDIFF equation:
> 
>  PROXDIFF = (PROXUSEFUL - PROXAVG) >> 4
> 
> The PROXDIFF value is compared to the proximity threshold register
> setting (PROXTHRESH, i.e. bits 3:7 in register RegProxCtrl8/9) plus or
> minus the hysteresis (RegProxCtrl10 bits 5:4) and then debounced
> (RegProxCtrl10 bits 3:2 (for close) and 1:0 (for far)).
> 
> if (PROXDIFF > PROXTHRESH + HYST)
>   // close event, i.e. DIR_FALLING
>   PROXSTAT = debounce() ? 1 : 0;
> else if (PROXDIFF < PROXTHRESH - HYST)
>   // far event, i.e. DIR_RISING
>   PROXSTAT = debounce() ? 0 : 1;
> 
> If that all passes then PROXSTAT is set to 1 for the close condition and
> 0 for the far condition. An irq is raised and eventually this driver
> will signal a new event indicating rising or falling.
> 
> I see that the driver implements sx9310_read_prox_data() as a read on
> the PROXDIFF value. That looks good for reading the processed signal for
> a channel after all that raw/avg/useful debouncing and filtering.

So, the controls IIO exposes rely on 3dB being enough to give the user some
sort of reasonable control over what filtering is done.  Sometimes we
get a part that does a bunch of filters like this one doesn't come
with plots of the filter responses...  In those cases it is almost impossible
to present anything to a user that they can figure out. 

So maybe best plan is just to give up and put them as controls in DT that
basically say see datasheet?

Horrible, but alternative is to do the maths and see if you can come
up with a control that has real meaning to a user.

Jonathan
