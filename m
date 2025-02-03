Return-Path: <linux-iio+bounces-14927-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D509A25DD2
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 16:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CF56162584
	for <lists+linux-iio@lfdr.de>; Mon,  3 Feb 2025 14:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C99205E32;
	Mon,  3 Feb 2025 14:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UBTmwZuS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D5C1E493;
	Mon,  3 Feb 2025 14:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738594711; cv=none; b=oz4Zvtx+N9fwZHjmhml8NWS2iI9yXsxlbSK7Q+IV01410LokLAegDsAKu+4nm1s0lCfE+CpwK3P1QDkOhd8icNPN5lA7e8AYioZj7pGyf1E7pTEkI7vbtoS2G4bvg8YV573/3XzD07TqRg34Fnj4a5bj9Z7E3GOgXVsT24eJy/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738594711; c=relaxed/simple;
	bh=jP1TIegHdeQmay4mVDQzRaM6VPwF8MXTgR27byfWXGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C/GTlDFYFzqtp1YMVu4KfBIBF1e1VamM4/QgakA1GOZqFt66Jt7FQ2GX76Pnij9l4rH9w3QNSuyF7ZpDiWGDcwgDNjJc88K6R/UWviX4IK3ZRGmc/o8VuN961fLTlLG39skip9g+s0vTpt0PYnkRwMAdKyPfuafOMQ2m1bNqw6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UBTmwZuS; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6eadd2946so73442985a.1;
        Mon, 03 Feb 2025 06:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738594708; x=1739199508; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ohKdpLK9aqQt7D/JxrKFfrFDVP6fewEVXEGMhLdBVo=;
        b=UBTmwZuSdurhJk6wy0LsuUcPoR/TLa2s9SVRG6GsD9ETqkE38RZhM4Dbg8pEHjYzFr
         9CfNFdcfpnxRaHaoMY16LpaKMRfsL+HMZUQYSg0Lxo5STVp9CFA1cD/1aqgHahB/c1lM
         Hzx8yOmScUAwA1VSnS2geUJ+5/YNCh/yJXe44cAxGfLnJyxyqjy2siqBSDlyfgGm450O
         Fhc3YE7lrK40KBo4wQ9tHMQwBO2k/9KLaKnIkL3EnJNtORfgoO+B3gIQoRKax9f/bUWj
         tkbLbAYAyMwEX/y5Ghx7Y/hwkDKSV4XxzBeKspzwC52+O9G7f242IMR2z5WJHwmBvRsE
         QhvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738594708; x=1739199508;
        h=in-reply-to:content-disposition:mime-version:references:reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3ohKdpLK9aqQt7D/JxrKFfrFDVP6fewEVXEGMhLdBVo=;
        b=YB0B6xHkosoXbpN0oOrvzY+E7Yh8ivwq8UU6SKWW9yuJJHGufmfwFbmYDCKCsk/x1B
         X30deRjGSwg5xzef24RY/lwtXrb9B+IkV/8b01EpgKochDf/l0wjyVbbiSFgvXI3Y5HT
         5OuOOnEV+MGOWVZ6ihLMS2DniqJOiUX2fUbCWx/V5MknuJBtqDa/WaEoxU3vqfDzNTwp
         4mJO8ey0RR6LKY8h/hkziMtwZCuWa8Slfmwh41ZHPrzefKa9wSl60OKNKyAdATWV8MJ/
         JdOjkzZZziUYVZEPWMgeNacCRSxvmPe/d3RXFuUlQVcrbosd1EJ1VwXsbHXnxhvnVnzh
         XSFA==
X-Forwarded-Encrypted: i=1; AJvYcCU/P+nyrUtRJkDBKf+vM+x133OvMoACDbLgs6Wo+W+PdGz/o19SrZ/5nYi2Br20O0VotWcaNpjYwudN@vger.kernel.org, AJvYcCUzIyE2jxKdBESC9yZBxM1QwMD9ASgV6p30C+d7BcLwB7VBiGN1wPfep4v3FzuSHPcUNEmhWHg/AnN1@vger.kernel.org, AJvYcCVDtQuG69REuRi8JxhuDwL7t1kDhOQoor1Ru1NSpbog6O7hzyRcFVHXZhMGKqOFX3PdLxF64jMc55b+qdl1@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0sKCdnTTXIhDFrJcgMYp4STKJorHEVzjTmzPyfml4Foynr4TX
	N0z7n0IVyoleIILQpt7r4xXZOfwF2UzIMSpZ17LHgTJ2bfgIa+x8
X-Gm-Gg: ASbGncuYuxBEwytb4WfKZ5OwT4YikR+/bxGFOZkLhBw7woJxBAgfl3DWnNoSeetoOLy
	kAmCw23i9TyQ+dW+lMiX0b3zBq9hYazLKEl7DJhAyHeYgK1beB/F6qrG0ESVVSr2Rsuhzut5DR7
	BPYC4H0E+Y8Lq2fmsMpkpLDiutMZa6U05/R/4KhHILXMf0z4LkLT19Xqf0l+wEc39I2OGZquFHq
	y587B9c6ZqZZG7bPds8i/pnBO/ZHZNUw6682PNOOueFl/PPL1ojU/bayBAlhdJwLRe4s/nIi9nH
	D1M7ypklN80mENM0XN9hiOxCL3x6Mayh8hqR
X-Google-Smtp-Source: AGHT+IH4+H1x7qVv0qG6mxLiEjHB1d+hBKmIckkGcL99pDlZTLkKnf5z7OmqwLaNsCP76sDB1cLKfA==
X-Received: by 2002:a05:620a:4252:b0:7b6:c3ad:6cc5 with SMTP id af79cd13be357-7bffcd1380fmr1192037885a.8.1738594707403;
        Mon, 03 Feb 2025 06:58:27 -0800 (PST)
Received: from JSANTO12-L01.ad.analog.com ([189.121.203.94])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c00a90d08asm530139185a.98.2025.02.03.06.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2025 06:58:26 -0800 (PST)
Date: Mon, 3 Feb 2025 11:58:22 -0300
From: Jonathan Santos <jonath4nns@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Jonathan Santos <Jonathan.Santos@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	PopPaul2021 <paul.pop@analog.com>
Subject: Re: [PATCH v2 15/16] iio: adc: ad7768-1: add filter type and
 oversampling ratio attributes
Message-ID: <Z6DZjh415XeUPx9j@JSANTO12-L01.ad.analog.com>
Reply-To: e145d80-1b2f-4107-8f8d-612024e1dd10@baylibre.com
References: <cover.1737985435.git.Jonathan.Santos@analog.com>
 <3a5684280e86df1e2cc2c9be291fa2807aa6cb02.1737985435.git.Jonathan.Santos@analog.com>
 <de145d80-1b2f-4107-8f8d-612024e1dd10@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de145d80-1b2f-4107-8f8d-612024e1dd10@baylibre.com>

On 01/27, David Lechner wrote:
> On 1/27/25 9:14 AM, Jonathan Santos wrote:
> > Separate filter type and decimation rate from the sampling frequency
> > attribute. The new filter type attribute enables SINC3 and WIDEBAND
> > filters, which were previously unavailable.
> > 
> > Previously, combining decimation and MCLK divider in the sampling
> > frequency obscured performance trade-offs. Lower MCLK divider
> > settings increase power usage, while lower decimation rates reduce
> > precision by decreasing averaging. By creating an oversampling
> > attribute, which controls the decimation, users gain finer control
> > over performance.
> > 
> > The addition of those attributes allows a wider range of sampling
> > frequencies and more access to the device features.
> > 
> > Co-developed-by: PopPaul2021 <paul.pop@analog.com>
> > Signed-off-by: PopPaul2021 <paul.pop@analog.com>
> > Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> > ---
> > v2 Changes:
> > * Decimation_rate attribute replaced for oversampling_ratio.
> > ---
> >  drivers/iio/adc/ad7768-1.c | 389 +++++++++++++++++++++++++++++++------
> >  1 file changed, 325 insertions(+), 64 deletions(-)
> > 
> > diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> > index 01ccbe0aa708..6d0b430a8d54 100644
> > --- a/drivers/iio/adc/ad7768-1.c
> > +++ b/drivers/iio/adc/ad7768-1.c
> > @@ -5,6 +5,7 @@
> >   * Copyright 2017 Analog Devices Inc.
> >   */
> >  #include <linux/bitfield.h>
> > +#include <linux/cleanup.h>
> >  #include <linux/clk.h>
> >  #include <linux/delay.h>
> >  #include <linux/device.h>
> > @@ -17,6 +18,7 @@
> >  #include <linux/regmap.h>
> >  #include <linux/regulator/consumer.h>
> >  #include <linux/sysfs.h>
> > +#include "linux/util_macros.h"
> 
> nit: alphabetical order
> 
> >  #include <linux/spi/spi.h>
> >  
> >  #include <linux/iio/buffer.h>
> > @@ -77,6 +79,10 @@
> >  #define AD7768_DIG_FIL_DEC_MSK		GENMASK(2, 0)
> >  #define AD7768_DIG_FIL_DEC_RATE(x)	FIELD_PREP(AD7768_DIG_FIL_DEC_MSK, x)
> >  
> > +/* AD7768_SINC3_DEC_RATE */
> > +#define AD7768_SINC3_DEC_RATE_MSB_MSK	GENMASK(12, 8)
> > +#define AD7768_SINC3_DEC_RATE_LSB_MSK	GENMASK(7, 0)
> > +
> >  /* AD7768_REG_CONVERSION */
> >  #define AD7768_CONV_MODE_MSK		GENMASK(2, 0)
> >  #define AD7768_CONV_MODE(x)		FIELD_PREP(AD7768_CONV_MODE_MSK, x)
> > @@ -97,6 +103,18 @@
> >  #define AD7768_RD_FLAG_MSK(x)		(BIT(6) | ((x) & 0x3F))
> >  #define AD7768_WR_FLAG_MSK(x)		((x) & 0x3F)
> >  
> > +/* Decimation Rate Limits */
> > +#define SINC5_DEC_RATE_MIN		8
> > +#define SINC5_DEC_RATE_MAX		1024
> > +#define SINC3_DEC_RATE_MIN		32
> > +#define SINC3_DEC_RATE_MAX		163840
> > +#define WIDEBAND_DEC_RATE_MIN		32
> > +#define WIDEBAND_DEC_RATE_MAX		1024
> > +
> > +enum {
> > +	DEC_RATE,
> 
> Odd to have enum with one member. Also should have AD7768_ namespace prefix.
> 

This is not in use anymore, i will remove it.

> > +};
> > +
> >  enum ad7768_conv_mode {
> >  	AD7768_CONTINUOUS,
> >  	AD7768_ONE_SHOT,
> > @@ -118,22 +136,12 @@ enum ad7768_mclk_div {
> >  	AD7768_MCLK_DIV_2
> >  };
> >  
> > -enum ad7768_dec_rate {
> > -	AD7768_DEC_RATE_32 = 0,
> > -	AD7768_DEC_RATE_64 = 1,
> > -	AD7768_DEC_RATE_128 = 2,
> > -	AD7768_DEC_RATE_256 = 3,
> > -	AD7768_DEC_RATE_512 = 4,
> > -	AD7768_DEC_RATE_1024 = 5,
> > -	AD7768_DEC_RATE_8 = 9,
> > -	AD7768_DEC_RATE_16 = 10
> > -};
> > -
> > -struct ad7768_clk_configuration {
> > -	enum ad7768_mclk_div mclk_div;
> > -	enum ad7768_dec_rate dec_rate;
> > -	unsigned int clk_div;
> > -	enum ad7768_pwrmode pwrmode;
> > +enum ad7768_flt_type {
> > +	SINC5,
> > +	SINC5_DEC_X8,
> > +	SINC5_DEC_X16,
> > +	SINC3,
> > +	WIDEBAND
> >  };
> >  
> >  enum ad7768_scan_type {
> > @@ -145,18 +153,12 @@ static const int ad7768_mclk_div_rates[4] = {
> >  	16, 8, 4, 2,
> >  };
> >  
> > -static const struct ad7768_clk_configuration ad7768_clk_config[] = {
> > -	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_8, 16,  AD7768_FAST_MODE },
> > -	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_16, 32,  AD7768_FAST_MODE },
> > -	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_32, 64, AD7768_FAST_MODE },
> > -	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_64, 128, AD7768_FAST_MODE },
> > -	{ AD7768_MCLK_DIV_2, AD7768_DEC_RATE_128, 256, AD7768_FAST_MODE },
> > -	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_128, 512, AD7768_MED_MODE },
> > -	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_256, 1024, AD7768_MED_MODE },
> > -	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_512, 2048, AD7768_MED_MODE },
> > -	{ AD7768_MCLK_DIV_4, AD7768_DEC_RATE_1024, 4096, AD7768_MED_MODE },
> > -	{ AD7768_MCLK_DIV_8, AD7768_DEC_RATE_1024, 8192, AD7768_MED_MODE },
> > -	{ AD7768_MCLK_DIV_16, AD7768_DEC_RATE_1024, 16384, AD7768_ECO_MODE },
> > +static const int ad7768_dec_rate_values[6] = {
> > +	32, 64, 128, 256, 512, 1024,
> > +};
> > +
> > +static const char * const ad7768_filter_enum[] = {
> > +	"sinc5", "sinc3", "wideband"
> 
> Do we also need to consider "sinc3+rej60" to account for the EN_60HZ_REJ bit
> in the DIGITAL_FILTER register?
> 

Sure, i will also include this filter.

> >  };
> >  
> >  static const struct iio_scan_type ad7768_scan_type[] = {
> > @@ -176,12 +178,32 @@ static const struct iio_scan_type ad7768_scan_type[] = {
> >  	},
> >  };
> >  
> > +static int ad7768_get_fil_type_attr(struct iio_dev *dev,
> > +				    const struct iio_chan_spec *chan);
> > +static int ad7768_set_fil_type_attr(struct iio_dev *dev,
> > +				    const struct iio_chan_spec *chan, unsigned int filter);
> > +
> > +static const struct iio_enum ad7768_flt_type_iio_enum = {
> > +	.items = ad7768_filter_enum,
> > +	.num_items = ARRAY_SIZE(ad7768_filter_enum),
> > +	.set = ad7768_set_fil_type_attr,
> > +	.get = ad7768_get_fil_type_attr,
> > +};
> > +
> > +static struct iio_chan_spec_ext_info ad7768_ext_info[] = {
> > +	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad7768_flt_type_iio_enum),
> > +	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL, &ad7768_flt_type_iio_enum),
> > +	{ },
> > +};
> > +
> >  static const struct iio_chan_spec ad7768_channels[] = {
> >  	{
> >  		.type = IIO_VOLTAGE,
> >  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> >  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> > -		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> > +					   BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),
> 
> info_mask_shared_by_type might be safer in case we ever have to add a non-
> voltage channel for some reason.
> 

ok!

> > +		.ext_info = ad7768_ext_info,
> >  		.indexed = 1,
> >  		.channel = 0,
> >  		.scan_index = 0,
> > @@ -201,7 +223,9 @@ struct ad7768_state {
> >  	struct gpio_chip gpiochip;
> >  	unsigned int gpio_avail_map;
> >  	unsigned int mclk_freq;
> > -	unsigned int dec_rate;
> > +	unsigned int mclk_div;
> > +	unsigned int oversampling_ratio;
> > +	enum ad7768_flt_type filter_type;
> >  	unsigned int samp_freq;
> >  	struct completion completion;
> >  	struct iio_trigger *trig;
> > @@ -223,6 +247,9 @@ struct ad7768_state {
> >  	} data __aligned(IIO_DMA_MINALIGN);
> >  };
> >  
> > +static int ad7768_set_freq(struct ad7768_state *st,
> > +			   unsigned int freq);
> 
> Would be nice if we can reorder functions to avoid forward declaration.
> 
> > +
> >  static int ad7768_spi_reg_read(void *context, unsigned int addr,
> >  			       unsigned int *val)
> >  {
> > @@ -281,6 +308,31 @@ static int ad7768_send_sync_pulse(struct ad7768_state *st)
> >  	return 0;
> >  }
> >  
> > +static int ad7768_set_mclk_div(struct ad7768_state *st, unsigned int mclk_div)
> > +{
> > +	unsigned int mclk_div_value;
> > +	int ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +	ret = ad7768_spi_reg_read(st, AD7768_REG_POWER_CLOCK, &mclk_div_value, 1);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mclk_div_value &= ~(AD7768_PWR_MCLK_DIV_MSK | AD7768_PWR_PWRMODE_MSK);
> > +	/* Set mclk_div value */
> > +	mclk_div_value |= AD7768_PWR_MCLK_DIV(mclk_div);
> > +	/*
> > +	 * Set power mode based on mclk_div value.
> > +	 * ECO_MODE is only recommended for MCLK_DIV 16
> > +	 */
> > +	if (mclk_div > AD7768_MCLK_DIV_16)
> > +		mclk_div_value |= AD7768_PWR_PWRMODE(AD7768_FAST_MODE);
> > +	else
> > +		mclk_div_value |= AD7768_PWR_PWRMODE(AD7768_ECO_MODE);
> > +
> > +	return regmap_write(st->regmap, AD7768_REG_POWER_CLOCK, mclk_div_value);
> 
> Can we do this with regmap_update_bits() and FIELD_PREP() instead?
> 

Sure

> > +}
> > +
> >  static int ad7768_set_mode(struct ad7768_state *st,
> >  			   enum ad7768_conv_mode mode)
> >  {
> > @@ -349,23 +401,183 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
> >  	return ret;
> >  }
> >  
> > -static int ad7768_set_dig_fil(struct ad7768_state *st,
> > -			      enum ad7768_dec_rate dec_rate)
> > +static int ad7768_set_sinc3_dec_rate(struct ad7768_state *st,
> > +				     unsigned int dec_rate)
> > +{
> > +	unsigned int dec_rate_msb, dec_rate_lsb, max_dec_rate;
> > +	int ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +	/*
> > +	 * Maximum dec_rate is limited by the MCLK_DIV value
> > +	 * and by the ODR. The edge case is for MCLK_DIV = 2
> > +	 * ODR = 50 SPS.
> > +	 * max_dec_rate <= MCLK / (2 * 50)
> > +	 */
> > +	max_dec_rate = st->mclk_freq / 100;
> > +	dec_rate = clamp_t(unsigned int, dec_rate, 32, max_dec_rate);
> > +	/*
> > +	 * Calculate the equivalent value to sinc3 decimation ratio
> > +	 * to be written on the SINC3_DECIMATION_RATE register:
> > +	 *  Value = (DEC_RATE / 32) -1
> > +	 */
> > +	dec_rate = DIV_ROUND_UP(dec_rate, 32) - 1;
> > +	dec_rate_msb = FIELD_GET(AD7768_SINC3_DEC_RATE_MSB_MSK, dec_rate);
> > +	dec_rate_lsb = FIELD_GET(AD7768_SINC3_DEC_RATE_LSB_MSK, dec_rate);
> > +
> > +	ret = regmap_write(st->regmap, AD7768_REG_SINC3_DEC_RATE_MSB, dec_rate_msb);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret = regmap_write(st->regmap, AD7768_REG_SINC3_DEC_RATE_LSB, dec_rate_lsb);
> > +	if (ret)
> > +		return ret;
> 
> Can we use regmap_bulk_write()?
> 
> > +
> > +	st->oversampling_ratio = (dec_rate + 1) * 32;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad7768_set_dec_rate(struct ad7768_state *st, unsigned int dec_rate)
> >  {
> > +	unsigned int mode, dec_rate_reg;
> > +	int ret;
> > +
> > +	dec_rate_reg = find_closest(dec_rate, ad7768_dec_rate_values,
> > +				    ARRAY_SIZE(ad7768_dec_rate_values));
> > +
> > +	guard(mutex)(&st->lock);
> > +	ret = regmap_read(st->regmap, AD7768_REG_DIGITAL_FILTER, &mode);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mode &= ~AD7768_DIG_FIL_DEC_MSK;
> > +	mode |= AD7768_DIG_FIL_DEC_RATE(dec_rate_reg);
> > +	ret = regmap_write(st->regmap, AD7768_REG_DIGITAL_FILTER, mode);
> 
> regmap_update_bits()?
> 
> > +	if (ret)
> > +		return ret;
> > +
> > +	st->oversampling_ratio = ad7768_dec_rate_values[dec_rate_reg];
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad7768_set_filter_type(struct iio_dev *dev,
> > +				  enum ad7768_flt_type filter_type)
> > +{
> > +	struct ad7768_state *st = iio_priv(dev);
> >  	unsigned int mode;
> >  	int ret;
> >  
> > -	if (dec_rate == AD7768_DEC_RATE_8 || dec_rate == AD7768_DEC_RATE_16)
> > -		mode = AD7768_DIG_FIL_FIL(dec_rate);
> > -	else
> > -		mode = AD7768_DIG_FIL_DEC_RATE(dec_rate);
> > +	guard(mutex)(&st->lock);
> 
> Lock was removed in previous patch, so shouldn't be using it here.
> 
> > +	ret = regmap_read(st->regmap, AD7768_REG_DIGITAL_FILTER, &mode);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mode &= ~AD7768_DIG_FIL_FIL_MSK;
> > +	mode |= AD7768_DIG_FIL_FIL(filter_type);
> >  
> >  	ret = regmap_write(st->regmap, AD7768_REG_DIGITAL_FILTER, mode);
> >  	if (ret < 0)
> >  		return ret;
> 
> Looks like we could drop the helper function and just use regmap_update_bits()
> directly now.
> 
> >  
> > -	/* A sync-in pulse is required every time the filter dec rate changes */
> > -	return ad7768_send_sync_pulse(st);
> > +	st->filter_type = filter_type;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad7768_configure_dig_fil(struct iio_dev *dev,
> > +				    enum ad7768_flt_type filter_type,
> > +				    unsigned int dec_rate)
> > +{
> > +	struct ad7768_state *st = iio_priv(dev);
> > +	int ret;
> > +
> > +	if (filter_type == SINC3) {
> 
> Using a switch statement instead would be more like other IIO code.
> 

I did some changes in this function to be able to use the switch
appropriately.

> > +		ret = ad7768_set_filter_type(dev, SINC3);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* recalculate the decimation for this filter mode */
> > +		ret = ad7768_set_sinc3_dec_rate(st, dec_rate);
> 
> Just return directly.
> 
> > +	} else if (filter_type == WIDEBAND) {
> > +		ret = ad7768_set_filter_type(dev, filter_type);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* recalculate the decimation rate */
> > +		ret = ad7768_set_dec_rate(st, dec_rate);
> > +	} else {
> > +		/* For SINC5 filter */
> > +		/* Decimation 8 and 16 are set in the digital filter field */
> > +		if (dec_rate <= 8) {
> > +			ret = ad7768_set_filter_type(dev, SINC5_DEC_X8);
> > +			if (ret)
> > +				return ret;
> > +
> > +			st->oversampling_ratio = 8;
> > +		} else if (dec_rate <= 16) {
> > +			ret = ad7768_set_filter_type(dev, SINC5_DEC_X16);
> > +			if (ret)
> > +				return ret;
> > +
> > +			st->oversampling_ratio = 16;
> > +		} else {
> > +			ret = ad7768_set_filter_type(dev, SINC5);
> > +			if (ret)
> > +				return ret;
> > +
> > +			ret = ad7768_set_dec_rate(st, dec_rate);
> > +		}
> > +	}
> > +
> > +	return ret;
> > +}
> > +
> > +static int ad7768_set_fil_type_attr(struct iio_dev *dev,
> > +				    const struct iio_chan_spec *chan,
> > +				    unsigned int filter)
> > +{
> > +	struct ad7768_state *st = iio_priv(dev);
> > +	int ret;
> > +
> > +	/*
> > +	 * Filters of types 0, 1, and 2 correspond to SINC5.
> > +	 * For SINC3 and wideband filter types, an offset of 2 is added
> > +	 * to align with the expected register values.
> > +	 */
> > +	if (filter != SINC5)
> > +		filter += 2;
> > +
> > +	ret = ad7768_configure_dig_fil(dev, filter, st->oversampling_ratio);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* Update sampling frequency */
> > +	return ad7768_set_freq(st, st->samp_freq);
> > +}
> > +
> > +static int ad7768_get_fil_type_attr(struct iio_dev *dev,
> > +				    const struct iio_chan_spec *chan)
> > +{
> > +	struct ad7768_state *st = iio_priv(dev);
> > +	int ret;
> > +	unsigned int mode;
> > +
> > +	ret = regmap_read(st->regmap, AD7768_REG_DIGITAL_FILTER, &mode);
> > +	if (ret)
> > +		return ret;
> > +
> > +	mode = FIELD_GET(AD7768_DIG_FIL_FIL_MSK, mode);
> > +	/* Filter types from 0 to 2 are represented as SINC5 */
> > +	if (mode < SINC3)
> > +		return SINC5;
> > +
> > +	/*
> > +	 * Remove the offset for the sinc3 and wideband filters
> > +	 * to get the corresponding attribute enum value
> > +	 */
> > +	return mode - 2;
> >  }
> >  
> >  static int ad7768_gpio_direction_input(struct gpio_chip *chip, unsigned int offset)
> > @@ -490,43 +702,37 @@ static int ad7768_gpio_init(struct iio_dev *indio_dev)
> >  static int ad7768_set_freq(struct ad7768_state *st,
> >  			   unsigned int freq)
> >  {
> > -	unsigned int diff_new, diff_old, pwr_mode, i, idx;
> > +	unsigned int diff_new, diff_old, i, idx;
> >  	int res, ret;
> >  
> > +	freq = clamp_t(unsigned int, freq, 50, 1024000);
> >  	diff_old = U32_MAX;
> >  	idx = 0;
> >  
> > -	res = DIV_ROUND_CLOSEST(st->mclk_freq, freq);
> > +	if (freq == 0)
> > +		return -EINVAL;
> > +
> > +	res = DIV_ROUND_CLOSEST(st->mclk_freq, freq * st->oversampling_ratio);
> >  
> >  	/* Find the closest match for the desired sampling frequency */
> > -	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++) {
> > -		diff_new = abs(res - ad7768_clk_config[i].clk_div);
> > +	for (i = 0; i < ARRAY_SIZE(ad7768_mclk_div_rates); i++) {
> > +		diff_new = abs(res - ad7768_mclk_div_rates[i]);
> >  		if (diff_new < diff_old) {
> >  			diff_old = diff_new;
> >  			idx = i;
> >  		}
> >  	}
> >  
> > -	/*
> > -	 * Set both the mclk_div and pwrmode with a single write to the
> > -	 * POWER_CLOCK register
> > -	 */
> > -	pwr_mode = AD7768_PWR_MCLK_DIV(ad7768_clk_config[idx].mclk_div) |
> > -		   AD7768_PWR_PWRMODE(ad7768_clk_config[idx].pwrmode);
> > -	ret = regmap_write(st->regmap, AD7768_REG_POWER_CLOCK, pwr_mode);
> > -	if (ret < 0)
> > -		return ret;
> > -
> > -	ret =  ad7768_set_dig_fil(st, ad7768_clk_config[idx].dec_rate);
> > -	if (ret < 0)
> > +	/* Set both the mclk_div and pwrmode */
> > +	ret = ad7768_set_mclk_div(st, idx);
> > +	if (ret)
> >  		return ret;
> >  
> > -	st->dec_rate = ad7768_clk_config[idx].clk_div /
> > -		       ad7768_mclk_div_rates[ad7768_clk_config[idx].mclk_div];
> >  	st->samp_freq = DIV_ROUND_CLOSEST(st->mclk_freq,
> > -					  ad7768_clk_config[idx].clk_div);
> > +					  ad7768_mclk_div_rates[idx] * st->oversampling_ratio);
> >  
> > -	return 0;
> > +	/* A sync-in pulse is required every time the filter dec rate changes */
> 
> Does this function actually change oversampling_ration/decimation rate? Or do
> we also need to sync after changing other filter parameters?
> 

This function would only change the power mode and mclk divider, so i
will fix the comment and add the sync to the other configuration
changes. 

> > +	return ad7768_send_sync_pulse(st);
> >  }
> >  
> >  static int ad7768_set_vcm_output(struct ad7768_state *st, unsigned int mode)
> > @@ -540,13 +746,16 @@ static ssize_t ad7768_sampling_freq_avail(struct device *dev,
> >  {
> >  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> >  	struct ad7768_state *st = iio_priv(indio_dev);
> > -	unsigned int freq;
> > +	unsigned int freq, freq_filtered;
> >  	int i, len = 0;
> >  
> > -	for (i = 0; i < ARRAY_SIZE(ad7768_clk_config); i++) {
> > -		freq = DIV_ROUND_CLOSEST(st->mclk_freq,
> > -					 ad7768_clk_config[i].clk_div);
> > -		len += scnprintf(buf + len, PAGE_SIZE - len, "%d ", freq);
> > +	freq_filtered = DIV_ROUND_CLOSEST(st->mclk_freq, st->oversampling_ratio);
> > +	for (i = 0; i < ARRAY_SIZE(ad7768_mclk_div_rates); i++) {
> > +		freq = DIV_ROUND_CLOSEST(freq_filtered,
> > +					 ad7768_mclk_div_rates[i]);
> > +		/* Sampling frequency cannot be lower than the minimum of 50 SPS */
> > +		if (freq >= 50)
> > +			len += sysfs_emit_at(buf, len, "%d ", freq);
> >  	}
> >  
> >  	buf[len - 1] = '\n';
> > @@ -556,6 +765,37 @@ static ssize_t ad7768_sampling_freq_avail(struct device *dev,
> >  
> >  static IIO_DEV_ATTR_SAMP_FREQ_AVAIL(ad7768_sampling_freq_avail);
> >  
> > +static ssize_t oversampling_ratio_available_show(struct device *dev,
> > +						 struct device_attribute *attr,
> > +						 char *buf)
> > +{
> > +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> > +	struct ad7768_state *st = iio_priv(indio_dev);
> > +	int len = 0;
> > +
> > +	/* Return oversampling ratio available in range format */
> > +	buf[len++] = '[';
> > +	if (st->filter_type == SINC3) {
> > +		len += sysfs_emit_at(buf, len, "%d ", SINC3_DEC_RATE_MIN);
> > +		len += sysfs_emit_at(buf, len, "%d ", SINC3_DEC_RATE_MIN);
> > +		len += sysfs_emit_at(buf, len, "%d ", SINC3_DEC_RATE_MAX);
> > +	} else if (st->filter_type == WIDEBAND) {
> > +		len += sysfs_emit_at(buf, len, "%d ", WIDEBAND_DEC_RATE_MIN);
> > +		len += sysfs_emit_at(buf, len, "%d ", WIDEBAND_DEC_RATE_MIN);
> > +		len += sysfs_emit_at(buf, len, "%d ", WIDEBAND_DEC_RATE_MAX);
> > +	} else {
> > +		len += sysfs_emit_at(buf, len, "%d ", SINC5_DEC_RATE_MIN);
> > +		len += sysfs_emit_at(buf, len, "%d ", SINC5_DEC_RATE_MIN);
> > +		len += sysfs_emit_at(buf, len, "%d ", SINC5_DEC_RATE_MAX);	}
> > +
> > +	buf[len - 1] = ']';
> > +	buf[len++] = '\n';
> > +
> > +	return len;
> > +}
> > +
> > +static IIO_DEVICE_ATTR_RO(oversampling_ratio_available, 0);
> > +
> >  static int ad7768_read_raw(struct iio_dev *indio_dev,
> >  			   struct iio_chan_spec const *chan,
> >  			   int *val, int *val2, long info)
> > @@ -597,6 +837,11 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> >  		*val = st->samp_freq;
> >  
> > +		return IIO_VAL_INT;
> > +
> > +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> > +		*val = st->oversampling_ratio;
> > +
> >  		return IIO_VAL_INT;
> >  	}
> >  
> > @@ -608,10 +853,19 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
> >  			    int val, int val2, long info)
> >  {
> >  	struct ad7768_state *st = iio_priv(indio_dev);
> > +	int ret;
> >  
> >  	switch (info) {
> >  	case IIO_CHAN_INFO_SAMP_FREQ:
> >  		return ad7768_set_freq(st, val);
> > +
> > +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> 
> Probably should have iio_device_claim_direct_mode() here since this is poking
> registers.
> 
> case IIO_CHAN_INFO_SAMP_FREQ: needs it too, so I would suggest to rename this
> function to __ad7768_write_raw() and then write:
> 
> static int ad7768_write_raw(struct iio_dev *indio_dev,
>   			    int val, int val2, long info)
> {
> 	int ret;
> 
> 	ret = iio_device_claim_direct_mode(indio_dev);
> 	if (ret)
> 		return ret;
> 
> 	ret = __ad7768_write_raw(indio_dev, val, val2, info);
> 	iio_device_release_direct_mode(indio_dev);
> 
> 	return ret;
> }
> 
> This is the preferred style to avoid extra indent and error unwinding complexity.
> 

Thanks for the suggestion!

> > +		ret = ad7768_configure_dig_fil(indio_dev, st->filter_type, val);
> > +		if (ret)
> > +			return ret;
> > +
> > +		/* Update sampling frequency */
> > +		return ad7768_set_freq(st, st->samp_freq);
> >  	default:
> >  		return -EINVAL;
> >  	}
> > @@ -627,6 +881,7 @@ static int ad7768_read_label(struct iio_dev *indio_dev,
> >  
> >  static struct attribute *ad7768_attributes[] = {
> >  	&iio_dev_attr_sampling_frequency_available.dev_attr.attr,
> > +	&iio_dev_attr_oversampling_ratio_available.dev_attr.attr,
> >  	NULL
> >  };
> 
> Opportunity for another preliminary cleanup patch. IIO has core support for
> *_available attributes now, so we can implement struct iio_info.read_avail
> callback instead of manually creating attribute. Existing
> sampling_frequency_available attribute can be converted to use this, then
> use it for oversampling_ratio_available as well.
> 

Sure, will do!

> >  
> > @@ -639,7 +894,7 @@ static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
> >  {
> >  	struct ad7768_state *st = iio_priv(indio_dev);
> >  
> > -	return st->dec_rate == 8 ? AD7768_SCAN_TYPE_HIGH_SPEED :
> > +	return st->oversampling_ratio == 8 ? AD7768_SCAN_TYPE_HIGH_SPEED :
> >  		AD7768_SCAN_TYPE_NORMAL;
> >  }
> >  
> > @@ -745,6 +1000,12 @@ static int ad7768_setup(struct iio_dev *indio_dev)
> >  			return ret;
> >  	}
> >  
> > +	/*
> > +	 * Set Default Digital Filter configuration:
> > +	 * SINC5 filter with x32 Decimation rate
> > +	 */
> > +	ret = ad7768_configure_dig_fil(indio_dev, SINC5, 32);
> > +
> >  	/* Set the default sampling frequency to 32000 kSPS */
> >  	return ad7768_set_freq(st, 32000);
> >  }
> 

