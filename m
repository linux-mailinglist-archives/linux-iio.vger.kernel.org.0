Return-Path: <linux-iio+bounces-16520-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAECCA568B4
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 14:19:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C77263A8312
	for <lists+linux-iio@lfdr.de>; Fri,  7 Mar 2025 13:19:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912F6218E82;
	Fri,  7 Mar 2025 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lJ4DltpQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B631A2398;
	Fri,  7 Mar 2025 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353555; cv=none; b=i5UyeMdKTP9O13evZEJ7IENlP3ENfdmi7Ttdrb6Da+KH7Op/zROrI2wzwCN6Kn4zJhpdaJZCyYyiG+22q53hX4c9y1yuALSOzw+71PwxQFazusMr+S6n7ktKTtGcS34BUx6idqwXKNsQ5tQMpdzlPbYrW3GmpkMlouCyVuy0gQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353555; c=relaxed/simple;
	bh=0DSn/PTRSgM3reu4DhbsF4DDbxPv1sZrQ+klQptiyhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfolXa9OQOgDHUc0NWumLN3i4D98H1Acjp+FUx3grzZS/H6SLV1X9DqDDgY/2eN2+WFn+hRDnSG4UapVn3WDmPljE+cIZAYDQkwwEvXjOeSTITXbpdI3buIX6VQSujEWS+KnThjgG0df4d4Ean1zs9VwvyKxdXfLXDo5gLjX0d0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lJ4DltpQ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2239f8646f6so33908395ad.2;
        Fri, 07 Mar 2025 05:19:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741353553; x=1741958353; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eImNnLSVIdIQFpmVL7ZVYdDntXt9XT8RVIowRhm/nWA=;
        b=lJ4DltpQv2AZliEiAdTL/AM7ONpY5YH2JOzQUEPDt9QNFS9XHjYjvk2SDeQye8fs64
         EsKV0nTyJIelj/BRcV87zrGVllegJYzYKtATaWKGdopXhxEZkmD23yWO5gLGSBILIHDD
         Q3d3rnVFQaFjQSCFbB4f20kt70+txWkOtKCTYiRERmp41u1JaTLHdUMrJpw+hSO7h7xF
         wMv+nV8h8s151cWaZCnKiwufjWDriGTEnLeRgGw5RJ4k6I+CqKXCusU1z2MLiY4Op5Db
         LYiTZxi2buwA9C7ah1UVX9gzbkjurpN2ds2WsISmbnR8ifK7d5JpFcHKfGBrK0XFkh4+
         lOtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741353553; x=1741958353;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eImNnLSVIdIQFpmVL7ZVYdDntXt9XT8RVIowRhm/nWA=;
        b=BHQPOEHG+54nHhz0PlTWQfW3mbtm1YwlKB9U094M56/6CHUj2l55wC90tQ25MgXFJV
         Tfhs67GmUAzgWrv4FzsCFH525bWif7O8mTfXBp26u54njdoeOQerQGhB/a//fDZzr+qo
         KPicLZhFj8L+OaUt3yY9iOdSmB+yzFJO616FvUEeIf3ofJeOWeOv1JMXO2O3DcYug4fz
         MJ6zklcGcDDEInu7OfWNtxBgSxT6PgxsSvCY0wEp7x80hvroO0hjVIaRsxcEb+j3J7ZI
         ffMnsnQ0UaqbpFJwxmS52nWEYqGfc9cfvkJz8TypEz7qsEM1Dyhgz7cEoUfA2nQfZ1LX
         lmMw==
X-Forwarded-Encrypted: i=1; AJvYcCVOkgCBYfBzYXABvp5IjO/DNeSUv0aEl5dPm9ydqmK3/28u1+aMF0VSv0Bhq6AKMELQv3ERfpJfRyDwMKpL@vger.kernel.org, AJvYcCVroVugL6SeSu9ec9tL27mfn8vzK/fy9sua3qSEmwJU1EBOQEKRAP4eblL4pdxS0ekfihsuXbP0DBoO@vger.kernel.org, AJvYcCVtcS1FwZlrFYpKHb9TsSqy7z2g2rSxf2x2sIeifwVCelq7NmbBQbIsUq/rilYxdm3DGtiH5DdsfxrfPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/d90sOG/SaEy5mRvmh+Yrl8V6orxLlzRhdy06pFljUjuirOQY
	mk/ohmMkhSOw+vtAPJ2y94FuktjVmZggjue56JQZsgEVGtzBmYu6
X-Gm-Gg: ASbGncu7riDvL/3JHpQhgVpAN+1wpO6UBCsXWHgAF3QKd4/SoZ/KwsSqsGBRHdK6Sto
	7xe86B8s1o0TZ8F5FA/XUpnZn6G8hfvPt7l2gL+6Q5kwTNh16W0WLj6i4jXVma3Yl5qbqF9dkY6
	ovIPNoT7RHdeWz2xEEtG64GcelNpu3Xqg0CKqGL+tjMD5LGdXfVRw/gyWqFXvqmN9O9VnhXJWaw
	jexk4Ruyig6NXzM1zrPH2+AJCtfhwxoWYsku/WL8Cxh8fjf2C0cDt4kNv0H91JHOS3XvYK6b9DD
	/I1wTAY71c8xfMZk/X6WsLgyuuMYkFuXe0BvjDbE0c1ONlOT3W+//Q==
X-Google-Smtp-Source: AGHT+IExqyi822ISn1fcSp/X6enD9IsnsJ0FvV3qlXmYFJJi/+pzoceA+KfV9d1W1JhyORit4JBYHg==
X-Received: by 2002:a05:6a20:1591:b0:1f3:484e:c55c with SMTP id adf61e73a8af0-1f544c99ea7mr6074059637.35.1741353552772;
        Fri, 07 Mar 2025 05:19:12 -0800 (PST)
Received: from localhost ([2804:30c:1f21:4300:1cf6:c485:6555:b1c5])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-736ade82020sm1346646b3a.17.2025.03.07.05.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 05:19:12 -0800 (PST)
Date: Fri, 7 Mar 2025 10:20:04 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl, lgirdwood@gmail.com, broonie@kernel.org,
	dlechner@baylibre.com, jonath4nns@gmail.com
Subject: Re: [PATCH v4 08/17] iio: adc: ad7768-1: convert driver to use regmap
Message-ID: <Z8ryhMV1lYZeZVCB@debian-BULLSEYE-live-builder-AMD64>
References: <cover.1741268122.git.Jonathan.Santos@analog.com>
 <b0c7976d4bc817b7056ef40e3ce870b42e8a2d80.1741268122.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0c7976d4bc817b7056ef40e3ce870b42e8a2d80.1741268122.git.Jonathan.Santos@analog.com>

On 03/06, Jonathan Santos wrote:
> Convert the AD7768-1 driver to use the regmap API for register
> access. This change simplifies and standardizes register interactions,
> reducing code duplication and improving maintainability.
> 
> Create two regmap configurations, one for 8-bit register values and
> other for 24-bit register values.
> 
> Since we are using regmap now, define the remaining registers from 0x32
> to 0x34.
> 
> Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
> ---
> v4 Changes:
> * Add `REGMAP24` to the register macros with 24-bit value.
> * Add `select REGMAP_SPI` line to the Kconfig.
> 
> v3 Changes:
> * Included a second register map for the 24-bit register values.
> * Added register tables to separate the 24-bit from the 8-bit values.
> 
> v2 Changes:
> * New patch in v2.
> ---
>  drivers/iio/adc/Kconfig    |   1 +
>  drivers/iio/adc/ad7768-1.c | 151 +++++++++++++++++++++++++------------
>  2 files changed, 104 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 849c90203071..a2fdb7e03a66 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -277,6 +277,7 @@ config AD7766
>  config AD7768_1
>  	tristate "Analog Devices AD7768-1 ADC driver"
>  	depends on SPI
> +	select REGMAP_SPI
>  	select IIO_BUFFER
>  	select IIO_TRIGGER
>  	select IIO_TRIGGERED_BUFFER
> diff --git a/drivers/iio/adc/ad7768-1.c b/drivers/iio/adc/ad7768-1.c
> index f5509a0a36ab..04a26e5b7d5c 100644
> --- a/drivers/iio/adc/ad7768-1.c
> +++ b/drivers/iio/adc/ad7768-1.c
> @@ -12,6 +12,7 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/sysfs.h>
>  #include <linux/spi/spi.h>
> @@ -53,12 +54,15 @@
>  #define AD7768_REG_SPI_DIAG_ENABLE	0x28
>  #define AD7768_REG_ADC_DIAG_ENABLE	0x29
>  #define AD7768_REG_DIG_DIAG_ENABLE	0x2A
> -#define AD7768_REG_ADC_DATA		0x2C
> +#define AD7768_REG24_ADC_DATA		0x2C
>  #define AD7768_REG_MASTER_STATUS	0x2D
>  #define AD7768_REG_SPI_DIAG_STATUS	0x2E
>  #define AD7768_REG_ADC_DIAG_STATUS	0x2F
>  #define AD7768_REG_DIG_DIAG_STATUS	0x30
>  #define AD7768_REG_MCLK_COUNTER		0x31
> +#define AD7768_REG_COEFF_CONTROL	0x32
> +#define AD7768_REG24_COEFF_DATA		0x33
> +#define AD7768_REG_ACCESS_KEY		0x34
>  
>  /* AD7768_REG_POWER_CLOCK */
>  #define AD7768_PWR_MCLK_DIV_MSK		GENMASK(5, 4)
> @@ -153,6 +157,8 @@ static const struct iio_chan_spec ad7768_channels[] = {
>  
>  struct ad7768_state {
>  	struct spi_device *spi;
> +	struct regmap *regmap;
> +	struct regmap *regmap24;
>  	struct regulator *vref;
>  	struct clk *mclk;
>  	unsigned int mclk_freq;
> @@ -175,46 +181,76 @@ struct ad7768_state {
>  	} data __aligned(IIO_DMA_MINALIGN);
>  };
>  
> -static int ad7768_spi_reg_read(struct ad7768_state *st, unsigned int addr,
> -			       unsigned int len)
> -{
> -	unsigned int shift;
> -	int ret;
> +static const struct regmap_range ad7768_regmap_rd_ranges[] = {
> +	regmap_reg_range(AD7768_REG_CHIP_TYPE, AD7768_REG_DIG_DIAG_ENABLE),
> +	regmap_reg_range(AD7768_REG_MASTER_STATUS, AD7768_REG_COEFF_CONTROL),
> +	regmap_reg_range(AD7768_REG_ACCESS_KEY, AD7768_REG_ACCESS_KEY),
> +};
>  
> -	shift = 32 - (8 * len);
> -	st->data.d8[0] = AD7768_RD_FLAG_MSK(addr);
> +static const struct regmap_access_table ad7768_regmap_rd_table = {
> +	.yes_ranges = ad7768_regmap_rd_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(ad7768_regmap_rd_ranges),
> +};
>  
> -	ret = spi_write_then_read(st->spi, st->data.d8, 1,
> -				  &st->data.d32, len);
> -	if (ret < 0)
> -		return ret;
> +static const struct regmap_range ad7768_regmap_wr_ranges[] = {
> +	regmap_reg_range(AD7768_REG_SCRATCH_PAD, AD7768_REG_SCRATCH_PAD),
> +	regmap_reg_range(AD7768_REG_INTERFACE_FORMAT, AD7768_REG_GPIO_WRITE),
> +	regmap_reg_range(AD7768_REG_OFFSET_HI, AD7768_REG_DIG_DIAG_ENABLE),
> +	regmap_reg_range(AD7768_REG_SPI_DIAG_STATUS, AD7768_REG_SPI_DIAG_STATUS),
> +	regmap_reg_range(AD7768_REG_COEFF_CONTROL, AD7768_REG_COEFF_CONTROL),
> +};
>  
> -	return (be32_to_cpu(st->data.d32) >> shift);
> -}
> +static const struct regmap_access_table ad7768_regmap_wr_table = {
> +	.yes_ranges = ad7768_regmap_wr_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(ad7768_regmap_wr_ranges),
> +};
>  
> -static int ad7768_spi_reg_write(struct ad7768_state *st,
> -				unsigned int addr,
> -				unsigned int val)
> -{
> -	st->data.d8[0] = AD7768_WR_FLAG_MSK(addr);
> -	st->data.d8[1] = val & 0xFF;
> +static const struct regmap_config ad7768_regmap_config = {
> +	.name = "ad7768-1-8",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.read_flag_mask = BIT(6),
> +	.rd_table = &ad7768_regmap_rd_table,
> +	.wr_table = &ad7768_regmap_wr_table,
> +	.max_register = AD7768_REG_ACCESS_KEY,
> +	.use_single_write = true,
> +	.use_single_read = true,
> +};
>  
> -	return spi_write(st->spi, st->data.d8, 2);
> -}
> +static const struct regmap_range ad7768_regmap24_rd_ranges[] = {
> +	regmap_reg_range(AD7768_REG24_ADC_DATA, AD7768_REG24_ADC_DATA),
> +	regmap_reg_range(AD7768_REG24_COEFF_DATA, AD7768_REG24_COEFF_DATA),

So, this device has only two registers that are 24-bit size?
Also, one of those is the ADC_DATA register which you will probably want
to read with optimized SPI messages in the future (devm_spi_optimize_message()).
That makes me wonder if the 24-bit regmap worth's the boiler plate to have it.
Does the driver access AD7768_REG24_COEFF_DATA after the patches from this
series is applied? If not, maybe drop the 24-bit regmap and implement ADC_DATA
with usual spi_message/spi_transfer interfaces?

> +};
>  
> -static int ad7768_set_mode(struct ad7768_state *st,
> -			   enum ad7768_conv_mode mode)
> -{
> -	int regval;
> +static const struct regmap_access_table ad7768_regmap24_rd_table = {
> +	.yes_ranges = ad7768_regmap24_rd_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(ad7768_regmap24_rd_ranges),
> +};
>  
> -	regval = ad7768_spi_reg_read(st, AD7768_REG_CONVERSION, 1);
> -	if (regval < 0)
> -		return regval;
> +static const struct regmap_range ad7768_regmap24_wr_ranges[] = {
> +	regmap_reg_range(AD7768_REG24_COEFF_DATA, AD7768_REG24_COEFF_DATA),
> +};
>  
> -	regval &= ~AD7768_CONV_MODE_MSK;
> -	regval |= AD7768_CONV_MODE(mode);
> +static const struct regmap_access_table ad7768_regmap24_wr_table = {
> +	.yes_ranges = ad7768_regmap24_wr_ranges,
> +	.n_yes_ranges = ARRAY_SIZE(ad7768_regmap24_wr_ranges),
> +};
> +
> +static const struct regmap_config ad7768_regmap24_config = {
> +	.name = "ad7768-1-24",
> +	.reg_bits = 8,
> +	.val_bits = 24,
> +	.read_flag_mask = BIT(6),
> +	.rd_table = &ad7768_regmap24_rd_table,
> +	.wr_table = &ad7768_regmap24_wr_table,
> +	.max_register = AD7768_REG24_COEFF_DATA,
> +};
>  
> -	return ad7768_spi_reg_write(st, AD7768_REG_CONVERSION, regval);
> +static int ad7768_set_mode(struct ad7768_state *st,
> +			   enum ad7768_conv_mode mode)
> +{
> +	return regmap_update_bits(st->regmap, AD7768_REG_CONVERSION,
> +				 AD7768_CONV_MODE_MSK, AD7768_CONV_MODE(mode));
>  }
>  
>  static int ad7768_scan_direct(struct iio_dev *indio_dev)
> @@ -233,9 +269,10 @@ static int ad7768_scan_direct(struct iio_dev *indio_dev)
>  	if (!ret)
>  		return -ETIMEDOUT;
>  
> -	readval = ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
> -	if (readval < 0)
> -		return readval;
> +	ret = regmap_read(st->regmap24, AD7768_REG24_ADC_DATA, &readval);
> +	if (ret)
> +		return ret;
> +
>  	/*
>  	 * Any SPI configuration of the AD7768-1 can only be
>  	 * performed in continuous conversion mode.
> @@ -259,16 +296,23 @@ static int ad7768_reg_access(struct iio_dev *indio_dev,
>  	if (ret)
>  		return ret;
>  
> +	ret = -EINVAL;
>  	if (readval) {
> -		ret = ad7768_spi_reg_read(st, reg, 1);
> -		if (ret < 0)
> -			goto err_release;
> -		*readval = ret;
> -		ret = 0;
> +		if (regmap_check_range_table(st->regmap, reg, &ad7768_regmap_rd_table))
> +			ret = regmap_read(st->regmap, reg, readval);
> +
> +		if (regmap_check_range_table(st->regmap24, reg, &ad7768_regmap24_rd_table))
> +			ret = regmap_read(st->regmap24, reg, readval);
> +
>  	} else {
> -		ret = ad7768_spi_reg_write(st, reg, writeval);
> +		if (regmap_check_range_table(st->regmap, reg, &ad7768_regmap_wr_table))
> +			ret = regmap_write(st->regmap, reg, writeval);
> +
> +		if (regmap_check_range_table(st->regmap24, reg, &ad7768_regmap24_wr_table))
> +			ret = regmap_write(st->regmap24, reg, writeval);
> +
>  	}
> -err_release:
> +
>  	iio_device_release_direct_mode(indio_dev);
>  
>  	return ret;
> @@ -285,7 +329,7 @@ static int ad7768_set_dig_fil(struct ad7768_state *st,
>  	else
>  		mode = AD7768_DIG_FIL_DEC_RATE(dec_rate);
>  
> -	ret = ad7768_spi_reg_write(st, AD7768_REG_DIGITAL_FILTER, mode);
> +	ret = regmap_write(st->regmap, AD7768_REG_DIGITAL_FILTER, mode);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -322,7 +366,7 @@ static int ad7768_set_freq(struct ad7768_state *st,
>  	 */
>  	pwr_mode = AD7768_PWR_MCLK_DIV(ad7768_clk_config[idx].mclk_div) |
>  		   AD7768_PWR_PWRMODE(ad7768_clk_config[idx].pwrmode);
> -	ret = ad7768_spi_reg_write(st, AD7768_REG_POWER_CLOCK, pwr_mode);
> +	ret = regmap_write(st->regmap, AD7768_REG_POWER_CLOCK, pwr_mode);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -449,11 +493,11 @@ static int ad7768_setup(struct ad7768_state *st)
>  	 * to 10. When the sequence is detected, the reset occurs.
>  	 * See the datasheet, page 70.
>  	 */
> -	ret = ad7768_spi_reg_write(st, AD7768_REG_SYNC_RESET, 0x3);
> +	ret = regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x3);
>  	if (ret)
>  		return ret;
>  
> -	ret = ad7768_spi_reg_write(st, AD7768_REG_SYNC_RESET, 0x2);
> +	ret = regmap_write(st->regmap, AD7768_REG_SYNC_RESET, 0x2);
>  	if (ret)
>  		return ret;
>  
> @@ -508,18 +552,19 @@ static int ad7768_buffer_postenable(struct iio_dev *indio_dev)
>  	 * continuous read mode. Subsequent data reads do not require an
>  	 * initial 8-bit write to query the ADC_DATA register.
>  	 */
> -	return ad7768_spi_reg_write(st, AD7768_REG_INTERFACE_FORMAT, 0x01);
> +	return regmap_write(st->regmap, AD7768_REG_INTERFACE_FORMAT, 0x01);
>  }
>  
>  static int ad7768_buffer_predisable(struct iio_dev *indio_dev)
>  {
>  	struct ad7768_state *st = iio_priv(indio_dev);
> +	unsigned int unused;
>  
>  	/*
>  	 * To exit continuous read mode, perform a single read of the ADC_DATA
>  	 * reg (0x2C), which allows further configuration of the device.
>  	 */
> -	return ad7768_spi_reg_read(st, AD7768_REG_ADC_DATA, 3);
> +	return regmap_read(st->regmap24, AD7768_REG24_ADC_DATA, &unused);
>  }
>  
>  static const struct iio_buffer_setup_ops ad7768_buffer_ops = {
> @@ -590,6 +635,16 @@ static int ad7768_probe(struct spi_device *spi)
>  
>  	st->spi = spi;
>  
> +	st->regmap = devm_regmap_init_spi(spi, &ad7768_regmap_config);
> +	if (IS_ERR(st->regmap))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap),
> +				     "Failed to initialize regmap");
> +
> +	st->regmap24 = devm_regmap_init_spi(spi, &ad7768_regmap24_config);
> +	if (IS_ERR(st->regmap24))
> +		return dev_err_probe(&spi->dev, PTR_ERR(st->regmap24),
> +				     "Failed to initialize regmap24");
> +
>  	st->vref = devm_regulator_get(&spi->dev, "vref");
>  	if (IS_ERR(st->vref))
>  		return PTR_ERR(st->vref);
> -- 
> 2.34.1
> 

