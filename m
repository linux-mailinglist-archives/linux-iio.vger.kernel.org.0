Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AC81DCDC3
	for <lists+linux-iio@lfdr.de>; Thu, 21 May 2020 15:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgEUNMj (ORCPT <rfc822;lists+linux-iio@lfdr.de>);
        Thu, 21 May 2020 09:12:39 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:45424 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727846AbgEUNMj (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 May 2020 09:12:39 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 04LDBC4s078057;
        Thu, 21 May 2020 08:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1590066672;
        bh=VemXfjgt65Oev2cvZlMZZzFpOSjBFRiDmH0WqyBrDRQ=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=S0qqcneGOnHgQNxpZegvDc5igJJmd0uK65jmWBnKDd8kJ9TsVFF5Ta3ddZamcFu99
         XCeCXpyCFX0MXRCyp5UGGOG+1Q1R4dwmPomjqwwYzaqPIf79ALR+eNZfdRE8SID7BN
         pxrvlJmvROFC2i5N+A2frjD1dudJWkeeXxaRAvwo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LDBCJ5113114;
        Thu, 21 May 2020 08:11:12 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 21
 May 2020 08:11:11 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 21 May 2020 08:11:11 -0500
Received: from [10.250.38.163] (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 04LDBA8m061105;
        Thu, 21 May 2020 08:11:11 -0500
Subject: Re: [PATCH 07/11] iio:health:afe4403 Fix timestamp alignment and
 prevent data leak.
To:     Jonathan Cameron <jic23@jic23.retrosnub.co.uk>, <jic23@kernel.org>,
        <linux-iio@vger.kernel.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
References: <20200517173000.220819-1-jic23@kernel.org>
 <20200517173000.220819-8-jic23@kernel.org>
 <951a305b-b3b4-6cfc-f39a-f7458dfcb54b@ti.com>
 <83B13776-904F-4FCF-93A6-D430281E4B55@jic23.retrosnub.co.uk>
From:   "Andrew F. Davis" <afd@ti.com>
Message-ID: <c0e4e79e-2a1a-07cd-dd4b-91a87333bc4f@ti.com>
Date:   Thu, 21 May 2020 09:11:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <83B13776-904F-4FCF-93A6-D430281E4B55@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 5/18/20 12:06 PM, Jonathan Cameron wrote:
> 
> 
> On 18 May 2020 01:09:47 BST, "Andrew F. Davis" <afd@ti.com> wrote:
>> On 5/17/20 1:29 PM, jic23@kernel.org wrote:
>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>
>>> One of a class of bugs pointed out by Lars in a recent review.
>>> iio_push_to_buffers_with_timestamp assumes the buffer used is aligned
>>> to the size of the timestamp (8 bytes).  This is not guaranteed in
>>> this driver which uses a 32 byte array of smaller elements on the
>> stack.
>>> As Lars also noted this anti pattern can involve a leak of data to
>>> userspace and that indeed can happen here.  We close both issues by
>>> moving to a suitable structure in the iio_priv() data with alignment
>>> explicitly requested.  This data is allocated with kzalloc so no
>>> data can leak appart from previous readings.
>>>
>>> Fixes: eec96d1e2d31 ("iio: health: Add driver for the TI AFE4403
>> heart monitor")
>>> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Cc: Andrew F. Davis <afd@ti.com>
>>> ---
>>>  drivers/iio/health/afe4403.c | 9 ++++++---
>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/iio/health/afe4403.c
>> b/drivers/iio/health/afe4403.c
>>> index e9f87e42ff4f..a3507624b30f 100644
>>> --- a/drivers/iio/health/afe4403.c
>>> +++ b/drivers/iio/health/afe4403.c
>>> @@ -65,6 +65,7 @@ static const struct reg_field afe4403_reg_fields[]
>> = {
>>>   * @regulator: Pointer to the regulator for the IC
>>>   * @trig: IIO trigger for this device
>>>   * @irq: ADC_RDY line interrupt number
>>> + * @buffer: Used to construct data layout to push into IIO buffer.
>>>   */
>>>  struct afe4403_data {
>>>  	struct device *dev;
>>> @@ -74,6 +75,8 @@ struct afe4403_data {
>>>  	struct regulator *regulator;
>>>  	struct iio_trigger *trig;
>>>  	int irq;
>>> +	/* Ensure suitable alignment for timestamp */
>>> +	s32 buffer[8] __aligned(8);
>>
>>
>> One of those fancy structs with the timestamp specified would be nice
>> here like the other patches. IIRC we have 6 s32 channels, plus a s64
>> ts.
> 
> I think we may only have some of those channels enabled.  So ts may be it several
> locations in the buffer. 
> 

Might have been better to have the ts at the beginning, could have also
helped with alignment for when an odd number of channels are enabled.

> Hence we could use the structure approach but it might give a false sense
> of what is going on. 
> 

That's true, it can always be cleaned later then.

Andrew

> J
>>
>> Other than that everything looks good.
>>
>> Andrew
>>
>>
>>>  };
>>>  
>>>  enum afe4403_chan_id {
>>> @@ -309,7 +312,6 @@ static irqreturn_t afe4403_trigger_handler(int
>> irq, void *private)
>>>  	struct iio_dev *indio_dev = pf->indio_dev;
>>>  	struct afe4403_data *afe = iio_priv(indio_dev);
>>>  	int ret, bit, i = 0;
>>> -	s32 buffer[8];
>>>  	u8 tx[4] = {AFE440X_CONTROL0, 0x0, 0x0, AFE440X_CONTROL0_READ};
>>>  	u8 rx[3];
>>>  
>>> @@ -326,7 +328,7 @@ static irqreturn_t afe4403_trigger_handler(int
>> irq, void *private)
>>>  		if (ret)
>>>  			goto err;
>>>  
>>> -		buffer[i++] = get_unaligned_be24(&rx[0]);
>>> +		afe->buffer[i++] = get_unaligned_be24(&rx[0]);
>>>  	}
>>>  
>>>  	/* Disable reading from the device */
>>> @@ -335,7 +337,8 @@ static irqreturn_t afe4403_trigger_handler(int
>> irq, void *private)
>>>  	if (ret)
>>>  		goto err;
>>>  
>>> -	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
>> pf->timestamp);
>>> +	iio_push_to_buffers_with_timestamp(indio_dev, afe->buffer,
>>> +					   pf->timestamp);
>>>  err:
>>>  	iio_trigger_notify_done(indio_dev->trig);
>>>  
>>>
> 
