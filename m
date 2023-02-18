Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E19969BB25
	for <lists+linux-iio@lfdr.de>; Sat, 18 Feb 2023 18:06:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229478AbjBRRGh (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Feb 2023 12:06:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229740AbjBRRGg (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Feb 2023 12:06:36 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A3201715B
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 09:06:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1614360B9F
        for <linux-iio@vger.kernel.org>; Sat, 18 Feb 2023 17:06:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63766C433D2;
        Sat, 18 Feb 2023 17:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676739993;
        bh=Q3sUT6u74Hr9PXDKf/p4GBcrntaXzxb8AbEPQaFoarQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ntkJb6C9M2eEXkJyeEfz+K7pRc902DgJm1cmO80/uDUfXCzg2dgURUfdKuVWqBwMS
         HYxrxd43gk1eKRzpi0ZIzxMhGpYOotNlvw/on2fb2IVqje0DrmRAjnV4nxzehXMXUW
         TAdkboq/8vkZw57zHtIyGR+1jviPPQ8Vy9P3yGXQQIZCeS7AITAkO6qUe5FYKQEz/u
         0Kdzna8kh4W/dNE9NiUNoIiDg8PfHwfoBMz3DausL7uMzfX1uCiemKYW1a34oDebtd
         fsaCZwcZ0wlP6p9NkpVQtOhFyFskKaVCKpgEtw4BlSm7IiVS7Rez/5+eQMVv5PZubJ
         y7/E1Gc+qxBUw==
Date:   Sat, 18 Feb 2023 17:20:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        "Mutanen, Mikko" <Mikko.Mutanen@fi.rohmeurope.com>
Subject: Re: ROHM ALS, integration time
Message-ID: <20230218172052.12c44aa5@jic23-huawei>
In-Reply-To: <11722ea9-7149-0305-5593-7a66dc1d73f0@fi.rohmeurope.com>
References: <65c7c45a-c953-e418-f640-9e46841151a1@gmail.com>
        <20230130130231.000013b6@Huawei.com>
        <baec476f-c72e-23d7-76b1-4e5062173226@fi.rohmeurope.com>
        <20230202165714.0a1c37ac@jic23-huawei>
        <11722ea9-7149-0305-5593-7a66dc1d73f0@fi.rohmeurope.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

> >> such it can't compensate the scale change.  
> 
> I started with the option 4) and wrote first 100% untested code draft. I 
> don't yet have the hardware at my hands so testing and fine-tuning needs 
> to wait for a while.
> 
> I wonder if I should send out an RFC to explain what I was up-to, or if 
> I should wait for the hardware, do testing and only send out the patches 
> when I believe things work as intended :)
> 
> Sending RFC early-on would perhaps be beneficial for me as it can help 
> me avoid working/finalizing a solution that will not be appreciated ;)
> 
> Yet, sending out and RFC with untested code may result reviewers (who 
> skip the "small print" explaining the code is untested and to be 
> reviewed for a concept only) to do unnecessary work. And in my 
> experience, no letters are large enough that all reviewers didn't skip 
> the resulting "small print" :)

Who would ever do that? *evil laugh*

RFC is fine.  If people spend time reviewing without checking 'why it is
an RFC' it is their own fault.  This is one reason I moan about any RFC
I see without the reasons being clearly called otu.

> 
> > 
> > So we have had a few examples that might apply here (can't remember if
> > any of them actually got implemented).
> > 
> > My aim would be to have the normal ABI do the right thing, but...
> > If we were to provide extra ABI that allows switching out of a default
> > mode then we can assume the code using it knows what it is doing.  
> 
> Hm. Maybe it's because all the virtual waffles and beer (last weekend 
> was FOSDEM weekend - but I was participating only remotely) - but I am 
> not 100% sure I know what you mean by the default mode.

Have the driver do 'best effort' on scaling etc with default being that
it doesn't care about time to take a reading. But have ABI that allows 
an override. Normal user would never use the override but would get something
reasonable.  Advanced user can mess with the settings if they want to.

> 
> > So maybe something like
> > 
> > auto_integration_time_from_scale that defaults to 1/true.
> > When 0/false,
> > integration_time becomes writeable.  If you write integration time
> > it would then affect scale appropriately and any change to scale
> > would be clamped within whatever range is possible for the integration
> > time provided.  
> 
> Hm. Does this mean that writing the integration time would
> 1) Change integration time in HW
> 2) Not change gain in HW
> 3) Change integration time and scale values in sysfs?

Yes. If this magic mode bit was set. 

> 
> My current attempt if to not provide the 'mode' change flag - but 
> provide R/W integration time and R/W scale.

That's best place to start I think.

> 
> Regarding the scale:
> 
> When scale is changed by user, the driver attempts to maintain 
> integration time and perform only the gain change. If requested scale 
> can not be supported by any available gain using the current integration 
> time, then the driver attempts to change both the gain and integration 
> time to achieve requested scale. (If this also fails, then an error is 
> returned).
> 
> I guess this is what is expected to happen in "normal mode".

Interesting. I was actually thinking prefer to change integration time
but your way may make more sense.

> 
> As I mentioned earlier, this does not allow a great control over the 
> integration time for users who (may?) wish to have shorter time with 
> gain bigger than 1x.
> 
> Hence the writeable integration time.
> Now, an user may request different integration time by writing the 
> integration time. I assumed this is also normal operation assuming this 
> does not cause a scale change?

If magic mode write hasn't happened, then integration time should reject
writes. Interface is too complex otherwise because if a user writes the
integration time then the scale, they'll expect that their integration
time has not changed.

If you ever used a film camera, kind of equivalent of switching between
an auto mode where the camera could adjust aperture (gain) and shutter
timing (integration time) to a shutter priority mode in which the 
shutter timing (integration time) remains what you set it to and the
scale can only be adjusted in a fashion that doesn't change it.

> Hence, my current attempt is to 
> compensate the caused scale change by adjusting also gain. It appears to 
> me (based on the equation from my HW colleagues) that the doubled 
> integration time also doubles the reported intensity value. I think this 
> is also expected. For example: Let's assume a case where we originally have
> gain 8x, int-time 400 mS

Yes. That's what I'd expect for a light sensor that was fairly linear.

> 
> user wants to set new int-time 200 mS.
> 
> Halving the measurement time would mean halving the reported intensity 
> values, causeing the scale to change, right? Now, in order to maintain 
> the scale, the driver would be not only dropping the integration time 
> but also internally doubling the gain from 8x to 16x.

yes.

> 
> > 
> > If you want to write an auto tuning routine you could do that and mostly
> > avoid the problem.
> > We have a few drivers doing that IIRC.  
> 
> Hm. Yes, it must be the virtual waffles :) I am unsure what you mean by 
> autotuning. Do you mean increasing the gain/integration time in driver 
> based on the raw-data to ensure values are as accurate as possible w/o 
> being saturated?

yup.  Then return a _processed value that incorporates the autotuned
scale.  If _scale and _integration_time are then provided they are
for info only and not guaranteed to be the values used to grab the reading.

> 
>    The only signal userspace
> > normally cares about is illuminance and hopefully the calculations
> > take the different settings into account.  I never much liked
> > the cases we have of this but there are a few e.g. gp2ap020a00f
> > In my view that should be a userspace problem as the algorithms to
> > tune this could be quite complex.
> >   
> 
> This definitely sounds like a computation better done in user-space to 
> me. I had hard enough time writing a simple lux-calculation in my driver 
> resulting bunch of overflow-checks and do_div()s... Luckily the 
> performance was not a priority.

It's 'fun' but we have had people do it. I never bothered for the light
sensor I wrote a long time back (which got dropped eventually)

> 
> >>
> >> I would be grateful for any suggestions :)
> >>
> >> Finally, the BU27034 allows pretty big gains - from 1x to 4096x. After a
> >> quick look in existing light sensor drivers - I think the available
> >> scales for IIO_INTENSITY channels are usually from 1.0 downwards. ("1.0
> >> 0.xxx 0.yyy 0.zzz"). 4096x (or 32768x if we take the max measurement
> >> time into account) will cause some loss of accuracy even with NANO scale
> >> if we use scale range starting from 1.0.  
> > 
> > *sigh* someone implemented an insane gain because they happened to be able
> > to. I'd imagine that adds so much noise to be effectively pointless.
> > That dynamic range seems unlikely to be of much practical use.  
> 
> I can't say anything to this as I don't have the sensor yet :)
> 
> >>
> >> As a side note - I had always thought measuring the light is just simple
> >> value reading from a sensor. I never regarded the fact that human eye
> >> sees only certain wavelengths or that the sensors sensitivity changes
> >> depending on the wavelength. It's funny how I always end up knowing less
> >> when I know more ;)  
> > 
> > Light sensors are a pain in many ways!  We've had a few datasheets over the
> > years that have insisted that the color channels have well specified units
> > despite there being no such definition that I'm aware of (and no means
> > to define one for cheap sensors. What is standard Red? :))  All the
> > illuminance values are just approximations to the official curve.
> > 
> > Sometime in the past we debated trying to describe the curves, but it's
> > hard to do as they aren't nice shapes (so 3DB points don't make much
> > sense).  
> 
> This is easy to agree after only a very brief look on the topic :)

One of those areas of technology where things aren't easily controlled or
well behaved!

J
> 
> Yours,
> -- Matti
> 

