Return-Path: <linux-iio+bounces-22445-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DC5B1E555
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 11:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243277AD7E9
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 09:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C04526738D;
	Fri,  8 Aug 2025 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOyTYQ8y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CE4E185E7F;
	Fri,  8 Aug 2025 09:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754644167; cv=none; b=r00LyaOB0LeIKcu0DymV42nQS20zcN5NWGGTi2Sc4qLCzFgS259wJ5UWMOq4NckOmcw78nQasFNHzpBP+rOYk5UHb5T959sM8rUIL1FWX5uSg05xmYs6CpRcRyMChRuUiSEj8I1Jt4BzHWOs66E9K1pgjuXgDV62MgmPnuU+y+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754644167; c=relaxed/simple;
	bh=UHvouIrH/mfUJnNlR3Q/bjILhyKU9ohDk/1rFR6ApJU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W2qDVwFzyK35sjTBbE0Lt8WFjwsAd1yNUgAYq6CR8+sapSzoAxv+6flkn0H3gmPptd2iMdiKC/V3g+U8vPdNrKuPYpD0MDV9xikReYy14HKdWMVnjTpWVY7fYOx2VDCVoN3JKniXz+dbx/AuxPkh6oaw8pcjexsJfGV32iE0Tuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOyTYQ8y; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-55b827aba01so1820603e87.0;
        Fri, 08 Aug 2025 02:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754644163; x=1755248963; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XdTS2IbOaTlOvfIW5t2Y16yPR+poauLghlKNM78GqwY=;
        b=VOyTYQ8yxhh8UmIRejUxoN+O6HbLvEKxMWrqDacHxWD/4MkmelWenI0vicM7T2AdGY
         qG0mw+/1H0QS25H4T4mVYUlYSgU6RkbPqaoitR/UqDxQp16XtLj9pHmBMndksQVR35Kr
         zUDrtUVjRBtg5dfXzdVKxd7yb4MQrP24di0q72viXMa0kL2GEj9my3EdcDEXLVRIrw9K
         +pdFu3jZnZ26NMw2pAY95q+rwz0gRromPxfmp/tLp2TM7ttiHOm9NlOEvV7tQVP0VehR
         dLcMoxS9yiz1NCx4pb67BoE+JTeIcPAayZQ2nv3no1wYFUgKbfCqQy8ObFHXqMcmyAs0
         UI9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754644163; x=1755248963;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XdTS2IbOaTlOvfIW5t2Y16yPR+poauLghlKNM78GqwY=;
        b=bRjs/wuSlgEu+0U2jgrWP0/3K2Sm07mnvyvEDVQ0OAiwoIxo8IPTP/K16GT+itbsKW
         sJ7UMaXCQJeBNrUStJ/UNGLU808Brb/MxEbOUsE7YYeUTRBupsKX3305aqFWICdo3njy
         sXfrnWv4M6VH/SyoQlseyQ7gTnKXc8tJ1sfzsE2kF/p5XD6fKMGYhaCdjzEEHoem22xE
         pT4KUsvq+qxeMsJa1TXw9fCDEWDT1Ai0siTbXJOWxE9ODAOJ8Ad9RtrFyJrU8NJZAO77
         y2pghK5ZaS3CNRRakWsE2naMjSvUDyFt/Kb3xbF+aXm5a8y290UiD2dQfm3IR+am3HiJ
         ZbOg==
X-Forwarded-Encrypted: i=1; AJvYcCWAx+q95SRzq173A91hEPpSnl0P/m3PdHj+jaG9lmalXnmvkqm0g2sSwDjsiTXotRaXEvdwiqLSmBTU@vger.kernel.org, AJvYcCXqpZFbiW9/VzzVHRmIUUtsnzjuFwn5iRVIh7fM9Y3rB2hNY8ATiDVbQ5FYm58bwBrXIMXD1Ovu2AQsZknJ@vger.kernel.org, AJvYcCXsqRCDe6l2sldM7QJOpBykDomT7R1/QU+v+HAAVbh2X1Mt7ScWDNkWS7N38XAj4nt7e3WrB25STeCR@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl8dArjeUIfx4HzyK85nf/grF8sJCJlANIkJLM9+zAEreHo9G9
	+X9YD2YMncfmBLsBt9Y1VlHVUZyhGLld/p74E+7e7IwgN4ht8oDR9U27
X-Gm-Gg: ASbGncvcp7O6oK8huZ3Phr2hjUWz1a3CAvg87B+zcddVRJ07nDiW/k79u3M2M5ffZmH
	fDYI3XIqasU8UtL2FCmi1nn2e5BXCRHC8Rx/UPlgBgs/3uJEEG1pLR/O7aXodnxIZwHcGy0Fi5M
	wZRoGWVkjK9M2guhSLUCKcFrQjNQyO/W75Dj6o2JKHtNGCrm0hdxhWVt+R5WSC+WHd8RODPRNgH
	TwpLt3mja5bvCxNqvJQkTKVaAvlr//l5zt62RwUG4hZMIrHnyoecfgBxGX9vyiuNeydyUd+NoQh
	ZZyKgQjK+bFSibstgpAb9wy4vZdmnbxXYAvOQ5fQ7fVB2TCTaPRMvMqZKTqOF0WrzwA7oCSs8z3
	jSKyDErmn3DoFVccQCUHYD5en7sBlgETlMhHMNIDnG9E8m14sbESNiJh06utx92Ro94rz+TIRd6
	l1zjU=
X-Google-Smtp-Source: AGHT+IFAxXS5fmM5d7jNsC2BbaecBEp8fV5ejq2biueT5V0HQk9irrmyJdjtJ314bqpDST/JZeoCBA==
X-Received: by 2002:a05:6512:1106:b0:55b:8827:b7b6 with SMTP id 2adb3069b0e04-55cc014a6efmr476437e87.48.1754644162889;
        Fri, 08 Aug 2025 02:09:22 -0700 (PDT)
Received: from ?IPV6:2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703? ([2a10:a5c0:800d:dd00:8fdf:935a:2c85:d703])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b88cabbd8sm3005319e87.149.2025.08.08.02.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Aug 2025 02:09:22 -0700 (PDT)
Message-ID: <62dbfa31-002b-4008-9273-01b161a72cac@gmail.com>
Date: Fri, 8 Aug 2025 12:09:21 +0300
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
 <076b7f07-e755-4fe7-84b1-f3f495978008@gmail.com>
 <t54tty4xbcsozeouoqmytdw6saedgoxbemnr2azbiv2f4h2wta@rf4fnooawrgs>
Content-Language: en-US, en-AU, en-GB, en-BW
From: Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <t54tty4xbcsozeouoqmytdw6saedgoxbemnr2azbiv2f4h2wta@rf4fnooawrgs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 08/08/2025 12:00, Nuno Sá wrote:
> On Fri, Aug 08, 2025 at 08:37:07AM +0300, Matti Vaittinen wrote:
>> On 07/08/2025 16:10, Nuno Sá wrote:
>>> On Thu, Aug 07, 2025 at 01:41:31PM +0100, Nuno Sá wrote:
>>>> On Thu, Aug 07, 2025 at 12:34:52PM +0300, Matti Vaittinen wrote:
>>>>> The ad7476 driver defines separate chan_spec structures for operation
>>>>> with and without convstart GPIO. At quick glance this may seem as if the
>>>>> driver did provide more than 1 data-channel to users - one for the
>>>>> regular data, other for the data obtained with the convstart GPIO.
>>>>>
>>>>> The only difference between the 'convstart' and 'non convstart'
>>>>> -channels is presence / absence of the BIT(IIO_CHAN_INFO_RAW) in
>>>>> channel's flags.
>>>>>
>>>>> We can drop the convstart channel spec, and related convstart macro, by
>>>>> allocating a mutable per driver instance channel spec an adding the flag
>>>>> in probe if needed. This will simplify the driver with the cost of added
>>>>> memory consumption.
>>>>>
>>>>> Assuming there aren't systems with very many ADCs and very few
>>>>> resources, this tradeoff seems worth making.
>>>>>
>>>>> Simplify the driver by dropping the 'convstart' channel spec and
>>>>> allocating the chan spec for each driver instance.
>>>>
>>>> I do not agree with this one. Looking at the diff, code does not look
>>>> simpler to me...
>>>
>>> Ok, on a second thought I'm ok with this. It makes adding devices easier
>>> and (IIUC) for the one you're adding later we only have "convst_channel"
>>> channels.
>>
>> Yes, that's right. The BD79105 requires the convstart.
>>
>>> On comment though...
>>>
>>>>
>>>> - Nuno Sá
>>>>
>>>>>
>>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>>>>>
>>>>> ---
>>>>> Revision history:
>>>>>    v1 => v2:
>>>>>    - New patch
>>>>>
>>>>> I considered squashing this change with the one limiting the chip_info
>>>>> scope. Having this as a separate change should help reverting if someone
>>>>> complains about the increased memory consumption though.
>>>>> ---
>>>>>    drivers/iio/adc/ad7476.c | 31 ++++++++++++++++++-------------
>>>>>    1 file changed, 18 insertions(+), 13 deletions(-)
>>>>>
>>>>> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
>>>>> index e97742912b8e..a30eb016c11c 100644
>>>>> --- a/drivers/iio/adc/ad7476.c
>>>>> +++ b/drivers/iio/adc/ad7476.c
>>>>> @@ -29,8 +29,6 @@ struct ad7476_state;
>>>>>    struct ad7476_chip_info {
>>>>>    	unsigned int			int_vref_mv;
>>>>>    	struct iio_chan_spec		channel[2];
>>>>> -	/* channels used when convst gpio is defined */
>>>>> -	struct iio_chan_spec		convst_channel[2];
>>>>>    	void (*reset)(struct ad7476_state *);
>>>>>    	bool				has_vref;
>>>>>    	bool				has_vdrive;
>>>>> @@ -41,6 +39,7 @@ struct ad7476_state {
>>>>>    	struct gpio_desc		*convst_gpio;
>>>>>    	struct spi_transfer		xfer;
>>>>>    	struct spi_message		msg;
>>>>> +	struct iio_chan_spec		channel[2];
>>>>>    	int				scale_mv;
>>>>>    	/*
>>>>>    	 * DMA (thus cache coherency maintenance) may require the
>>>>> @@ -153,24 +152,18 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>>>>>    #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
>>>>>    		BIT(IIO_CHAN_INFO_RAW))
>>>>>    #define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
>>>>> -#define AD7091R_CONVST_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), \
>>>>> -		BIT(IIO_CHAN_INFO_RAW))
>>>>>    #define ADS786X_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
>>>>>    		BIT(IIO_CHAN_INFO_RAW))
>>>>>    static const struct ad7476_chip_info ad7091_chip_info = {
>>>>>    	.channel[0] = AD7091R_CHAN(12),
>>>>>    	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>>>>> -	.convst_channel[0] = AD7091R_CONVST_CHAN(12),
>>>>> -	.convst_channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>>>>>    	.reset = ad7091_reset,
>>>>>    };
>>>>>    static const struct ad7476_chip_info ad7091r_chip_info = {
>>>>>    	.channel[0] = AD7091R_CHAN(12),
>>>>>    	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>>>>> -	.convst_channel[0] = AD7091R_CONVST_CHAN(12),
>>>>> -	.convst_channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>>>>>    	.int_vref_mv = 2500,
>>>>>    	.has_vref = true,
>>>>>    	.reset = ad7091_reset,
>>>>> @@ -282,7 +275,7 @@ static int ad7476_probe(struct spi_device *spi)
>>>>>    	const struct ad7476_chip_info *chip_info;
>>>>>    	struct ad7476_state *st;
>>>>>    	struct iio_dev *indio_dev;
>>>>> -	int ret;
>>>>> +	int ret, i;
>>>>>    	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>>>>>    	if (!indio_dev)
>>>>> @@ -332,16 +325,28 @@ static int ad7476_probe(struct spi_device *spi)
>>>>>    	if (IS_ERR(st->convst_gpio))
>>>>>    		return PTR_ERR(st->convst_gpio);
>>>>> +	/*
>>>>> +	 * This will never realize. Unless someone changes the channel specs
>>>>> +	 * in this driver. And if someone does, without changing the loop
>>>>> +	 * below, then we'd better immediately produce a big fat error, before
>>>>> +	 * the change proceeds from that developer's table.
>>>>> +	 */
>>>>> +	BUILD_BUG_ON(ARRAY_SIZE(st->channel) != ARRAY_SIZE(chip_info->channel));
>>>
>>> I guess it make sense but still looks too fancy for this :)
>>
>> Nothing else but a developer's carefulness keeps the number of channels "in
>> sync" for these two structs. I was originally doing WARN_ON() - but then I
>> thought that it's be even better to catch this at build time. Then I found
>> the BUILD_BUG_ON(). I see Andy suggested static_assert() instead - I've no
>> idea why one is preferred over other though. Let's see if I get educated by
>> Andy :)
>>
>>>
>>>>> +	for (i = 0; i < ARRAY_SIZE(st->channel); i++) {
>>>>> +		st->channel[i] = chip_info->channel[i];
>>>>> +		if (st->convst_gpio)
>>>
>>> I would flip this an do:
>>> 	if (!st->convst_gpio)
>>> 		break;
>>
>> To me this would just add an extra line of code, and more complex flow. I
>> would definitely agree if there were more operations to be done for the
>> 'convstart channels' - but since this is really just "if it's convstart,
>> then set a bit" - the
>>
>> if (foo)
>> 	bar;
>>
>> seems simpler than
>>
>> if (!foo)
>> 	break;
>> bar;
> 
> Yes but in this particular case, you likely would not need to do any
> line break afterward because of indentation. Logically it also makes
> sense because st->convst_gpio is a device property (not a channel one).
> So it makes no sense to check it for all channels (I know we only have two
> channels). So if you prefer, you could even do:
> 
> if (st->convst_gpio) {
> 	for (...)
> 		__set_bit(...);
> }
> 
> which also would make more sense to me.

I considered this option, but I need to populate all the channels in
st->channel with the template data from chip_info->channel anyways. 
Hence I want to loop through the channels also when the st->convst_gpio 
is not there :)

> 
> Up to you now :)

Well, I already sent the v3. (Sorry, I should've waited a bit more but 
wanted to get it out before the weekend). I kept the same logic as in 
v2. You can still suggest improvements there!

Yours,
	-- Matti

