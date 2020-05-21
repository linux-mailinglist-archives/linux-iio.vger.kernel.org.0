Return-Path: <linux-iio-owner@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2841DD09D
	for <lists+linux-iio@lfdr.de>; Thu, 21 May 2020 16:59:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729784AbgEUO7n convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-iio@lfdr.de>); Thu, 21 May 2020 10:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729740AbgEUO7m (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 21 May 2020 10:59:42 -0400
X-Greylist: delayed 887 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 21 May 2020 07:59:42 PDT
Received: from haggis.mythic-beasts.com (haggis.mythic-beasts.com [IPv6:2a00:1098:0:86:1000:0:2:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BE5FC061A0E
        for <linux-iio@vger.kernel.org>; Thu, 21 May 2020 07:59:42 -0700 (PDT)
Received: from [2a00:1098:80::1:1] (port=34436 helo=erriapus.retrosnub.co.uk)
        by haggis.mythic-beasts.com with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92.3)
        (envelope-from <jic23@jic23.retrosnub.co.uk>)
        id 1jbmRB-0004Pb-LO; Thu, 21 May 2020 15:44:45 +0100
Received: from [192.168.0.10] (cpc149474-cmbg20-2-0-cust94.5-4.cable.virginm.net [82.4.196.95])
        by erriapus.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id BDF403A0109;
        Thu, 21 May 2020 15:44:42 +0100 (BST)
Date:   Thu, 21 May 2020 15:44:43 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <c0e4e79e-2a1a-07cd-dd4b-91a87333bc4f@ti.com>
References: <20200517173000.220819-1-jic23@kernel.org> <20200517173000.220819-8-jic23@kernel.org> <951a305b-b3b4-6cfc-f39a-f7458dfcb54b@ti.com> <83B13776-904F-4FCF-93A6-D430281E4B55@jic23.retrosnub.co.uk> <c0e4e79e-2a1a-07cd-dd4b-91a87333bc4f@ti.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Subject: Re: [PATCH 07/11] iio:health:afe4403 Fix timestamp alignment and prevent data leak.
To:     "Andrew F. Davis" <afd@ti.com>, jic23@kernel.org,
        linux-iio@vger.kernel.org
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Lars-Peter Clausen <lars@metafoo.de>
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
Message-ID: <5763033E-38E7-434A-AAA9-E5D27FEDBA35@jic23.retrosnub.co.uk>
X-Mythic-Source-External: YES
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org



On 21 May 2020 14:11:10 BST, "Andrew F. Davis" <afd@ti.com> wrote:
>
>
>On 5/18/20 12:06 PM, Jonathan Cameron wrote:
>> 
>> 
>> On 18 May 2020 01:09:47 BST, "Andrew F. Davis" <afd@ti.com> wrote:
>>> On 5/17/20 1:29 PM, jic23@kernel.org wrote:
>>>> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>>
>>>> One of a class of bugs pointed out by Lars in a recent review.
>>>> iio_push_to_buffers_with_timestamp assumes the buffer used is
>aligned
>>>> to the size of the timestamp (8 bytes).  This is not guaranteed in
>>>> this driver which uses a 32 byte array of smaller elements on the
>>> stack.
>>>> As Lars also noted this anti pattern can involve a leak of data to
>>>> userspace and that indeed can happen here.  We close both issues by
>>>> moving to a suitable structure in the iio_priv() data with
>alignment
>>>> explicitly requested.  This data is allocated with kzalloc so no
>>>> data can leak appart from previous readings.
>>>>
>>>> Fixes: eec96d1e2d31 ("iio: health: Add driver for the TI AFE4403
>>> heart monitor")
>>>> Reported-by: Lars-Peter Clausen <lars@metafoo.de>
>>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>>> Cc: Andrew F. Davis <afd@ti.com>
>>>> ---
>>>>  drivers/iio/health/afe4403.c | 9 ++++++---
>>>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/iio/health/afe4403.c
>>> b/drivers/iio/health/afe4403.c
>>>> index e9f87e42ff4f..a3507624b30f 100644
>>>> --- a/drivers/iio/health/afe4403.c
>>>> +++ b/drivers/iio/health/afe4403.c
>>>> @@ -65,6 +65,7 @@ static const struct reg_field
>afe4403_reg_fields[]
>>> = {
>>>>   * @regulator: Pointer to the regulator for the IC
>>>>   * @trig: IIO trigger for this device
>>>>   * @irq: ADC_RDY line interrupt number
>>>> + * @buffer: Used to construct data layout to push into IIO buffer.
>>>>   */
>>>>  struct afe4403_data {
>>>>  	struct device *dev;
>>>> @@ -74,6 +75,8 @@ struct afe4403_data {
>>>>  	struct regulator *regulator;
>>>>  	struct iio_trigger *trig;
>>>>  	int irq;
>>>> +	/* Ensure suitable alignment for timestamp */
>>>> +	s32 buffer[8] __aligned(8);
>>>
>>>
>>> One of those fancy structs with the timestamp specified would be
>nice
>>> here like the other patches. IIRC we have 6 s32 channels, plus a s64
>>> ts.
>> 
>> I think we may only have some of those channels enabled.  So ts may
>be it several
>> locations in the buffer. 
>> 
>
>Might have been better to have the ts at the beginning, could have also
>helped with alignment for when an odd number of channels are enabled.

Perhaps but for many use cases we don't turn timestamps on and we would need to pad
 anyway for alignment of the fifo. 

>
>> Hence we could use the structure approach but it might give a false
>sense
>> of what is going on. 
>> 
>
>That's true, it can always be cleaned later then.

Agreed. This is definitely something we can revisit sometime in the future. 

J
>
>Andrew
>
>> J
>>>
>>> Other than that everything looks good.
>>>
>>> Andrew
>>>
>>>
>>>>  };
>>>>  
>>>>  enum afe4403_chan_id {
>>>> @@ -309,7 +312,6 @@ static irqreturn_t afe4403_trigger_handler(int
>>> irq, void *private)
>>>>  	struct iio_dev *indio_dev = pf->indio_dev;
>>>>  	struct afe4403_data *afe = iio_priv(indio_dev);
>>>>  	int ret, bit, i = 0;
>>>> -	s32 buffer[8];
>>>>  	u8 tx[4] = {AFE440X_CONTROL0, 0x0, 0x0, AFE440X_CONTROL0_READ};
>>>>  	u8 rx[3];
>>>>  
>>>> @@ -326,7 +328,7 @@ static irqreturn_t afe4403_trigger_handler(int
>>> irq, void *private)
>>>>  		if (ret)
>>>>  			goto err;
>>>>  
>>>> -		buffer[i++] = get_unaligned_be24(&rx[0]);
>>>> +		afe->buffer[i++] = get_unaligned_be24(&rx[0]);
>>>>  	}
>>>>  
>>>>  	/* Disable reading from the device */
>>>> @@ -335,7 +337,8 @@ static irqreturn_t afe4403_trigger_handler(int
>>> irq, void *private)
>>>>  	if (ret)
>>>>  		goto err;
>>>>  
>>>> -	iio_push_to_buffers_with_timestamp(indio_dev, buffer,
>>> pf->timestamp);
>>>> +	iio_push_to_buffers_with_timestamp(indio_dev, afe->buffer,
>>>> +					   pf->timestamp);
>>>>  err:
>>>>  	iio_trigger_notify_done(indio_dev->trig);
>>>>  
>>>>
>> 

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
