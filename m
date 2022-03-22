Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378504E3C0A
	for <lists+linux-iio@lfdr.de>; Tue, 22 Mar 2022 10:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiCVJ7P (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Tue, 22 Mar 2022 05:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiCVJ7P (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 22 Mar 2022 05:59:15 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F62C6B0BB
        for <linux-iio@vger.kernel.org>; Tue, 22 Mar 2022 02:57:47 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5EA698393B;
        Tue, 22 Mar 2022 10:57:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1647943065;
        bh=Pxrn4FAg1hk9YOx6nZDsbrLHTR4UB4tuL7/M1rvzOdI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=oHRJsSwUFdkazfsStMkkqhJLHxIL8WL8VS6h/3WtAb9qFd1u/BFMeIHwaT15VSn7G
         KybQH2xuuq6Ep+zZlKAuge9/4WqiVLLYHfWc0f5U4GoTTinVNuJtEejG7OSou+rO6+
         dcecx1mKHb1BY3DpNiUlwCzzyL4Gfp4fMCR+NGcNyUX6JGfG37XrKh2mtpB0RTiF2a
         GMiQ+2dg2YNaRjuu5YFglk2J75LlUqpOKe4wHrPPmiRgyvPgh04tkazwj004e/RqB4
         BJk6MHJX9C85omITylCBhk60TfKoEVDSL/n5X0LDAJ+WunX5hdV7VJYm0YPECVSex+
         eMjqsy+7JCE6w==
Message-ID: <220fa73c-5d61-a564-79a3-eabff366964c@denx.de>
Date:   Tue, 22 Mar 2022 10:57:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] iio: core: WARN in case sample bits do not fit storage
 bits
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?Q?Nuno_S=c3=a1?= <noname.nuno@gmail.com>
Cc:     linux-iio@vger.kernel.org, Daniel Baluta <daniel.baluta@nxp.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <20220320181542.168147-1-marex@denx.de>
 <YjhWIN6GsuhPskrs@smile.fi.intel.com>
 <8b6f00be-c520-45c3-4497-d0fc310ff52f@denx.de>
 <Yjijg7m+TnaMs519@smile.fi.intel.com>
 <30a13541-0ffb-a537-e943-3751b7fd316b@denx.de>
 <bd7f7b9853cbea30740af14d29a46f1a9f93a2a7.camel@gmail.com>
 <YjmbstSwzbu5ZdBg@smile.fi.intel.com>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <YjmbstSwzbu5ZdBg@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 3/22/22 10:49, Andy Shevchenko wrote:
> On Tue, Mar 22, 2022 at 08:43:10AM +0100, Nuno Sá wrote:
>> On Mon, 2022-03-21 at 20:46 +0100, Marek Vasut wrote:
>>> On 3/21/22 17:10, Andy Shevchenko wrote:
>>>> On Mon, Mar 21, 2022 at 03:46:51PM +0100, Marek Vasut wrote:
>>>>> On 3/21/22 11:40, Andy Shevchenko wrote:
>>>>>> On Sun, Mar 20, 2022 at 07:15:42PM +0100, Marek Vasut wrote:
>>>>>>> Add runtime check to verify whether storagebits are at least
>>>>>>> as big
>>>>>>> as shifted realbits. This should help spot broken drivers
>>>>>>> which may
>>>>>>> set realbits + shift above storagebits.
>>>>>>
>>>>>> Thanks!
>>>>>>
>>>>>> ...
>>>>>>
>>>>>>> +                       /* Verify that sample bits fit into
>>>>>>> storage */
>>>>>>> +                       WARN_ON(channels[i].scan_type.storage
>>>>>>> bits <
>>>>>>> +                               channels[i].scan_type.realbit
>>>>>>> s +
>>>>>>> +                               channels[i].scan_type.shift);
>>>>>>
>>>>>> Not sure WARN is a good level (it might be fatal on some setups
>>>>>> and we won't that),
>>>>>> besides the fact that we may use dev_WARN(). Perhaps dev_warn()
>>>>>> would suffice?
>>>>>
>>>>> I was actually thinking about BUG(), but that might crash
>>>>> existing systems.
>>>>> I think we want a strong indicator that something wrong is going
>>>>> on which
>>>>> must be fixed and the splat produced by WARN_ON() is a good
>>>>> indicator of
>>>>> that. It also does not crash existing systems,
>>>>
>>>> It does crash _some_ of them, unfortunately.
>>>
>>> Details please ?
>>>
>>> WARN_ON() shouldn't cause crash outright, or do I miss something ?
>>
>> Arghh, completely forgot about this... Andy is right, maybe there are
>> other cases (in which case, it would be nice to share :D), but this one
>> is definitely one of them:
>>
>> https://elixir.bootlin.com/linux/latest/source/kernel/panic.c#L579
>>
>> You can have a cmdline parameter to panic on _WARN() and some systems
>> may have it.
> 
> Yes, I meant panic on warning.
> 
> And I can't imagine that this driver can be system critical to the extent
> that we have to crash the system.

Is there something which does trigger a backtrace, but without 
panic()ing the system ?
