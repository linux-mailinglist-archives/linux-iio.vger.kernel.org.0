Return-Path: <linux-iio+bounces-9224-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B5C396E655
	for <lists+linux-iio@lfdr.de>; Fri,  6 Sep 2024 01:31:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8931FB244C4
	for <lists+linux-iio@lfdr.de>; Thu,  5 Sep 2024 23:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2121B86E6;
	Thu,  5 Sep 2024 23:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="wBGqo4TI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A11AD27F
	for <linux-iio@vger.kernel.org>; Thu,  5 Sep 2024 23:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725579046; cv=none; b=d0hfm6rKWlHESHNvnKNuHnHpipt5g8Hmogd8ClGIlOEkqA60fIwJgTnlZ7EMsjsGLQf+uVT2HhJCRQZ5DNhz5dd1tO20Brpr73LShxtBhF209swedrjPU6vdNTenYgsuYRlpHGfEdIlfQLSeW/C59DX0gTcdEErGBRqLyktkMwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725579046; c=relaxed/simple;
	bh=MGNy32swnESW3BTbKYR1zBRyMKqhcnuJn3DfgG4JJJ8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IZWxx3t3kgZ8rs2qJFktQ/EgOwitflfqNRih/WXseHzyFqF8H7IVv+p+SUJ7TJ1AxTJz9uzKMVR6V3+i8ndSIDGyowH1TB42bLcoyHPHMaAok5K6a7ll7FyVYmYE1RHCYK52enVoB7af0OwZOHCa3SuwieThU1Me2HzdnSs4BTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=wBGqo4TI; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-709339c91f9so943684a34.0
        for <linux-iio@vger.kernel.org>; Thu, 05 Sep 2024 16:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1725579043; x=1726183843; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XBvv3qPT4MjxlFShCp2q0cYF1Mz/iUlLiK0mVDzsjHo=;
        b=wBGqo4TIzEtIk7ST+4MZa2U7OXNg2wrm3krNvX+aC9ThitYX1rdHOPe1frRzuydh4D
         kwY1hALIcFwPhra+/Ytiiw1/qgOoSqBMdHVKHpxYzqZid4aDZBNC58rEyeGFWnd3BCSq
         FG6LNT/pzNNHeH7x8PIW7ryVAWpDez78Bt9d4xB726x/LrvDE9gBb6uD9FRwqIPOmow7
         HKb7LJo5FbcHnuRuoEWEU+dQeAFwU7X3Q0IOdZkV/RtseKgJ3zIdMkZcasES/GzsvebN
         K6SzuccZHRsu9tFrskES5T/Tuo7DNhaa0yMPr/lyIreiYQ78DcBV/lQPYzvwhU9CGgPG
         JNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725579043; x=1726183843;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XBvv3qPT4MjxlFShCp2q0cYF1Mz/iUlLiK0mVDzsjHo=;
        b=IcbXktN++txRHIlQVeAY6k7zaoPoi5rm19n9A4hfhXfgkencur7ppTDcw69vib8ZN2
         Ko8yOOqJ+mwN3zc4Ma+NHREUwOvgnvWUPZ2qJfjcLi2HUOHWOv8xS9e0Il47ih51Nuqo
         8E8+8Nf9TmXF3n4ZQNba9jti6g6xa7caGf0wMezroonKeK0ZHBRehIN6rmjFJEu5eEJX
         1gx+sI3qUbI3MaMVRJMixtcWnPbI50KhS0OO/YdpOZXOyWlK/kQ/COFiAD4Oqv9oi5iz
         JeQ/QjsE2QYgb5xd+eUWKv/dDKYx8k8XFgPLtwOa2sR7I3NrQ8nN4M+lqZzd4XdiD9C6
         iOlg==
X-Forwarded-Encrypted: i=1; AJvYcCWUT/IAlRlw0QcmUrFTJ5HJ44aPwkYziSDy9o+qC78iSLsK+WZHZXRXoP24gt8vfdPFkYIQFRsUdXU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJz3HdSAJARDAybG7IJahTuLTi5rO7JvC+WsvfFEtY0U3txazt
	oawLrGUSwiyPWCq+/IriyoYtyFUSOiNwWNUMEvb/DaaClhnQ46pxa/DfN443pBY=
X-Google-Smtp-Source: AGHT+IFMdf9HqvBf177U9t4MUt/b3mp0D+OaHMb+7eB/tQ00jaHPpjqpmyjpoRMfw7WeRM1lHPb4Sg==
X-Received: by 2002:a05:6830:6e18:b0:709:32c3:68ef with SMTP id 46e09a7af769-710cc26eb63mr839158a34.30.1725579042557;
        Thu, 05 Sep 2024 16:30:42 -0700 (PDT)
Received: from [192.168.0.142] (ip98-183-112-25.ok.ok.cox.net. [98.183.112.25])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-70f671c1fe1sm3407647a34.69.2024.09.05.16.30.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Sep 2024 16:30:42 -0700 (PDT)
Message-ID: <2bf78e47-909a-45c0-bebb-6a8d38cdef7c@baylibre.com>
Date: Thu, 5 Sep 2024 18:30:41 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 8/8] iio: adc: ad7606: add support for AD7606C-{16,18}
 parts
To: Alexandru Ardelean <aardelean@baylibre.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: jic23@kernel.org, krzk+dt@kernel.org, robh@kernel.org, lars@metafoo.de,
 michael.hennerich@analog.com, gstols@baylibre.com
References: <20240905082404.119022-1-aardelean@baylibre.com>
 <20240905082404.119022-9-aardelean@baylibre.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20240905082404.119022-9-aardelean@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 9/5/24 3:24 AM, Alexandru Ardelean wrote:
> The AD7606C-16 and AD7606C-18 are pretty similar with the AD7606B.
> The main difference between AD7606C-16 & AD7606C-18 is the precision in
> bits (16 vs 18).
> Because of that, some scales need to be defined for the 18-bit variants, as
> they need to be computed against 2**18 (vs 2**16 for the 16 bit-variants).
> 
> Because the AD7606C-16,18 also supports bipolar & differential channels,
> for SW-mode, the default range of 10 V or ±10V should be set at probe.
> On reset, the default range (in the registers) is set to value 0x3 which
> corresponds to '±10 V single-ended range', regardless of bipolar or
> differential configuration.
> 
> Aside from the scale/ranges, the AD7606C-16 is similar to the AD7606B.
> 
> The AD7606C-18 variant offers 18-bit precision. Because of this, the
> requirement to use this chip is that the SPI controller supports padding
> of 18-bit sequences to 32-bit arrays.
> 
> Datasheet links:
>   https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-16.pdf
>   https://www.analog.com/media/en/technical-documentation/data-sheets/ad7606c-18.pdf
> 
> Signed-off-by: Alexandru Ardelean <aardelean@baylibre.com>
> ---
>  drivers/iio/adc/ad7606.c     | 266 +++++++++++++++++++++++++++++++----
>  drivers/iio/adc/ad7606.h     |  17 ++-
>  drivers/iio/adc/ad7606_spi.c |  55 ++++++++
>  3 files changed, 309 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7606.c b/drivers/iio/adc/ad7606.c
> index 4c3fbb28f790..999c4411859e 100644
> --- a/drivers/iio/adc/ad7606.c
> +++ b/drivers/iio/adc/ad7606.c
> @@ -28,14 +28,44 @@
>  
>  #include "ad7606.h"
>  
> +typedef void (*ad7606c_chan_setup_cb_t)(struct ad7606_state *st, int ch,
> +					bool bipolar, bool differential);
> +
>  /*
>   * Scales are computed as 5000/32768 and 10000/32768 respectively,
>   * so that when applied to the raw values they provide mV values
>   */
> -static const unsigned int ad7606_scale_avail[2] = {
> +static const unsigned int ad7606_16bit_hw_scale_avail[2] = {
>  	152588, 305176
>  };
>  
> +static const unsigned int ad7606_18bit_hw_scale_avail[2] = {
> +	38147, 76294
> +};
> +
> +static const unsigned int ad7606c_16_scale_single_ended_unipolar_avail[3] = {
> +	76294, 152588, 190735,
> +};
> +
> +static const unsigned int ad7606c_16_scale_single_ended_bipolar_avail[5] = {
> +	76294, 152588, 190735, 305176, 381470
> +};
> +
> +static const unsigned int ad7606c_16_scale_differential_bipolar_avail[4] = {
> +	152588, 305176, 381470, 610352
> +};
> +
> +static const unsigned int ad7606c_18_scale_single_ended_unipolar_avail[3] = {
> +	19073, 38147, 47684
> +};
> +
> +static const unsigned int ad7606c_18_scale_single_ended_bipolar_avail[5] = {
> +	19073, 38147, 47684, 76294, 95367
> +};
> +
> +static const unsigned int ad7606c_18_scale_differential_bipolar_avail[4] = {
> +	38147, 76294, 95367, 152588
> +};
>  
>  static const unsigned int ad7616_sw_scale_avail[3] = {
>  	76293, 152588, 305176
> @@ -82,11 +112,19 @@ static int ad7606_reg_access(struct iio_dev *indio_dev,
>  	}
>  }
>  
> -static int ad7606_read_samples(struct ad7606_state *st)
> +static int ad7606_read_samples(struct ad7606_state *st, bool sign_extend_samples)
>  {
> +	unsigned int storagebits = st->chip_info->channels[1].scan_type.storagebits;

Why [1]? Sure, they are all the same, but [0] would seem less arbitrary.

>  	unsigned int num = st->chip_info->num_channels - 1;
> -	u16 *data = st->data;
> -	int ret;
> +	u32 *data32 = st->data.d32;
> +	u16 *data16 = st->data.d16;
> +	void *data;
> +	int i, ret;
> +
> +	if (storagebits > 16)
> +		data = data32;
> +	else
> +		data = data16;
>  
>  	/*
>  	 * The frstdata signal is set to high while and after reading the sample
> @@ -108,11 +146,25 @@ static int ad7606_read_samples(struct ad7606_state *st)
>  			return -EIO;
>  		}
>  
> -		data++;
> +		if (storagebits > 16)
> +			data32++;
> +		else
> +			data16++;
>  		num--;
>  	}
>  
> -	return st->bops->read_block(st->dev, num, data);
> +	ret = st->bops->read_block(st->dev, num, data);

Since data++ was removed, this looks broken now as well as the
other read_block() not visible in the diff.

Maybe better to drop data32 and data16, keep the change of data
to void*, and change data++ to data += BITS_TO_BYTES(storagebits)?

Although, all of this might be moot since it looks like this
needs to be rebased on [1].

[1]: https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git/commit/?h=fixes-togreg&id=90826e08468ba7fb35d8b39645b22d9e80004afe

> +	if (ret)
> +		return ret;
> +
> +	if (storagebits == 16 || !sign_extend_samples)
> +		return 0;
> +
> +	/* For 18 bit samples, we need to sign-extend samples to 32 bits */
> +	for (i = 0; i < num; i++)
> +		data32[i] = sign_extend32(data32[i], 17);> +
> +	return 0;
>  }
>  
>  static irqreturn_t ad7606_trigger_handler(int irq, void *p)
> @@ -124,11 +176,11 @@ static irqreturn_t ad7606_trigger_handler(int irq, void *p)
>  
>  	guard(mutex)(&st->lock);
>  
> -	ret = ad7606_read_samples(st);
> +	ret = ad7606_read_samples(st, true);

Shouldn't the sign_extend parameter depend on if the data is unipolar or bipolar?

>  	if (ret)
>  		goto error_ret;
>  
> -	iio_push_to_buffers_with_timestamp(indio_dev, st->data,
> +	iio_push_to_buffers_with_timestamp(indio_dev, st->data.d16,
>  					   iio_get_time_ns(indio_dev));
>  error_ret:
>  	iio_trigger_notify_done(indio_dev->trig);
> @@ -142,6 +194,7 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
>  			      int *val)
>  {
>  	struct ad7606_state *st = iio_priv(indio_dev);
> +	unsigned int storagebits = st->chip_info->channels[1].scan_type.storagebits;
>  	int ret;
>  
>  	gpiod_set_value(st->gpio_convst, 1);
> @@ -152,9 +205,13 @@ static int ad7606_scan_direct(struct iio_dev *indio_dev, unsigned int ch,
>  		goto error_ret;
>  	}
>  
> -	ret = ad7606_read_samples(st);
> -	if (ret == 0)
> -		*val = sign_extend32(st->data[ch], 15);
> +	ret = ad7606_read_samples(st, false);

Why not let ad7606_read_samples() do the sign extending since
it can do that now?

> +	if (ret == 0) {
> +		if (storagebits > 16)
> +			*val = sign_extend32(st->data.d32[ch], 17);
> +		else
> +			*val = sign_extend32(st->data.d16[ch], 15);
> +	}
>  
>  error_ret:
>  	gpiod_set_value(st->gpio_convst, 0);
> @@ -267,7 +324,7 @@ static int ad7606_write_raw(struct iio_dev *indio_dev,
>  			ch = chan->address;
>  		cs = &st->chan_scales[ch];
>  		i = find_closest(val2, cs->scale_avail, cs->num_scales);
> -		ret = st->write_scale(indio_dev, ch, i);
> +		ret = st->write_scale(indio_dev, ch, i + cs->reg_offset);
>  		if (ret < 0)
>  			return ret;
>  		cs->range = i;
> @@ -350,6 +407,18 @@ static const struct iio_chan_spec ad7606_channels_16bit[] = {
>  	AD7606_CHANNEL(7, 16),
>  };
>  
> +static const struct iio_chan_spec ad7606_channels_18bit[] = {
> +	IIO_CHAN_SOFT_TIMESTAMP(8),
> +	AD7606_CHANNEL(0, 18),
> +	AD7606_CHANNEL(1, 18),
> +	AD7606_CHANNEL(2, 18),
> +	AD7606_CHANNEL(3, 18),
> +	AD7606_CHANNEL(4, 18),
> +	AD7606_CHANNEL(5, 18),
> +	AD7606_CHANNEL(6, 18),
> +	AD7606_CHANNEL(7, 18),
> +};
> +
>  /*
>   * The current assumption that this driver makes for AD7616, is that it's
>   * working in Hardware Mode with Serial, Burst and Sequencer modes activated.
> @@ -410,6 +479,18 @@ static const struct ad7606_chip_info ad7606_chip_info_tbl[] = {
>  		.oversampling_avail = ad7606_oversampling_avail,
>  		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
>  	},
> +	[ID_AD7606C_16] = {
> +		.channels = ad7606_channels_16bit,
> +		.num_channels = 9,

Could be nice to have a cleanup patch before this to convert others to
use ARRAY_SIZE(), then use ARRAY_SIZE(ad7606_channels_16bit) here
instead of 9.

> +		.oversampling_avail = ad7606_oversampling_avail,
> +		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
> +	},
> +	[ID_AD7606C_18] = {
> +		.channels = ad7606_channels_18bit,
> +		.num_channels = 9,
> +		.oversampling_avail = ad7606_oversampling_avail,
> +		.oversampling_num = ARRAY_SIZE(ad7606_oversampling_avail),
> +	},
>  	[ID_AD7616] = {
>  		.channels = ad7616_channels,
>  		.num_channels = 17,
> @@ -581,7 +662,122 @@ static const struct iio_trigger_ops ad7606_trigger_ops = {
>  	.validate_device = iio_trigger_validate_own_device,
>  };
>  
> -static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
> +static void ad7606c_18_chan_setup(struct ad7606_state *st, int ch,
> +				  bool bipolar, bool differential)
> +{
> +	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
> +
> +	if (differential) {
> +		cs->scale_avail =
> +			ad7606c_18_scale_differential_bipolar_avail;
> +		cs->num_scales =
> +			ARRAY_SIZE(ad7606c_18_scale_differential_bipolar_avail);
> +		/* Bipolar differential ranges start at 8 (b1000) */
> +		cs->reg_offset = 8;
> +		cs->range = 1;
> +	} else if (bipolar) {
> +		cs->scale_avail =
> +			ad7606c_18_scale_single_ended_bipolar_avail;
> +		cs->num_scales =
> +			ARRAY_SIZE(ad7606c_18_scale_single_ended_bipolar_avail);

I guess cs->reg_offset is 0 for this one?

> +		cs->range = 3;
> +	} else {
> +		cs->scale_avail =
> +			ad7606c_18_scale_single_ended_unipolar_avail;
> +		cs->num_scales =
> +			ARRAY_SIZE(ad7606c_18_scale_single_ended_unipolar_avail);
> +		/* Unipolar single-ended ranges start at 5 (b0101) */
> +		cs->reg_offset = 5;
> +		cs->range = 1;
> +	}
> +}
> +
> +static void ad7606c_16_chan_setup(struct ad7606_state *st, int ch,
> +				  bool bipolar, bool differential)
> +{
> +	struct ad7606_chan_scale *cs = &st->chan_scales[ch];
> +
> +	if (differential) {
> +		cs->scale_avail =
> +			ad7606c_16_scale_differential_bipolar_avail;
> +		cs->num_scales =
> +			ARRAY_SIZE(ad7606c_16_scale_differential_bipolar_avail);
> +		/* Bipolar differential ranges start at 8 (b1000) */
> +		cs->reg_offset = 8;
> +		cs->range = 1;
> +	} else if (bipolar) {
> +		cs->scale_avail =
> +			ad7606c_16_scale_single_ended_bipolar_avail;
> +		cs->num_scales =
> +			ARRAY_SIZE(ad7606c_16_scale_single_ended_bipolar_avail);
> +		cs->range = 3;
> +	} else {
> +		cs->scale_avail =
> +			ad7606c_16_scale_single_ended_unipolar_avail;
> +		cs->num_scales =
> +			ARRAY_SIZE(ad7606c_16_scale_single_ended_unipolar_avail);
> +		/* Unipolar single-ended ranges start at 5 (b0101) */
> +		cs->reg_offset = 5;
> +		cs->range = 1;
> +	}
> +}
> +
> +static int ad7606c_sw_mode_setup_channels(struct iio_dev *indio_dev,
> +					  ad7606c_chan_setup_cb_t chan_setup_cb)
> +{
> +	unsigned int num_channels = indio_dev->num_channels - 1;
> +	struct ad7606_state *st = iio_priv(indio_dev);
> +	bool chan_configured[AD760X_MAX_CHANNELS] = {};
> +	struct device *dev = st->dev;
> +	int ret;
> +	u32 ch;
> +
> +	/* We need to hook this first */

Comment would be more useful if it said why.

> +	ret = st->bops->sw_mode_config(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		bool bipolar, differential;
> +		u32 pins[2];
> +
> +		ret = fwnode_property_read_u32(child, "reg", &ch);
> +		if (ret)
> +			continue;
> +
> +		/* channel number (here) is from 1 to num_channels */
> +		if (ch == 0 || ch > num_channels) {
> +			dev_warn(st->dev,
> +				 "Invalid channel number (ignoring): %d\n", ch);
> +			continue;
> +		}
> +
> +		bipolar = fwnode_property_present(child, "bipolar");

IIRC, fwnode_property_read_bool() is preferred for bool/flag properties.

> +
> +		ret = fwnode_property_read_u32_array(child, "diff-channels",
> +						     pins, ARRAY_SIZE(pins));
> +		/* Channel is differential, if pins are the same as 'reg' */
> +		if (ret == 0 && pins[0] == ch && pins[1] == ch)
> +			differential = true;
> +		else
> +			differential = false;

Would probably better to error on bad pin numbers rather than default to
not differential.

> +
> +		ch--;
> +
> +		chan_setup_cb(st, ch, bipolar, differential);
> +		chan_configured[ch] = true;
> +	}
> +
> +	/* Apply default configuration to unconfigured (via DT) channels */
> +	for (ch = 0; ch < num_channels; ch++) {
> +		if (!chan_configured[ch])
> +			chan_setup_cb(st, ch, false, false);
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad7606_sw_mode_setup(struct iio_dev *indio_dev, unsigned int id)
>  {
>  	unsigned int num_channels = indio_dev->num_channels - 1;
>  	struct ad7606_state *st = iio_priv(indio_dev);
> @@ -596,17 +792,30 @@ static int ad7606_sw_mode_setup(struct iio_dev *indio_dev)
>  
>  	indio_dev->info = &ad7606_info_sw_mode;
>  
> -	/* Scale of 0.076293 is only available in sw mode */
> -	/* After reset, in software mode, ±10 V is set by default */
> -	for (ch = 0; ch < num_channels; ch++) {
> -		struct ad7606_chan_scale *cs = &st->chan_scales[ch];
> +	switch (id) {
> +	case ID_AD7606C_18:
> +		ret = ad7606c_sw_mode_setup_channels(indio_dev,
> +						     ad7606c_18_chan_setup);
> +		break;
> +	case ID_AD7606C_16:
> +		ret = ad7606c_sw_mode_setup_channels(indio_dev,
> +						     ad7606c_16_chan_setup);
> +		break;
> +	default:
> +		/* Scale of 0.076293 is only available in sw mode */
> +		/* After reset, in software mode, ±10 V is set by default */
> +		for (ch = 0; ch < num_channels; ch++) {
> +			struct ad7606_chan_scale *cs = &st->chan_scales[ch];
> +
> +			cs->scale_avail = ad7616_sw_scale_avail;
> +			cs->num_scales = ARRAY_SIZE(ad7616_sw_scale_avail);
> +			cs->range = 2;
> +		}
>  
> -		cs->scale_avail = ad7616_sw_scale_avail;
> -		cs->num_scales = ARRAY_SIZE(ad7616_sw_scale_avail);
> -		cs->range = 2;
> +		ret = st->bops->sw_mode_config(indio_dev);
> +		break;
>  	}
>  
> -	ret = st->bops->sw_mode_config(indio_dev);
>  	if (ret)
>  		return ret;
>  
> @@ -655,9 +864,16 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  	st->oversampling = 1;
>  
>  	cs = &st->chan_scales[0];
> -	cs->range = 0;
> -	cs->scale_avail = ad7606_scale_avail;
> -	cs->num_scales = ARRAY_SIZE(ad7606_scale_avail);
> +	switch (id) {
> +	case ID_AD7606C_18:
> +		cs->scale_avail = ad7606_18bit_hw_scale_avail;
> +		cs->num_scales = ARRAY_SIZE(ad7606_18bit_hw_scale_avail);
> +		break;
> +	default:
> +		cs->scale_avail = ad7606_16bit_hw_scale_avail;
> +		cs->num_scales = ARRAY_SIZE(ad7606_16bit_hw_scale_avail);
> +		break;
> +	}
>  
>  	ret = devm_regulator_get_enable(dev, "avcc");
>  	if (ret)
> @@ -706,7 +922,7 @@ int ad7606_probe(struct device *dev, int irq, void __iomem *base_address,
>  	st->write_scale = ad7606_write_scale_hw;
>  	st->write_os = ad7606_write_os_hw;
>  
> -	ret = ad7606_sw_mode_setup(indio_dev);
> +	ret = ad7606_sw_mode_setup(indio_dev, id);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/iio/adc/ad7606.h b/drivers/iio/adc/ad7606.h
> index 2113ad460c0f..6b0897aa2dc7 100644
> --- a/drivers/iio/adc/ad7606.h
> +++ b/drivers/iio/adc/ad7606.h
> @@ -22,7 +22,7 @@
>  		.scan_type = {					\
>  			.sign = 's',				\
>  			.realbits = (bits),			\
> -			.storagebits = (bits),			\
> +			.storagebits = (bits) > 16 ? 32 : 16,	\
>  			.endianness = IIO_CPU,			\
>  		},						\
>  }
> @@ -45,7 +45,7 @@
>  		.scan_type = {					\
>  			.sign = 's',				\
>  			.realbits = (bits),			\
> -			.storagebits = (bits),			\
> +			.storagebits = (bits) > 16 ? 32 : 16,	\
>  			.endianness = IIO_CPU,			\
>  		},						\
>  }
> @@ -88,6 +88,8 @@ struct ad7606_chip_info {
>   *			such that it can be read via the 'read_avail' hook
>   * @num_scales		number of elements stored in the scale_avail array
>   * @range		voltage range selection, selects which scale to apply
> + * @reg_offset		offset for the register value, to be applied when
> + *			writing the value of 'range' to the register value
>   */
>  struct ad7606_chan_scale {
>  #define AD760X_MAX_SCALE_SHOW		(AD760X_MAX_CHANNELS * 2)
> @@ -95,6 +97,7 @@ struct ad7606_chan_scale {
>  	int				scale_avail_show[AD760X_MAX_SCALE_SHOW];
>  	unsigned int			num_scales;
>  	unsigned int			range;
> +	unsigned int			reg_offset;
>  };
>  
>  /**
> @@ -151,9 +154,13 @@ struct ad7606_state {
>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the
>  	 * transfer buffers to live in their own cache lines.
> -	 * 16 * 16-bit samples + 64-bit timestamp
> +	 * 16 * 16-bit samples + 64-bit timestamp - for AD7616
> +	 * 8 * 32-bit samples + 64-bit timestamp - for AD7616C-18 (and similar)
>  	 */
> -	unsigned short			data[20] __aligned(IIO_DMA_MINALIGN);
> +	union {
> +		unsigned short d16[20];
> +		unsigned int d32[10];
> +	} data __aligned(IIO_DMA_MINALIGN);
>  	__be16				d16[2];
>  };
>  
> @@ -192,6 +199,8 @@ enum ad7606_supported_device_ids {
>  	ID_AD7606_6,
>  	ID_AD7606_4,
>  	ID_AD7606B,
> +	ID_AD7606C_16,
> +	ID_AD7606C_18,
>  	ID_AD7616,
>  };
>  
> diff --git a/drivers/iio/adc/ad7606_spi.c b/drivers/iio/adc/ad7606_spi.c
> index e00f58a6a0e9..b8d630ad156d 100644
> --- a/drivers/iio/adc/ad7606_spi.c
> +++ b/drivers/iio/adc/ad7606_spi.c
> @@ -77,6 +77,18 @@ static const struct iio_chan_spec ad7606b_sw_channels[] = {
>  	AD7606_SW_CHANNEL(7, 16),
>  };
>  
> +static const struct iio_chan_spec ad7606c_18_sw_channels[] = {
> +	IIO_CHAN_SOFT_TIMESTAMP(8),
> +	AD7606_SW_CHANNEL(0, 18),
> +	AD7606_SW_CHANNEL(1, 18),
> +	AD7606_SW_CHANNEL(2, 18),
> +	AD7606_SW_CHANNEL(3, 18),
> +	AD7606_SW_CHANNEL(4, 18),
> +	AD7606_SW_CHANNEL(5, 18),
> +	AD7606_SW_CHANNEL(6, 18),
> +	AD7606_SW_CHANNEL(7, 18),
> +};
> +
>  static const unsigned int ad7606B_oversampling_avail[9] = {
>  	1, 2, 4, 8, 16, 32, 64, 128, 256
>  };
> @@ -120,6 +132,19 @@ static int ad7606_spi_read_block(struct device *dev,
>  	return 0;
>  }
>  
> +static int ad7606_spi_read_block18to32(struct device *dev,
> +				       int count, void *buf)
> +{
> +	struct spi_device *spi = to_spi_device(dev);
> +	struct spi_transfer xfer = {
> +		.bits_per_word = 18,
> +		.len = count,

Isn't count the number of words? .len needs to be the number
of bytes, so 4 * count.

> +		.rx_buf = buf,
> +	};
> +
> +	return spi_sync_transfer(spi, &xfer, 1);
> +}
> +
>  static int ad7606_spi_reg_read(struct ad7606_state *st, unsigned int addr)
>  {
>  	struct spi_device *spi = to_spi_device(st->dev);
> @@ -283,6 +308,19 @@ static int ad7606B_sw_mode_config(struct iio_dev *indio_dev)
>  	return 0;
>  }
>  
> +static int ad7606c_18_sw_mode_config(struct iio_dev *indio_dev)
> +{
> +	int ret;
> +
> +	ret = ad7606B_sw_mode_config(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->channels = ad7606c_18_sw_channels;
> +
> +	return 0;
> +}
> +
>  static const struct ad7606_bus_ops ad7606_spi_bops = {
>  	.read_block = ad7606_spi_read_block,
>  };
> @@ -305,6 +343,15 @@ static const struct ad7606_bus_ops ad7606B_spi_bops = {
>  	.sw_mode_config = ad7606B_sw_mode_config,
>  };
>  
> +static const struct ad7606_bus_ops ad7606c_18_spi_bops = {
> +	.read_block = ad7606_spi_read_block18to32,
> +	.reg_read = ad7606_spi_reg_read,
> +	.reg_write = ad7606_spi_reg_write,
> +	.write_mask = ad7606_spi_write_mask,
> +	.rd_wr_cmd = ad7606B_spi_rd_wr_cmd,
> +	.sw_mode_config = ad7606c_18_sw_mode_config,
> +};
> +
>  static int ad7606_spi_probe(struct spi_device *spi)
>  {
>  	const struct spi_device_id *id = spi_get_device_id(spi);
> @@ -315,8 +362,12 @@ static int ad7606_spi_probe(struct spi_device *spi)
>  		bops = &ad7616_spi_bops;
>  		break;
>  	case ID_AD7606B:
> +	case ID_AD7606C_16:
>  		bops = &ad7606B_spi_bops;
>  		break;
> +	case ID_AD7606C_18:
> +		bops = &ad7606c_18_spi_bops;
> +		break;
>  	default:
>  		bops = &ad7606_spi_bops;
>  		break;
> @@ -333,6 +384,8 @@ static const struct spi_device_id ad7606_id_table[] = {
>  	{ "ad7606-6", ID_AD7606_6 },
>  	{ "ad7606-8", ID_AD7606_8 },
>  	{ "ad7606b",  ID_AD7606B },
> +	{ "ad7606c-16",  ID_AD7606C_16 },
> +	{ "ad7606c-18",  ID_AD7606C_18 },
>  	{ "ad7616",   ID_AD7616 },
>  	{ }
>  };
> @@ -344,6 +397,8 @@ static const struct of_device_id ad7606_of_match[] = {
>  	{ .compatible = "adi,ad7606-6" },
>  	{ .compatible = "adi,ad7606-8" },
>  	{ .compatible = "adi,ad7606b" },
> +	{ .compatible = "adi,ad7606c-16" },
> +	{ .compatible = "adi,ad7606c-18" },
>  	{ .compatible = "adi,ad7616" },
>  	{ }
>  };


