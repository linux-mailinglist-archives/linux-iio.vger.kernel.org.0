Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 832C86B679B
	for <lists+linux-iio@lfdr.de>; Sun, 12 Mar 2023 16:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229552AbjCLPqz (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 12 Mar 2023 11:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbjCLPqz (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 12 Mar 2023 11:46:55 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80E5830291
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 08:46:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2DEF1B80B07
        for <linux-iio@vger.kernel.org>; Sun, 12 Mar 2023 15:46:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A910C433EF;
        Sun, 12 Mar 2023 15:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678636005;
        bh=+REWdxSEFXmTTwqDpZx228NtUNAypHLtHR0Fo1wcSDo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WvKr4rRarJ10wa3P0wnj6pXs42dc77HdMMWm0kRSmb/CS7IinOUg+c/+K00J9JGCL
         /uE6RxizYLF87UNMcwaDadqFB6juR0naCzxyDskyG3C/M5jmccgtbIekqcKCjpNEQv
         cUsOoAsQFxEAxOqDMjuB2zmRi0sPv7AoPrwBhw+gCRfBvXTZAp7EcpIm3zi8QBZfeS
         mqJUrtVvKebPvltb07omJgEwJGM/nZxgjtM+SvnFhI3FOEZ7wOJaQQtuHYGzodjaD6
         /MYFOQJwvt7lPbWDuWqCfMi2sZNt2Ado4V5pT/+UGL/uOX5jdLqgHPT8c+dNM4VEFw
         ALk37uds3gVIQ==
Date:   Sun, 12 Mar 2023 15:46:51 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Andres Heinloo" <andres@gfz-potsdam.de>
Cc:     "Eddie James" <eajames@linux.ibm.com>, linux-iio@vger.kernel.org
Subject: Re: Bugs in dps310 Linux driver
Message-ID: <20230312154651.43c5bb2f@jic23-huawei>
In-Reply-To: <web-1201064@cgp-be2-mgmt.gfz-potsdam.de>
References: <web-1200302@cgp-be2-mgmt.gfz-potsdam.de>
        <20230304170620.795f4d99@jic23-huawei>
        <web-1201064@cgp-be2-mgmt.gfz-potsdam.de>
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

On Sun, 05 Mar 2023 03:05:01 +0100
"Andres Heinloo" <andres@gfz-potsdam.de> wrote:

> On Sat, 4 Mar 2023 17:06:20 +0000
>   Jonathan Cameron <jic23@kernel.org> wrote:
> > On Fri, 03 Mar 2023 12:10:00 +0100
> > "Andres Heinloo" <andres@gfz-potsdam.de> wrote:
> >   
> >> Hello,
> >> 
> >> I've been struggling with the dps310 driver, which gives incorrect 
> >> pressure values and in particular different values than 
> >>manufacturers 
> >> code (https://github.com/Infineon/RaspberryPi_DPS).
> >> 
> >> I think I've found where the problem is. Firstly, there is a mistake 
> >> in bit numbering at 
> >> https://github.com/torvalds/linux/blob/857f1268a591147f7be7509f249dbb3aba6fc65c/drivers/iio/pressure/dps310.c#L51
> >> 
> >> According to datasheet, correct is:
> >> 
> >> #define  DPS310_INT_HL          BIT(7)
> >> #define  DPS310_TMP_SHIFT_EN    BIT(3)
> >> #define  DPS310_PRS_SHIFT_EN    BIT(2)
> >> #define  DPS310_FIFO_EN         BIT(1)
> >> #define  DPS310_SPI_EN          BIT(0)
> >> 
> >> Eg., the current code is using wrong bit (4) for 
> >>DPS310_PRS_SHIFT_EN, 
> >> which means that pressure shift is never enabled.  
> > 
> > Checking the datasheet, seems like you are right.
> > https://www.infineon.com/dgdl/Infineon-DPS310-DataSheet-v01_02-EN.pdf?fileId=5546d462576f34750157750826c42242
> > Section 7: 
> > 
> > Though that's not the only bit that is wrong.  Looks like FIFO 
> >enable is as well.
> > So any fix should deal with that as well.  
> 
> Yes, DPS310_PRS_SHIFT_EN, DPS310_FIFO_EN, DPS310_SPI_EN are all wrong, 
> but the latter 2 are not used by the driver.
> 
> 
> > The differences between the register map and the datasheet I'm 
> >looking at make
> > me think that perhaps the driver was developed against a prototype 
> >part.
> > The registers are in a different order for starters with the B0, B1 
> >and B2
> > sets in reverse order.  Any fix patch should tidy that up as well.  
> 
> Yes, but that's just different naming. MSB is called B2 in the 
> datasheet and B0 in the driver.

That would be good to fix though as it will only cause more confusion
in the future.  Sure that 'fix' should be at the end of any patch set
and might wait for the next kernel merge window rather than going in
quickly.

> 
> 
> >> Secondly, there is a problem with overflows starting at 
> >> https://github.com/torvalds/linux/blob/857f1268a591147f7be7509f249dbb3aba6fc65c/drivers/iio/pressure/dps310.c#L654
> >> 
> >> Since p is a 24-bit value,
> >> 
> >> nums[3] = p * p * p * (s64)data->c30;
> >> 
> >> can and does overflow.  
> > 
> > Makes sense, though I can't immediately see a good solution as we 
> >need
> > to maintain the remainder part.  
> 
> I don't have a good solution either, but there must be other IIO 
> sensors that have something similar that could be possibly reused.

I'm not sure I've seen a power of 3 in many calculations.
There may be a similar case in another driver, but I can't immediately point to one.

> 
> 
> >> Second overflow problem is at 
> >> https://github.com/torvalds/linux/blob/857f1268a591147f7be7509f249dbb3aba6fc65c/drivers/iio/pressure/dps310.c#L684
> >> 
> >> In fact, I don't understand why 1000000000LL is needed. Since only 7 
> >> values are summed, using 10LL should give the same precision.  
> > Whilst the existing  value seems large - I'm not great with 
> >precision calcs so could
> > you lay out why 10LL is sufficient?  
> 
> Unless I overlooked something, the error of integer division (eg., 
> discarding fractional part) is <1. In this case, the results of 7 
> integer divisions are summed, so the error is <7. When multiplying 
> numerators by 10LL, the error would be <0.7. Which is OK, since we are 
> interested only in the integer part.
That works for me as an explanation.  Thanks

Jonathan

> 
> Andres

