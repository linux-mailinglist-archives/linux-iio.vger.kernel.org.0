Return-Path: <linux-iio+bounces-16973-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 986D1A65690
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 16:53:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 136663B759A
	for <lists+linux-iio@lfdr.de>; Mon, 17 Mar 2025 15:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE07F188907;
	Mon, 17 Mar 2025 15:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="IdNLgRWV"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25E0187346
	for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742226407; cv=none; b=I+uoTBug9H3ACjmEHaY9jqedlb3JSGHK5iL+3dS456QQHQ+rAKsMIuUDkeurqQKfdADapFbYQJOgTFw0QPFJGW0qO5vV5VruD7+5BzqkO1hbDxIFMlejiPjRKZ0IA8I0DEaakciZBaiOQUtuEzGsyGjvw04bSk5jgWw0Qr85B2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742226407; c=relaxed/simple;
	bh=nMkcbK7rnWCIpgL+LrcuWEQLQ+oABD8VNGsKOQi3vnw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OJ7bc/sBhYWT0u7VO8BA24wdSptsAVf8evAI5ecVJ+M1lrvVdo4ZzpCHLiwC110TtwgOrfYgirsdw9yar6IQHNTsSfrvLCq76l//lJ2wuayqTkuLyxTfrHBqiP3+JsrGMeTL0c4bN4nMj+irxucx3RVTcIoz5v5KSbCwdcQIsw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=IdNLgRWV; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3fa0eb29cebso3227600b6e.0
        for <linux-iio@vger.kernel.org>; Mon, 17 Mar 2025 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742226403; x=1742831203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xxGNuwSiLEC16juyCY9zxGdn8dvaO0Mb9PTV3kmTytI=;
        b=IdNLgRWVzk+yncNOIcmy4n0tbYcUdHiWKDJgiQSL1lodSMEEYx5YsP1iJKUax8ikv3
         257tM57iXPArHFqJMulmt1tVDa6HMUL5CvHyoiQ7r5Wgk/m3+Jhrk4IBr/QcmnyCQ/Np
         H16aw0lIBHenqj+TcfIq9ibWPvlyOpYwIZrE5vslRLPJqjaB9DGQ2nPLAA+9gF14gOur
         5ejEcsU2YaV4OTDHmghqt0DC8mLJwe1GqONX4XcWkBKtryMu7JPd7SfY4AoQ03xtp5Xj
         ojt6JZjZSAz37Jc1yxwWwdiLUFOBUMVjsxDsY22ldLQW8ZZfV+EAAW7rg4Je29T4+qdQ
         Ew7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742226403; x=1742831203;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xxGNuwSiLEC16juyCY9zxGdn8dvaO0Mb9PTV3kmTytI=;
        b=ILzqXJ125InEqUkd7Z+iFV24mP6euzkLakq8AvgDRkQfSzQQbwDMLsRZzxV2/XNflG
         1rnLNspR5EpY1IUP/fJtVumuBhIMWIIYbXjX8MkAhj9M/mSJxwIr8WO/C1j6XhZaKgut
         Wq0DgRZFEI05RT08n3ffp2sDJA9AxKQNh63VIlj5hdCNqmlCA+oG+z4cBYimUVe9eX7k
         6daWrEBXtjDz+HLs9Xs8E+9av5NhbpBaEqvApHkiHyd9NJRSR3suNRkGWa2s4tCiOslN
         d71uJJPVP2lVNspp80mNZJk8TBpRpBE6qxqiu0LB/2iYRWgh+g1Sgoj2YJDxmRWNSb54
         rqVA==
X-Forwarded-Encrypted: i=1; AJvYcCWZWyzY8xjwN9C835bP16/lSqtKM74q96y43eooVz+OBnfusSrnyF/UqzuxlSStcY0gxTwLknS6/Fw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw22ZIvHJnu20Jt+7XD8wCKb56rRTmyP8JH9+Mgkuk4VjB0og5A
	Mwr7Ab+fWgq/bobIeGexsw0eB+kBL19yLClLY6QPgBuVuNGGsllyxvBwuooWXwF/RwpTyT6R8yf
	B9FI=
X-Gm-Gg: ASbGncssAyvwbWEZ7hH3YkJaBvyfvk8xPfATtSg1L4A7eGWZPD1UF2Kx+yO0bwQAW8H
	X923hsbHDr9GT5qkojFTrdG96zjB93RNTiRD6ZQoNTuTSZc8t2OKIPVDleKTHxayH1KBFrfNOAf
	H8+Z9CyEukDr1UaOtH3WW8nkawLaQi4okCxCOeZjRLj10dqpi3mwSG7WDwVGgEslGcZ9bpwGo5F
	aU0MrWBJ/mSnWKQskaDwjWfi0HOqRjAyKQhB3M/++rlmNSNImIvfpoa7WduG4sqTG5Fz/SYEL1B
	tKKS0p7gAJYaE8FZOOy3mTyx24qOLulZJZOl09ZmBlcs1OejW/Ag7r8Y2blVkZT7gB+snieh7I/
	QGyekKw==
X-Google-Smtp-Source: AGHT+IFFtYd6yezG8t20CQe2zbctBzchEdRc4S/9ladxI0m7POupxKIlYT2EGN1PZGkgE32uracq7w==
X-Received: by 2002:a05:6808:3509:b0:3f6:a851:fe56 with SMTP id 5614622812f47-3fcbb6c0905mr9258519b6e.12.1742226403596;
        Mon, 17 Mar 2025 08:46:43 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3fcd5bfff2dsm1861032b6e.32.2025.03.17.08.46.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Mar 2025 08:46:43 -0700 (PDT)
Message-ID: <60831e04-52c2-446f-8bc5-b5d3e9e5fd40@baylibre.com>
Date: Mon, 17 Mar 2025 10:46:42 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/4] iio: adc: ad4000: Add support for SPI offload
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lars@metafoo.de,
 Michael.Hennerich@analog.com, corbet@lwn.net
References: <cover.1741970538.git.marcelo.schmitt@analog.com>
 <301fc83a961c4a2ef2ac980d0baa83d9d89a88c5.1741970538.git.marcelo.schmitt@analog.com>
 <20250317102751.5702fb82@jic23-huawei>
 <Z9hAUs1wPOIAo2nt@debian-BULLSEYE-live-builder-AMD64>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <Z9hAUs1wPOIAo2nt@debian-BULLSEYE-live-builder-AMD64>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/17/25 10:31 AM, Marcelo Schmitt wrote:


> ...
>>> +/*
>>> + * This executes a data sample transfer when using SPI offloading for when the
>>> + * device connections are in "3-wire" mode, selected when the adi,sdi-pin device
>>> + * tree property is set to "high". In this connection mode, the ADC SDI pin is
>>> + * connected to VIO and ADC CNV pin is connected to a SPI controller CS (it
>>> + * can't be connected to a GPIO).
>>> + *
>>> + * In order to achieve the maximum sample rate, we only do one transfer per
>>> + * SPI offload trigger. This has the effect that the first sample data is not
>>> + * valid because it is reading the previous conversion result. We also use
>>
>> Say what happens to that invalid sample.  Is it dropped or provided to userspace
>> as if it were valid?  (I hope dropped!)
> 
> TL;DR: The invalid sample goes into the buffer as a valid one.
> 
> In AD4000 '3-wire' mode, data capture has a latency (delay) of one sample.
> 
> The ADC begins sampling data N at CNV rising edge
>           |   +-- CNV (usually SPI CS) is brought low to begin reading the data
>           |   |                                +-- Data N + 1 that will be read
>           |   |                                |   on the next transfer starts 
>           v   v                                v   being sampled at end of transfer N.
>            ___                                  ____            
> CNV  _____/   \________________________________/    \_____
>                     _     _             _
> SCLK ______________/ \___/ \_ ...   ___/ \_______________
>                    ___   ___           ___
> SDO  _____________/___\_/___\ ...   __/___\_______________
>                     ^
>                     |
>              Data from conversion N is output from here on
> 
> A better drawing can be found in datasheet page 29, Figure 57.
> https://www.analog.com/media/en/technical-documentation/data-sheets/ADAQ4003.pdf
> 
> In sum, we're always reading a conversion that started at the end of the
> previous SPI transfer or, in other words, the data comes out with a latency
> (delay) of one read.
> 
> Datasheet somehow mentions that by saying
> 	When turbo mode is enabled, the conversion result read on SDO corresponds to
> 	the result of the previous conversion.
> 
> I think I can do a dummy SPI transfer on buffer preenable so at least the
> first data is not invalid. Would that be better?

Not really. There will be a relatively long delay between that conversion
trigger and when the sample is read. So the data might be slightly less stale
in that case, but still not particularly useful, e.g. if you are doing any
kind of signal processing that expects equal time between all samples.

On similar chips, like ad7944, we just documented that the first sample does
not contain valid data and needs to be discarded.

> 
>>
>>> + * bits_per_word to ensure the minimum of SCLK cycles are used. And a delay is
>>> + * added to make sure we meet the minimum quiet time before releasing the CS
>>> + * line. Plus the CS change delay is set to ensure that we meet the minimum
>>> + * conversion time before asserting CS again.
>>> + *
>>> + * This timing is only valid if turbo mode is disabled (reading during acquisition).
>>> + */
>>> +static int ad4000_prepare_offload_message(struct ad4000_state *st,
>>> +					  const struct iio_chan_spec *chan)
>>> +
>>
> ...
>>> +		xfers[1].bits_per_word = chan->scan_type.realbits;
>>>  	xfers[1].delay.value = st->time_spec->t_quiet2_ns;
>>>  	xfers[1].delay.unit = SPI_DELAY_UNIT_NSECS;
>>>  
>>> @@ -719,7 +1007,9 @@ static int ad4000_prepare_4wire_mode_message(struct ad4000_state *st,
>>>  	xfers[0].delay.unit = SPI_DELAY_UNIT_NSECS;
>>>  
>>>  	xfers[1].rx_buf = &st->scan.data;
>>> -	xfers[1].len = BITS_TO_BYTES(chan->scan_type.storagebits);
>>> +	xfers[1].len = chan->scan_type.realbits > 16 ? 4 : 2;
>>> +	if (chan->scan_type.endianness != IIO_BE)
>>
>> This is odd enough to require a comment.  Why is endianness relevant?
> 
> When using SPI offloading (at least with PULSAR-ADC HDL project [1]), ADC data
> is read by SPI controller and pushed to DMA memory in CPU endianness. I don't
> know exactly where data gets rearranged in the data path (whether SPI-Engine,
> the DMA controller, or something else rearranges ADC data into CPU endianess).
> But I know, from testing with these ADCs and HDL project, that data is correct
> when read in CPU endianness because it converts back to expected mV values.
> When IIO buffers were set to IIO_BE and SPI offloading is used, data just looked
> weird and didn't convert to expected values in mV.
> 
> [1]: https://analogdevicesinc.github.io/hdl/projects/pulsar_adc/index.html
> 
> Other IIO drivers also set IIO_CPU buffer endianness when using offload support,
> e.g. ad7944, ad7380.

These drivers also use IIO_CPU for the non-SPI offload case though.

> 
> They only say buffer would use 32 storagebits when using SPI offload.
> https://lore.kernel.org/linux-iio/20250207-dlech-mainline-spi-engine-offload-2-v8-10-e48a489be48c@baylibre.com/
> https://lore.kernel.org/linux-iio/20250220-wip-bl-spi-offload-ad7380-v1-1-838aa873e62a@baylibre.com/#t
> 
> I also didn't expect to find out HDL support for 16-bit data width was removed.
> We used to have a build parameter for 16-bit precision ADCs.
> https://github.com/analogdevicesinc/hdl/commit/b2dc91b30dae891b6319d88e083f26e726f43ba0#diff-1117c2618353232e5f22aa6a12e8ae976757fa897b3425f470a12123cae26535L13

A while back the HDL engineers mentioned to us that they wanted to standardize
on 32-bit data words everywhere. While not the most efficient use of memory,
having fewer options does make things simpler across the entire software stack.

> 
> Would something like 'because SPI offloading leads to data being pushed to
> memory in CPU endianness' be a reasonable comment?

Another way to say it is that SPI offload reads data in complete words and not
in separate 8-bit xfers (bits_per_word = realbits vs. bits_per_word = 8).



