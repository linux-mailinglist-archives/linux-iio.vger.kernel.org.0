Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF756AAB66
	for <lists+linux-iio@lfdr.de>; Sat,  4 Mar 2023 18:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCDRG1 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Mar 2023 12:06:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjCDRG0 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2023 12:06:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6061E2B2
        for <linux-iio@vger.kernel.org>; Sat,  4 Mar 2023 09:06:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 156DA60A0B
        for <linux-iio@vger.kernel.org>; Sat,  4 Mar 2023 17:06:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91F41C433D2;
        Sat,  4 Mar 2023 17:06:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677949584;
        bh=ZBPnbSKFHiO35toU1s5uH6sqdcvesLEODxNloce+RKM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=HzAfCqD+hSAj/D8FmMoDlgWmMXrY/StiRT4nZIQnb1OmJa6QyKd7uGm+I4hGIgmeG
         sF6sWKdSL29XdINnIokrlbnwVgQD5G/dxLBdE0ZwW5Bkr0DUG5620fud/TLrLNnMGs
         HtB6rFcFpOS46A3UbRqRLXCBJJFdeG7ungNh7iDm8/sZeo0TBTuAp0Hte7ly/A5sTV
         cR6iq+OyF/KqZ2QW2f7/VkrbzXOUgxCazqHNcNWlrn+oGmOsJX0DWj13Mg/cmQkylP
         AP5M6+26IT+spvzouD75Kh4nveRkNsjF3rbpr1HsTGOTvHqiWx2a/fvbmAEFD5gwrJ
         fgF8C/8jhLFzw==
Date:   Sat, 4 Mar 2023 17:06:20 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     "Andres Heinloo" <andres@gfz-potsdam.de>
Cc:     "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>,
        "Eddie James" <eajames@linux.ibm.com>, linux-iio@vger.kernel.org
Subject: Re: Bugs in dps310 Linux driver
Message-ID: <20230304170620.795f4d99@jic23-huawei>
In-Reply-To: <web-1200302@cgp-be2-mgmt.gfz-potsdam.de>
References: <web-1200302@cgp-be2-mgmt.gfz-potsdam.de>
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

On Fri, 03 Mar 2023 12:10:00 +0100
"Andres Heinloo" <andres@gfz-potsdam.de> wrote:

> Hello,
> 
> I've been struggling with the dps310 driver, which gives incorrect 
> pressure values and in particular different values than manufacturers 
> code (https://github.com/Infineon/RaspberryPi_DPS).
> 
> I think I've found where the problem is. Firstly, there is a mistake 
> in bit numbering at 
> https://github.com/torvalds/linux/blob/857f1268a591147f7be7509f249dbb3aba6fc65c/drivers/iio/pressure/dps310.c#L51
> 
> According to datasheet, correct is:
> 
> #define  DPS310_INT_HL          BIT(7)
> #define  DPS310_TMP_SHIFT_EN    BIT(3)
> #define  DPS310_PRS_SHIFT_EN    BIT(2)
> #define  DPS310_FIFO_EN         BIT(1)
> #define  DPS310_SPI_EN          BIT(0)
> 
> Eg., the current code is using wrong bit (4) for DPS310_PRS_SHIFT_EN, 
> which means that pressure shift is never enabled.

Checking the datasheet, seems like you are right.
https://www.infineon.com/dgdl/Infineon-DPS310-DataSheet-v01_02-EN.pdf?fileId=5546d462576f34750157750826c42242
Section 7: 

Though that's not the only bit that is wrong.  Looks like FIFO enable is as well.
So any fix should deal with that as well.

The differences between the register map and the datasheet I'm looking at make
me think that perhaps the driver was developed against a prototype part.
The registers are in a different order for starters with the B0, B1 and B2
sets in reverse order.  Any fix patch should tidy that up as well.


> 
> Secondly, there is a problem with overflows starting at 
> https://github.com/torvalds/linux/blob/857f1268a591147f7be7509f249dbb3aba6fc65c/drivers/iio/pressure/dps310.c#L654
> 
> Since p is a 24-bit value,
> 
> nums[3] = p * p * p * (s64)data->c30;
> 
> can and does overflow.

Makes sense, though I can't immediately see a good solution as we need
to maintain the remainder part.

> 
> Second overflow problem is at 
> https://github.com/torvalds/linux/blob/857f1268a591147f7be7509f249dbb3aba6fc65c/drivers/iio/pressure/dps310.c#L684
> 
> In fact, I don't understand why 1000000000LL is needed. Since only 7 
> values are summed, using 10LL should give the same precision.
Whilst the existing  value seems large - I'm not great with precision calcs so could
you lay out why 10LL is sufficient?


> 
> Best regards,
> Andres

