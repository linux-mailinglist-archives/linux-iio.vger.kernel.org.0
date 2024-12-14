Return-Path: <linux-iio+bounces-13448-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 807D19F1E6C
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 13:02:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D7D8E7A05EB
	for <lists+linux-iio@lfdr.de>; Sat, 14 Dec 2024 12:02:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E6C18F2EA;
	Sat, 14 Dec 2024 12:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GGAyvjrT"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319E317A597;
	Sat, 14 Dec 2024 12:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734177757; cv=none; b=EYB4Ki5uNZ/2+yVu3j+biYihBjTim2L5s3oEysq7momVROnkPNcQPcFVEWHUt7y8G+b3uUTPeplNBczL9OZsnhbiH6imrLsk9Zr8ivaraXC5woiuJEJZrz+m3c3JBn2P7PIJ6bBpF3Q5nTr6Y5zL4t3FccK7MtdvfK4zw48i9RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734177757; c=relaxed/simple;
	bh=FBWgktWMqwrvXKBxjcw8z4eJsMrgmMqnzHI1HOGcIGk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xl1eum+MTk/yN1ORssuz5aGEfnpJn46QmMIN1zIVZvRHnzXEB1hoHwRSuVi3anaq1aGLqPKheubXYWpcxKtMKAw9Tqr5lXC7p8m5iSHRDeG1fJe0FxG63IPwAlDm8xPheBCZqbUnit65z8OYj4NAyovIjMPZqZKMCH2sTEhnxEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GGAyvjrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27343C4CED1;
	Sat, 14 Dec 2024 12:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734177756;
	bh=FBWgktWMqwrvXKBxjcw8z4eJsMrgmMqnzHI1HOGcIGk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GGAyvjrTsAb0V/z1IPGtftJVJ0G/wHpRr6Kk/DhTYcrylBpc1aEE5zAc+AU4FV5QA
	 XyT9cMxXBq49fKJvLG2clyAjJhDt2Ftz4WYNzW7ntPo2Yk66mbYm/5E6jzLn7RhQjN
	 jplH+oeZFF3BhkL0JavrkDY0cJBUC03EtfkPFcvY+IipUDGxE33EYVSKwpnHES/o+R
	 qwIBm/4FUQwJtKJFE1OpdPLevVkklYnVlA7JSy6LfzO2ubx5Brn4hCm5D5LRuhp93L
	 nW6jYN8jktW6yk722vSzUcLGiyd8cZ+MzXFCH97KotJ/TFtx4Cas/8Lr0xbVfERo9O
	 rJbbhF6HpJvew==
Date: Sat, 14 Dec 2024 12:02:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v7 1/7] iio: accel: adxl345: add function to switch
 measuring mode
Message-ID: <20241214120227.56b885fa@jic23-huawei>
In-Reply-To: <20241213211909.40896-2-l.rubusch@gmail.com>
References: <20241213211909.40896-1-l.rubusch@gmail.com>
	<20241213211909.40896-2-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Dec 2024 21:19:03 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Replace the powerup / powerdown functions by a generic function to put
> the sensor in STANDBY, or MEASURE mode. When configuring the FIFO for
> several features of the accelerometer, it is recommended to put
> measuring in STANDBY mode.
> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
Mostly in the interests of trimming down the queue of patches in flight
and because this one has been fine for a few versions without significant
comment.

Applied this patch to the togreg branch of iio.git and pushed out initially
as testing to let 0-day take a look.

Thanks

Jonathan

> ---
>  drivers/iio/accel/adxl345_core.c | 42 +++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 88df9547b..b48bc838c 100644
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
> @@ -237,11 +255,11 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
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
>  		return ret;
>  


