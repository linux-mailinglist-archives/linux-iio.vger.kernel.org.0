Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49E3E4D555E
	for <lists+linux-iio@lfdr.de>; Fri, 11 Mar 2022 00:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235122AbiCJXaq (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 10 Mar 2022 18:30:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233249AbiCJXap (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 10 Mar 2022 18:30:45 -0500
X-Greylist: delayed 82519 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Mar 2022 15:29:41 PST
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC44D74842
        for <linux-iio@vger.kernel.org>; Thu, 10 Mar 2022 15:29:41 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E5AD28392C;
        Fri, 11 Mar 2022 00:29:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1646954979;
        bh=m3XZu/VIxe8GFVs1CggJRma0bSL/pTPn7RPKlrfTtH8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=m4MyIcVnXLaUyszpRBK36kGCZCfBgM0muUbh7rrsKv3UTO6XFLOIQqzRUt2MHvkqm
         AwmLe37j0Nh+7tr0FT2TQBkNlwgXDIsArnq/da0z657i4JHX/1Wcv2Hg8qPEZk/G85
         46vLipQF/skWcOi+9eF0vnZCvE746Cg6wFlOwhe5yE4twruM0GXZ3bl2mNFNAnw6JK
         rOge1dNpsEMc69T8FS1LZdJisL+j0zWPhSWnHvkJwuvGAGy46F3XqHGjeVKrBPCgdx
         f2jKJuZ4LwmEdDGRY2yRS5/aiiXio/tRq0e91GYL7LAzFBthAkl66yD3oMiZmZYb6X
         z9KfuwoRJT3FQ==
Message-ID: <082e1654-74b7-aed2-4915-f8dd304540d6@denx.de>
Date:   Fri, 11 Mar 2022 00:29:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 4/6] iio: adc: ti-ads1015: Deduplicate channel macros
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220310003402.490478-1-marex@denx.de>
 <20220310003402.490478-4-marex@denx.de> <YioKZ6EZvYHOOFMe@smile.fi.intel.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <YioKZ6EZvYHOOFMe@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.5 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/10/22 15:25, Andy Shevchenko wrote:
> On Thu, Mar 10, 2022 at 01:34:00AM +0100, Marek Vasut wrote:
>> These macros differ only in the number of valid bits of each ADC sample
>> and the shift of those bits, i.e. ADS1015 is 12bit ADC shifted by 4 left,
>> ADS1115 is 16bit ADC shifted by 0. No functional change.
> 
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> ...
> 
>> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Cc: Daniel Baluta <daniel.baluta@nxp.com>
>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> You may consider using --cc parameter in `git send-email` to avoid this noise
> in the commit messages.

This is deliberate so I can keep track of who to CC on which patch.

> ...
> 
>> -		.realbits = 12,					\
>> +		.realbits = (_realbits),			\
>>   		.storagebits = 16,				\
> 
> This seems inconsistent a bit. What if the next chip wants to have more than
> 16 bits in realbits?

When such a chip exists, this can be parametrized as well.

> ...
> 
>> -		.realbits = 16,					\
>> +		.realbits = (_realbits),			\
>>   		.storagebits = 16,				\
> 
> Ditto.
> 
> I see two options:
> 1) add static assert to make sure realbits <= storagebits;

Does static_assert work in array of structures (I don't think it does) ?

> 2) make it also configurable.

That would be unnecessary duplication, this patch is trying to 
DEduplicate the driver code, not REduplicate it differently.
