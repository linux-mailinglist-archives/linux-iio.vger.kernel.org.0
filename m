Return-Path: <linux-iio+bounces-12599-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 085A19D772E
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 703E828205D
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 18:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425CD13A244;
	Sun, 24 Nov 2024 18:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wg6wQNP0"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F181074BE1;
	Sun, 24 Nov 2024 18:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732472076; cv=none; b=pDyAACTGImTCnPCiwP6heNqZTGspIXv1MK6AA2dJbxhZS3Acso2ibHKTOMOsiJBaQtbwe7D4ehGdcdS1cCK9PsNm0WMi3L3x9rv1oNKvzV2z9ISREjMWt5y0Y5KA78Foij42mmQrIBZF0o/YQSZ9FyoQ4h0/Sg33iVjCyCanrBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732472076; c=relaxed/simple;
	bh=rfstF72gdDCGAx/RG8npyL0k9OSYoWd+VhUMxaBaFIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfjnnBGSGL+rD1jQcT7of3hr3gAgq9rITZQYnRPH702GNlcd440vOtWaHRmjtELyUR5gwQMJNeZvpndQAj5lsz7izZBWTYRbdrIApfGNIPcCEf+iJx9Qf295KQrbqFwgXsLkHeeHAHhY7/K6Ztwk12B4oAt0d3AUtdsO+MOlgG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wg6wQNP0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE94EC4CECC;
	Sun, 24 Nov 2024 18:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732472075;
	bh=rfstF72gdDCGAx/RG8npyL0k9OSYoWd+VhUMxaBaFIQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Wg6wQNP0uqoh8zJJZxASpcqGgVEMQuP66q2yMj6cpg82e5ElPsY1Ah9dHdMqRAQ/y
	 1akU3/nzgXu4rtvvvWw9YtOaRCHnAd6ribwHoRW3JWiqAcnLJtj5ZFJcABXV2sOnup
	 UWzdaOnUuwIw37iy145yP7OhQldM8U4s8BMWe3SDfQkPDOkWTTxSL1Z5nbi7swMIhL
	 TJpbZI+g5JAltPfU++x8Tn1PNC5L2mlZ8scZoUyfTeT5InKLI0MVBbXZ/e0u/lgPAf
	 Rf5b1TooCVKiIUWHcR1nurSR+RHDLd+HL6uVCki8FVWnzFpVq3N4l1E5r509ozuTyy
	 yuWtUfu0wu38g==
Date: Sun, 24 Nov 2024 18:14:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 07/22] iio: accel: adxl345: initialize IRQ number
Message-ID: <20241124181428.59b85176@jic23-huawei>
In-Reply-To: <20241117182651.115056-8-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-8-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:36 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the possibility to claim an interrupt and init the state structure
> with interrupt number and interrupt line to use. The adxl345 can use
> two different interrupt lines, mainly to signal FIFO watermark events,
> single or double tap, activity, etc. Hence, having the interrupt line
> available is crucial to implement such features.

If there are two interrupt lines, you need to be more clever.
Imagine only one of them is wired. How do you know which one it is?

The query needs to be done by name.  When there are multiple interrupts
the ones found in spi and i2c structures could be anything, so don't use
those.

See fwnode_irq_get_by_name()


> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345.h      | 1 +
>  drivers/iio/accel/adxl345_core.c | 6 ++++++
>  drivers/iio/accel/adxl345_i2c.c  | 2 +-
>  drivers/iio/accel/adxl345_spi.c  | 8 ++++++--
>  4 files changed, 14 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index 3d5c8719db..cf4132715c 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -62,6 +62,7 @@ struct adxl345_chip_info {
>  };
>  
>  int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> +		       int irq,
>  		       int (*setup)(struct device*, struct regmap*));
>  
>  #endif /* _ADXL345_H_ */
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 81688a9eaf..902bd3568b 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -11,6 +11,7 @@
>  #include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/units.h>
> +#include <linux/interrupt.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -18,6 +19,7 @@
>  #include "adxl345.h"
>  
>  struct adxl34x_state {
> +	int irq;
>  	const struct adxl345_chip_info *info;
>  	struct regmap *regmap;
>  };
> @@ -196,12 +198,14 @@ static const struct iio_info adxl345_info = {
>   *                        also covers the adxl375 and adxl346 accelerometer
>   * @dev:	Driver model representation of the device
>   * @regmap:	Regmap instance for the device
> + * @irq:	Interrupt handling for async usage

This is an integer, not a handling.   See if you can come up with clearer comment.

>   * @setup:	Setup routine to be executed right before the standard device
>   *		setup
>   *
>   * Return: 0 on success, negative errno on error
>   */
>  int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> +		       int irq,
>  		       int (*setup)(struct device*, struct regmap*))
>  {
>  	struct adxl34x_state *st;
> @@ -224,6 +228,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  
>  	st = iio_priv(indio_dev);
>  	st->regmap = regmap;
> +
> +	st->irq = irq;
>  	st->info = device_get_match_data(dev);
>  	if (!st->info)
>  		return -ENODEV;
> diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
> index 4065b8f7c8..604b706c29 100644
> --- a/drivers/iio/accel/adxl345_i2c.c
> +++ b/drivers/iio/accel/adxl345_i2c.c
> @@ -27,7 +27,7 @@ static int adxl345_i2c_probe(struct i2c_client *client)
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializing regmap\n");
>  
> -	return adxl345_core_probe(&client->dev, regmap, NULL);
> +	return adxl345_core_probe(&client->dev, regmap, client->irq, NULL);
>  }
>  
>  static const struct adxl345_chip_info adxl345_i2c_info = {
> diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
> index 61fd9a6f5f..39e7d71e1d 100644
> --- a/drivers/iio/accel/adxl345_spi.c
> +++ b/drivers/iio/accel/adxl345_spi.c
> @@ -39,9 +39,13 @@ static int adxl345_spi_probe(struct spi_device *spi)
>  		return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
>  
>  	if (spi->mode & SPI_3WIRE)
> -		return adxl345_core_probe(&spi->dev, regmap, adxl345_spi_setup);
> +		return adxl345_core_probe(&spi->dev, regmap,
> +					  spi->irq,
> +					  adxl345_spi_setup);
Very early wrap. I think spi->irq fits on the line above.

>  	else
> -		return adxl345_core_probe(&spi->dev, regmap, NULL);
> +		return adxl345_core_probe(&spi->dev, regmap,
> +					  spi->irq,
> +					  NULL);
>  }
>  
>  static const struct adxl345_chip_info adxl345_spi_info = {


