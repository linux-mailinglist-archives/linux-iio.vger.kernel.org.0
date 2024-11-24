Return-Path: <linux-iio+bounces-12600-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F499D7781
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 19:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 761EFB2B817
	for <lists+linux-iio@lfdr.de>; Sun, 24 Nov 2024 18:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D9A126BEE;
	Sun, 24 Nov 2024 18:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTDk3Zvj"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF9A224FA;
	Sun, 24 Nov 2024 18:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732472189; cv=none; b=g6oFbySKHztvKvSasE71UuKQz9gHB11luBT7ij+w7y0VHzMBeKg+TcxYDPDipAvsV9kb2/57FSyiQPqgz6CnOjRqe89fUi68Ni+b5hJ7dBthfQfOXpUpACa1xaoEXNmHBmhGCmcKDV7rTaF7iuFyyodiuCA5NBbW35y3yTOa1XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732472189; c=relaxed/simple;
	bh=FXsuG6lDU1uWF4iyfoWnk1dMCf5iIc4lUECmwOYM7NI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Njvj9+YjxlD+36/v/tHdZwUi0+SsN/7XRGvi1yJ2YWb0NFa5raswckYPtQ8hX5Mfzaim40MGH8mpVN+Xxc9g7CCtuPPqsm6ckbG00KzF2DL16JtA5X4yh9cS5QYgZr7n4dkKwUKZGjRL//oTYHlP7Krbv+0lXK8CMafQTEK80VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTDk3Zvj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B58C4CECC;
	Sun, 24 Nov 2024 18:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732472189;
	bh=FXsuG6lDU1uWF4iyfoWnk1dMCf5iIc4lUECmwOYM7NI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MTDk3Zvj5ymz6fVnlE+/RNU3sFjfxXMQD3YKBM9SWCCGQBH1axe6GglrIBT4Xl4La
	 jVhLsjbCZNDOX5ratGwNf+hOzHc6BdmWj9ezDWuC8gVPicoU+XjYblGvmoNDrg63H+
	 IbQ2578o8YNjhiU7xqcxqHejin/I2000YsZD+EjduSvqw7Rx7uOrnw3dDsL48X/nML
	 bt6u4fIOcztBeSFZpB+nzzX5m0IQiTGx8br3W12eduMOm5ONdDkpUt9RDgW3xjBVoU
	 bOpFaevOAe85TvRCYCW0DcSfyhgWgBICxavtJ00k3feA+WEm8EHUHu9Tu0NXISlWuG
	 W+CMYU9Jh1KLg==
Date: Sun, 24 Nov 2024 18:16:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
 eraretuya@gmail.com
Subject: Re: [PATCH v2 08/22] iio: accel: adxl345: initialize FIFO delay
 value for SPI
Message-ID: <20241124181622.6df37d30@jic23-huawei>
In-Reply-To: <20241117182651.115056-9-l.rubusch@gmail.com>
References: <20241117182651.115056-1-l.rubusch@gmail.com>
	<20241117182651.115056-9-l.rubusch@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 17 Nov 2024 18:26:37 +0000
Lothar Rubusch <l.rubusch@gmail.com> wrote:

> Add the possibility to delay FIFO access when SPI is used. According to
> the datasheet this is needed for the adxl345. When initialization
> happens over SPI the need for delay is to be signalized, and the delay
> will be used.
A specific reference to a section of the specification might be useful
here.

One trivial comment inline, but otherwise looks fine to me.

> 
> Signed-off-by: Lothar Rubusch <l.rubusch@gmail.com>
> ---
>  drivers/iio/accel/adxl345.h      | 2 +-
>  drivers/iio/accel/adxl345_core.c | 6 +++++-
>  drivers/iio/accel/adxl345_i2c.c  | 2 +-
>  drivers/iio/accel/adxl345_spi.c  | 3 +++
>  4 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/adxl345.h b/drivers/iio/accel/adxl345.h
> index cf4132715c..4ba493f636 100644
> --- a/drivers/iio/accel/adxl345.h
> +++ b/drivers/iio/accel/adxl345.h
> @@ -62,7 +62,7 @@ struct adxl345_chip_info {
>  };
>  
>  int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> -		       int irq,
> +		       int irq, bool fifo_delay_default,
>  		       int (*setup)(struct device*, struct regmap*));
>  
>  #endif /* _ADXL345_H_ */
> diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
> index 902bd3568b..51b229cc44 100644
> --- a/drivers/iio/accel/adxl345_core.c
> +++ b/drivers/iio/accel/adxl345_core.c
> @@ -22,6 +22,7 @@ struct adxl34x_state {
>  	int irq;
>  	const struct adxl345_chip_info *info;
>  	struct regmap *regmap;
> +	bool fifo_delay; /* delay: delay is needed for SPI */
>  };
>  
>  #define ADXL345_CHANNEL(index, axis) {					\
> @@ -199,13 +200,14 @@ static const struct iio_info adxl345_info = {
>   * @dev:	Driver model representation of the device
>   * @regmap:	Regmap instance for the device
>   * @irq:	Interrupt handling for async usage
> + * @fifo_delay_default: Using FIFO with SPI needs delay
>   * @setup:	Setup routine to be executed right before the standard device
>   *		setup
>   *
>   * Return: 0 on success, negative errno on error
>   */
>  int adxl345_core_probe(struct device *dev, struct regmap *regmap,
> -		       int irq,
> +		       int irq, bool fifo_delay_default,
>  		       int (*setup)(struct device*, struct regmap*))
>  {
>  	struct adxl34x_state *st;
> @@ -234,6 +236,8 @@ int adxl345_core_probe(struct device *dev, struct regmap *regmap,
>  	if (!st->info)
>  		return -ENODEV;
>  
> +	st->fifo_delay = fifo_delay_default;
> +
>  	indio_dev->name = st->info->name;
>  	indio_dev->info = &adxl345_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> diff --git a/drivers/iio/accel/adxl345_i2c.c b/drivers/iio/accel/adxl345_i2c.c
> index 604b706c29..fa1b7e7026 100644
> --- a/drivers/iio/accel/adxl345_i2c.c
> +++ b/drivers/iio/accel/adxl345_i2c.c
> @@ -27,7 +27,7 @@ static int adxl345_i2c_probe(struct i2c_client *client)
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(&client->dev, PTR_ERR(regmap), "Error initializing regmap\n");
>  
> -	return adxl345_core_probe(&client->dev, regmap, client->irq, NULL);
> +	return adxl345_core_probe(&client->dev, regmap, client->irq, false, NULL);
>  }
>  
>  static const struct adxl345_chip_info adxl345_i2c_info = {
> diff --git a/drivers/iio/accel/adxl345_spi.c b/drivers/iio/accel/adxl345_spi.c
> index 39e7d71e1d..75940d9c1c 100644
> --- a/drivers/iio/accel/adxl345_spi.c
> +++ b/drivers/iio/accel/adxl345_spi.c
> @@ -12,6 +12,7 @@
>  #include "adxl345.h"
>  
>  #define ADXL345_MAX_SPI_FREQ_HZ		5000000
> +#define ADXL345_MAX_FREQ_NO_FIFO_DELAY	1500000
>  
>  static const struct regmap_config adxl345_spi_regmap_config = {
>  	.reg_bits = 8,
> @@ -41,10 +42,12 @@ static int adxl345_spi_probe(struct spi_device *spi)
>  	if (spi->mode & SPI_3WIRE)
>  		return adxl345_core_probe(&spi->dev, regmap,
>  					  spi->irq,
> +					  spi->max_speed_hz > ADXL345_MAX_FREQ_NO_FIFO_DELAY,
>  					  adxl345_spi_setup);
>  	else
>  		return adxl345_core_probe(&spi->dev, regmap,
>  					  spi->irq,
> +					  spi->max_speed_hz > ADXL345_MAX_FREQ_NO_FIFO_DELAY,

use a local variable to establish this without the very long line.

>  					  NULL);
>  }
>  


