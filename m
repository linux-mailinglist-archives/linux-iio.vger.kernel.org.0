Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB69935346F
	for <lists+linux-iio@lfdr.de>; Sat,  3 Apr 2021 17:03:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236641AbhDCPDY (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sat, 3 Apr 2021 11:03:24 -0400
Received: from www381.your-server.de ([78.46.137.84]:45268 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231821AbhDCPDX (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Apr 2021 11:03:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=Aw1UNqJ5vEutFfUOJuRXblyd5gG8qhauQ3xAU2OtKaI=; b=NRu1djl1A64MiXCAr9ExVVzg0R
        i+m2b9VDizmYjavQjAgDC2rgfbnOGfqL4b/zXi7yVMW91ayYM3RDOCcDKQqKXnc5/yjKjP4x5ZLks
        noSSK0wHYWfh8GHe8OqZFvJ/+CPfCLcIqMPDiKGKf2yvNA+tCrFvlNRx1+rxLtjuhQ4GQweCFLMIt
        EQx8C9eqU5bEQtL7edP0TZC3HkFfBJ8Ra18xG7dOXWPOd3DHAYNGI/Vm8RCj4b8nyN/qpIAlSyR3h
        XCpKoKkWFFdUSQCCluYNJOoLYXPkYROIbKjk3W8i7p+CwK7zvE4TrRUX3VRzzM5vPogMkHx84OLNj
        7WqR4tDA==;
Received: from sslproxy02.your-server.de ([78.47.166.47])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lShnx-000B0U-Cz; Sat, 03 Apr 2021 17:03:17 +0200
Received: from [2001:a61:2aa1:1e01:9e5c:8eff:fe01:8578]
        by sslproxy02.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lShnx-000PvC-8K; Sat, 03 Apr 2021 17:03:17 +0200
Subject: Re: [PATCH v2 2/2] iio: temperature: add driver support for ti tmp117
To:     Puranjay Mohan <puranjay12@gmail.com>
Cc:     alexandru.ardelean@analog.com, Jonathan Cameron <jic23@kernel.org>,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20210401091648.87421-1-puranjay12@gmail.com>
 <20210401091648.87421-3-puranjay12@gmail.com>
 <7a9097bf-9f8d-0fe7-7b5e-84643bcff760@metafoo.de>
 <CANk7y0gwSZgxzmxtOZayyy_TrUP+rbjtN4WXZAsZE7E46UmUDg@mail.gmail.com>
From:   Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <e76fbb33-f0d9-6067-0a44-aa7e7646595e@metafoo.de>
Date:   Sat, 3 Apr 2021 17:03:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <CANk7y0gwSZgxzmxtOZayyy_TrUP+rbjtN4WXZAsZE7E46UmUDg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26129/Sat Apr  3 13:05:44 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 4/3/21 4:58 PM, Puranjay Mohan wrote:
> On Fri, Apr 2, 2021 at 1:43 PM Lars-Peter Clausen <lars@metafoo.de> wrote:
>> On 4/1/21 11:16 AM, Puranjay Mohan wrote:
>>> TMP117 is a Digital temperature sensor with integrated NV memory.
>>>
>>> Add support for tmp117 driver in iio subsystem.
>>> Datasheet:-https://www.ti.com/lit/gpn/tmp117
>>>
>>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>> Nice and clean driver. Just some comments about the CALIBBIAS.
>>
>>> [...]
>>> +#define TMP117_RESOLUTION_10UC               78125
>> Isn't the unit here 100 uC?
> it is 7.8125 milli degrees_C so 78125 x 10^-4 milli degrees_C
> which is 78125 x 10^-4 x 10^3 micro degrees_C
> so it becomes 78125 x 10^-1 micro degrees_C = 78125 10_microdegrees_C.
> Did it in detail so I remember it in the future. I guess you thought
> it as 0.78125 millidegrees_C?
Ah, I get it, it is a tenth micro degree, not tens of micro degrees, 
sorry got confused.
> [...]
>
>> I think that would be quite unexpected behavior. The unit should be the
>> same. Here in the read function you can just return the register value.
> Okay, if you feel that would be right then I will do it.
Yea, I think reading and writing in different units would be a bit 
confusing.
>> Just make sure to properly sign extend like for the RAW property.
>>
>>> +             return IIO_VAL_INT_PLUS_MICRO;
>>> [...]
>>> +}
>>> +
>>> +static int tmp117_write_raw(struct iio_dev *indio_dev,
>>> +             struct iio_chan_spec const *channel, int val,
>>> +             int val2, long mask)
>>> +{
>>> +     struct tmp117_data *data = iio_priv(indio_dev);
>>> +     s16 off;
>>> +
>>> +     switch (mask) {
>>> +     case IIO_CHAN_INFO_CALIBBIAS:
>>> +             off = (s16)val;
>> This should have some input validation to avoid writing bogus values to
>> the register when the value is out of range. You can either reject out
>> of range values or clamp them into the valid range (using the clamp()
>> macro).
> the maximum value which this register takes is 0xffff, so it should
> get clamped automatically when casting to s16?
> I might be wrong here.
Casting will truncate the upper bits. So something like 0x12345 gets 
turned into 0x2345.
>
>>> +             return i2c_smbus_write_word_swapped(data->client,
>>> +                                             TMP117_REG_TEMP_OFFSET, off);
>>> +
>>> +     default:
>>> +             return -EINVAL;
>>> +     }
>>> +}
>>> +
>> [...]
>
>

