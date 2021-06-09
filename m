Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9A003A1080
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 12:49:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234202AbhFIJrV (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 05:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234017AbhFIJrV (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jun 2021 05:47:21 -0400
Received: from outbound.soverin.net (outbound.soverin.net [IPv6:2a01:4f8:fff0:2d:8::218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD32C061574
        for <linux-iio@vger.kernel.org>; Wed,  9 Jun 2021 02:45:26 -0700 (PDT)
Received: from smtp.freedom.nl (unknown [10.10.3.36])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by outbound.soverin.net (Postfix) with ESMTPS id D8C39600D8;
        Wed,  9 Jun 2021 09:37:54 +0000 (UTC)
Received: from smtp.freedom.nl (smtp.freedom.nl [116.202.65.211]) by soverin.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=freedom.nl; s=default;
        t=1623231473; bh=WwSeiHRDe1eHouaL6AtXfnHdPKVjxSnUx3J+IDw8ZTI=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=Iu4AJVOdqoIlUWSFPh0v9Rt2KOgVhA8/7EDExsDpORSXreIw4oj1miXiBbmU95eJn
         ffDHVxPhS2ThUo7pIb1yxXxlS8ZSSOB+/MOtER82Tan96dedQlxEQDD6INh0TPc7ML
         sNCGDNbTWflFyyOH3O1HOAOzWPvdjMi+slGG2R6k=
Subject: Re: active_scan_mask
To:     Lars-Peter Clausen <lars@metafoo.de>,
        "Sa, Nuno" <Nuno.Sa@analog.com>,
        Henk Medenblik <iio-developer@freedom.nl>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>
References: <08a77a5c-9399-e615-f2df-3251756ed890@freedom.nl>
 <CA+U=Dsq23-y7OBuc6+YCVwpUARNO-PBCDh4Mnaqpe51k=M8Dtw@mail.gmail.com>
 <46567041-1dbf-2b00-3500-011fd722e2fc@freedom.nl>
 <CA+U=Dsp6GqpkTm1RVQdw3S_RF+4jHabM9SNyjD1vhY3qq3gKkw@mail.gmail.com>
 <b5a7e616-5d3b-5899-5c51-255c82a33e40@freedom.nl>
 <PH0PR03MB6366D542CBF7F389134F3E9999369@PH0PR03MB6366.namprd03.prod.outlook.com>
 <2bf66558-8a90-f27c-6c8a-b149a79aaa0e@metafoo.de>
From:   Henk Medenblik <iio-developer@freedom.nl>
Message-ID: <f09cae31-1be5-4693-7629-d172724db85a@freedom.nl>
Date:   Wed, 9 Jun 2021 11:37:50 +0200
MIME-Version: 1.0
In-Reply-To: <2bf66558-8a90-f27c-6c8a-b149a79aaa0e@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

I agree,

The patch works.
@Lars, can you create the patch and push it in your analog devices 
kernel tree sources ?

Regards

Henk

On 6/9/21 10:55 AM, Lars-Peter Clausen wrote:
> On 6/9/21 10:19 AM, Sa, Nuno wrote:
>> Hi Henk,
>>
>>> From: Henk Medenblik <iio-developer@freedom.nl>
>>> Sent: Wednesday, June 9, 2021 9:04 AM
>>> To: Alexandru Ardelean <ardeleanalex@gmail.com>; Henk Medenblik
>>> <iio-developer@freedom.nl>
>>> Cc: linux-iio <linux-iio@vger.kernel.org>
>>> Subject: Re: active_scan_mask
>>>
>>> [External]
>>>
>>> Dear Alexandru,
>>>
>>>> Hmm, so the "zerocopy" branch isn't at v0.21.
>>>> It's something much older [ ~6 years ? ].
>>>> Though the kernel active scan mask is unrelated to libiio, since
>>>> iio_readdev is being used in different sessions.
>>>>
>>>> The 4.14 version of the kernel, isn't quite new.
>>>> There was some recent fix with regards to active scan-mask
>>> computation.
>>>> But I am not sure if it's related to this.
>>>>
>>>> Will try to make some time to do some testing on this.
>>>>
>>> I believe it is a bug which still exists in the adi linux kernel 
>>> sources.
>>> In industrialio-buffer.c :
>>>
>>> static int iio_channel_mask_clear(struct iio_dev *indio_dev,
>>>       struct iio_buffer *buffer, int bit)
>>> {
>>>       unsigned int ch;
>>>
>>>       clear_bit(bit, buffer->channel_mask);
>>>
>>>       memset(buffer->scan_mask, 0,
>>> BITS_TO_LONGS(indio_dev->masklength));  <---------
>>>       for_each_set_bit(ch, buffer->channel_mask, indio_dev-
>>>> num_channels)
>>>           set_bit(indio_dev->channels[ch].scan_index, buffer-
>>>> scan_mask);
>>>       return 0;
>>> }
>>>
>> Take a look at [1] for more details. Long story short, I think this 
>> is here because we have
>> some devices where we have bit granularity. Hence, we map all 
>> channels to the same
>> scan_index and to distinguish which channels are enabled, we could 
>> not use the current
>> upstream implementation. I remember some talks about this but not 
>> actual patches
>> came from it (I will have to go over those emails to see if I can 
>> come up with some
>> patches).
>>
>> Regarding the memset, that looks like a bug. I guess we want:
>>
>> memset(buffer->scan_mask, 0, BITS_TO_LONGS(indio_dev->masklength) * 
>> sizeof(*buffer->scan_mask));
>>
>> Ccing Lars as he implemented this patches and might have something to 
>> add to
>> your questions.
>>
> Yea, my fault, sorry. The patch looks good.
