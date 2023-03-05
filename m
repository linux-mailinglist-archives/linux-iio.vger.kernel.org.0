Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5436AADC9
	for <lists+linux-iio@lfdr.de>; Sun,  5 Mar 2023 03:05:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjCECFG (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 4 Mar 2023 21:05:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCECFF (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 4 Mar 2023 21:05:05 -0500
Received: from mail.gfz-potsdam.de (mail.gfz-potsdam.de [139.17.229.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 592D612076
        for <linux-iio@vger.kernel.org>; Sat,  4 Mar 2023 18:05:03 -0800 (PST)
Received: from [84.186.199.243] (account andres@gfz-potsdam.de)
  by gfz-potsdam.de (CommuniGate Pro WEBUSER 7.1.3)
  with HTTP id 1201059; Sun, 05 Mar 2023 03:05:01 +0100
From:   "Andres Heinloo" <andres@gfz-potsdam.de>
Subject: Re: Bugs in dps310 Linux driver
To:     "Jonathan Cameron" <jic23@kernel.org>
Cc:     "Eddie James" <eajames@linux.ibm.com>, linux-iio@vger.kernel.org
X-Mailer: CommuniGate Pro WebUser v7.1.3
Date:   Sun, 05 Mar 2023 03:05:01 +0100
Message-ID: <web-1201064@cgp-be2-mgmt.gfz-potsdam.de>
In-Reply-To: <20230304170620.795f4d99@jic23-huawei>
References: <web-1200302@cgp-be2-mgmt.gfz-potsdam.de>
 <20230304170620.795f4d99@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8; format="flowed"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Sat, 4 Mar 2023 17:06:20 +0000
  Jonathan Cameron <jic23@kernel.org> wrote:
> On Fri, 03 Mar 2023 12:10:00 +0100
> "Andres Heinloo" <andres@gfz-potsdam.de> wrote:
> 
>> Hello,
>> 
>> I've been struggling with the dps310 driver, which gives incorrect 
>> pressure values and in particular different values than 
>>manufacturers 
>> code (https://github.com/Infineon/RaspberryPi_DPS).
>> 
>> I think I've found where the problem is. Firstly, there is a mistake 
>> in bit numbering at 
>> https://github.com/torvalds/linux/blob/857f1268a591147f7be7509f249dbb3aba6fc65c/drivers/iio/pressure/dps310.c#L51
>> 
>> According to datasheet, correct is:
>> 
>> #define  DPS310_INT_HL          BIT(7)
>> #define  DPS310_TMP_SHIFT_EN    BIT(3)
>> #define  DPS310_PRS_SHIFT_EN    BIT(2)
>> #define  DPS310_FIFO_EN         BIT(1)
>> #define  DPS310_SPI_EN          BIT(0)
>> 
>> Eg., the current code is using wrong bit (4) for 
>>DPS310_PRS_SHIFT_EN, 
>> which means that pressure shift is never enabled.
> 
> Checking the datasheet, seems like you are right.
> https://www.infineon.com/dgdl/Infineon-DPS310-DataSheet-v01_02-EN.pdf?fileId=5546d462576f34750157750826c42242
> Section 7: 
> 
> Though that's not the only bit that is wrong.  Looks like FIFO 
>enable is as well.
> So any fix should deal with that as well.

Yes, DPS310_PRS_SHIFT_EN, DPS310_FIFO_EN, DPS310_SPI_EN are all wrong, 
but the latter 2 are not used by the driver.


> The differences between the register map and the datasheet I'm 
>looking at make
> me think that perhaps the driver was developed against a prototype 
>part.
> The registers are in a different order for starters with the B0, B1 
>and B2
> sets in reverse order.  Any fix patch should tidy that up as well.

Yes, but that's just different naming. MSB is called B2 in the 
datasheet and B0 in the driver.


>> Secondly, there is a problem with overflows starting at 
>> https://github.com/torvalds/linux/blob/857f1268a591147f7be7509f249dbb3aba6fc65c/drivers/iio/pressure/dps310.c#L654
>> 
>> Since p is a 24-bit value,
>> 
>> nums[3] = p * p * p * (s64)data->c30;
>> 
>> can and does overflow.
> 
> Makes sense, though I can't immediately see a good solution as we 
>need
> to maintain the remainder part.

I don't have a good solution either, but there must be other IIO 
sensors that have something similar that could be possibly reused.


>> Second overflow problem is at 
>> https://github.com/torvalds/linux/blob/857f1268a591147f7be7509f249dbb3aba6fc65c/drivers/iio/pressure/dps310.c#L684
>> 
>> In fact, I don't understand why 1000000000LL is needed. Since only 7 
>> values are summed, using 10LL should give the same precision.
> Whilst the existing  value seems large - I'm not great with 
>precision calcs so could
> you lay out why 10LL is sufficient?

Unless I overlooked something, the error of integer division (eg., 
discarding fractional part) is <1. In this case, the results of 7 
integer divisions are summed, so the error is <7. When multiplying 
numerators by 10LL, the error would be <0.7. Which is OK, since we are 
interested only in the integer part.

Andres
