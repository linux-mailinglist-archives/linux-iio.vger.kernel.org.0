Return-Path: <linux-iio+bounces-18898-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AC7AA4E26
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 16:12:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 456CA5A647F
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 14:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B84525DD0D;
	Wed, 30 Apr 2025 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="vapXLKqj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BAA3101E6
	for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 14:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746022321; cv=none; b=D3ldeVRiGIyUpECtMEw6DxO6CMfF6LkRdoirIS/Y5f23cNRbGhEPDIETwyVB4Z7uKqzq59p96mfHGRb/SH8yx56fs2AA/MSDIO9ZBTVK+8CR6zz3DrHyzKLqufab+SZpTmtUoo6PHpS8fetcm7XbxRBTDo6Y7TKxuUah0lAPV5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746022321; c=relaxed/simple;
	bh=VTVoggf6JS6pnIcZ+XS3UM8XE+/4dsDQS0s1ZJJWmTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fshsaObnxEQSQTC+NMLxwN/L7gDKLfUdAG5ECjgVWYzlRSn367O4s29FmIBYPTkjWBQ90P47Jogf18d1TCvfURgiXewIPtzLG6xEJbcq4D004co4xGuyGMqyapXSdBY2XQtkaaSUfyILLE7zIvSG2Lm+dbTV/axvVPnCasHIGHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=vapXLKqj; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f6a92f234dso5174037b6e.3
        for <linux-iio@vger.kernel.org>; Wed, 30 Apr 2025 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1746022318; x=1746627118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FXr5IaAciIjxJwMtezTJjCywVevxWSVV4iijAA9ygRc=;
        b=vapXLKqjFPve7zCgvVBiqr3aJN3yYSIriPELDGQYzdnd33A6h/ThVUb5wuaFdUfCe8
         VMhJO1UaZNhp7ssB2kiHAxRe76Q+ULaORzyBhK8QBN7Yfuc6WmrIgYyNecyc97ysE7r7
         niqGl5qym5mvTpUD5kZZwrabL2E02F0kjDVehXbh9TMfaEHUKW0XHoHNwIZmBG6xZxwW
         e6GAxdGhx56Zp6zZMz0G6OPW5f3v8dYym87F1Ihs+FMe9wTs/mOBKrRMS8syBbYoWyTM
         uelQIySMxzUjGVtATCieJNDiWwo8SR2fcAiMO5Cwb85/dPc/5SmXGdiordti0QtS0wBu
         Qn8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746022318; x=1746627118;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FXr5IaAciIjxJwMtezTJjCywVevxWSVV4iijAA9ygRc=;
        b=ha6os6vRM1aJRYyYAX5epiN0AhQvHtMK/2hi9yIP4OheRuQ9zto/BB8P9UrbTljd4B
         iklEoFmLX+YYsnUCHf5AT6p5NdxV9uhL10JB1sRGeuWEORwgS9pPEgsgckNWWQL2yFax
         Cz6ugNWOJbXaFofYFpH/Fuo2aGf3azqXNPw+57tMUqjnt42Ym3HF83tqjnNk5lbM6qQ7
         nLYBUKTe701M8oa1KSHBS0H5uM0Vynh/+WBYly0J26QfpCftHLFjEZw/mE2xBDHJQ8yM
         Ibxo5durz538Y+a48e+Q9wrIviKqJAk5R6QFtO1UyZDYOfa9DQ574C0zlm/yKXQHPq3h
         4Ssg==
X-Forwarded-Encrypted: i=1; AJvYcCXAHeEgTyGY0YwfwWKRs9el0itdfEezYDz7dXkQRwOLv8QlOu+tu5l/uj8odlnZ+LLwG/6VC9n60lg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU9mOKaZtPsEfhhL9fiKiiTkHPI+17ciTr62oeFxmr8Ezjb2wN
	nzrPWxoTg3zD4U8HAM+YDng8vvY1zNCuNgpRzSY9vF6zRjF+5rN2ON28bVPudUo=
X-Gm-Gg: ASbGncuIMcSc/B7gDpn3+NVpKcCINakaYlbDYtqwheHYsOdi1lxCeO2B2SvKVyrGjDG
	e1WzWnAMBpt5jC1SFbsGMu+ZdSycYocBo2Fk1bX2hL2nItO5kZwairtVWKJ+yKMWXm0sTHHguF3
	gEUOXS4FEBLNUKgA7xHMa/PiApEWM0iorHzPNzZdHr0Kxh0Lfmwf57xW4CY+b5iUVlCzLlmJqBZ
	wqTjxSRz3OGEBBcN0tD3f5NYRMRyMte1HN2Ah8733DbuDpACHutXDxLSdZgRb9nK3N8AD75n/CL
	eizbT8Ch3Pkt/RfBnwUtnFNn0tR5yabNm+Pbbckb99WdUpBNRvWZ1/iBDNkd87qNKXsfrYuwKIS
	27uWf9+jAOX2AVHc=
X-Google-Smtp-Source: AGHT+IGm+YRDzAV25Fg59YboolWAEWJM5fvIS8POZ8P+KjKU4rTAu+9CAE/+oSyEAf7EUAu7s7UD8w==
X-Received: by 2002:a05:6808:8518:b0:3f7:ccac:287f with SMTP id 5614622812f47-402d24e8ef8mr1326804b6e.27.1746022317997;
        Wed, 30 Apr 2025 07:11:57 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:359a:f1e:f988:206a? ([2600:8803:e7e4:1d00:359a:f1e:f988:206a])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-40212a598f5sm819181b6e.36.2025.04.30.07.11.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Apr 2025 07:11:57 -0700 (PDT)
Message-ID: <c6e1c555-37c0-484c-a955-39163cd148bb@baylibre.com>
Date: Wed, 30 Apr 2025 09:11:56 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] iio: adc: ad4080: add driver support
To: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>
Cc: "jic23@kernel.org" <jic23@kernel.org>, "robh@kernel.org"
 <robh@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20250425112538.59792-1-antoniu.miclaus@analog.com>
 <20250425112538.59792-12-antoniu.miclaus@analog.com>
 <27e40c72-7c3a-4595-8647-5fd1f428ea9f@baylibre.com>
 <CY4PR03MB3399A9584A631E5C30CF72EC9B832@CY4PR03MB3399.namprd03.prod.outlook.com>
From: David Lechner <dlechner@baylibre.com>
Content-Language: en-US
In-Reply-To: <CY4PR03MB3399A9584A631E5C30CF72EC9B832@CY4PR03MB3399.namprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/30/25 7:31 AM, Miclaus, Antoniu wrote:
> ...
>>> +	unsigned int num_channels;
>>> +};
>>
>> I guess this is preparing the driver to support more than one chip?
>>
> Yes. It is stated also in the cover letter.
>>> +
>>> +struct ad4080_state {
>>> +	struct spi_device		*spi;
>>
>> It looks like this is only ever used to get &spi->dev. We could drop this and
>> get dev from regmap instead.
> How can I get the dev from regmap?

struct device *dev = regmap_get_device(regmap);

>>> +	struct regmap			*regmap;
>>> +	struct clk			*clk;
>>> +	struct iio_backend		*back;
>>> +	const struct ad4080_chip_info	*info;
>>> +	/*
>>> +	 * Synchronize access to members the of driver state, and ensure
>>> +	 * atomicity of consecutive regmap operations.
>>> +	 */
>>> +	struct mutex			lock;
>>> +	unsigned int			num_lanes;
>>> +	unsigned int			dec_rate;
>>> +	enum ad4080_filter_type		filter_type;
>>> +	bool				lvds_cnv_en;
>>> +};
>>> +
>>> +static const struct regmap_config ad4080_regmap_config = {
>>> +	.reg_bits = 16,
>>> +	.val_bits = 8,
>>> +	.read_flag_mask = BIT(7),
>>> +	.max_register = 0x29,
>>> +};
>>> +
>>> +static int ad4080_reg_access(struct iio_dev *indio_dev, unsigned int reg,
>>> +			     unsigned int writeval, unsigned int *readval)
>>> +{
>>> +	struct ad4080_state *st = iio_priv(indio_dev);
>>> +
>>
>> Missing guard(mutex)(&st->lock); ?
> Aren't regmap operations thread safe? (own internal locking).

For single operations, yes. But I assumed that you added the lock so that when
functions that do multiple regmap read/writes don't have another thread doing
a different regmap operation in the middle.

However, it looks like ad4080_lvds_sync_write() is currently the only function
like this and it is only called during probe. So it seems like the extra mutex
lock isn't currently needed and could be removed from the driver entirely.

>>> +	if (readval)
>>> +		return regmap_read(st->regmap, reg, readval);
>>> +
>>> +	return regmap_write(st->regmap, reg, writeval);
>>> +}


...

>>> +
>>> +static int ad4080_set_dec_rate(struct iio_dev *dev,
>>> +			       const struct iio_chan_spec *chan,
>>> +			       unsigned int mode)
>>> +{
>>> +	struct ad4080_state *st = iio_priv(dev);
>>> +	int ret;
>>> +
>>
>> Don't we need to check for < 2 as well?
>>
>>> +	if (st->filter_type >= SINC_5 && mode >= 512)
>>> +		return -EINVAL;
>>> +
>>> +	guard(mutex)(&st->lock);
>>> +	ret = regmap_update_bits(st->regmap, AD4080_REG_FILTER_CONFIG,
>>> +
>> AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK,
>>> +
>> FIELD_PREP(AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK,
>>> +					    (ilog2(mode) - 1)));
>>
>> Otherwise ilog2(mode) - 1 could be < 0.
>>
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	st->dec_rate = mode;
>>
>> This saves the value the user entered, not what the hardware is actually doing.
>> It should be saving the power of 2 value instead.
>>
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int ad4080_read_raw(struct iio_dev *indio_dev,
>>> +			   struct iio_chan_spec const *chan,
>>> +			   int *val, int *val2, long m)
>>> +{
>>> +	struct ad4080_state *st = iio_priv(indio_dev);
>>> +	int dec_rate;
>>> +
>>> +	switch (m) {
>>> +	case IIO_CHAN_INFO_SCALE:
>>> +		return ad4080_get_scale(st, val, val2);
>>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>>> +		if (st->filter_type == SINC_5_COMP)
>>> +			dec_rate = st->dec_rate * 2;
>>> +		else
>>> +			dec_rate = st->dec_rate;
>>
>> As a concequence of the above, this will return incorrect information if the
>> user didn't enter an exact value.
> Isn't the user constrained by the ad4080_read_avail for entering the dec_rate values?
> The user both writes and reads the actual decimation rate value. The conversions are done inside the functions.

Yes, the oversampling_ratio attribute is calling ad4080_get_dec_rate(), so
that one is OK, but this is the sampling_frequency attribute. Currently
st->dec_rate holds the user-requested value and isn't necessarily the same as
the value that would be returned by ad4080_get_dec_rate(indio_dev, chan).

If we dropped st->dec_rate and used ad4080_get_dec_rate(indio_dev, chan) here
too, that would be an acceptable solution too.

>>
>>> +		if (st->filter_type)
>>> +			*val = DIV_ROUND_CLOSEST(clk_get_rate(st->clk),
>> dec_rate);
>>> +		else
>>> +			*val = clk_get_rate(st->clk);
>>> +		return IIO_VAL_INT;
>>> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
>>> +		*val = ad4080_get_dec_rate(indio_dev, chan);
>>> +		return IIO_VAL_INT;
>>> +	default:
>>> +		return -EINVAL;
>>> +	}
>>> +}

...

>>> +static const struct iio_chan_spec ad4080_channels[] = {
>>
>> Array with one element doesn't make sense. It can just be a single struct.
> Isn't indio_dev->channels expecting an array?

No, it expects a pointer. So &ad4080_channel; can be used to get a pointer to
a single struct instance.


