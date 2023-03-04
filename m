Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 352416AAC68
	for <lists+linux-iio@lfdr.de>; Sat,  4 Mar 2023 21:26:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjCDU00 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Mar 2023 15:26:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjCDU0Z (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2023 15:26:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDF11ADCC
        for <linux-iio@vger.kernel.org>; Sat,  4 Mar 2023 12:26:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4F3060A6E
        for <linux-iio@vger.kernel.org>; Sat,  4 Mar 2023 20:26:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44FBEC433D2;
        Sat,  4 Mar 2023 20:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677961583;
        bh=ZHkUA3d/JaqDwMS04dc0u/JDSuKeIt1BbTMxFLhM/gc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=rEnLzlisJazoyTN4+tf7mEAzcwzHrgnd5uqpBOJOOBAK+9mDZ8h/ywfZehTN6rSbM
         8GLjVhDONx4h8722uJa3rq7G5q8w9SVnVB4HzTXPSAxF+jFK2SNRELt0i0i5xi/X7B
         iVPxdeLJlg75xG1Z4cTweAqoW0VgOPMZTyXvOYVffHTiGsMWYo7J0yo8FE8C2VgMq9
         F3KnCWWtoOdP8jwEGueh5uM5GnKV02iDG/WnFx9Euc0BKpPRQKTytaunnrxM5bMNuq
         YR/Col7177abqfEBKv9cFh0dQAhyHc7oV116ALYpdDyX7en5PKCHO4aK6KbsUqOnvn
         jyN3/ah12jIqA==
Date:   Sat, 4 Mar 2023 20:26:19 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>
Subject: Re: [low prio, just pondering] About the light sensor "sensitivity
 area"
Message-ID: <20230304202619.7ea219a7@jic23-huawei>
In-Reply-To: <71d17152-ad12-1465-2a5d-4dbe98057ca3@gmail.com>
References: <65c7c45a-c953-e418-f640-9e46841151a1@gmail.com>
        <20230130130231.000013b6@Huawei.com>
        <baec476f-c72e-23d7-76b1-4e5062173226@fi.rohmeurope.com>
        <20230202165714.0a1c37ac@jic23-huawei>
        <11722ea9-7149-0305-5593-7a66dc1d73f0@fi.rohmeurope.com>
        <71d17152-ad12-1465-2a5d-4dbe98057ca3@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
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

On Sat, 25 Feb 2023 11:35:14 +0200
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 2/6/23 16:34, Vaittinen, Matti wrote:
> > On 2/2/23 18:57, Jonathan Cameron wrote:  
> >> On Tue, 31 Jan 2023 09:31:53 +0000
> >> "Vaittinen, Matti" <Matti.Vaittinen@fi.rohmeurope.com> wrote:
> >>  
> >>> On 1/30/23 15:02, Jonathan Cameron wrote:  
> >>>> On Mon, 30 Jan 2023 14:04:53 +0200
> >>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:  
> >>>
> >>> As a side note - I had always thought measuring the light is just simple
> >>> value reading from a sensor. I never regarded the fact that human eye
> >>> sees only certain wavelengths or that the sensors sensitivity changes
> >>> depending on the wavelength. It's funny how I always end up knowing less
> >>> when I know more ;)  
> >>
> >> Light sensors are a pain in many ways!  We've had a few datasheets over the
> >> years that have insisted that the color channels have well specified units
> >> despite there being no such definition that I'm aware of (and no means
> >> to define one for cheap sensors. What is standard Red? :))  All the
> >> illuminance values are just approximations to the official curve.
> >>
> >> Sometime in the past we debated trying to describe the curves, but it's
> >> hard to do as they aren't nice shapes (so 3DB points don't make much
> >> sense).  
> 
> This is a low-priority mail with just some very initial pondering. Feel 
> free to skip this if you're in a hurry.
> 
> I guess the problem of telling what the sensor values represent for 
> sensors where the sensitivity is a poor match to a colour has been 
> dwelling in the background :)
> 
> I don't have any long experience on these devices so I have seen only 
> couple of the light sensor data-sheets, and mostly just for ROHM 
> sensors. Maybe this is the reason why the common thing I have seen in 
> these data-sheets representing the sensitivity to wave lengths has been 
> a "spectral response" curve. All of the data-sheets have represented a 
> curve where "sensor responsivity" is in the Y-Axis and wave length at 
> the X-axis. And yes, in many cases this curve (especially for a CLEAR 
> light) is of arbitrary shape for example like this:

That is indeed typical info to find on a datasheet though IIRC the
y axis meaning varies a bit (log values sometimes for example)

> 
> 
> 
> 
> S                                           ***
> e                                      *       *
> n                                  *            *
> s                        **       *             *
> i                   *       **   *               *
> t                *             *                  *
> i              *                                  *
> v             *                                    *
> i         **                                       *
> t      *                                           *
> y    *                                             *
>     *                                                ***
>    *                                                     ******
>   *                                                            *
>   *                                                            *
> 400		500		600		700		800nm
>                 W a v e l e n g h t
> 
> 
> Having this in mind it seems to be impossible to have just one or a few 
> categories of sensitivity, or to describe it accurately by just some 
> "peak-sensitivity" wave-lenght and a value representing "width of the 
> curve".
> 
> So, maybe we should abandon the idea of having a great categorization / 
> abstraction in-driver or IIO framework (other than the R,G,B,C,IR,UV - 

Can't abandon them in general as ABI we need to carry on supporting and
in many cases that's enough info for the application.  Can expand beyond
them though.

> which works fine for some sensors). What I could think of is providing a 
> set of 'data points' representing the sensitivity curves. Say, we had 
> in_sensitivity_wavelength_calibpoints and 
> in_sensitivity_wavelength_num_calibpoints (or what ever could fit for 
> the IIO naming scheme) - where user could get sensor provided datapoints 
> that represent the sensitivity as a function of wavelength. Userland 
> could then decide the best curve fitting for the data-points and compute 
> the sensitivity according to the best available algorithms. I think this 
> kind of curve-fitting-to-datapoints is quite standard stuff in the 
> user-space these days - but it feels like an overwhelming task in the 
> kernel land/drivers...

A more general approach would be to mandate the curve fitting then require
drivers to provide sufficient values that the approximation is within
X percent of the value from the datasheet.

Otherwise it becomes a question of what wavelengths to use.
> 
> This all is just some pondering. I do not have a proper use-case for 
> this kind of a sensitivity curve data as I work for a component vendor 
> instead of doing actual systems utilizing these components :/ It's 
> actually a little sad as I seem to keep thinking what kind of a device I 
> could build using these components - just to end up noticing that I am 
> not in a position where I was building these devices :p (You wouldn't 
> believe how cool imaginary clocking device for driving a camera clock 
> with light sensor detecting flickering I just designed in my head the 
> other night XD).

They are fun. I'll admit my main experience of these has come with devices
that 'happen to have them' rather than ever having designed them into
anything (and last actual board design I got involved in was many years
ago).

> 
> Well, I still hope I can help creating device driver/framework stuff 
> people can use to build devices - in the end of the day it will also 
> benefit the component vendor as the components are typically used in 
> these devices ;)
> 
> Oh. Got carried away. Anyways, have you considered just offering an 
> entry with sensitivity data-points instead of offering wavelength and 
> 3DB-limits? Do you think that could be useful?

As you've noted, 3DB doesn't work for this, but I think remains
useful for time domain filters. 

I think it would potentially be useful to have better data, but what
we really need is a user to tell use what they need.

Until that happens we may well be either over or under designing
the solution.

Jonathan
 
> 
> Yours,
> 	-- Matti
> 

