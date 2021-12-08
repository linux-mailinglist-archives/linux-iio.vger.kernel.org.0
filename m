Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD24446D337
	for <lists+linux-iio@lfdr.de>; Wed,  8 Dec 2021 13:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbhLHM05 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 8 Dec 2021 07:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhLHM04 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 8 Dec 2021 07:26:56 -0500
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a01:4f8:fff0:2d:8::215])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C79C061746
        for <linux-iio@vger.kernel.org>; Wed,  8 Dec 2021 04:23:24 -0800 (PST)
Received: from smtp.freedom.nl (unknown [10.10.3.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id 36EFB600FA;
        Wed,  8 Dec 2021 12:23:22 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [116.202.127.71]) by soverin.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=deathstar2.nl;
        s=soverin; t=1638966200;
        bh=XxY2t2xchkuR4MCA/ynO/NAPsgVwFX99FhKGRJWXxG8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=XuSJX0B9oK64Cu+0sZX8nlzUAN8CT9P0MDMw/Q9pLN6PpXuGGQjiSTqB2Qt2z9AT1
         pTa4GrPoUHdOpGtVLJTvV0M2a18ZdbWbqCTdLDBDz6XfTSDA5+/JJ1sjbXawD3MqFA
         hms4QFmYG5xxe0znrXrB24i8L6wcFN4eGHDpcop6WIQtSZzquu2vFzHb00eltdtZt/
         hIEVcswymSQKqXQdRGAaU0KpmGfdhG8+T/Y7HqWPV4KbVhdgpc7irTWBXSwACQXaOJ
         MZsD/3sSp1bEUCwbWPborhgoje/iIY8h1vMoxWj7foUeyMAih0LTrfVA38eYwdukhO
         pH+XKMth/F8lA==
Subject: Re: iio display large numbers
To:     Alexandru Ardelean <ardeleanalex@gmail.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio <linux-iio@vger.kernel.org>
References: <9bd04e6d-7418-9d01-6e80-52fd7e84086f@deathstar2.nl>
 <20211207161338.000012bd@Huawei.com>
 <CAHp75VdB5vquGKnHSZhkLJDnUTXo68-mvHsRfPg+eqgb8pueTA@mail.gmail.com>
 <CA+U=DsrD1S0QMFXgjf4tNUmprS5j40hv2Jhp+ykbYqn70V2mJw@mail.gmail.com>
From:   Henk <yoda@deathstar2.nl>
Organization: DeathStar2
Message-ID: <9a48b2f6-2e20-35c3-7856-cfc019cdd94c@deathstar2.nl>
Date:   Wed, 8 Dec 2021 13:23:13 +0100
MIME-Version: 1.0
In-Reply-To: <CA+U=DsrD1S0QMFXgjf4tNUmprS5j40hv2Jhp+ykbYqn70V2mJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi,

Wouldn't it be an option to extend the IIO framework with a unit 
description like Hz, kHz, MHz, GHz....
Otherwise I am happy with the IIO_VAL_INT_64 for the time being.

Btw... software developers should not decide which precision is a real 
world issue or not :) but only decide to support the need.

For the time being it is a bit stupid that my 2.5 GHz output from my 
LTC6951 shows up as a negative frequency :)

Regards,

Henk Medenblik


On 12/8/21 10:49 AM, Alexandru Ardelean wrote:
> On Wed, Dec 8, 2021 at 11:33 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Wed, Dec 8, 2021 at 2:56 AM Jonathan Cameron
>> <Jonathan.Cameron@huawei.com> wrote:
>>> On Tue, 7 Dec 2021 13:40:19 +0100
>>> Henk <yoda@deathstar2.nl> wrote:
>> ...
>>
>>> Two options for this.  If the thing we are controlling is the raw channel then
>>> we have the option to provide _scale reflecting the fact that a large value
>>> e.g. GHz is not normally controlled at a Hz granularity.
>> But some sensors can be really high-precision ones, although I
>> couldn't imagine a value that requires more than 32-bit for that in
>> general engineering. Where one may ask for more is something like very
>> precise physics experiments in CERN :-)
> Yeah, and this is where IIO and some sensors and clock generators seem to go.
> Research and military, 5G networks, aerospace, etc.
>
> It's a bit tricky to pin certain sub-systems (for some of them).
> Like, the clock-framework can only represent up to 4 (or 2) billion HZ
> (I forget if it's u32 or i32).
> So, this creates limitations/discussions with some clock-chips and
> where they need to go (IIO or CCF).
>
> On the other end, there was a discussion [a few months back] about
> needing lower than nano scales in IIO.
>
> So, this opens up a new set of discussions, like:
> 1. How should people use Linux for these types of devices?
> 1a. Should people use Linux for these types of devices?
> 2. [If 1 is Yes, then] Which sub-system to use?
> 3. Once a sub-system has been chosen, how to do it?
> 3a. Extend the common framework (and how?) to support these new sets of devices?
> 3b. Or do some custom attributes?
>
> On point 3, a lot of times 3b is the chosen route [by chip vendors],
> because these new chips seem to come out faster than the ability to
> extend these common frameworks.
>
> To me, it has become obvious [a few years ago] that the Linux kernel
> has been very good at serving computing needs mostly targeted towards
> data-centers (big physical servers, lots of VMs, networking and all).
>
> We're probably going to see more of these specialized devices trying
> to slowly pop up.
>
> And it will be an interesting journey to see (after all of it unfolds).
>
>>> Where that doesn't apply or the range is really very big we do have the
>>> slightly nasty option of IIO_VAL_INT_64
>>>
>>> https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=testing&id=6bb835f3d00467c9a5e35f4955afa29df96a404e
>>>
>>> This is very new, so not in mainline yet, though it is queued up for the
>>> next merge window and should be linux-next.
>>
>>
>> --
>> With Best Regards,
>> Andy Shevchenko

-- 
“Do. Or do not. There is no try.”...

