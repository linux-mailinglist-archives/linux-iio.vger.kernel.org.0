Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D56DE343133
	for <lists+linux-iio@lfdr.de>; Sun, 21 Mar 2021 06:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229995AbhCUFX2 (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Sun, 21 Mar 2021 01:23:28 -0400
Received: from www381.your-server.de ([78.46.137.84]:53078 "EHLO
        www381.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbhCUFXM (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 21 Mar 2021 01:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=metafoo.de;
         s=default2002; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
        MIME-Version:Date:Message-ID:References:To:From:Subject:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID;
        bh=jugzcHOdoc+jFR0v95Uoef9LUJMSkODEACuDjFDwbL8=; b=FKTbm39MruxXV3guj67rHGK8K8
        s3vqsQnoCuj3pUvBW9dDvtw95DigKiQDVotDpB2SewffCs1d72rhGs4NFaI88canU/WnLStFyKTZK
        TUiGflTTyqq+uXF/Fq/zqqECpz4vpML9GlMKrcL+QRS2ZQ1olzctIoLdS/jnrVJeY8R9boRko9A95
        qM4LPjmO//d52ET1o7ouHRdVSi8ozqEGS812a1PGHM0ls0+XJFAHz1Vd87/SxtXbsNagpBbCx2/mB
        AuG+HXQD2HD+X/ha20EKgNyrNbVr1dUoKzIbLKlzuvN0WebY4YPkPFOofrochKYYMdZk6Umo0oP0L
        ICkvbD+w==;
Received: from sslproxy06.your-server.de ([78.46.172.3])
        by www381.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <lars@metafoo.de>)
        id 1lNqYO-000BBX-Gs; Sun, 21 Mar 2021 06:23:08 +0100
Received: from [2001:a61:2aa9:e001:9e5c:8eff:fe01:8578]
        by sslproxy06.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <lars@metafoo.de>)
        id 1lNqYO-0008jg-Br; Sun, 21 Mar 2021 06:23:08 +0100
Subject: Re: [PATCH v1 2/2] iio: temperature: add driver support for ti tmp117
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Puranjay Mohan <puranjay12@gmail.com>,
        alexandru.ardelean@analog.com, jic23@kernel.org,
        devicetree@vger.kernel.org, knaack.h@gmx.de,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210320064509.119878-1-puranjay12@gmail.com>
 <20210320064509.119878-3-puranjay12@gmail.com>
 <760dccc2-b098-71ce-037b-b667dbc05f57@metafoo.de>
Message-ID: <8cdd7333-cfeb-d6af-829b-47f45fbc0eb1@metafoo.de>
Date:   Sun, 21 Mar 2021 06:23:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <760dccc2-b098-71ce-037b-b667dbc05f57@metafoo.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Authenticated-Sender: lars@metafoo.de
X-Virus-Scanned: Clear (ClamAV 0.102.4/26115/Sat Mar 20 12:03:55 2021)
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On 3/21/21 6:07 AM, Lars-Peter Clausen wrote:
> On 3/20/21 7:45 AM, Puranjay Mohan wrote:
>> TMP117 is a Digital temperature sensor with integrated NV memory.
>>
>> Add support for tmp117 driver in iio subsystem.
>>
>> Datasheet:-https://www.ti.com/lit/gpn/tmp117
>>
>> Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
>
> This looks good to me. Just two small bits I overlooked during the 
> first review, sorry for that.
>
>> +};
>> +
>> [...]
>> +static int tmp117_read_raw(struct iio_dev *indio_dev,
>> +        struct iio_chan_spec const *channel, int *val,
>> +        int *val2, long mask)
>> +{
>> +    struct tmp117_data *data = iio_priv(indio_dev);
>> +    u16 tmp, off;
>> +
>> +    switch (mask) {
>> +    case IIO_CHAN_INFO_RAW:
>> +        tmp = tmp117_read_reg(data, TMP117_REG_TEMP);
>> +        *val = tmp;
> No need for tmp here. Just directly assign to val.

Actually thinking about this, does the current implementation work 
correctly for negative temperatures?

I think there are two options to fix it. Either cast to s16 or use the 
sign_extend32() function.

Have a look at how the tmp006 driver handles this. It is a good example, 
including the error checking. In general you should check if your I2C 
read failed and return an error in that case rather than a bogus value 
for the measurement. Same for when reading the calibration offset.

Another thing. IIO reports temperature values in milli degrees Celsius. 
I believe in the current implementation the scale is so that it will 
report in degrees Celsius instead.

