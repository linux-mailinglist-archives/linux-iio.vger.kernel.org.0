Return-Path: <linux-iio+bounces-9575-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43ECB9791F1
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 18:04:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9C87282126
	for <lists+linux-iio@lfdr.de>; Sat, 14 Sep 2024 16:04:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B2C1D0944;
	Sat, 14 Sep 2024 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TGmnWC1Z"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4161E4AD;
	Sat, 14 Sep 2024 16:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726329836; cv=none; b=rjOm+iOVzV+e9AYeGEw1vRjwAz053/+bW6CrlwQwvB3nVdfe3nfkmu5lNIXhk6WvSThi+FLVBM9qC5ZvAncZX3CaxUlwv52riMCsZgbXOTHc8vpO7dE+VG7LvqOBt0AAnQmqo+iwif9qGjT7w78hv8hZhDqcIBNEcXifvxnn17w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726329836; c=relaxed/simple;
	bh=Aa/Dt/9oSgkSjzIOJ/ghRzxN708Zll4gS9FIDuzDbJM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fkUVdP834TPWpnXHgOd2RABDQzndq45f8ZbEBM1CuiJaTqEieCXeXcHbpy4tk3ZJDJac6Wq+bLY+0Y+vVUENddF28fuUa5w/cX7aBXANjBcmWlKlEwj5ZG6uVDmKXCIUCNOafSqYQ4tMdDa2dWMKZD52ZfMaFBwd+x4kO67inoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TGmnWC1Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E84C4CEC0;
	Sat, 14 Sep 2024 16:03:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726329836;
	bh=Aa/Dt/9oSgkSjzIOJ/ghRzxN708Zll4gS9FIDuzDbJM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TGmnWC1Zej/XHTM5dW6CNBnUa1T7i/ttwfw+lBPzTfYFrDoow7WRghj4OsEV4IKnc
	 fZP8ETOchVja7TMRLBZakWA7bdtD1z874r2Cblg97ap4L94MlxjO+p5wDK5USjnRI/
	 EkSfP8NpUiJGJLC+1SviR8izN7uYoO7jGzY4pz36yiqwjUJPRoAmyp1MCGCys+wsz7
	 k2L1fFZJL0SSqx1na83NVknfvwvMudPiPYEIwXM6cq5og1w+K8d2wrGSL53+A5PgNH
	 8cZvx9TSUq+DFsMZrD9hRcZAm2Qd0O5zYNkBuph63dzMqJDKIBGtQfMM7taLRqLXCN
	 +dNtrfbtDQLeg==
Date: Sat, 14 Sep 2024 17:03:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Rishi Gupta <gupt21@gmail.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 7/7] iio: light: veml6030: add support for veml6035
Message-ID: <20240914170347.54959319@jic23-huawei>
In-Reply-To: <20240913-veml6035-v1-7-0b09c0c90418@gmail.com>
References: <20240913-veml6035-v1-0-0b09c0c90418@gmail.com>
	<20240913-veml6035-v1-7-0b09c0c90418@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Sep 2024 15:19:02 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The veml6035 is an ALS that shares most of its functionality with the
> veml6030, which allows for some code recycling.
> 
> Some chip-specific properties differ and dedicated functions to get and
> set the sensor gain as well as its initialization are required.
> 
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Mostly a request to first switch to using read_avail() and the relevant
bit masks instead of custom attributes.  That will require converting the
driver to that approach first, but looks straight forward.

> ---
>  drivers/iio/light/veml6030.c | 300 +++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 273 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/iio/light/veml6030.c b/drivers/iio/light/veml6030.c
> index 2945cc1db599..105f310c4954 100644
> --- a/drivers/iio/light/veml6030.c
> +++ b/drivers/iio/light/veml6030.c
> @@ -1,13 +1,19 @@
>  // SPDX-License-Identifier: GPL-2.0+
>  /*
> - * VEML6030 Ambient Light Sensor
> + * VEML6030 and VMEL6035 Ambient Light Sensors
>   *
>   * Copyright (c) 2019, Rishi Gupta <gupt21@gmail.com>
>   *
> + * VEML6030:
>   * Datasheet: https://www.vishay.com/docs/84366/veml6030.pdf
>   * Appnote-84367: https://www.vishay.com/docs/84367/designingveml6030.pdf
> + *
> + * VEML6035:
> + * Datasheet: https://www.vishay.com/docs/84889/veml6035.pdf
> + * Appnote-84944: https://www.vishay.com/docs/84944/designingveml6035.pdf
>   */
>  
> +#include <linux/bitfield.h>
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/err.h>
> @@ -38,16 +44,33 @@
>  #define VEML6030_ALS_INT_EN   BIT(1)
>  #define VEML6030_ALS_SD       BIT(0)
>  
> +#define VEML6035_GAIN_M       GENMASK(12, 10)
> +#define VEML6035_GAIN         BIT(10)
> +#define VEML6035_DG           BIT(11)
> +#define VEML6035_SENS         BIT(12)
> +#define VEML6035_INT_CHAN     BIT(3)
> +#define VEML6035_CHAN_EN      BIT(2)
> +
> +struct veml603x_chip {
> +	const char *name;
> +	const struct iio_info *info;
> +	const struct iio_info *info_no_irq;
> +	const char * const in_illuminance_scale_avail;

For this, better with read_avail() provided and a pointer to an array of
values + a size element in here.  That way we can get rid of the
custom attribute handling.  Might end up as similar amount of code, but
will be simpler to read.

> +	int (*hw_init)(struct iio_dev *indio_dev);
> +	int (*set_als_gain)(struct iio_dev *indio_dev, int val, int val2);
> +	int (*get_als_gain)(struct iio_dev *indio_dev, int *val, int *val2);
> +};

>  
>  /* Integration time available in seconds */
> @@ -63,14 +87,25 @@ static IIO_CONST_ATTR(in_illuminance_integration_time_available,
>  
>  /*
>   * Scale is 1/gain. Value 0.125 is ALS gain x (1/8), 0.25 is
> - * ALS gain x (1/4), 1.0 = ALS gain x 1 and 2.0 is ALS gain x 2.
> + * ALS gain x (1/4), 0.5 is ALS gain x (1/2), 1.0 is ALS gain x 1,
> + * 2.0 is ALS gain x2, and 4.0 is ALS gain x 4.
>   */
> -static IIO_CONST_ATTR(in_illuminance_scale_available,
> +static IIO_CONST_ATTR_NAMED(veml6030_in_illuminance_scale_available,
> +			    in_illuminance_scale_available,
>  				"0.125 0.25 1.0 2.0");
> +static IIO_CONST_ATTR_NAMED(veml6035_in_illuminance_scale_available,
> +			    in_illuminance_scale_available,
> +				"0.125 0.25 0.5 1.0 2.0 4.0");
>  
>  static struct attribute *veml6030_attributes[] = {
>  	&iio_const_attr_in_illuminance_integration_time_available.dev_attr.attr,
> -	&iio_const_attr_in_illuminance_scale_available.dev_attr.attr,
> +	&iio_const_attr_veml6030_in_illuminance_scale_available.dev_attr.attr,
> +	NULL
> +};
> +
> +static struct attribute *veml6035_attributes[] = {
> +	&iio_const_attr_in_illuminance_integration_time_available.dev_attr.attr,
> +	&iio_const_attr_veml6035_in_illuminance_scale_available.dev_attr.attr,

Using get_avail() etc would let you handle these as arrays of numbers rather than
strings + get rid of the need for any custom attributes. This should be
a very simple conversion so perhaps worth doing before adding the
new support.  Then you will have pointers to the value arrays + sizes
in your chip specific structures that just get looked up directly
by read_avail()


>  	NULL
>  };


>  
> +/*
> + * Set ALS gain to 1/8, integration time to 100 ms, ALS and WHITE
> + * channel enabled, ALS channel interrupt, PSM enabled,
> + * PSM_WAIT = 0.8 s, persistence to 1 x integration time and the
> + * threshold interrupt disabled by default. First shutdown the sensor,
> + * update registers and then power on the sensor.
> + */
> +static int veml6035_hw_init(struct iio_dev *indio_dev)
> +{
> +	int ret, val;
> +	struct veml6030_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +
> +	ret = veml6030_als_shut_down(data);
> +	if (ret) {
> +		dev_err(&client->dev, "can't shutdown als %d\n", ret);
> +		return ret;

If this is only ever called from probe() (I think that's true?)
can use return dev_err_probe() for all these error cases.
Main advantage here being shorter simpler code.

> +	}
> +
> +	ret = regmap_write(data->regmap, VEML6030_REG_ALS_CONF,
> +			   VEML6035_SENS | VEML6035_CHAN_EN | VEML6030_ALS_SD);
> +	if (ret) {
> +		dev_err(&client->dev, "can't setup als configs %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_update_bits(data->regmap, VEML6030_REG_ALS_PSM,
> +				 VEML6030_PSM | VEML6030_PSM_EN, 0x03);
> +	if (ret) {
> +		dev_err(&client->dev, "can't setup default PSM %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WH, 0xFFFF);
> +	if (ret) {
> +		dev_err(&client->dev, "can't setup high threshold %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = regmap_write(data->regmap, VEML6030_REG_ALS_WL, 0x0000);
> +	if (ret) {
> +		dev_err(&client->dev, "can't setup low threshold %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = veml6030_als_pwr_on(data);
> +	if (ret) {
> +		dev_err(&client->dev, "can't poweron als %d\n", ret);
> +		return ret;
> +	}
> +
> +	/* Clear stale interrupt status bits if any during start */
> +	ret = regmap_read(data->regmap, VEML6030_REG_ALS_INT, &val);
> +	if (ret < 0) {
> +		dev_err(&client->dev,
> +			"can't clear als interrupt status %d\n", ret);
> +		return ret;

It's true of existing code, but I noticed it here.
Should we be powering down in this error path?

> +	}
> +
> +	/* Cache currently active measurement parameters */
> +	data->cur_gain = 5;
> +	data->cur_resolution = 1024;
> +	data->cur_integration_time = 3;
> +
> +	return 0;
> +}


