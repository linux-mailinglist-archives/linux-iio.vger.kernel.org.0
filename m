Return-Path: <linux-iio+bounces-7588-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5231793053C
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 12:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049D11F2240C
	for <lists+linux-iio@lfdr.de>; Sat, 13 Jul 2024 10:45:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A17F7344A;
	Sat, 13 Jul 2024 10:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="XETdx1qF"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-30.smtpout.orange.fr [80.12.242.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0262347A53;
	Sat, 13 Jul 2024 10:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720867540; cv=none; b=f8jGuUZ2oVFEu2mgroaV8H5L3t+GPFQUIT3mhCGH6K8nO5zZ7z6oiCo2ed49Ymc8q2LxwrRfEkD+Ul38OLmJylhkvkhSxSONZipDPFoxDZXruH0wtQ9EH4nROSsG0oXCNZOZQAcAMglAtz6I0dx1t64NzxIltc2f+vPeVkET0Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720867540; c=relaxed/simple;
	bh=0Sgv7iDpBQpLnt5xMwKPbYl7cBdSmNSaz+6GBBDmHeI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K+8JX8d1+7CuVKF81YAbu8wF1gjxPUmAyA6rc2KJC2bz2kKvA8IccXVkPmVATACQAnEdeKDpePcHhr2865GeGNPvYnJBai3sTg9SLcslAnpiJ/7R0ZXenr3R64R2RucCn2R5CsG2NzJX1CAQjBMTqaRTE0Kdjqmg7Tz2CWkXmE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=XETdx1qF; arc=none smtp.client-ip=80.12.242.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id SaEtsYZnxYjQzSaEusagth; Sat, 13 Jul 2024 12:44:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1720867468;
	bh=sXFkaELaVcONq/wZ2YavLzkpI2a5TGDA0QnUmOOLdDc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=XETdx1qFiWm2wv1qVsnrg5HRDRXJGt17UQMy9937mb67e9lecYyQBUskcGtQKPZG7
	 Y/liAE57sG+KkX9LUANzSr7nqSJFcFFk6DoSsxG7dspsZq3L8nb3D+FBeDBCwY9YR8
	 rn4R/t6I/4W26l/FANDYmX5TNIwQjG2w3vSgpdBndQ8//LGwZrsjMC0RQPS7frY1ET
	 1TZTG5WcejO8ZEEEzR+8brhjNH8qf47U82ZSyHkSMl3w2flVmyCjFM0Pk9l3p+KRxN
	 DJJAPeWUWBfQTJOByYnlKWHXehIyzx0q0tYzw9d+jNXRX9np993Lkz8YfUbLnd0lNB
	 dTuLCip7+3ykQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Sat, 13 Jul 2024 12:44:28 +0200
X-ME-IP: 90.11.132.44
Message-ID: <2c0e9d3c-72be-499d-a52e-779d851b37a9@wanadoo.fr>
Date: Sat, 13 Jul 2024 12:44:27 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] iio: humidity: Add support for ENS21x
To: jfelmeden@thegoodpenguin.co.uk
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, jic23@kernel.org,
 krzk+dt@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, robh@kernel.org
References: <20240710-ens21x-v3-0-4e3fbcf2a7fb@thegoodpenguin.co.uk>
 <20240710-ens21x-v3-2-4e3fbcf2a7fb@thegoodpenguin.co.uk>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240710-ens21x-v3-2-4e3fbcf2a7fb@thegoodpenguin.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 10/07/2024 à 15:24, Joshua Felmeden a écrit :
> Add support for ENS210/ENS210A/ENS211/ENS212/ENS213A/ENS215.
> 
> The ENS21x is a family of temperature and relative humidity sensors with
> accuracies tailored to the needs of specific applications.
> 
> Signed-off-by: Joshua Felmeden <jfelmeden-tUaQ5FxYRYX4aQPF92CzsNBc4/FLrbF6@public.gmane.org>
> ---
>   drivers/iio/humidity/Kconfig  |  11 ++
>   drivers/iio/humidity/Makefile |   1 +
>   drivers/iio/humidity/ens21x.c | 346 ++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 358 insertions(+)

Hi,

as kernel test robot complained, there will be a v4.

So here are a few nitpicks/questions, in case it helps.

...

> +#include <linux/types.h>
> +#include <linux/i2c.h>
> +#include <linux/delay.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
> +#include <linux/crc7.h>

Nitpick: usually, it is prefered to keep #include alphabetically ordered.

...

> +
> +/* magic constants */
> +#define ENS21X_CONST_TEMP_SCALE_INT 15 /* integer part of temperature scale (1/64) */
> +#define ENS21X_CONST_TEMP_SCALE_DEC 625000 /* decimal part of temperature scale */
> +#define ENS21X_CONST_HUM_SCALE_INT 1 /* integer part of humidity scale (1/512) */
> +#define ENS21X_CONST_HUM_SCALE_DEC 953125 /* decimal part of humidity scale */
> +#define ENS21X_CONST_TEMP_OFFSET_INT -17481 /* temperature offset (64 * -273.15) */
> +#define ENS21X_CONST_TEMP_OFFSET_DEC 600000 /* decimal part of offset */
> +#define ENS210_CONST_CONVERSION_TIME 130
> +#define ENS212_CONST_CONVERSION_TIME 32
> +#define ENS215_CONST_CONVERSION_TIME 132

Datasheet says 130 for ENS213A and ENS215.
Is it a typo?
If 132 is intentional, maybe a samll comment explaining why would be 
welcomed?

...

> +static int ens21x_get_measurement(struct iio_dev *indio_dev, bool temp, int *val)
> +{
> +	u32 regval, regval_le;
> +	int ret, tries;
> +	struct ens21x_dev *dev_data = iio_priv(indio_dev);
> +
> +	/* assert read */
> +	i2c_smbus_write_byte_data(dev_data->client, ENS21X_REG_SENS_START,
> +				  temp ? ENS21X_SENS_START_T_START :
> +					 ENS21X_SENS_START_H_START);
> +
> +	/* wait for conversion to be ready */
> +	switch (dev_data->part_id) {
> +	case ENS210:
> +	case ENS210A:
> +		msleep(ENS210_CONST_CONVERSION_TIME);
> +		break;
> +	case ENS211:
> +	case ENS212:
> +		msleep(ENS212_CONST_CONVERSION_TIME);
> +		break;
> +	case ENS213A:
> +	case ENS215:
> +		msleep(ENS215_CONST_CONVERSION_TIME);
> +		break;
> +	default:
> +		dev_err(&dev_data->client->dev, "unrecognised device");
> +		return -ENODEV;
> +	}
> +
> +	tries = 10;
> +	while (tries-- > 0) {
> +		usleep_range(4000, 5000);

We just msleep()'ed the max expected time for the conversion. So, maybe 
the code could be re-arranged so that this delay is done only if we retry?

> +		ret = i2c_smbus_read_byte_data(dev_data->client,
> +					       ENS21X_REG_SENS_STAT);
> +		if (ret < 0)
> +			continue;
> +		if (!(ret & (temp ? ENS21X_SENS_STAT_T_ACTIVE :
> +				    ENS21X_SENS_STAT_H_ACTIVE)))
> +			break;
> +	}
> +	if (tries < 0) {
> +		dev_err(&indio_dev->dev, "timeout waiting for sensor reading\n");
> +		return -EIO;
> +	}

...

> +	indio_dev->name = id->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ens21x_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ens21x_channels);
> +	indio_dev->info = &ens21x_info;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}
> +
> +

Nitpick: unneeded 2nd new line.

> +static const struct of_device_id ens21x_of_match[] = {
> +	{ .compatible = "sciosense,ens210", .data = (void *)ENS210},
> +	{ .compatible = "sciosense,ens210a", .data = (void *)ENS210A },
> +	{ .compatible = "sciosense,ens211", .data = (void *)ENS211},

...

CJ


