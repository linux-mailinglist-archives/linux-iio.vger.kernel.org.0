Return-Path: <linux-iio+bounces-22422-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E2F55B1E1BD
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 07:37:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 488863AA387
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 05:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB91183CA6;
	Fri,  8 Aug 2025 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dvjqnSjo"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB0E2E36E2;
	Fri,  8 Aug 2025 05:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754631432; cv=none; b=R7v6aWlGsksuqQPPD9QxcyjGKZm7YRH3QdG8bD48KKujlhKBf2NCSu+oU8yutEA0R1ACd54OltpGLUKnASfAS4unm/aF8WbDHmhS3EI5bJ+CfQn6wJcCWaP4d8kekxXyXb65RtQa8K455PQyzhUSnKwl18+nh2mgyjJt9Gk/IM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754631432; c=relaxed/simple;
	bh=ReL259bd3nivSX01LUnw3ZxcDEEvimVynQ4TPXsCw3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=D35cYBXzGc43Z7UxPovcuKsJ422MylgBo+degmfv9vsyb3WeMC/Zac10rNxz+3j+qMqy1SfoTgkf0GRbQ8/fQl5JiXcKF7OGF3cGaaz6PV9NSCZ09CDj0IU27aQHzis6GWX8psDzC9ZVxO3eHEyoBmfVgt+yNHkHKKl0YdxMS5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dvjqnSjo; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-55b93104888so2093998e87.1;
        Thu, 07 Aug 2025 22:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754631429; x=1755236229; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P9/PTLlgH6H5EC5DYrgVjUTcm9G2X86SzOWmbd7na+0=;
        b=dvjqnSjoC1q4LrAZjzOjeWrohfO3y6qyexUnLoAObjZb60qNA0cffyH981hnHOuFZf
         UCeWgQZ77S3Po02zjyu4GYY1ITq3PsXYf7XjSloXHPVBji4fJTtgj8hxrG9cz4ao6D1c
         Zo0NY0ddy+EMm1oWKINfPRYEXwp6RlP8DnxL916O9hXrDZPpheztL5agYLRlgZlLGbFi
         CqTUrxMwc4D1gYyMNUoSsUqwD7x5cdjQiqi8uEEwZmK0vi1bDdYqcJtw9HAgE0zOz6qq
         NZOoBjgvMZjY83UMXM/ssnwrOpGjfLxtEb3BkLyWP/3xdrVFtnrSgquKVFJ5jYoetVIT
         ekbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754631429; x=1755236229;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9/PTLlgH6H5EC5DYrgVjUTcm9G2X86SzOWmbd7na+0=;
        b=qaMUNkOnrEqj/hNKd9ZukHGrU0l+y7qwtQMoDHsE8Shu1JtAlJDKfhsrJDbAZu6tfN
         oTyyJ0T3xTcAuvjZ48eVGXqkTbP27urzHHGTH9+XFJ3Qv/Pq69DKyHFuGh+/6sPJ2QyB
         V/nTruU0VRoEAJ84cyW6yWSpp+BFICMe/33U5oiMhTdk3vdjGPAE7hc3SscVMRIEllwH
         VEI7Gy3Fkv2NvkGAb76vbtWSFqr+9+CjcfOtjMJyiqm1LeL3D9BvlQ948W2R6+4ajxaB
         09/X6JIRYGGj4JfXTLkjtZVryui37iQC0nn2ojDmVLp6ibRj+7aQpiCzhJmNgx01Zh87
         z1RQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4qcHhkGiaFp3hmjbjHkE2aoyb4tvBCCo1951t+JijPml1vQ0kJMIDSOu1cu1UtN83KaEICWOhOR7Emhjh@vger.kernel.org, AJvYcCWMxEoPIC8uSW3Ciob4MRjwdKlO0grNXrENKhDjmwgeAHQXGO2U2Q/Mjpa8TOcmlWi89EcrMz37xVWK@vger.kernel.org, AJvYcCXD4dtanwZWuCttigXKO8EbKAib98/TtMno6tmglD14nmf7zqIUzFyivOyv1FcQntfIArxmR15Gt0Tw@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8sFCuXJ8yUSPlvx11aX3mKGZuPVAH1zS1H7aR4DaTCO7Kqq84
	n+jiLDQAD2gHMW+tKCx4xq3FaFa/JKRuBKzgo3MBFCPzdaivQGKCck8r9E7W9Q==
X-Gm-Gg: ASbGncsA/byawweTO9rtFCE10GlTHOPyFJ8ciFtYnPFPS0rRFzlO3bUYvwjbaG9anEa
	b8t+bwDUUMgLNN56wkvLEaIA1tVIYkbTyxTTwmOstOJzX/Eh2XJe4yVHh7BiQjtFisU4O2PDSOH
	HGY9m+WE2VbBBBscuGW4BrjnbKsjDeggZsMTUzrH2IXGGsgXrw0APHlqT/Pz34a8Qz63qxvLQki
	kaN3jhDzs47WaNQV+bGu88dZdm6mJ0FdzbcaLpriKYm/SUSn7qlQvbYX6uj99XtvqCdHjvTWISM
	cq96v0j+IHLGjtKLxqeOfcl/Ziwfw+oI8elBHbUIh1blC7ImdDjEmXWfAY0/uuwmQG1rvfrClT/
	C1qIuEiWuOoHeTyqyguAaVsDXNGd60GTYy6/pFNOXi/OTXg57dcTG0RlzPKMrmVrOucdMNnXF00
	ymB1g=
X-Google-Smtp-Source: AGHT+IEg7RdFfQO0GXa0yuWQlV7B7yBjP3q7pEgqUTQzeECC2LPJePgL3tFZ0W3k1uOTomJ+JO5hJQ==
X-Received: by 2002:a05:6512:3ca4:b0:55b:8698:6a1d with SMTP id 2adb3069b0e04-55cc00ad9f0mr416886e87.3.1754631428733;
        Thu, 07 Aug 2025 22:37:08 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cabae7sm2850880e87.143.2025.08.07.22.37.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Aug 2025 22:37:08 -0700 (PDT)
Message-ID: <076b7f07-e755-4fe7-84b1-f3f495978008@gmail.com>
Date: Fri, 8 Aug 2025 08:37:07 +0300
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/10] iio: adc: ad7476: Drop convstart chan_spec
To: =?UTF-8?Q?Nuno_S=C3=A1?= <noname.nuno@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
 Lars-Peter Clausen <lars@metafoo.de>,
 Michael Hennerich <Michael.Hennerich@analog.com>,
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>,
 =?UTF-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1754559149.git.mazziesaccount@gmail.com>
 <09bf5e7973c37413ada950741e6e09c375e37c57.1754559149.git.mazziesaccount@gmail.com>
 <tc4od3jtqnj743naxefx5lxkha46wohuuvw46mik6nullvsqbe@knj4t23eaodw>
 <ngcbj6p7vfakah5fqsxqjlmrcycpg5rxfrbh4s34fll2kb3zq2@eyesluawn5w2>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <ngcbj6p7vfakah5fqsxqjlmrcycpg5rxfrbh4s34fll2kb3zq2@eyesluawn5w2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07/08/2025 16:10, Nuno Sá wrote:
> On Thu, Aug 07, 2025 at 01:41:31PM +0100, Nuno Sá wrote:
>> On Thu, Aug 07, 2025 at 12:34:52PM +0300, Matti Vaittinen wrote:
>>> The ad7476 driver defines separate chan_spec structures for operation
>>> with and without convstart GPIO. At quick glance this may seem as if the
>>> driver did provide more than 1 data-channel to users - one for the
>>> regular data, other for the data obtained with the convstart GPIO.
>>>
>>> The only difference between the 'convstart' and 'non convstart'
>>> -channels is presence / absence of the BIT(IIO_CHAN_INFO_RAW) in
>>> channel's flags.
>>>
>>> We can drop the convstart channel spec, and related convstart macro, by
>>> allocating a mutable per driver instance channel spec an adding the flag
>>> in probe if needed. This will simplify the driver with the cost of added
>>> memory consumption.
>>>
>>> Assuming there aren't systems with very many ADCs and very few
>>> resources, this tradeoff seems worth making.
>>>
>>> Simplify the driver by dropping the 'convstart' channel spec and
>>> allocating the chan spec for each driver instance.
>>
>> I do not agree with this one. Looking at the diff, code does not look
>> simpler to me...
> 
> Ok, on a second thought I'm ok with this. It makes adding devices easier
> and (IIUC) for the one you're adding later we only have "convst_channel"
> channels.

Yes, that's right. The BD79105 requires the convstart.

> On comment though...
> 
>>
>> - Nuno Sá
>>
>>>
>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>
>>> ---
>>> Revision history:
>>>   v1 => v2:
>>>   - New patch
>>>
>>> I considered squashing this change with the one limiting the chip_info
>>> scope. Having this as a separate change should help reverting if someone
>>> complains about the increased memory consumption though.
>>> ---
>>>   drivers/iio/adc/ad7476.c | 31 ++++++++++++++++++-------------
>>>   1 file changed, 18 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
>>> index e97742912b8e..a30eb016c11c 100644
>>> --- a/drivers/iio/adc/ad7476.c
>>> +++ b/drivers/iio/adc/ad7476.c
>>> @@ -29,8 +29,6 @@ struct ad7476_state;
>>>   struct ad7476_chip_info {
>>>   	unsigned int			int_vref_mv;
>>>   	struct iio_chan_spec		channel[2];
>>> -	/* channels used when convst gpio is defined */
>>> -	struct iio_chan_spec		convst_channel[2];
>>>   	void (*reset)(struct ad7476_state *);
>>>   	bool				has_vref;
>>>   	bool				has_vdrive;
>>> @@ -41,6 +39,7 @@ struct ad7476_state {
>>>   	struct gpio_desc		*convst_gpio;
>>>   	struct spi_transfer		xfer;
>>>   	struct spi_message		msg;
>>> +	struct iio_chan_spec		channel[2];
>>>   	int				scale_mv;
>>>   	/*
>>>   	 * DMA (thus cache coherency maintenance) may require the
>>> @@ -153,24 +152,18 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>>>   #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
>>>   		BIT(IIO_CHAN_INFO_RAW))
>>>   #define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
>>> -#define AD7091R_CONVST_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), \
>>> -		BIT(IIO_CHAN_INFO_RAW))
>>>   #define ADS786X_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
>>>   		BIT(IIO_CHAN_INFO_RAW))
>>>   
>>>   static const struct ad7476_chip_info ad7091_chip_info = {
>>>   	.channel[0] = AD7091R_CHAN(12),
>>>   	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>>> -	.convst_channel[0] = AD7091R_CONVST_CHAN(12),
>>> -	.convst_channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>>>   	.reset = ad7091_reset,
>>>   };
>>>   
>>>   static const struct ad7476_chip_info ad7091r_chip_info = {
>>>   	.channel[0] = AD7091R_CHAN(12),
>>>   	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>>> -	.convst_channel[0] = AD7091R_CONVST_CHAN(12),
>>> -	.convst_channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>>>   	.int_vref_mv = 2500,
>>>   	.has_vref = true,
>>>   	.reset = ad7091_reset,
>>> @@ -282,7 +275,7 @@ static int ad7476_probe(struct spi_device *spi)
>>>   	const struct ad7476_chip_info *chip_info;
>>>   	struct ad7476_state *st;
>>>   	struct iio_dev *indio_dev;
>>> -	int ret;
>>> +	int ret, i;
>>>   
>>>   	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>>>   	if (!indio_dev)
>>> @@ -332,16 +325,28 @@ static int ad7476_probe(struct spi_device *spi)
>>>   	if (IS_ERR(st->convst_gpio))
>>>   		return PTR_ERR(st->convst_gpio);
>>>   
>>> +	/*
>>> +	 * This will never realize. Unless someone changes the channel specs
>>> +	 * in this driver. And if someone does, without changing the loop
>>> +	 * below, then we'd better immediately produce a big fat error, before
>>> +	 * the change proceeds from that developer's table.
>>> +	 */
>>> +	BUILD_BUG_ON(ARRAY_SIZE(st->channel) != ARRAY_SIZE(chip_info->channel));
> 
> I guess it make sense but still looks too fancy for this :)

Nothing else but a developer's carefulness keeps the number of channels 
"in sync" for these two structs. I was originally doing WARN_ON() - but 
then I thought that it's be even better to catch this at build time. 
Then I found the BUILD_BUG_ON(). I see Andy suggested static_assert() 
instead - I've no idea why one is preferred over other though. Let's see 
if I get educated by Andy :)

> 
>>> +	for (i = 0; i < ARRAY_SIZE(st->channel); i++) {
>>> +		st->channel[i] = chip_info->channel[i];
>>> +		if (st->convst_gpio)
> 
> I would flip this an do:
> 	if (!st->convst_gpio)
> 		break;

To me this would just add an extra line of code, and more complex flow. 
I would definitely agree if there were more operations to be done for 
the 'convstart channels' - but since this is really just "if it's 
convstart, then set a bit" - the

if (foo)
	bar;

seems simpler than

if (!foo)
	break;
bar;

> 		
>>> +			st->channel[i].info_mask_separate |=
>>> +				BIT(IIO_CHAN_INFO_RAW);
> 		
> 		__set_bit()...

Ok. Thanks.


Thanks for the review(s) Nuno!

Yours,
	-- Matti

