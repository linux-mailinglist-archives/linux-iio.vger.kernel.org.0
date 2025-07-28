Return-Path: <linux-iio+bounces-22110-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31360B13DF6
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 17:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85DEE3B1753
	for <lists+linux-iio@lfdr.de>; Mon, 28 Jul 2025 15:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F52A270548;
	Mon, 28 Jul 2025 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7azJp4O"
X-Original-To: linux-iio@vger.kernel.org
Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1617126FDB6;
	Mon, 28 Jul 2025 15:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753715480; cv=none; b=Wx70ekrurq5Md1VB5sFmADnAoYvLzE/QVZRPeklXeoFUCmojwsb6dOV5RiNrnJC3BMRWwZTl8cW94PuwqjvDehpwBklFtSpcLHeb6EGrVtyWFrSA3EUZrverg7ne+7DVjtfN9l4R4wgnIyZ3hIzOlTJammOWfnIio8YVE/njddI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753715480; c=relaxed/simple;
	bh=zm5sdjWwncistV0GSdXwbbW5in+4ManQo1eSDpiEaW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cSMO4q9jnS90YpW6OBxe0qPacyZJhPsJ1vK1w0m8LSqaKMLlYp5E9UK/PVcif+OeH5ogOxTruzWnbctvd203aJ/3AjL0uJvRsnfXdPvukEbCDpBy+LD2C1/d1/1QljavkXN+8L6mZBG+4kV4UdRvtFGyrxQ9Rb+lOS2l4msOvbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7azJp4O; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-4e8135adfccso1447291137.1;
        Mon, 28 Jul 2025 08:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753715477; x=1754320277; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tH7ZZVnJEgCpl86bvJHk2RXOFtUWZuabqU+n8qdMLmA=;
        b=O7azJp4OdpkDlO/MnSBEvFk97dK+s5AuA0/Z+mvq0I/6Te7nrmLponQLMKGLMno8TF
         lU0JyNYRlWG+sR+JD4XjaBkfCo7Eqaw3ERclNMk5y/KmJWyYXHWzLrvzJv0Wv3OribMr
         DWFrI3+i4v3/YLJWI11M6s0vpTAB6n+Gw5qVVfx6X3tptDsP8qnwv/bzYlBdFV9gF2Gr
         eD/5m2dzSR+jlj8QTxyQt5b+ojFMU5SM8gMSk8NnpAKMNppen5akg4iBFxCchP5gpzK/
         jJTZ3ihmkh/R8OVdz4VPrztF/R/yhdivBIeoRIgzdruS2+rUBo40tHqzNkNdOe6fm5qM
         B4eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753715477; x=1754320277;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tH7ZZVnJEgCpl86bvJHk2RXOFtUWZuabqU+n8qdMLmA=;
        b=TXPZeCyR3GJpyVeaSwkCdnIjjUEinhjvn4jjoiuO39eLeNz8LuTyL3I/jFDmOdiVjv
         KnOJUR3Ux1G7vCjcBdU6A4TCUfygKC/FOMpJ4/yFBbGRkGCU8ZPUqwUhsnYhStMDQU1C
         /ykm4x4RM2nyrQa3WExeXFL28LwBh4RTlIjqDf6HdSXe7/nFnnuVECtz3/Km7L4Nux1d
         Jv0i1HOxwFVNzH2vYBqC02pwKPBLxOjxDvjzmqWOhYY7CND7Q3+9sMypRcjXOPssZ70M
         H8xVnaf/jNJc2OWon9ymuBxroDoZYpTGbeillY/UmAIdi/1iVSgL5AOx4lm8Tal+g1L7
         pOJQ==
X-Forwarded-Encrypted: i=1; AJvYcCViajMtQgdKHDKmqjSzmwEV/Gl0p8dM+Alwj1RcAeETXynhYmesAXdN++eQ7nAhQq7ClFPl+x8eDAnK@vger.kernel.org, AJvYcCXbYGGMnWWixD23vXK/uwFxzR6W+AfXZcB5Vi88CbXIexb6XpZEDdhqNqDPXxJzzu26a6F5pzARDzeSpjHZ@vger.kernel.org, AJvYcCXogJgfLiLznkIAstThXnNiVmfwyeI0KADK6dkz5ZOQD6trOXeMGx4TjFSb+SjAcC0p2tCNhfOxzRS3@vger.kernel.org
X-Gm-Message-State: AOJu0YyoQIUqpnGYCK6FWexxIuAtzlYDKljknef0DYPPKmDes6ozT8h6
	d+yjVCB3vfrT8mkafqxcpTNDVC+93CbeOSsiXMNzIHBNH/hMFGdzgOaD
X-Gm-Gg: ASbGncvlDPQLlwYL8XrnZarDIayI0PLDq9RRcsq6SBPR9nPED7UAS4w9BW/eyNAQ0h+
	RFMvxMgR+ibIcBrwbEjO66Uan7IeO1+PhweT/r5LQ0892IUxDu1MEktXyf0qDtPy1xs5U8ebn6m
	zesxPyjqIEWDm2Nyekhy5Y2fcmW7shBP9ECMJL5Uz/1lX1iVbeba8osRmYq4l0Hg6DaVYO+epLt
	XkBT+4l16I2NQp2/iIjzpJonl+bmB55uZawuar8GJawhnkMaHjyQfctUviQ6T9KOQfL/kY/fvov
	p9Ltsb84NxnI08HqkMG/LN3/KFUCjNLA6lYNUeg+Jsv2Cb3llB3GIi57BncQ7gYRdEAAf7PdUcC
	01HRIGIap3+Ub
X-Google-Smtp-Source: AGHT+IEktxSaOubwonI1LDHN4dky8p+eSpxFJaJ2x9Pjpl/WoHpCkNhg4nmMGVmyJ1FxhrYcjItIMg==
X-Received: by 2002:a67:e7c9:0:b0:4ec:c548:e10e with SMTP id ada2fe7eead31-4fa3fa53ca2mr5355743137.3.1753715476640;
        Mon, 28 Jul 2025 08:11:16 -0700 (PDT)
Received: from nsa ([45.144.113.55])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4fa46d0745fsm1165742137.5.2025.07.28.08.11.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 08:11:16 -0700 (PDT)
Date: Mon, 28 Jul 2025 16:11:28 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: Ioana Risteiu <Ioana.Risteiu@analog.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Ramona Nechita <ramona.nechita@analog.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/4] iio: adc: Update ad7779 to use IIO backend
Message-ID: <uwente5i2eztozco5qeaglgvtuamewytxijaqjzaaxlbvdsoyj@fuko4wpwbztl>
References: <20250728134340.3644-1-Ioana.Risteiu@analog.com>
 <20250728134340.3644-5-Ioana.Risteiu@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250728134340.3644-5-Ioana.Risteiu@analog.com>

On Mon, Jul 28, 2025 at 04:43:36PM +0300, Ioana Risteiu wrote:
> Add a new functionality to ad7779 driver that streams data through data
> output interface using IIO backend interface.
> 
> Signed-off-by: Ioana Risteiu <Ioana.Risteiu@analog.com>
> ---
>  drivers/iio/adc/ad7779.c | 299 +++++++++++++++++++++++++++++++++------
>  1 file changed, 256 insertions(+), 43 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7779.c b/drivers/iio/adc/ad7779.c
> index 845adc510239..872c551eadf6 100644
> --- a/drivers/iio/adc/ad7779.c
> +++ b/drivers/iio/adc/ad7779.c
> @@ -31,6 +31,8 @@
>  #include <linux/iio/triggered_buffer.h>
>  #include <linux/iio/trigger_consumer.h>
>  
> +#include <linux/iio/backend.h>
> +
>  #define AD7779_SPI_READ_CMD			BIT(7)
>  
>  #define AD7779_DISABLE_SD			BIT(7)
> @@ -116,6 +118,12 @@
>  #define AD7779_CRC8_POLY			0x07
>  DECLARE_CRC8_TABLE(ad7779_crc8_table);
>

...

>  
> +static const struct iio_chan_spec_ext_info ad7779_ext_info_filter[] = {
> +	IIO_ENUM("data_lines", IIO_SHARED_BY_ALL, &ad7779_data_lines_enum),
> +	IIO_ENUM_AVAILABLE("data_lines", IIO_SHARED_BY_ALL,
> +			   &ad7779_data_lines_enum),
> +	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad7779_filter_enum),
> +	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL,
> +			   &ad7779_filter_enum),
> +	{ }
> +};
> +

I guess this can get simpler... Do we really want to control data_lanes
at runtime? From my experience that's a DT parameter and it's not
something you can change at runtime. Often is a synthesis parameter on
the IP core (backend side).


>  #define AD777x_CHAN_S(index, _ext_info)					\
>  	{								\
>  		.type = IIO_VOLTAGE,					\
> @@ -669,11 +788,34 @@ static const struct iio_chan_spec_ext_info ad7779_ext_filter[] = {
>  		},							\
>  	}
>  
> +#define AD777X_CHAN(index, _ext_info)					       \
> +	{								       \
> +		.type = IIO_VOLTAGE,					       \
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),       \
> +		.address = (index),					       \
> +		.indexed = 1,						       \
> +		.channel = (index),					       \
> +		.scan_index = (index),					       \
> +		.ext_info = (_ext_info),				       \
> +		.scan_type = {						       \
> +			.sign = 's',					       \
> +			.realbits = 24,					       \
> +			.storagebits = 32,				       \
> +		},							       \
> +	}
> +
>  #define AD777x_CHAN_NO_FILTER_S(index)					\
>  	AD777x_CHAN_S(index, NULL)
>  
> +#define AD777X_CHAN_NO_FILTER(index)					       \
> +	AD777X_CHAN(index, ad7779_ext_info)
> +
>  #define AD777x_CHAN_FILTER_S(index)					\
>  	AD777x_CHAN_S(index, ad7779_ext_filter)
> +
> +#define AD777X_CHAN_FILTER(index)					       \
> +	AD777X_CHAN(index, ad7779_ext_info_filter)
> +
>  static const struct iio_chan_spec ad7779_channels[] = {
>  	AD777x_CHAN_NO_FILTER_S(0),
>  	AD777x_CHAN_NO_FILTER_S(1),
> @@ -686,6 +828,17 @@ static const struct iio_chan_spec ad7779_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(8),
>  };
>  
> +static const struct iio_chan_spec ad7779_channels_data[] = {
> +	AD777X_CHAN_NO_FILTER(0),
> +	AD777X_CHAN_NO_FILTER(1),
> +	AD777X_CHAN_NO_FILTER(2),
> +	AD777X_CHAN_NO_FILTER(3),
> +	AD777X_CHAN_NO_FILTER(4),
> +	AD777X_CHAN_NO_FILTER(5),
> +	AD777X_CHAN_NO_FILTER(6),
> +	AD777X_CHAN_NO_FILTER(7),
> +};
> +
>  static const struct iio_chan_spec ad7779_channels_filter[] = {
>  	AD777x_CHAN_FILTER_S(0),
>  	AD777x_CHAN_FILTER_S(1),
> @@ -698,6 +851,17 @@ static const struct iio_chan_spec ad7779_channels_filter[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(8),
>  };
>  
> +static const struct iio_chan_spec ad7779_channels_filter_data[] = {
> +	AD777X_CHAN_FILTER(0),
> +	AD777X_CHAN_FILTER(1),
> +	AD777X_CHAN_FILTER(2),
> +	AD777X_CHAN_FILTER(3),
> +	AD777X_CHAN_FILTER(4),
> +	AD777X_CHAN_FILTER(5),
> +	AD777X_CHAN_FILTER(6),
> +	AD777X_CHAN_FILTER(7),
> +};
> +
>  static const struct iio_buffer_setup_ops ad7779_buffer_setup_ops = {
>  	.preenable = ad7779_buffer_preenable,
>  	.postdisable = ad7779_buffer_postdisable,
> @@ -752,6 +916,91 @@ static int ad7779_conf(struct ad7779_state *st, struct gpio_desc *start_gpio)
>  	return 0;
>  }
>  
> +static int ad7779_register_irq(struct ad7779_state *st, struct iio_dev *indio_dev)
> +{
> +	int ret;
> +	struct device *dev = &st->spi->dev;
> +
> +	indio_dev->info = &ad7779_info;
> +	indio_dev->channels = st->chip_info->channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
> +

We might be able to get the above in a generic way... See below.

> +	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> +					  iio_device_id(indio_dev));
> +	if (!st->trig)
> +		return -ENOMEM;
> +
> +	st->trig->ops = &ad7779_trigger_ops;
> +
> +	iio_trigger_set_drvdata(st->trig, st);
> +
> +	ret = devm_request_irq(dev, st->spi->irq, iio_trigger_generic_data_rdy_poll,
> +			       IRQF_ONESHOT | IRQF_NO_AUTOEN, indio_dev->name,
> +			       st->trig);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "request IRQ %d failed\n",
> +					st->spi->irq);
> +
> +	ret = devm_iio_trigger_register(dev, st->trig);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->trig = iio_trigger_get(st->trig);
> +
> +	init_completion(&st->completion);
> +
> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &ad7779_trigger_handler,
> +					      &ad7779_buffer_setup_ops);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
> +				    AD7779_DCLK_CLK_DIV_MSK,
> +				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static int ad7779_register_back(struct ad7779_state *st, struct iio_dev *indio_dev)
> +{
> +	struct device *dev = &st->spi->dev;
> +	int ret = -EINVAL;
> +
> +	indio_dev->info = &ad7779_info_data;
> +
> +	if (strcmp(st->chip_info->name, "ad7771") == 0) {
> +		indio_dev->channels = ad7779_channels_filter_data;
> +		indio_dev->num_channels = ARRAY_SIZE(ad7779_channels_filter_data);
> +	} else {
> +		indio_dev->channels = ad7779_channels_data;
> +		indio_dev->num_channels = ARRAY_SIZE(ad7779_channels_data);
> +	}

I wonder if it makes sense to add a new compatible since our userspace
interface will be considerable different (similar to what was done in
[1]? This would make things easier to handle for the above. If not, I
would likely introduce a "has_filter" boolean in chip info for the
above.

> +
> +	st->back = devm_iio_backend_get(dev, NULL);
> +	if (IS_ERR(st->back)) {
> +		dev_err_probe(dev, ret, "failed to get iio backend");
> +		return PTR_ERR(st->back);
> +	}
> +
> +	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_backend_enable(dev, st->back);
> +	if (ret)
> +		return ret;
> +
> +	ret = iio_backend_num_lanes_set(st->back, 4);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);

The above is repeated in ad7779_register_irq(). You can take it out and
do it in ad7779_probe().

> +}
> +
>  static int ad7779_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -760,8 +1009,8 @@ static int ad7779_probe(struct spi_device *spi)
>  	struct device *dev = &spi->dev;
>  	int ret = -EINVAL;
>  
> -	if (!spi->irq)
> -		return dev_err_probe(dev, ret, "DRDY irq not present\n");

The above could be a cleanup patch. I mean just drop the check and let
devm_request_irq() in case an interrupt is not present.

> +	if (!spi->irq && !device_property_present(dev, "io-backends"))
> +		return dev_err_probe(dev, ret, "Either DRDY interrupt or io-backends property required\n");

Then, we could just use device_property_present() to decide which
probing path to follow.

>  
>  	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
>  	if (!indio_dev)
> @@ -804,49 +1053,12 @@ static int ad7779_probe(struct spi_device *spi)
>  		return ret;
>  
>  	indio_dev->name = st->chip_info->name;
> -	indio_dev->info = &ad7779_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = st->chip_info->channels;
> -	indio_dev->num_channels = ARRAY_SIZE(ad7779_channels);
> -
> -	st->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", indio_dev->name,
> -					  iio_device_id(indio_dev));
> -	if (!st->trig)
> -		return -ENOMEM;
> -
> -	st->trig->ops = &ad7779_trigger_ops;
> -
> -	iio_trigger_set_drvdata(st->trig, st);
> -
> -	ret = devm_request_irq(dev, spi->irq, iio_trigger_generic_data_rdy_poll,
> -			       IRQF_ONESHOT | IRQF_NO_AUTOEN, indio_dev->name,
> -			       st->trig);
> -	if (ret)
> -		return dev_err_probe(dev, ret, "request IRQ %d failed\n",
> -				     st->spi->irq);
> -
> -	ret = devm_iio_trigger_register(dev, st->trig);
> -	if (ret)
> -		return ret;
> -
> -	indio_dev->trig = iio_trigger_get(st->trig);
> -
> -	init_completion(&st->completion);
> -
> -	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> -					      &iio_pollfunc_store_time,
> -					      &ad7779_trigger_handler,
> -					      &ad7779_buffer_setup_ops);
> -	if (ret)
> -		return ret;
>  
> -	ret = ad7779_spi_write_mask(st, AD7779_REG_DOUT_FORMAT,
> -				    AD7779_DCLK_CLK_DIV_MSK,
> -				    FIELD_PREP(AD7779_DCLK_CLK_DIV_MSK, 7));
> -	if (ret)
> -		return ret;
device_property_present> -
> -	return devm_iio_device_register(dev, indio_dev);

Arguably, ad7779_register_irq() could be introduced in a precursor
patch.

> +	if (spi->irq)
> +		return ad7779_register_irq(st, indio_dev);
> +	else
> +		return ad7779_register_back(st, indio_dev);

Redundante else...

- Nuno Sá

