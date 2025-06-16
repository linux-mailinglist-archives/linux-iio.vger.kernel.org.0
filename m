Return-Path: <linux-iio+bounces-20724-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71273ADBB56
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 22:41:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11AE21760BF
	for <lists+linux-iio@lfdr.de>; Mon, 16 Jun 2025 20:41:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD54214812;
	Mon, 16 Jun 2025 20:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zZOil2Mv"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7445F20F063
	for <linux-iio@vger.kernel.org>; Mon, 16 Jun 2025 20:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750106484; cv=none; b=emb+tpdXn3o03+67MGo+sdy37fc38aZ2tsxrADN4e4Gz7dhRi3Vur1LZYzkAn1wfJ0JM09ijGg9CAbPMlKi32KTaQYtSm1ZjCVnxrOQ+NrVRMP7KlVy/WFAhJYKk7POYs0OCjcAmIUu0dByfeFXFQoeUNHF1IqidwtPl9DwF5L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750106484; c=relaxed/simple;
	bh=PVT87WlybxJHerz4UDh4GIny5iFa04yiRNA92A0CPXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKixgypGG29VN+RwlHIvOVmZjqM3+uegIxctXQoM8Rx0krxbMRGivNUvrTr52/OAugLsSf3S6RqBk0zZmOZ790/5psxBMQzDyfVJqev+j2WEYqMrYzKLF74vjLb6AiGbzMkpqfYsb2iHTKY59mur/3cfb9x//a9/EohqeyvtjpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zZOil2Mv; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-7311a8bb581so5022902a34.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Jun 2025 13:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1750106481; x=1750711281; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=35iJbW24MVWZXNa4Hg8QhqJKno4ctrNckZhqZHzLkMU=;
        b=zZOil2MvJEBOTCpYuEJeUIqsMv+YN3jYhII1E6raqAe5bA0JQSmyeHchh7qGyiHF49
         qnjcu6Jv5qB6RWfnyMMIDwLOfSdbywgw4g+oP5/V5RjpE6zYCeyhZhCA4HbDynKK8jwY
         kBJoPhy1JmUPqCgH+Po8dFhAjVmkF3k9yESAzmqm4zYbdIs52fhVnCYI/soIrdd1OQuM
         VDnn+PV/zD8MCdhSatveCxtG1Z3LxnrkrrgbSdUWlbYwVwd7/RBpGWoQIJ8fRWAAYmde
         zD7ZEN9q+wMpC8Rw9Wz15ZCwo7xwy2rmZMB+fHsSBbykCdBZzjhUxDZ5FwA73RY4mXTa
         mVVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750106481; x=1750711281;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=35iJbW24MVWZXNa4Hg8QhqJKno4ctrNckZhqZHzLkMU=;
        b=N4Rt08q2/JQyIh0sOQhkwYU+nG6Oc9yehkE8vkDbAa+fhJyG4rDD2XtgN3EfWMly+K
         ogavAxad6tFDyNiecChRCsnQoGJrX0o8Ic7VcPpqbeUyjRizy1ADYdOYTnsEY5PlHLZn
         mYobC7acwT32BmjTL4j7qiWAjRxXgs0nhWNA34FRlUtNHENQnMd7HsvBQjmJiLkPcZtV
         tfNdNwg5/1mSPlVY/QHmQesqCIzK3EtaZBWVWLylucgriycSp/wgoy40ZJfbUGfJZ8RX
         VXMhuhE1FeT729YxeGpktWzrCHiIlrzogj6ko/ucj+xl68TAZRpGcvxNmOwUuyKod+5z
         BSag==
X-Forwarded-Encrypted: i=1; AJvYcCUB0Avz5Bum6cUMcHJApkKlCLoJbWOZ7IZh5UpuTEE4nRUJbXKX6+UhRM/ZboAj+ywfxKmm9ta+FJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlpzVCubopiBC0/Ey0kmz8GjEeYTcWatbcsk2KFWdWuf5FYZgR
	8SztPYQDR52tWIii46Hr4BG+ZO9t74/uV6T6o5NQlvzIDU3dCoKV6j6jHUs/QwUgaDU=
X-Gm-Gg: ASbGncuISQNdogmfcQ9SEBJQukWAN3DPU3Q0n6Yzq0Sl4n2VGbHtCsRAF+P0luKm6Qu
	lRCN8iRVPSsq1LReOGjivZ2A4l26E47T6BGkjE0pCwU0q+rOTGI8I1vg1qxlVmwKOLyfbzUh7KB
	6xW3uk/YO5wE/IdG4TKx6TZF32IPAY+AGYG55Rv9dDhpF3+GGdwDWZo2m9pPtPWevkgMGb//4ID
	ys983hItyyO3kepKbHdTqCUbUBhu8oq2+4MP/LqeZowQ9104Ced8ilx91JwoUVkPM3H1T5e8rVK
	YJ90ov7jcyFrqVAJHN43w7f3no9dfIUxTIodcjLeO8Pe6dmYfp1Htvxl8jAVobm7N/zjmxmx/BU
	btHH8OLI3tIbt2YzLvmhS8T1BQWQG98oAWuxyOHc=
X-Google-Smtp-Source: AGHT+IH4LSHUxzGYnf+n0kYthQZOcYkXdsbk74uDImpxOEm3CoQ0mfS8X/FjnJ3rG8a0Ngt4PIehyA==
X-Received: by 2002:a05:6830:3c08:b0:735:25:a00d with SMTP id 46e09a7af769-73a364649e5mr8164991a34.25.1750106481313;
        Mon, 16 Jun 2025 13:41:21 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:1d00:9583:1e37:58ed:10ae? ([2600:8803:e7e4:1d00:9583:1e37:58ed:10ae])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a2855499csm1323647a34.63.2025.06.16.13.41.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 13:41:20 -0700 (PDT)
Message-ID: <c29feb5b-2699-411a-87dc-249f5b9ff6c0@baylibre.com>
Date: Mon, 16 Jun 2025 15:41:20 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/11] iio: adc: Add basic support for AD4170
To: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Ana-Maria Cusco <ana-maria.cusco@analog.com>, jic23@kernel.org,
 lars@metafoo.de, Michael.Hennerich@analog.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linus.walleij@linaro.org, brgl@bgdev.pl, marcelo.schmitt1@gmail.com
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
 <48598c0753cccf515addbe85acba3f883ff8f036.1749582679.git.marcelo.schmitt@analog.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <48598c0753cccf515addbe85acba3f883ff8f036.1749582679.git.marcelo.schmitt@analog.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/10/25 3:31 PM, Marcelo Schmitt wrote:
> From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> 
> The AD4170 is a multichannel, low noise, 24-bit precision sigma-delta
> analog to digital converter. The AD4170 design offers a flexible data
> acquisition solution with crosspoint multiplexed analog inputs,
> configurable ADC voltage reference inputs, ultra-low noise integrated PGA,
> digital filtering, wide range of configurable output data rates, internal
> oscillator and temperature sensor, four GPIOs, and integrated features for
> interfacing with load cell weigh scales, RTD, and thermocouple sensors.
> 
> Add basic support for the AD4170 ADC with the following features:
> - Single-shot read.
> - Analog front end PGA configuration.
> - Differential and pseudo-differential input configuration.
> 

...

> +static int ad4170_fill_scale_tbl(struct iio_dev *indio_dev,
> +				 struct iio_chan_spec const *chan)
> +{
> +	struct ad4170_state *st = iio_priv(indio_dev);
> +	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
> +	struct device *dev = &st->spi->dev;
> +	int bipolar = chan->scan_type.sign == 's' ? 1 : 0;
> +	int precision_bits = chan->scan_type.realbits;
> +	int pga, ainm_voltage, ret;
> +	unsigned long long offset;
> +
> +	ainm_voltage = 0;
> +	ret = ad4170_get_ain_voltage_uv(st, chan->channel2, &ainm_voltage);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to fill scale table\n");
> +
> +	for (pga = 0; pga < AD4170_NUM_PGA_OPTIONS; pga++) {

From what I read in the datasheet, it sounds like if adi,reference-buffer is
precharge, then the PGA is bypassed, so there would only be 1 option in that
case (gain = 1).

> +		u64 nv;
> +		unsigned int lshift, rshift;
> +
> +		/*
> +		 * The PGA options are numbered from 0 to 9, with option 0 being
> +		 * a gain of 2^0 (no actual gain), and 7 meaning a gain of 2^7.
> +		 * Option 8, though, sets a gain of 0.5, so the input signal can
> +		 * be attenuated by 2 rather than amplified. Option 9, allows
> +		 * the signal to bypass the PGA circuitry (no gain).
> +		 *
> +		 * The scale factor to get ADC output codes to values in mV
> +		 * units is given by:
> +		 * _scale = (input_range / gain) / 2^precision
> +		 * AD4170 gain is a power of 2 so the above can be written as
> +		 * _scale = input_range / 2^(precision + gain)
> +		 * Keep the input range in µV to avoid truncating the less
> +		 * significan bits when right shifting it so to preserve scale
> +		 * precision.
> +		 */
> +		nv = (u64)chan_info->input_range_uv * NANO;
> +		lshift = !!(pga & BIT(3)); /* handle options 8 and 9 */
> +		rshift = precision_bits - bipolar + (pga & GENMASK(2, 0)) - lshift;
> +		chan_info->scale_tbl[pga][0] = 0;
> +		chan_info->scale_tbl[pga][1] = div_u64(nv >> rshift, MILLI);
> +
> +		/*
> +		 * If the negative input is not at GND, the conversion result
> +		 * (which is relative to IN-) will be offset by the level at IN-.
> +		 * Use the scale factor the other way around to go from a known
> +		 * voltage to the corresponding ADC output code.
> +		 * With that, we are able to get to what would be the output
> +		 * code for the voltage at the negative input.
> +		 * If the negative input is not fixed, there is no offset.
> +		 */
> +		offset = ((unsigned long long)abs(ainm_voltage)) * MICRO;
> +		offset = DIV_ROUND_CLOSEST_ULL(offset, chan_info->scale_tbl[pga][1]);
> +
> +		/*
> +		 * After divided by the scale, offset will always fit into 31
> +		 * bits. For _raw + _offset to be relative to GND, the value
> +		 * provided as _offset is of opposite sign than the real offset.
> +		 */
> +		if (ainm_voltage > 0)
> +			chan_info->offset_tbl[pga] = -(int)(offset);
> +		else
> +			chan_info->offset_tbl[pga] = (int)(offset);
> +	}
> +	return 0;
> +}
> +
> +static int ad4170_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type, int *length,
> +			     long info)
> +{
> +	struct ad4170_state *st = iio_priv(indio_dev);
> +	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SCALE:
> +		*vals = (int *)chan_info->scale_tbl;
> +		*length = ARRAY_SIZE(chan_info->scale_tbl) * 2;
> +		*type = IIO_VAL_INT_PLUS_NANO;
> +		return IIO_AVAIL_LIST;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad4170_set_pga(struct ad4170_state *st,
> +			  struct iio_chan_spec const *chan, int val, int val2)
> +{
> +	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
> +	struct ad4170_setup *setup = &chan_info->setup;
> +	unsigned int pga;

Likewise, here would also need to check for precharge and only allow
gain = 1 in in that case.

> +
> +	for (pga = 0; pga < AD4170_NUM_PGA_OPTIONS; pga++) {
> +		if (val == chan_info->scale_tbl[pga][0] &&
> +		    val2 == chan_info->scale_tbl[pga][1])
> +			break;
> +	}
> +
> +	if (pga == AD4170_NUM_PGA_OPTIONS)
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->lock);
> +	setup->afe &= ~AD4170_AFE_PGA_GAIN_MSK;
> +	setup->afe |= FIELD_PREP(AD4170_AFE_PGA_GAIN_MSK, pga);
> +
> +	return ad4170_write_channel_setup(st, chan->address, false);
> +}
> +

