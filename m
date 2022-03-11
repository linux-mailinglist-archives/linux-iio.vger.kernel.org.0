Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF5C4D68C0
	for <lists+linux-iio@lfdr.de>; Fri, 11 Mar 2022 19:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345035AbiCKSxC (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Fri, 11 Mar 2022 13:53:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243689AbiCKSxC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Fri, 11 Mar 2022 13:53:02 -0500
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A981C60C9
        for <linux-iio@vger.kernel.org>; Fri, 11 Mar 2022 10:51:58 -0800 (PST)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 00FE881DE9;
        Fri, 11 Mar 2022 19:51:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1647024717;
        bh=r2uBpMO+CmKIGzBX6d1wqTh7FrpeEYZqyolNXzlxUMc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GJNGVTuBhxsrtjJ2P4YNT1XujWmW6aOL92WuzBe20WE2T73LJCI5Jxmyq3MUlkJvQ
         sVMdiyas8bHMwtNYuta8EYqqp/oQ+9YYB2RSUjujXjpFjox8hnEg/MhvPXBdpYGwb6
         pChbzP4LOzbYJUcSQQIcTWfmaVRqu2E/rNcZzQM9moFv4vuTVinx8z/d1AxlbD63DW
         I1IqN3dN6SHaVH+8jjG8tKHAqspvCK31GMGX48h5+19oc2TkyiP5cQ2XfLU2FlyBWI
         e7EMs+iKbnrIQrnsqIS3ED+6EoLNvarHTvbVCOv5Lxn5YCCQoScT1eiX+cAMxICbA7
         QQ17V6RdD4Bjg==
Message-ID: <35811c26-2363-6be0-09fe-91ee77f29069@denx.de>
Date:   Fri, 11 Mar 2022 19:51:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 4/6] iio: adc: ti-ads1015: Deduplicate channel macros
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220310003402.490478-1-marex@denx.de>
 <20220310003402.490478-4-marex@denx.de> <YioKZ6EZvYHOOFMe@smile.fi.intel.com>
 <082e1654-74b7-aed2-4915-f8dd304540d6@denx.de>
 <CAHp75VfDv5CE0cDSBDeMeWj4ub1JV9o-jPpqhLvwnmmN+=WJ0Q@mail.gmail.com>
 <1504edf0-5773-781a-1a4f-056f57dfbf15@denx.de>
 <YiuA3jvbpkSQfuFM@smile.fi.intel.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <YiuA3jvbpkSQfuFM@smile.fi.intel.com>
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

On 3/11/22 18:03, Andy Shevchenko wrote:
> On Fri, Mar 11, 2022 at 12:33:49PM +0100, Marek Vasut wrote:
>> On 3/11/22 12:29, Andy Shevchenko wrote:
>>> On Fri, Mar 11, 2022 at 1:55 AM Marek Vasut <marex@denx.de> wrote:
>>>> On 3/10/22 15:25, Andy Shevchenko wrote:
>>>>> On Thu, Mar 10, 2022 at 01:34:00AM +0100, Marek Vasut wrote:
> 
> ...
> 
>>>>>> -            .realbits = 12,                                 \
>>>>>> +            .realbits = (_realbits),                        \
>>>>>>                .storagebits = 16,                              \
>>>>>
>>>>> This seems inconsistent a bit. What if the next chip wants to have more than
>>>>> 16 bits in realbits?
>>>>
>>>> When such a chip exists, this can be parametrized as well.
>>>
>>> Yes, My point is that it's error prone.
>>
>> Won't IIO core warn if realbits > storagebits ?
> 
> If it's the case, then it's very good!

No, apparently it won't .

> ...
> 
>>>>> I see two options:
>>>>> 1) add static assert to make sure realbits <= storagebits;
>>>>
>>>> Does static_assert work in array of structures (I don't think it does) ?
>>>
>>> You can check, but IIRC some of the macros have it. Don't remember the
>>> details, though.
>>
>> I already checked before replying, hence my question, as I didn't find a way
>> to make it work.
> 
> It seems that current use cases have it either in functions or in
> the expressions as ({...}). I dunno if the result of ({...}) can be
> a data structure or compound literal.

I added a patch to v2, but ugh, it isn't nice:

[PATCH v2 7/7] iio: adc: ti-ads1015: Add static assert to test if 
shifted realbits fit into storagebits
