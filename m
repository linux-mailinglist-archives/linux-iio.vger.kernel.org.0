Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E9956884B4
	for <lists+linux-iio@lfdr.de>; Thu,  2 Feb 2023 17:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjBBQnT (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 2 Feb 2023 11:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbjBBQnS (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 2 Feb 2023 11:43:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65F184B487
        for <linux-iio@vger.kernel.org>; Thu,  2 Feb 2023 08:43:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DB4A361BF7
        for <linux-iio@vger.kernel.org>; Thu,  2 Feb 2023 16:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78D59C433D2;
        Thu,  2 Feb 2023 16:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675356196;
        bh=KGwWh7tF7QRODfu8QdyVBiK1yseXB/UdOmLb7Z135jw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=X6HlApJ9ZICC9DXc0NFsAqYIkDBaMcGcfeeFcaH6RhY3msd53pveftJ4sYDGZ4O8q
         SWcjyWKQQSFxHTrSSPZ1pSjQnoOqgghDrsv2VXpTy6YcaRMRaRoA5kdoIPa7Zxpp6i
         HfaJH26O+ZAjDOmGfEMLdtBY+iMPIYIg2S3TSUdZN3GsF5puBkUQfLY618m2NdyrnH
         CeRbr9+i/y/NdwHbAutIgERuLQlh31mzBSN0xBdMSwPliae9fMUfusn7jAEGDszZHV
         DSCvzGKG1XJqPU039CjpBqn0WAewITJF8FTR2MJyPglxlmUxpk+2386bd8LsefHioZ
         19T58lB6MowJg==
Date:   Thu, 2 Feb 2023 16:57:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: ROHM ALS, integration time
Message-ID: <20230202165714.0a1c37ac@jic23-huawei>
In-Reply-To: <baec476f-c72e-23d7-76b1-4e5062173226@fi.rohmeurope.com>
References: <65c7c45a-c953-e418-f640-9e46841151a1@gmail.com>
        <20230130130231.000013b6@Huawei.com>
        <baec476f-c72e-23d7-76b1-4e5062173226@fi.rohmeurope.com>
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

On Tue, 31 Jan 2023 09:31:53 +0000
"Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:

> On 1/30/23 15:02, Jonathan Cameron wrote:
> > On Mon, 30 Jan 2023 14:04:53 +0200
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:  
> 
> >> However, the values
> >> spilled from raw IIO_INTENSITY channels will change when integration
> >> time is changed. So, should I use the info_mask_shared_by_type =
> >> BIT(IIO_CHAN_INFO_INT_TIME) for IIO_INTENSITY channels?  
> > 
> > Ah. This problem. The mixture of two things that effectively map to scaling
> > of raw channels. As _scale must be applied by userspace to the _raw channel
> > that has to reflect both the result of integration time and a front end amplifier
> > and is the control typical userspace expects to use to vary the sensitivity.
> > 
> > That makes it messy because it's not always totally obvious whether, when
> > trying to increase sensitivity, it is better to increase sample time or gain.
> > Usually you do sample time first as that tends to reduce noise and for light
> > sensors we rarely need particular quick answers.
> > 
> > So in the interests of keeping things easy to understand for userspace code
> > you would need to provide writeable _scale that then attempts to find the
> > best combination of amplifier gain and sampling time.  
> 
> There is (at least) one more thing which I just noticed when I continued 
> writing the code.
> 
> Changing the integration time impacts all intensity channels. 

Oh yuck. 

> So, scale 
> will be adjusted for all channels when a request to set scale for one 
> channel causes integration time to change. (Gain on the other hand is 
> adjustable separately for each channel.) Do you think a typical 
> user-space application can cope with this?

Sensor is slow anyway, so how about updating it before a read
if the value is different from requested for the current channel?

> 
> I am unsure if I should just use the biggest integration time (400mS) by 
> default and only decrease this when very small amplification is 
> requested by setting scale > 1. TBH, I don't like this. It prevents 
> having shorter measurement times with gains greater than 1x - and I 
> believe that users may want to have higher gains also in cases where 
> they wish quicker measurements from the sensor.

Possibly shorter times might be desired, though uncommon for people
to care a lot about read speed on a light sensor.  Light levels
usually change slowly (assuming no one is doing anything exciting
with the sensor)

> 
> Some other options I am considering:
> 1. Skip time config for now - easiest but does not give full usability

Not great - for same reason as below (saturation)

> 2. Allow setting the time via devicetree at probe time - slightly better 
> but not very dynamic.

Don't do that one.  Usual reason to want to set this stuff is to avoid
saturation of the sensor.

> 3. Custom device-specific sysfs file for setting the time so 
> specifically tailored userland apps have access to it - adding new ABI 
> for this is probably not something we prefer ;)

Indeed - new ABI is normally unused ABI.

> 4. Allow setting the integration time in situations where the driver can 
> internally hide the scale change by changing the gain as well - this 
> operation is not atomic in the HW and adds some extra complexity to the 
> driver. Also, this fails for configurations where the gain setting is 
> such it can't compensate the scale change.

So we have had a few examples that might apply here (can't remember if
any of them actually got implemented).

My aim would be to have the normal ABI do the right thing, but...
If we were to provide extra ABI that allows switching out of a default
mode then we can assume the code using it knows what it is doing.

So maybe something like

auto_integration_time_from_scale that defaults to 1/true.
When 0/false,
integration_time becomes writeable.  If you write integration time
it would then affect scale appropriately and any change to scale
would be clamped within whatever range is possible for the integration
time provided.

If you want to write an auto tuning routine you could do that and mostly
avoid the problem.
We have a few drivers doing that IIRC.  The only signal userspace
normally cares about is illuminance and hopefully the calculations
take the different settings into account.  I never much liked
the cases we have of this but there are a few e.g. gp2ap020a00f
In my view that should be a userspace problem as the algorithms to
tune this could be quite complex.

> 
> I would be grateful for any suggestions :)
> 
> Finally, the BU27034 allows pretty big gains - from 1x to 4096x. After a 
> quick look in existing light sensor drivers - I think the available 
> scales for IIO_INTENSITY channels are usually from 1.0 downwards. ("1.0 
> 0.xxx 0.yyy 0.zzz"). 4096x (or 32768x if we take the max measurement 
> time into account) will cause some loss of accuracy even with NANO scale 
> if we use scale range starting from 1.0. 

*sigh* someone implemented an insane gain because they happened to be able
to. I'd imagine that adds so much noise to be effectively pointless.
That dynamic range seems unlikely to be of much practical use.


> Is there anything that prevents 
> starting the available scales for example from 16.0 ending 976562.5 
> NANOs (to decrease loss of precision assuming both the full gain range 
> and all timing values [except the 5 mS] are supported)?

That's fine.  Intensity is defined as unit free (because there are no
sensible units) so no code should be making any assumptions.

> At least I 
> didn't see any limitations in the sysfs-bus-iio ;) My guess is the 
> userspace usually handles the integer portion of scale just fine(?)

It definitely should! There are other types of device where gains
tend to be much greater than 1

> 
> Oh, by the way - I found a publicly available data-sheet for the ALS 
> sensor I am working with. :)
> 
> https://fscdn.rohm.com/en/products/databook/datasheet/ic/sensor/light/bu27034nuc-e.pdf
> 
> Seems like no public datasheet for the other sensors I mentioned though :(
> 
> As a side note - I had always thought measuring the light is just simple 
> value reading from a sensor. I never regarded the fact that human eye 
> sees only certain wavelengths or that the sensors sensitivity changes 
> depending on the wavelength. It's funny how I always end up knowing less 
> when I know more ;)

Light sensors are a pain in many ways!  We've had a few datasheets over the
years that have insisted that the color channels have well specified units
despite there being no such definition that I'm aware of (and no means
to define one for cheap sensors. What is standard Red? :))  All the
illuminance values are just approximations to the official curve.

Sometime in the past we debated trying to describe the curves, but it's
hard to do as they aren't nice shapes (so 3DB points don't make much
sense).

> 
> Yours,
> 	-- Matti
> 

