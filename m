Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4B76BFBAC
	for <lists+linux-iio@lfdr.de>; Sat, 18 Mar 2023 17:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbjCRQy3 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 18 Mar 2023 12:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjCRQy2 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 18 Mar 2023 12:54:28 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7786131E08
        for <linux-iio@vger.kernel.org>; Sat, 18 Mar 2023 09:54:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 89784B80861
        for <linux-iio@vger.kernel.org>; Sat, 18 Mar 2023 16:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5C7C433D2;
        Sat, 18 Mar 2023 16:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679158463;
        bh=YO2hGTbkGoctlaNBa7ZEcCznBjGW+EGVLQ8Sa/4hJRk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=hY2ibdpzJR7whgo8xrY26HARvD5liigT/GTuBtkWFFqbuTUzve8UH5pY+s3FxFTsf
         uMzu/VFTu8MA/4OWyo63o0TF+kFJSCF40cuCRDT23fb2yXzQ9Ro3NpRHYLA6Sqk0vQ
         3sgkJ7DFrveloLHxHEtHjThkaxe9B7ZMiQZV/BTlG3ZtRv27m3VsI+tEZdKu8Q/6hK
         E1NCddb8dHNeOeiKIbrUQtWYTzHFDuRMWHOBavsg6bVLyjm0mzDmjorcydlSCmKXUN
         4aGCOnLFWedj3BON6dDctXK4eqOyTlP3DdjOm7zNOa7Es1gLvRgK9nLx5CHlf7/nvq
         qHvSgs3qjwvRg==
Date:   Sat, 18 Mar 2023 17:09:17 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Andres Heinloo <andres@gfz-potsdam.de>
Cc:     Eddie James <eajames@linux.ibm.com>, linux-iio@vger.kernel.org
Subject: Re: Bugs in dps310 Linux driver
Message-ID: <20230318170917.4a00a07c@jic23-huawei>
In-Reply-To: <45414cf9-4ba2-86ff-e040-4e0b762efdf1@gfz-potsdam.de>
References: <web-1200302@cgp-be2-mgmt.gfz-potsdam.de>
        <20230304170620.795f4d99@jic23-huawei>
        <web-1201064@cgp-be2-mgmt.gfz-potsdam.de>
        <web-1202839@cgp-be2-mgmt.gfz-potsdam.de>
        <20230312154348.257ddf87@jic23-huawei>
        <45414cf9-4ba2-86ff-e040-4e0b762efdf1@gfz-potsdam.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 13 Mar 2023 17:36:00 +0100
Andres Heinloo <andres@gfz-potsdam.de> wrote:

> On 3/12/23 16:43, Jonathan Cameron wrote:
> > On Mon, 06 Mar 2023 22:15:15 +0100
> > "Andres Heinloo" <andres@gfz-potsdam.de> wrote:
> >   
> >> On Sun, 05 Mar 2023 03:05:01 +0100
> >>    "Andres Heinloo" <andres@gfz-potsdam.de> wrote:  
> >>> On Sat, 4 Mar 2023 17:06:20 +0000
> >>>   Jonathan Cameron <jic23@kernel.org> wrote:  
> >>>> On Fri, 03 Mar 2023 12:10:00 +0100
> >>>> "Andres Heinloo" <andres@gfz-potsdam.de> wrote:
> >>>>      
> >>>>> Hello,
> >>>>>
> >>>>> I've been struggling with the dps310 driver, which gives incorrect
> >>>>> pressure values and in particular different values than manufacturers
> >>>>> code (https://github.com/Infineon/RaspberryPi_DPS).
> >>>>>
> >>>>> I think I've found where the problem is. Firstly, there is a mistake
> >>>>> in bit numbering at
> >>>>> https://github.com/torvalds/linux/blob/857f1268a591147f7be7509f249dbb3aba6fc65c/drivers/iio/pressure/dps310.c#L51
> >>>>>
> >>>>> According to datasheet, correct is:
> >>>>>
> >>>>> #define  DPS310_INT_HL          BIT(7)
> >>>>> #define  DPS310_TMP_SHIFT_EN    BIT(3)
> >>>>> #define  DPS310_PRS_SHIFT_EN    BIT(2)
> >>>>> #define  DPS310_FIFO_EN         BIT(1)
> >>>>> #define  DPS310_SPI_EN          BIT(0)
> >>>>>
> >>>>> Eg., the current code is using wrong bit (4) for
> >>>>> DPS310_PRS_SHIFT_EN, which means that pressure shift is never
> >>>>> enabled.  
> >>>>
> >>>> Checking the datasheet, seems like you are right.
> >>>> https://www.infineon.com/dgdl/Infineon-DPS310-DataSheet-v01_02-EN.pdf?fileId=5546d462576f34750157750826c42242
> >>>> Section 7:
> >>>> Though that's not the only bit that is wrong.  Looks like FIFO
> >>>> enable is as well.
> >>>> So any fix should deal with that as well.  
> >>>
> >>> Yes, DPS310_PRS_SHIFT_EN, DPS310_FIFO_EN, DPS310_SPI_EN are all
> >>> wrong, but the latter 2 are not used by the driver.
> >>>
> >>>      
> >>>> The differences between the register map and the datasheet I'm
> >>>> looking at make
> >>>> me think that perhaps the driver was developed against a prototype
> >>>> part.
> >>>> The registers are in a different order for starters with the B0, B1
> >>>> and B2
> >>>> sets in reverse order.  Any fix patch should tidy that up as well.  
> >>>
> >>> Yes, but that's just different naming. MSB is called B2 in the
> >>> datasheet and B0 in the driver.
> >>>
> >>>      
> >>>>> Secondly, there is a problem with overflows starting at
> >>>>> https://github.com/torvalds/linux/blob/857f1268a591147f7be7509f249dbb3aba6fc65c/drivers/iio/pressure/dps310.c#L654
> >>>>>
> >>>>> Since p is a 24-bit value,
> >>>>>
> >>>>> nums[3] = p * p * p * (s64)data->c30;
> >>>>>
> >>>>> can and does overflow.  
> >>>>
> >>>> Makes sense, though I can't immediately see a good solution as we
> >>>> need
> >>>> to maintain the remainder part.  
> >>>
> >>> I don't have a good solution either, but there must be other IIO
> >>> sensors that have something similar that could be possibly reused.
> >>>
> >>>      
> >>>>> Second overflow problem is at
> >>>>> https://github.com/torvalds/linux/blob/857f1268a591147f7be7509f249dbb3aba6fc65c/drivers/iio/pressure/dps310.c#L684
> >>>>>
> >>>>> In fact, I don't understand why 1000000000LL is needed. Since only 7
> >>>>> values are summed, using 10LL should give the same precision.  
> >>>> Whilst the existing  value seems large - I'm not great with
> >>>> precision calcs so could
> >>>> you lay out why 10LL is sufficient?  
> >>>
> >>> Unless I overlooked something, the error of integer division (eg.,
> >>> discarding fractional part) is <1. In this case, the results of 7
> >>> integer divisions are summed, so the error is <7. When multiplying
> >>> numerators by 10LL, the error would be <0.7. Which is OK, since we
> >>> are interested only in the integer part.  
> >>
> >> Unfortunately it seems that there may be more problems with the
> >> driver. I've noticed that my device has lost sample rate and precision
> >> settings few times. When looking at the code, it seems the settings
> >> are not restored when dps310_reset_reinit() is called at
> >> https://github.com/torvalds/linux/blob/8ca09d5fa3549d142c2080a72a4c70ce389163cd/drivers/iio/pressure/dps310.c#L438
> >>  
> > 
> > Agreed. Looks like that stuff is missing.  This reset path is pretty horrible
> > in general, so I'm not surprised a few things got missed. Should be easy enough
> > to add a cache of those and and set them again if you want to try that.  
> 
> One option would be adding sample_rate and oversampling_ratio to 
> dps310_data struct, but some questions remain.

That's what I'd do here.

> 
> I think doing a silent reset is not good, because it can cause bad 
> samples. When looking at data, you don't know if there was an actual 
> pressure spike or if it was caused by a reset. I think a better solution 
> would be immediately returning an error (-EIO?) to inform user space 
> about an intermittent failure.

Userspace may well not retry because for vast majority of devices a failure
like this indicates something went very wrong (or bad hardware). So it might
well just log the error somewhere and quit.  Here we have a device that as
I understand it has a reasonably frequent lock up condition so we kind of
need to paper over that in the kernel to present what userspace expects.

A rate limited print to the kernel log might be a good idea though so
at least there is some record of it happening.

> 
> (I suspect that in case of some errors, the IIO subsystem retries 
> internally and hides the error.)

I can't immediately think of a path were the subsystem does retries.
Tend to just pass them up to userspace.

> 
> The purpose of timeout_recovery_failed seems questionable, because if 
> you end up with timeout_recovery_failed == true, the only way to recover 
> from timeout is reloading the kernel module.

In theory if that happens we've concluded the device is dead. So expected
fix is reset the board.  The fact it recovers after some other sequence
means the work around isn't working.

> 
> I'm afraid I'm not able to provide a patch to fix the problems soon.

Understood, we may have to wait on someone with hardware who has the time.
The wrong bit definitions are easier so maybe we can fix those up.

> 
> 
> >> Apparently I've also ended up with data->timeout_recovery_failed ==
> >> true at
> >> https://github.com/torvalds/linux/blob/8ca09d5fa3549d142c2080a72a4c70ce389163cd/drivers/iio/pressure/dps310.c#L443,
> >> but the device worked fine after just reloading the kernel module.
> >> This is difficult to reproduce, though.  
> > 
> > Hmm. There are a few things that could cause that.  Maybe something running slow, or
> > an intermittent write failure (noisy environment or bad wire / track maybe?)  
> 
> (Off-topic) Write failures is a different problem that is very annoying. 
> I'm not sure if this could be the case with dps310, but I have an 
> ADXL355 device that is connected via SPI and often register writes fail 
> silently. I have a short cable that is well connected and SPI should be 
> running at max 1Mhz according to .../of_node/spi-max-frequency. I ended 
> up wrapping regmap functions to check register value after each write. I 
> haven't noticed errors when reading registers. (I'm using Raspberry Pi.)

Some of these sensors are very sensitive.  I have one or two that basically
don't work over cables (including one that only works if I attach an oscilloscope
with a long test lead...)

You could perhaps propose an addition to regmap to verify a write so that
at least we know it failed.

Jonathan

> 
> Andres

