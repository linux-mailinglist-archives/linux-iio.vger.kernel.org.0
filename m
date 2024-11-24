Return-Path: <linux-iio+bounces-12598-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA1C9D7725
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:10:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 872431633ED
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 18:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE929136658;
	Sun, 24 Nov 2024 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpZGHnOk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9E13201;
	Sun, 24 Nov 2024 18:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732471815; cv=none; b=dsjRS21lNQQh0RUTz2P32GSLRLU1wYmNvl/EqpMFSRa1ecVj0ijCNmFCwZHDmnSHEfUPwYw9mTRjbHMz7hGMnnrffBG7aahR8QhCFjno+Oi+svOODSFA1yLht6HDUK+z2SQOz4LxKJzbrao+YjxFk4SKJmsGIBF/LptYklYsNrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732471815; c=relaxed/simple;
	bh=GsGyQyybKs9e//8vblwCUKO+66z3RfZrNb0aopC9kd0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hwQ7brjo67EashyS5CK+u+jx9w46TEckC07yOrS1td6vyw+KWHPq2u39z6TdVAEe3CTCiYlNWMoQ8f5cIpftFEAIObhhuqYlKkb7vccmgEaB0sGQT8LGK0N6EaeNPpysdsXlEO7E/XP5cwz09bBuMZ2WdtGqL56QZKKXbkaIHUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpZGHnOk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42386C4CECC;
	Sun, 24 Nov 2024 18:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732471815;
	bh=GsGyQyybKs9e//8vblwCUKO+66z3RfZrNb0aopC9kd0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MpZGHnOkln+DOI/hvl5NubSI5QYXxDRilTToEHXVFW7HNJfbHSCQFjQb+r/MQKGTw
	 HWJbJt3mmcnJfQpPMo7w1PlQksOkHvhgK0hXp1+yl4GYULLXC1hVmW7VmhamUDIrLf
	 EriVyu6dMDROhcRCj6HjP0Eh98Dx6ANOk80+xMq0B9QOvfvJofHR3NAc+ea8KNr+jP
	 jpSmpGiDvqSyj857cYVLKLxcpqS/LkZoTV40nFcf8kZfuHjkJwdf5VHoC0tqf1HLOc
	 lj6x66K0RggNPpdc7Lb2hccMmpSs4yPklg4FKz1widjhRkoehm51pfc4tawcNgqeGx
	 flBUExZY9H4vA==
Date: Sun, 24 Nov 2024 18:10:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 06/22] iio: accel: adxl345: add function to switch
 measuring
Message-ID: <20241124181007.24fce875@jic23-huawei>
In-Reply-To: <20241117182651.115056-7-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-7-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:35 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Replace the powerup / powerdown functions by a generic function to put
> the sensor in STANDBY, or MEASURE mode. This is needed for several
> features of the accelerometer. It allows to change e.g. FIFO settings.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345_core.c | 53 ++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 926e397678..81688a9eaf 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -138,6 +138,39 @@ static int adxl345_write_raw_get_fmt(struct iio_dev *indio_dev,
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
> +static int adxl345_set_measure_en(struct adxl34x_state *st, bool en)
> +{
> +	unsigned int val = 0;
> +	int ret;
> +
> +	val = (en) ? ADXL345_POWER_CTL_MEASURE : ADXL345_POWER_CTL_STANDBY;
> +	ret = regmap_write(st->regmap, ADXL345_REG_POWER_CTL, val);
> +	if (ret)
> +		return -EINVAL;
Don't eat the error response from regmap_write. I will probably be more
useful than simple -EINVAL if we get a problem.

	return regmap_write()

> +
> +	return 0;
> +}
> +
> +static void adxl345_powerdown(void *ptr)
> +{
> +	struct adxl34x_state *st = ptr;
> +
> +	adxl345_set_measure_en(st, false);
> +}
> +
>  static IIO_CONST_ATTR_SAMP_FREQ_AVAIL(
>  "0.09765625 0.1953125 0.390625 0.78125 1.5625 3.125 6.25 12.5 25 50 100 200 400 800 1600 3200"
>  );
> @@ -158,16 +191,6 @@ static const struct iio_info adxl345_info = {
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
>   * adxl345_core_probe() - probe and setup for the adxl345 accelerometer,
>   *                        also covers the adxl375 and adxl346 accelerometer
> @@ -242,14 +265,12 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  		return dev_err_probe(dev, -ENODEV, "Invalid device ID: %x, expected %x\n",
>  				     regval, ADXL345_DEVID);
>  
> -	/* Enable measurement mode */
> -	ret = adxl345_powerup(st->regmap);
> +	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st);

This should be done after the call to turn the device on.  Otherwise we are powering
down a device that is already powered down if this returns an error.
So original ordering looks correct to me.


>  	if (ret < 0)
> -		return dev_err_probe(dev, ret, "Failed to enable measurement mode\n");
> +		return dev_err_probe(dev, ret, "Failed to add action or reset\n");
>  
> -	ret = devm_add_action_or_reset(dev, adxl345_powerdown, st->regmap);
> -	if (ret < 0)
> -		return ret;
> +	/* Enable measurement mode */
> +	adxl345_set_measure_en(st, true);
Check if this fails.

>  
>  	return devm_iio_device_register(dev, indio_dev);
>  }


