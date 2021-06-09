Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362A83A0F0E
	for <lists+linux-iio@lfdr.de>; Wed,  9 Jun 2021 10:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbhFII5L (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Wed, 9 Jun 2021 04:57:11 -0400
Received: from www381.your-server.de ([78.46.137.84]:53584 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbhFII5L (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 9 Jun 2021 04:57:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=TF4pI0JkQrbXmgP1GkndX6Xa+rOJBUqYkRtsnaP4LVE=; b=TjnlIGCGxgOPJNjxV1xDEORSn0
        pyiLaGUdhMCoBmc55DTfP6vLNCvmVyx8qqxDOWGhUptlaLWIDMDmuO5yKm8VumM0M2X3FxHI+TKi1
        scBm9E8knTlhHsp09ItZX1raVysavrbSJA4r0KAVjemyIUCuIQa5OZThtemndQqp6tlMG5DQA6ygv
        8A/xsxO6Egh/fWhP4B34uTxdN16Z4lpDxYwKvevOxmvvkMyE1Ube2Tu4+RnV+7dtxq6kPvA5eFdgB
        gwdJ4GjevxdzKDyDx/l4T0Q4BP1/QkG13vgw0/dbWRfWV7IrRUUbyX9tZ+zZZcTrEemOEAa6fgkdH
        Limw51Xg==;
Received: from sslproxy03.your-server.de ([88.198.220.132])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lqtzV-00088o-5x; Wed, 09 Jun 2021 10:55:13 +0200
Received: from [2001:a61:2bd3:3c01:9e5c:8eff:fe01:8578]
        by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lqtzU-00095V-Pt; Wed, 09 Jun 2021 10:55:12 +0200
Subject: Re: active_scan_mask
To:     "Sa, Nuno" <Nuno.Sa@analog.com>,
        Henk Medenblik <iio-developer@freedom.nl>,
        Alexandru Ardelean <ardeleanalex@gmail.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>
References: <08a77a5c-9399-e615-f2df-3251756ed890@freedom.nl>
 <CA+U=Dsq23-y7OBuc6+YCVwpUARNO-PBCDh4Mnaqpe51k=M8Dtw@mail.gmail.com>
 <46567041-1dbf-2b00-3500-011fd722e2fc@freedom.nl>
 <CA+U=Dsp6GqpkTm1RVQdw3S_RF+4jHabM9SNyjD1vhY3qq3gKkw@mail.gmail.com>
 <b5a7e616-5d3b-5899-5c51-255c82a33e40@freedom.nl>
 <PH0PR03MB6366D542CBF7F389134F3E9999369@PH0PR03MB6366.namprd03.prod.outlook.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <2bf66558-8a90-f27c-6c8a-b149a79aaa0e@metafoo.de>
Date:   Wed, 9 Jun 2021 10:55:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <PH0PR03MB6366D542CBF7F389134F3E9999369@PH0PR03MB6366.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.103.2/26195/Tue Jun  8 13:07:27 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 6/9/21 10:19 AM, Sa, Nuno wrote:
> Hi Henk,
>
>> From: Henk Medenblik <iio-developer@freedom.nl>
>> Sent: Wednesday, June 9, 2021 9:04 AM
>> To: Alexandru Ardelean <ardeleanalex@gmail.com>; Henk Medenblik
>> <iio-developer@freedom.nl>
>> Cc: linux-iio <linux-iio@vger.kernel.org>
>> Subject: Re: active_scan_mask
>>
>> [External]
>>
>> Dear Alexandru,
>>
>>> Hmm, so the "zerocopy" branch isn't  at v0.21.
>>> It's something much older [ ~6 years ? ].
>>> Though the kernel active scan mask is unrelated to libiio, since
>>> iio_readdev is being used in different sessions.
>>>
>>> The 4.14 version of the kernel, isn't quite new.
>>> There was some recent fix with regards to active scan-mask
>> computation.
>>> But I am not sure if it's related to this.
>>>
>>> Will try to make some time to do some testing on this.
>>>
>> I believe it is a bug which still exists in the adi linux kernel sources.
>> In industrialio-buffer.c :
>>
>> static int iio_channel_mask_clear(struct iio_dev *indio_dev,
>>       struct iio_buffer *buffer, int bit)
>> {
>>       unsigned int ch;
>>
>>       clear_bit(bit, buffer->channel_mask);
>>
>>       memset(buffer->scan_mask, 0,
>> BITS_TO_LONGS(indio_dev->masklength));  <---------
>>       for_each_set_bit(ch, buffer->channel_mask, indio_dev-
>>> num_channels)
>>           set_bit(indio_dev->channels[ch].scan_index, buffer-
>>> scan_mask);
>>       return 0;
>> }
>>
> Take a look at [1] for more details. Long story short, I think this is here because we have
> some devices where we have bit granularity. Hence, we map all channels to the same
> scan_index and to distinguish which channels are enabled, we could not use the current
> upstream implementation. I remember some talks about this but not actual patches
> came from it (I will have to go over those emails to see if I can come up with some
> patches).
>
> Regarding the memset, that looks like a bug. I guess we want:
>
> memset(buffer->scan_mask, 0, BITS_TO_LONGS(indio_dev->masklength) * sizeof(*buffer->scan_mask));
>
> Ccing Lars as he implemented this patches and might have something to add to
> your questions.
>
Yea, my fault, sorry. The patch looks good.
