Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0C56B679A
	for <lists+linux-iio@lfdr.de>; Sun, 12 Mar 2023 16:43:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjCLPnr (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Mar 2023 11:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjCLPnr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Mar 2023 11:43:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F76125B94
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 08:43:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB282B80B50
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 15:43:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9368C4339B;
        Sun, 12 Mar 2023 15:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678635822;
        bh=tKfCXYOOleCQQQzlEhRp2DMcB7jwl7SPXAhqcl3bmQo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=K/udf01ioAOfPX3EYmkuuFUaqZuXzkNoosFPd3qjcAprlwcMiCQBdDAAN1sVzPUSU
         DpdSdF4RlPQ5uqVPP85KR9w802se+bLYp3+n4HKiM/A1KFqOaicckL2dUxe9CChsIn
         f7069bP9rrVTKesUlUocyUjN+FpJkkG5RNLjCvHd1DhY4GCgcLnnWSiulPTl+mb+vJ
         mIX9T+oWlbrravIQUKQdXPIhhmkFuh8BWuksN/Q2Y5vbfcnsmh2ApTR2I8OJdY6c8O
         1r3ZY7w31qXLHIULtsVhJUEJbuyGA3ZPMQBm9CgvXylzlaUr2luOK7mqXLa+lXKX9Z
         4t91xuWCUAVLg==
Date:   Sun, 12 Mar 2023 15:43:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Andres Heinloo" <andres@gfz-potsdam.de>
Cc:     "Eddie James" <eajames@linux.ibm.com>, linux-iio@vger.kernel.org
Subject: Re: Bugs in dps310 Linux driver
Message-ID: <20230312154348.257ddf87@jic23-huawei>
In-Reply-To: <web-1202839@cgp-be2-mgmt.gfz-potsdam.de>
References: <web-1200302@cgp-be2-mgmt.gfz-potsdam.de>
        <20230304170620.795f4d99@jic23-huawei>
        <web-1201064@cgp-be2-mgmt.gfz-potsdam.de>
        <web-1202839@cgp-be2-mgmt.gfz-potsdam.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Mon, 06 Mar 2023 22:15:15 +0100
"Andres Heinloo" <andres@gfz-potsdam.de> wrote:

> On Sun, 05 Mar 2023 03:05:01 +0100
>   "Andres Heinloo" <andres@gfz-potsdam.de> wrote:
> > On Sat, 4 Mar 2023 17:06:20 +0000
> >  Jonathan Cameron <jic23@kernel.org> wrote:  
> >> On Fri, 03 Mar 2023 12:10:00 +0100
> >> "Andres Heinloo" <andres@gfz-potsdam.de> wrote:
> >>   
> >>> Hello,
> >>> 
> >>> I've been struggling with the dps310 driver, which gives incorrect 
> >>>pressure values and in particular different values than manufacturers 
> >>>code (https://github.com/Infineon/RaspberryPi_DPS).
> >>> 
> >>> I think I've found where the problem is. Firstly, there is a mistake 
> >>>in bit numbering at 
> >>>https://github.com/torvalds/linux/blob/857f1268a591147f7be7509f249dbb3aba6fc65c/drivers/iio/pressure/dps310.c#L51
> >>> 
> >>> According to datasheet, correct is:
> >>> 
> >>> #define  DPS310_INT_HL          BIT(7)
> >>> #define  DPS310_TMP_SHIFT_EN    BIT(3)
> >>> #define  DPS310_PRS_SHIFT_EN    BIT(2)
> >>> #define  DPS310_FIFO_EN         BIT(1)
> >>> #define  DPS310_SPI_EN          BIT(0)
> >>> 
> >>> Eg., the current code is using wrong bit (4) for 
> >>>DPS310_PRS_SHIFT_EN, which means that pressure shift is never 
> >>>enabled.  
> >> 
> >> Checking the datasheet, seems like you are right.
> >> https://www.infineon.com/dgdl/Infineon-DPS310-DataSheet-v01_02-EN.pdf?fileId=5546d462576f34750157750826c42242
> >> Section 7: 
> >> Though that's not the only bit that is wrong.  Looks like FIFO 
> >>enable is as well.
> >> So any fix should deal with that as well.  
> > 
> > Yes, DPS310_PRS_SHIFT_EN, DPS310_FIFO_EN, DPS310_SPI_EN are all 
> >wrong, but the latter 2 are not used by the driver.
> > 
> >   
> >> The differences between the register map and the datasheet I'm 
> >>looking at make
> >> me think that perhaps the driver was developed against a prototype 
> >>part.
> >> The registers are in a different order for starters with the B0, B1 
> >>and B2
> >> sets in reverse order.  Any fix patch should tidy that up as well.  
> > 
> > Yes, but that's just different naming. MSB is called B2 in the 
> >datasheet and B0 in the driver.
> > 
> >   
> >>> Secondly, there is a problem with overflows starting at 
> >>>https://github.com/torvalds/linux/blob/857f1268a591147f7be7509f249dbb3aba6fc65c/drivers/iio/pressure/dps310.c#L654
> >>> 
> >>> Since p is a 24-bit value,
> >>> 
> >>> nums[3] = p * p * p * (s64)data->c30;
> >>> 
> >>> can and does overflow.  
> >> 
> >> Makes sense, though I can't immediately see a good solution as we 
> >>need
> >> to maintain the remainder part.  
> > 
> > I don't have a good solution either, but there must be other IIO 
> >sensors that have something similar that could be possibly reused.
> > 
> >   
> >>> Second overflow problem is at 
> >>>https://github.com/torvalds/linux/blob/857f1268a591147f7be7509f249dbb3aba6fc65c/drivers/iio/pressure/dps310.c#L684
> >>> 
> >>> In fact, I don't understand why 1000000000LL is needed. Since only 7 
> >>>values are summed, using 10LL should give the same precision.  
> >> Whilst the existing  value seems large - I'm not great with 
> >>precision calcs so could
> >> you lay out why 10LL is sufficient?  
> > 
> > Unless I overlooked something, the error of integer division (eg., 
> >discarding fractional part) is <1. In this case, the results of 7 
> >integer divisions are summed, so the error is <7. When multiplying 
> >numerators by 10LL, the error would be <0.7. Which is OK, since we 
> >are interested only in the integer part.  
> 
> Unfortunately it seems that there may be more problems with the 
> driver. I've noticed that my device has lost sample rate and precision 
> settings few times. When looking at the code, it seems the settings 
> are not restored when dps310_reset_reinit() is called at 
> https://github.com/torvalds/linux/blob/8ca09d5fa3549d142c2080a72a4c70ce389163cd/drivers/iio/pressure/dps310.c#L438
> 

Agreed. Looks like that stuff is missing.  This reset path is pretty horrible
in general, so I'm not surprised a few things got missed. Should be easy enough
to add a cache of those and and set them again if you want to try that.


> Apparently I've also ended up with data->timeout_recovery_failed == 
> true at 
> https://github.com/torvalds/linux/blob/8ca09d5fa3549d142c2080a72a4c70ce389163cd/drivers/iio/pressure/dps310.c#L443, 
> but the device worked fine after just reloading the kernel module. 
> This is difficult to reproduce, though.

Hmm. There are a few things that could cause that.  Maybe something running slow, or
an intermittent write failure (noisy environment or bad wire / track maybe?)


> Andres

