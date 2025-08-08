Return-Path: <linux-iio+bounces-22463-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDFFB1EA4E
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 16:23:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0252B18C6955
	for <lists+linux-iio@lfdr.de>; Fri,  8 Aug 2025 14:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FD227EFFA;
	Fri,  8 Aug 2025 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfECbbgW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368BB246BCD;
	Fri,  8 Aug 2025 14:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754662996; cv=none; b=dhVprIK59y3jhU6dAaalg2tlrzadvJ+qY5Xe7hDVIrMjP8lqWkYxuyf2KJBLG2BEN0cffNHQe4+KfvxSlGRk/ZfkIgBd5LpC8km1FY77ZkGdD4MqLuPqfA7qlIL/Ll9sQJmEYMeIzVyw3GCzKK319KBrVR/TgI3PBV6t2EaGutk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754662996; c=relaxed/simple;
	bh=lSyohJe+qMBCMoM0nviWkA0Dom8gQCGYgu/eDN5ZiBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E/2MYsyVlHTowxsbAksdIXqLTrf4IaoI6atGdToyBPpyf7+YonR7MTiSSYj+M1Z4e5TKtPhF1mSpukyHoWxf48IwKEA0KYgqFDKU7gAGZawWn2mvlCziB75IyBADbHWZmROnCpAaewYFCNzjwZ8uhMGJj+mYJe2nu8/cQkJMz7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfECbbgW; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4b0a2dd3a75so21857341cf.0;
        Fri, 08 Aug 2025 07:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754662994; x=1755267794; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7t0Eg5w2mMzB5SCM9LOlQLAE2QMemnRv17xVtnDhBzc=;
        b=HfECbbgWKKkboPaw0cAjPCg5e9dFTiNuRfyOfkll4xTGQ/bCZv7uUPj07varVEuBot
         wsQSxqaKLRyly9EAFEC7rSIJOINYM+t9MOaTQIoadHHV+eG3VGN2Qf7ihf+3FfeohX9K
         12kIfpAWKv8GJTHtjizVWiPUHDc+MZQx5JtYoH+J+yvJsA+9N7mtBJK9kHxiXpgO8dw8
         wSI2dI1wcp7UsIyBWOfn0d9SCe3MGnUbd7F7jui+5ETPZo9NV5wppqCNGjAx/jW4Epb/
         ++SkM89pVFi5n3EmAQuyTHymsvfe0ATKxNBb2xGvKYB7UddZs37Vk9KxYOS01QIVa15C
         a+XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754662994; x=1755267794;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7t0Eg5w2mMzB5SCM9LOlQLAE2QMemnRv17xVtnDhBzc=;
        b=RdbFjpnUUtxPup1clzHD50n3pAbp5Re28JUWElvWM0Em4hCvTy089HS4WewVLb7L+z
         NUw6KQOuiOajsJDwIDKG07BLVjRC72TI6JAY+WCF3DfSIUVADfENxTmNuINB4DZ0qsR0
         sFZNuqnQ0W0ILSNFqg4LMfX4+p4IHJ24SW4d04esegSpONoqrZuxGFHPx7TRJRWyb+xZ
         0BchQI3uR+SCRxfTvh7elYybbiMv315YPVgeg7qdKYuIXAo1VWhujZd3mHHCh4KxhPKZ
         uUYtSAUs2toe7Qce1t0Accr0shKFxlEkwfDJL7p3+RCDDWbleEdTC37syVrsqE6wKl6R
         Igzg==
X-Forwarded-Encrypted: i=1; AJvYcCV6rLwHVgkNW+GJpR905JUtnWEcK0AAZdmySuLLYL37QMMK5GZStNYMe/obdxBbUdsoRDcbESSWG63f@vger.kernel.org, AJvYcCW1fgmVwYG037RAJ6o0k8xjxojrF0aGiYouwtYpVjpaCz/lWvJq30p8eV5gVzOfMSoIDWljhhn0C8eWyxbw@vger.kernel.org, AJvYcCX82UDXcxmjn5aLR6gYFdy+u+ChyA8GEunFh2aLfXXxIQRHDW/L02c/3PbQSkJOUh9wQgxrm0F88NVz@vger.kernel.org
X-Gm-Message-State: AOJu0YzLQNFj3pj47xsiobm6EYHxh5NoFoHMoBYcrPCi8Slzv5FrM2t1
	/w+2i/tzo5YyJUwgJf6P9UHFWcV84TX3fIdACw5+jvFlL5Cqzo+NF2RhXOsHcVuJdkWHdw==
X-Gm-Gg: ASbGncsVEgzFzYJNf/FTmaNCcS3jrIh2EdAkJxJ9UvFfkkH94HueYBhGzZChQoeYQUb
	6SRe+wJyELIzjCw2UfJNxS03xz4jGNp9I4eDfq6Qhhk+TsZ8IC2hN6Kn2KHBNs/gvK/u721AJHW
	5i1TpebgrfenB64H1J6jzCefrr0RjKsp2Pl3pGQTEYPr1gg8BhXa/ixQ9ZEhW0Ip4pnU//2L+iu
	OcyOD1fOOlD7Uk4A+jdiE+8ZfGgzLThzbYP1eFixY1AvBnvNHExD65j3Vc1QrkCzC8jpplzX6g6
	oXFZ/DX18r2DVx7yfS8JLCQtDQi1IZ3xoAZgjvwTAH87uLZflA9yhuI4bwukE+fIKKzn9B3i6Oq
	91k8Et5Ub0jB8+A==
X-Google-Smtp-Source: AGHT+IHnyD3ArD5JYGIqRAc6h/JGG3I2BZANQjUHGqSA2Sv3wJaQ+GuOQP6WzrD/oajdLgIUp6WlJA==
X-Received: by 2002:a05:622a:5916:b0:4b0:b5b8:de03 with SMTP id d75a77b69052e-4b0b5b8e283mr23484101cf.50.1754662993645;
        Fri, 08 Aug 2025 07:23:13 -0700 (PDT)
Received: from nsa ([87.249.138.211])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b08cfbc7b9sm41242781cf.23.2025.08.08.07.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Aug 2025 07:23:12 -0700 (PDT)
Date: Fri, 8 Aug 2025 15:23:27 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/10] iio: adc: ad7476: Drop convstart chan_spec
Message-ID: <jarpgbc2p46mh6nqsrz2e6rb4l3f3gpc32ebberizv5x3bwg55@b6s6qu22eqjw>
References: <cover.1754641960.git.mazziesaccount@gmail.com>
 <8ed500a973d14460f541f1701e4423eb11b1f179.1754641960.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8ed500a973d14460f541f1701e4423eb11b1f179.1754641960.git.mazziesaccount@gmail.com>

On Fri, Aug 08, 2025 at 11:53:29AM +0300, Matti Vaittinen wrote:
> The ad7476 driver defines separate chan_spec structures for operation
> with and without convstart GPIO. At quick glance this may seem as if the
> driver did provide more than 1 data-channel to users - one for the
> regular data, other for the data obtained with the convstart GPIO.
> 
> The only difference between the 'convstart' and 'non convstart'
> -channels is presence / absence of the BIT(IIO_CHAN_INFO_RAW) in
> channel's flags.
> 
> We can drop the convstart channel spec, and related convstart macro, by
> allocating a mutable per driver instance channel spec and adding the flag
> in probe if needed. This will simplify the driver with the cost of added
> memory consumption.
> 
> Assuming there aren't systems with very many ADCs and very few
> resources, this tradeoff seems worth making.
> 
> Simplify the driver by dropping the 'convstart' channel spec and
> allocating the channel spec for each driver instance.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
>  v2 => v3:
>  - Use __set_bit() instead of |=
>  - Swicth BUILD_BUG_ON to static_assert
>  - Clarify a comment
>  - Improve commit message
> 
>  v1 => v2:
>  - New patch
> ---

Reviewed-by: Nuno Sá <nuno.sa@analog.com>

>  drivers/iio/adc/ad7476.c | 31 +++++++++++++++++++------------
>  1 file changed, 19 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index 1445f0f599d9..ad9e629f0cbd 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -6,6 +6,7 @@
>   * Copyright 2010 Analog Devices Inc.
>   */
>  
> +#include <linux/bitops.h>
>  #include <linux/device.h>
>  #include <linux/kernel.h>
>  #include <linux/slab.h>
> @@ -29,8 +30,6 @@ struct ad7476_state;
>  struct ad7476_chip_info {
>  	unsigned int			int_vref_mv;
>  	struct iio_chan_spec		channel[2];
> -	/* channels used when convst gpio is defined */
> -	struct iio_chan_spec		convst_channel[2];
>  	void (*reset)(struct ad7476_state *);
>  	bool				has_vref;
>  	bool				has_vdrive;
> @@ -42,6 +41,7 @@ struct ad7476_state {
>  	struct gpio_desc		*convst_gpio;
>  	struct spi_transfer		xfer;
>  	struct spi_message		msg;
> +	struct iio_chan_spec		channel[2];
>  	int				scale_mv;
>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the
> @@ -154,24 +154,18 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
>  #define AD7940_CHAN(bits) _AD7476_CHAN((bits), 15 - (bits), \
>  		BIT(IIO_CHAN_INFO_RAW))
>  #define AD7091R_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), 0)
> -#define AD7091R_CONVST_CHAN(bits) _AD7476_CHAN((bits), 16 - (bits), \
> -		BIT(IIO_CHAN_INFO_RAW))
>  #define ADS786X_CHAN(bits) _AD7476_CHAN((bits), 12 - (bits), \
>  		BIT(IIO_CHAN_INFO_RAW))
>  
>  static const struct ad7476_chip_info ad7091_chip_info = {
>  	.channel[0] = AD7091R_CHAN(12),
>  	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> -	.convst_channel[0] = AD7091R_CONVST_CHAN(12),
> -	.convst_channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>  	.reset = ad7091_reset,
>  };
>  
>  static const struct ad7476_chip_info ad7091r_chip_info = {
>  	.channel[0] = AD7091R_CHAN(12),
>  	.channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
> -	.convst_channel[0] = AD7091R_CONVST_CHAN(12),
> -	.convst_channel[1] = IIO_CHAN_SOFT_TIMESTAMP(1),
>  	.int_vref_mv = 2500,
>  	.has_vref = true,
>  	.reset = ad7091_reset,
> @@ -282,6 +276,7 @@ static int ad7476_probe(struct spi_device *spi)
>  {
>  	struct ad7476_state *st;
>  	struct iio_dev *indio_dev;
> +	unsigned int i;
>  	int ret;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
> @@ -332,16 +327,28 @@ static int ad7476_probe(struct spi_device *spi)
>  	if (IS_ERR(st->convst_gpio))
>  		return PTR_ERR(st->convst_gpio);
>  
> +	/*
> +	 * This will never happen. Unless someone changes the channel specs
> +	 * in this driver. And if someone does, without changing the loop
> +	 * below, then we'd better immediately produce a big fat error, before
> +	 * the change proceeds from that developer's table.
> +	 */
> +	static_assert(ARRAY_SIZE(st->channel) == ARRAY_SIZE(st->chip_info->channel));
> +	for (i = 0; i < ARRAY_SIZE(st->channel); i++) {
> +		st->channel[i] = st->chip_info->channel[i];
> +		if (st->convst_gpio)
> +			__set_bit(IIO_CHAN_INFO_RAW,
> +				  &st->channel[i].info_mask_separate);
> +	}
> +
>  	st->spi = spi;
>  
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = st->chip_info->channel;
> -	indio_dev->num_channels = 2;
> +	indio_dev->channels = st->channel;
> +	indio_dev->num_channels = ARRAY_SIZE(st->channel);
>  	indio_dev->info = &ad7476_info;
>  
> -	if (st->convst_gpio)
> -		indio_dev->channels = st->chip_info->convst_channel;
>  	/* Setup default message */
>  
>  	st->xfer.rx_buf = &st->data;
> -- 
> 2.50.1
> 



