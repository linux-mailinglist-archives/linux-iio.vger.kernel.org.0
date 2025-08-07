Return-Path: <linux-iio+bounces-22397-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23F6CB1D820
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 14:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EAD717757A
	for <lists+linux-iio@lfdr.de>; Thu,  7 Aug 2025 12:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6202255E20;
	Thu,  7 Aug 2025 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cNp6FsM9"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5FBA253F1D;
	Thu,  7 Aug 2025 12:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754570478; cv=none; b=OllugN+3xiLQRX9nA1qoYrTz6iqD6Pg1HXwj4RGtpqnjBv96JVZhdmdmFUSswWJEmlcZLt3JIk5dEuZc++sDPUKSXqzOOLAEHESQnrU7bVMHtQOsaoty6W1tyLIsj/u1+ndPQhfQboiPbF7vwTDLMEKpVVDYM2cukroDqdl5OJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754570478; c=relaxed/simple;
	bh=TXGyvaGyMPPVNg79PAuVHfmrGIvwkuLJcVwwkb3efdg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DzgrbUWFLsYAI6uXSj9m7QEfq89rvu6WRxtow554ZFxDQDUTDlNSDq6MaGCiZGH8CtV+UeghIsBLWrLeyF3fPVaRbMP7IkkIrnbNNqCx9x2hyaY6EaFbUUxg1gmJIUkYdJGJK63TjZcP6BXFo5grM9GDL9ibq3aD22XVQTVBBLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cNp6FsM9; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6152faff57eso1462012a12.1;
        Thu, 07 Aug 2025 05:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754570475; x=1755175275; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=01XnmLDiSywh1IksP4ISoM8TkZ79wUU132NpH98B/mk=;
        b=cNp6FsM9cCV1VepOM0+9CVHdVnacb9rTnKuCTXUyVDyqIMc0s2HVzJErfqdTiscvOK
         7sUa7r6mECmQ14rQH0ohG2W9Uia8up03ANGefwxugrmkicbxDHDnhLTdWJwGXKk8R6Rq
         M+QFGdpbvca+GZ20PvCCeycuUNrSh/T3/rzdlWJ+9FaO7CFyaaSwIlRGWAbdf3Gu4Tt6
         p4ONTNlhTTdvSCCnRZ6fBc6xbnsU6SMGJevF6/jHFhfhImGhFUZtRp+8VWTZJW+/ZjC8
         OGwTMHy859gmhK/wy254TWLdZPalooDyqMCAJjKC80jvbFePY64ZQhFDJae9qhpjvpdk
         0PMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754570475; x=1755175275;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=01XnmLDiSywh1IksP4ISoM8TkZ79wUU132NpH98B/mk=;
        b=JAyimAVNhnaS5rBtJRdxUaETD6pZm3cUnoFrofK7FEYAnPQN6Hw4pLRT/kFg84Gc9j
         xYoZsuqzXHXuHJpVZXVGb/3oat/wQm3aEqFWWDGgUlEuFc1W1/bF0qnGgqc+jE62a/GN
         Eg29DGIcpTfcq0URdpKjeMXEcni+2GuLTDgJ6FD7+FOqYnaSGeL8PErR9wBhvYbtighO
         nY/BPThJi2T9iRWsiqYs36uKu6wKpsAue2l9nRa7iIiGJM8+FxmlgrOe5Mb0bpzHBWK5
         LyEoJuoSc4l3W5yrX1WiLsCk7Ibaf4KCiQPQ+cRstnjHvJ8z3l2r1uztnLBpux+8g20q
         ZYaQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUCh4VPxh02z9c0jYBoiwdFz/ocRgrjuOmpx3geFthhjjuR+TXvH1NESs9MoLqPjD5xS2wokJAFpjnI8Om@vger.kernel.org, AJvYcCUqj+9XdCbpxeY3OIwehvm3LFOfTDeRfd01UqhEgWuzdRbPP5L72niCD+9diInSxDSysK/mzoWV9G8O@vger.kernel.org, AJvYcCXmw4KPL2dsAmr9Lc2C73yZXWEWTqXLR+i43uCfx2p0AvoT8ZneVq31KjiwTC9yF4yC4wvRWutdSCmx@vger.kernel.org
X-Gm-Message-State: AOJu0Yxj1y8zPYBG5uqu4nv2pu+gF6UnOfm2R1nbOxq2pvV5gdcJGqC9
	jDABSOC8lYNh9BI8K9P66KCULTqZej4geFfODqdpn3JjVxuRo6gm6SyW
X-Gm-Gg: ASbGnctSTavd93Dki+svPQ/h+Zb86bTvEQbnbBm0XP8kmMVfBL5n7B3Z9MQtsfojZLY
	M2qrGLpk57nHmDMWQx++GoQPgZH/v4IK07z7plqbXHlaMucX+Ae4lOrjnz1U8PBT+6P+DoQpsKr
	3y2+FZ4a9eEb+3u9jnvUuoEqaFhJ5jb2xTiYqZyHHVa9HHDMXy88fom+mZffjQso7enRg8d98du
	uWn0Qe5WwFoUbQzvHcwwEk4hieLC0OFtqfZjJsPp2Hi6bqYq5LRGl65WOZpDvYWl0/Tls5l7nqE
	sd/3CQCPEcPWQTl3Ne3bzxDMDFFPA89eJZSv14JjqHt2/WIAIISQceEH1bfb7Hls5Rbx1ZGYG5+
	2oOBisOgbZ8M=
X-Google-Smtp-Source: AGHT+IGku22djVhhVWppa2oQyT6ofOGRDGpP0ni3lMyo+dSJab9QhN1xKuqjT7L6D4y/OJ6hykUz2Q==
X-Received: by 2002:a05:6402:1d29:b0:5fc:9979:78f7 with SMTP id 4fb4d7f45d1cf-617b662665dmr1594352a12.14.1754570474882;
        Thu, 07 Aug 2025 05:41:14 -0700 (PDT)
Received: from nsa ([185.128.9.33])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-617c843c48fsm718011a12.10.2025.08.07.05.41.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 05:41:14 -0700 (PDT)
Date: Thu, 7 Aug 2025 13:41:31 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/10] iio: adc: ad7476: Drop convstart chan_spec
Message-ID: <tc4od3jtqnj743naxefx5lxkha46wohuuvw46mik6nullvsqbe@knj4t23eaodw>
References: <cover.1754559149.git.mazziesaccount@gmail.com>
 <09bf5e7973c37413ada950741e6e09c375e37c57.1754559149.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09bf5e7973c37413ada950741e6e09c375e37c57.1754559149.git.mazziesaccount@gmail.com>

On Thu, Aug 07, 2025 at 12:34:52PM +0300, Matti Vaittinen wrote:
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
> allocating a mutable per driver instance channel spec an adding the flag
> in probe if needed. This will simplify the driver with the cost of added
> memory consumption.
> 
> Assuming there aren't systems with very many ADCs and very few
> resources, this tradeoff seems worth making.
> 
> Simplify the driver by dropping the 'convstart' channel spec and
> allocating the chan spec for each driver instance.

I do not agree with this one. Looking at the diff, code does not look
simpler to me...

- Nuno Sá

> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> 
> ---
> Revision history:
>  v1 => v2:
>  - New patch
> 
> I considered squashing this change with the one limiting the chip_info
> scope. Having this as a separate change should help reverting if someone
> complains about the increased memory consumption though.
> ---
>  drivers/iio/adc/ad7476.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7476.c b/drivers/iio/adc/ad7476.c
> index e97742912b8e..a30eb016c11c 100644
> --- a/drivers/iio/adc/ad7476.c
> +++ b/drivers/iio/adc/ad7476.c
> @@ -29,8 +29,6 @@ struct ad7476_state;
>  struct ad7476_chip_info {
>  	unsigned int			int_vref_mv;
>  	struct iio_chan_spec		channel[2];
> -	/* channels used when convst gpio is defined */
> -	struct iio_chan_spec		convst_channel[2];
>  	void (*reset)(struct ad7476_state *);
>  	bool				has_vref;
>  	bool				has_vdrive;
> @@ -41,6 +39,7 @@ struct ad7476_state {
>  	struct gpio_desc		*convst_gpio;
>  	struct spi_transfer		xfer;
>  	struct spi_message		msg;
> +	struct iio_chan_spec		channel[2];
>  	int				scale_mv;
>  	/*
>  	 * DMA (thus cache coherency maintenance) may require the
> @@ -153,24 +152,18 @@ static int ad7476_read_raw(struct iio_dev *indio_dev,
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
> @@ -282,7 +275,7 @@ static int ad7476_probe(struct spi_device *spi)
>  	const struct ad7476_chip_info *chip_info;
>  	struct ad7476_state *st;
>  	struct iio_dev *indio_dev;
> -	int ret;
> +	int ret, i;
>  
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
> @@ -332,16 +325,28 @@ static int ad7476_probe(struct spi_device *spi)
>  	if (IS_ERR(st->convst_gpio))
>  		return PTR_ERR(st->convst_gpio);
>  
> +	/*
> +	 * This will never realize. Unless someone changes the channel specs
> +	 * in this driver. And if someone does, without changing the loop
> +	 * below, then we'd better immediately produce a big fat error, before
> +	 * the change proceeds from that developer's table.
> +	 */
> +	BUILD_BUG_ON(ARRAY_SIZE(st->channel) != ARRAY_SIZE(chip_info->channel));
> +	for (i = 0; i < ARRAY_SIZE(st->channel); i++) {
> +		st->channel[i] = chip_info->channel[i];
> +		if (st->convst_gpio)
> +			st->channel[i].info_mask_separate |=
> +				BIT(IIO_CHAN_INFO_RAW);
> +	}
> +
>  	st->spi = spi;
>  
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = chip_info->channel;
> -	indio_dev->num_channels = 2;
> +	indio_dev->channels = st->channel;
> +	indio_dev->num_channels = ARRAY_SIZE(st->channel);
>  	indio_dev->info = &ad7476_info;
>  
> -	if (st->convst_gpio)
> -		indio_dev->channels = chip_info->convst_channel;
>  	/* Setup default message */
>  
>  	st->xfer.rx_buf = &st->data;
> -- 
> 2.50.1
> 



