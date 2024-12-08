Return-Path: <linux-iio+bounces-13221-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B73A9E8581
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 14:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC8902812C7
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 13:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEB814A0B9;
	Sun,  8 Dec 2024 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bL2o9BjJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910CF139566;
	Sun,  8 Dec 2024 13:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733665350; cv=none; b=WaBzDQHRle7UdGqnZKvWJLZz/+jdkplQamPyv1uhMhggTI6IcSYosax1/YjSSq6/5zb01L/FFMStNYg21UgBrl50RuHaTw9j4MyIU4Rk1JucH5PBGsnDwDtrFysJUN1NsgAEcwsDSUoBG3N6J/+wPvjUVXCSMqMK/g6HX1xHDwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733665350; c=relaxed/simple;
	bh=YeLYwaUR6aCPTHMEDpa2Xt+5ddGYfruL0nQBYAVrv0k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WC8e+fMGeZffS/wc58F+qixsIIMLEjzxQrN2uVd0dPz0vGSA8g5dF6yTY8RZplWvtZQ0TyaAIxzFhLgjsozrNddwzrcnc9CMDDFdB+ncxRDR4lVwzB2Q/APQmkX7N4vbDXr8tCjx/aHYjguJYdqwkqf5+BVk0ioES6bo1Uzbn7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bL2o9BjJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B119C4CED2;
	Sun,  8 Dec 2024 13:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733665350;
	bh=YeLYwaUR6aCPTHMEDpa2Xt+5ddGYfruL0nQBYAVrv0k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bL2o9BjJ06G6ydjZNjCFfMk8c2WtGXKUMG7lZvfXPqMwTb9uk2MCKG0KUGeRS6pLo
	 xdB6pg49rE/Bcxwv9ChO29JMiZNKeph5/pk9BUWyosB2/RifmXYAcJPE/dyhJvUGqp
	 dBY3zIONVcK8kHT8PL0QJsRgQqO/jhXrn+YKGhmhJT8h0i/lVn3ZEn5N11NrCYHEAc
	 XBcJzy0G94GKAxpSjbxBFuSUaypBpfR2r/rqM+GAMJ8AoJzTfGCTJkCVVrw+j1IoLM
	 lfjfKOGBNo3qMgOZMySOyH81ODD9AzYKreRw3VVTJ35HEJdLX3PKM6fDUize25MP/Y
	 sTyaioFxD8qpA==
Date: Sun, 8 Dec 2024 13:42:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v5 04/10] iio: accel: adxl345: add function to switch
 measuring mode
Message-ID: <20241208134220.0a8b84f5@jic23-huawei>
In-Reply-To: <20241205171343.308963-5-l.rubusch@gmail.com>
References: <20241205171343.308963-1-l.rubusch@gmail.com>
	<20241205171343.308963-5-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Dec 2024 17:13:37 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Replace the powerup / powerdown functions by a generic function to put
> the sensor in STANDBY, or MEASURE mode. When configuring the FIFO for
> several features of the accelerometer, it is recommended to put
> measuring in STANDBY mode.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Hi Lothar,

One trivial comment inline.

Jonathan

> ---
>  drivers/iio/accel/adxl345_core.c | 44 ++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 98ff37271f1..1d020b0d79c 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -138,6 +138,34 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
>  	}
>  }
>  
> +/**
> + * adxl345_set_measure_en() - Enable and disable measuring.
> + *
> + * @st: The device data.
> + * @en: Enable measurements, else standby mode.
> + *
> + * For lowest power operation, standby mode can be used. In standby mode,
> + * current consumption is supposed to be reduced to 0.1uA (typical). In this
> + * mode no measurements are made. Placing the device into standby mode
> + * preserves the contents of FIFO.
> + *
> + * Return: Returns 0 if successful, or a negative error value.
> + */
> +static int adxl345_set_measure_en(struct adxl345_state *st, bool en)
> +{
> +	unsigned int val = 0;
> +
> +	val = (en) ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
> +	return regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
> +}
> +
> +static void adxl345_powerdown(void *ptr)
> +{
> +	struct adxl345_state *st = ptr;
> +
> +	adxl345_set_measure_en(st, false);
> +}
> +
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
>  "0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200"
>  );
> @@ -158,16 +186,6 @@ static const struct iio_info adxl345_info = {
>  	.write_raw_get_fmt	= adxl345_write_raw_get_fmt,
>  };
>  
> -static int adxl345_powerup(void *regmap)
> -{
> -	return regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_MEASURE);
> -}
> -
> -static void adxl345_powerdown(void *regmap)
> -{
> -	regmap_write(regmap, ADXL345_REG_POWER_CTL, ADXL345_POWER_CTL_STANDBY);
> -}
> -
>  /**
>   * adxl345_core_probe() - Probe and setup for the accelerometer.
>   * @dev:	Driver model representation of the device
> @@ -236,13 +254,13 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  				     regval, ADXL345_DEVID);
>  
>  	/* Enable measurement mode */
> -	ret = adxl345_powerup(st->regmap);
> +	ret = adxl345_set_measure_en(st, true);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret, "Failed to enable measurement mode\n");
>  
> -	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st->regmap);
> +	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st);
>  	if (ret < 0)
> -		return ret;
> +		return dev_err_probe(dev, ret, "Failed to add action or reset\n");
You will never see that message, though arguably that's an implementation detail.

The only error that devm_add_action_or_reset() returns is -ENOMEM;
dev_err_probe() doesn't print on -ENOMEM because enough screaming occurs at
other layers.

I normally don't bother commenting on this one if it's introduced as one of
many messages, but here you are adding just this one so I have commented.


>  
>  	return devm_iio_device_register(dev, indio_dev);
>  }


