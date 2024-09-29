Return-Path: <linux-iio+bounces-9883-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4237E989611
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 16:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F34A3B21BC9
	for <lists+linux-iio@lfdr.de>; Sun, 29 Sep 2024 14:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9489B14EC7D;
	Sun, 29 Sep 2024 14:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WrsSu4ay"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F9D38F6D;
	Sun, 29 Sep 2024 14:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727621685; cv=none; b=HBpUwkbvT+VNPv1G5fhZ+WKjrRQzUuct5Q3+cynmgVDpX5mRovfyvuKrhVo+kFxCnUTs3tEUNfv343kSNfrgN2wUGBlVTRV1pb3b/qQBIkdAwPyuaYlCnUUnk5ryWW+WXP9gxU8gNsonyXW0csCEImx9jCNuehnLn+xVE/Eknwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727621685; c=relaxed/simple;
	bh=h1wCOEWNwmeVwY+5OCdLYnqmKx4uvrqO3C2WhNd2TVA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IKzcAl/LSusz5IqqNoY+auT5KGcaEJ3MavdayWtV75Nq4aDvFhvAcjh0pp0CQz2vfY7bv6sSGPcOZpxY15CxT7CGoxwmRE1ktYFyFpwbOZjl+PSxj+hNt9oBvuch2oMtKzPQ8W6UXx5Aq0cHkbk29hSs7xZ1M83ScrfdKEx7G2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WrsSu4ay; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50DC4C4CEC5;
	Sun, 29 Sep 2024 14:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727621684;
	bh=h1wCOEWNwmeVwY+5OCdLYnqmKx4uvrqO3C2WhNd2TVA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WrsSu4ays+rLIoiR15IIuNJ7HVySCanwwOV6j788lTnWRximAWD4nrrdbaahtTzgS
	 bixZQDpjR5XYhidmGXABHqFKV5B56HBNMEGQ1a+60FKFyYXFcFo1BMi+wpxGwQq9N0
	 OrRYfTRQlyyS+bPc79truqaBIfXBd+BKrNw/qHM3QElCRF+j891sE/GyHtdD890cpX
	 8KOY0XBLB8+e2ot7IzBjZYOihDe7pvhSF7lP8nMLo/Dqk1FHidmuT6MYScethQQEwN
	 uKmIBvaAzs/BY2CEgYWT4kO0T3VoGOdv3ZlfVzljsgjFxw6N7/oM9GWQ0jBEGbuRhk
	 qNpv2TZzEIOeg==
Date: Sun, 29 Sep 2024 15:54:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alex Lanzano <lanzano.alex@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: bmi270: Add spi driver for bmi270 imu
Message-ID: <20240929155437.60115014@jic23-huawei>
In-Reply-To: <20240927183717.3613601-1-lanzano.alex@gmail.com>
References: <20240927183717.3613601-1-lanzano.alex@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 27 Sep 2024 14:37:10 -0400
Alex Lanzano <lanzano.alex@gmail.com> wrote:

> Implement SPI driver for the Bosch BMI270 6-axis IMU. Provide raw read
> write access to acceleration and angle velocity measurements via the SPI
> interface on the device.
> 
> Signed-off-by: Alex Lanzano <lanzano.alex@gmail.com>

A few minor things inline but looks good in general.

Jonathan

> diff --git a/drivers/iio/imu/bmi270/bmi270.h b/drivers/iio/imu/bmi270/bmi270.h
> index 608b29ea58a3..8950e6234203 100644
> --- a/drivers/iio/imu/bmi270/bmi270.h
> +++ b/drivers/iio/imu/bmi270/bmi270.h
> @@ -4,11 +4,13 @@
>  #define BMI270_H_
>  
>  #include <linux/regmap.h>
> +#include <linux/iio/iio.h>
>  
>  struct device;
>  struct bmi270_data {
>  	struct device *dev;
>  	struct regmap *regmap;
> +	__le16 sample __aligned(IIO_DMA_MINALIGN);

For the read path you are bouncing anyway, so the DMA_MINALIGN is only needed
for anything the write direction.  Make the suggested change below and that
will bounce as well so that you don't need this.

>  };
>  
>  extern const struct regmap_config bmi270_regmap_config;
> diff --git a/drivers/iio/imu/bmi270/bmi270_core.c b/drivers/iio/imu/bmi270/bmi270_core.c
> index 8e45343d6472..4decdad791d9 100644
> --- a/drivers/iio/imu/bmi270/bmi270_core.c
> +++ b/drivers/iio/imu/bmi270/bmi270_core.c
> @@ -66,16 +66,9 @@ enum bmi270_scan {
>  	BMI270_SCAN_GYRO_Z,
>  };
>  
> -const struct regmap_config bmi270_regmap_config = {
> -	.reg_bits = 8,
> -	.val_bits = 8,
> -};
> -EXPORT_SYMBOL_NS_GPL(bmi270_regmap_config, IIO_BMI270);
> -
>  static int bmi270_get_data(struct bmi270_data *bmi270_device,
>  			   int chan_type, int axis, int *val)
>  {
> -	__le16 sample;
>  	int reg;
>  	int ret;
>  
> @@ -90,11 +83,13 @@ static int bmi270_get_data(struct bmi270_data *bmi270_device,
>  		return -EINVAL;
>  	}
>  
> -	ret = regmap_bulk_read(bmi270_device->regmap, reg, &sample, sizeof(sample));
> +	ret = regmap_bulk_read(bmi270_device->regmap, reg,
> +			       &bmi270_device->sample,
> +			       sizeof(bmi270_device->sample));
>  	if (ret)
>  		return ret;
>  
> -	*val = sign_extend32(le16_to_cpu(sample), 15);
> +	*val = sign_extend32(le16_to_cpu(bmi270_device->sample), 15);
>  
>  	return 0;
>  }
> diff --git a/drivers/iio/imu/bmi270/bmi270_i2c.c b/drivers/iio/imu/bmi270/bmi270_i2c.c
> index f70dee2d8a64..ce8279ae90cd 100644
> --- a/drivers/iio/imu/bmi270/bmi270_i2c.c
> +++ b/drivers/iio/imu/bmi270/bmi270_i2c.c
> @@ -9,12 +9,17 @@
>  
>  #include "bmi270.h"
>  
> +const struct regmap_config bmi270_i2c_regmap_config = {
static const

(same for spi one)

> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
>  static int bmi270_i2c_probe(struct i2c_client *client)
>  {
>  	struct regmap *regmap;
>  	struct device *dev = &client->dev;
>  
> -	regmap = devm_regmap_init_i2c(client, &bmi270_regmap_config);
> +	regmap = devm_regmap_init_i2c(client, &bmi270_i2c_regmap_config);
>  	if (IS_ERR(regmap))
>  		return dev_err_probe(dev, PTR_ERR(regmap),
>  				     "Failed to init i2c regmap");
> diff --git a/drivers/iio/imu/bmi270/bmi270_spi.c b/drivers/iio/imu/bmi270/bmi270_spi.c
> new file mode 100644
> index 000000000000..906b9b852a09
> --- /dev/null
> +++ b/drivers/iio/imu/bmi270/bmi270_spi.c
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/regmap.h>
Alphabetical order preferred.

> +
> +#include "bmi270.h"
> +
> +/*
> + * The following two functions are taken from the BMI323 spi driver code.
> + * In section 6.4 of the BMI270 data it specifies that after a read
> + * operation the first data byte from the device is a dummy byte
> + */
> +static int bmi270_regmap_spi_read(void *context, const void *reg_buf,
> +				  size_t reg_size, void *val_buf,
> +				  size_t val_size)
> +{
> +	struct spi_device *spi = context;

I'd be tempted to rename the input parameter context to spi and then
parse it directly to the spi_write_then_read()

> +
> +	return spi_write_then_read(spi, reg_buf, reg_size, val_buf, val_size);
> +}
> +
> +static int bmi270_regmap_spi_write(void *context, const void *data,
> +				   size_t count)
> +{
> +	struct spi_device *spi = context;
> +	u8 *data_buff = (u8 *)data;
> +
> +	/*
> +	 * Remove the extra pad byte since its only needed for the read
> +	 * operation
> +	 */
> +	data_buff[1] = data_buff[0];
> +	return spi_write(spi, data_buff + 1, count - 1);
That needs a DMA safe buffer (unlike write_then_read which always
bounces).  I'd avoid that complexity by using spi_write_then_read
here as well but set the read to 0 length and pass NULL for the buffer.
That function is intended to be used like this as it special cases 0
length for either write or read buffers.

> +}


