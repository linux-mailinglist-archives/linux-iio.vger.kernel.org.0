Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFAF4E1D3C
	for <lists+linux-iio@lfdr.de>; Sun, 20 Mar 2022 18:50:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239621AbiCTRve (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 20 Mar 2022 13:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbiCTRve (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 20 Mar 2022 13:51:34 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7CF2639
        for <linux-iio@vger.kernel.org>; Sun, 20 Mar 2022 10:50:10 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id D5BE383960;
        Sun, 20 Mar 2022 18:50:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1647798607;
        bh=+4u2+7gsqy5snQOdg5avtB6+GEwMZJQ3RAwSz2unDQ0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=tF+/aaJ4aXNFY+rMLRs0KGX7DFkbGUxOSB5UzbJNjFGQKiXICURkqpwwnRnaw/idN
         W58mJmickyDemzTF5leS04VafzRY66v8UO7SRKh9Ur4rRAqOReFkbt09fiW8QnSq82
         /7pajyFQuKZsBdPYVrOnxQ8OLQhYf/9NqwkiNk/db0JnlPN0bD39XrFn4TtWi7Gfcs
         A4ZNKVMA2lUIyKnh1LcXuiPPtG9BKSlxAPDastQsUQue15YXbOvovdAVblzxSg2/Y+
         d5QQhgjissGYdSoy7NXCKSuDtNz+W4G6uoimDKfSnUb3Q2+iITMGh+FeMSqJm1S7y8
         Q+MoGoqcAvB4Q==
Message-ID: <780e7f61-c283-d60e-2372-005fb8de56d1@denx.de>
Date:   Sun, 20 Mar 2022 18:50:06 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 7/7] iio: adc: ti-ads1015: Add static assert to test if
 shifted realbits fit into storagebits
Content-Language: en-US
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio <linux-iio@vger.kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220311184925.99270-1-marex@denx.de>
 <20220311184925.99270-7-marex@denx.de>
 <CAHp75VdS+VRFSu8q3Si4yVEJd3aYxoFBaz4cYh7PXLGCLmNvaA@mail.gmail.com>
 <65e934d0-b002-1cf1-1b4d-1ff53d04df50@denx.de>
 <20220320131041.4efcf35b@jic23-huawei>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20220320131041.4efcf35b@jic23-huawei>
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

On 3/20/22 14:10, Jonathan Cameron wrote:
> On Sat, 12 Mar 2022 22:28:22 +0100
> Marek Vasut <marex@denx.de> wrote:
> 
>> On 3/12/22 13:19, Andy Shevchenko wrote:
>>> On Fri, Mar 11, 2022 at 8:50 PM Marek Vasut <marex@denx.de> wrote:
>>>>
>>>> Add compile-time static_assert wrapper to verify that shifted realbits
>>>> fit into storagebits. The macro is implemented in a more generic way so
>>>> it can be used to verify other values if required.
>>>
>>> Thanks! I think we may leave it to maintainers to decide if it is
>>> worth adding or not.
>>
>> Right, that's why I placed it as 7/7, since the macro is ... not pretty.
> 
> It's ugly but that's all wrapped up in the macro so I'll take it and
> see what blows up :)
> 
> Longer term, maybe we'd should add a general runtime check in the IIO core?

I wonder whether something like that could be made completely generic, 
but, let's do that in the next step.

> Not quite so nice as catching at compile time but would catch all such issues
> the moment anyone actually tries out a driver with whatever device they've
> just added support for.
> 
> I'll let this sit a little longer for additional review before picking it up
> (missed this cycle anyway so lots of time).
> 
> 
> A few other comments on this driver whilst we are here on things we should
> cleanup at somepoint.
> 1) Move over to the read_avail callback rather than having the attribute
>     groups.  It may well be slightly more code but then makes them available
>     to in kernel users.   Slowly moving all drivers with _available for standard
>     ABI over to the callback is on the todo list but it will take a while...
> 2) Possibly introduced a static const array of
>     struct ad1015_chip_info {
> 	all the per device stuff currently handled in code in probe
>     };
> Then simply access that directly using the the device_match_data.

I found a small bug in the tla2024 integration, the attrs assignment is 
wrong, so I'll send 1 and 2 above alongside V3 shortly.
