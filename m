Return-Path: <linux-iio+bounces-5607-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AAB8D74EF
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 13:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AFD0B20FDD
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 11:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E20B381D4;
	Sun,  2 Jun 2024 11:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VrbP0iAp"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3068079C2;
	Sun,  2 Jun 2024 11:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717327470; cv=none; b=duAp7fXmrTM5VmZypmGuf+9dB/sKQMplLX+domfafL23uAFxNBHoUm0Qh8lHROwuALhjDcLSrtfH+nyeYi38PgvWMywvzhThoFO6EtieRhrLq7db76/uZT1gNHvCTAYPh1Y0XoP5zrsc8+iBBbueyuwa7PmIDc59nLulgs/DAt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717327470; c=relaxed/simple;
	bh=breEUuOAOGHCHQAc0Q2YzGgD+LR2MrT12ai7HXyzQfY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p/1aDRJleVUTJ1GkKSWOki0z6Fbt1orTTBr0lEe6wL4ZaeGO2+wj3ZI4HfpSy42serCWiKTPoNcqLrBag5ImdwYLFYWEu4pwRPxSXIkvOZ7zDOEdYd81sDBcY+bMMpIFb9ciRHjJgV3Jnj5uReH0D0sw7/25lP+auv+WB96R/EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VrbP0iAp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB5BC2BBFC;
	Sun,  2 Jun 2024 11:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717327469;
	bh=breEUuOAOGHCHQAc0Q2YzGgD+LR2MrT12ai7HXyzQfY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=VrbP0iApjMIaW1t9IaXwumw5bqCsQ1nbAxTuyuB6ejdON9ULNMJe7ilp5mSET5cwP
	 OgAX2TJGEN7KVZ8eCsLHMLAzUbGzD+jmOlH509dej2ePTitmF00+7aszk3dSj3mHdh
	 qBXxgCW8YB31xggiqWo7uqlpesf++V+pqUHo7HMqeIIuYeo85JlBiTLeXSNXvX1S6z
	 POjVw6qfDLvDtYcSxKP+SfKO3EPqk+VqR5WPsTJNNYoXRjtpmtnBf8zljFvejAcnA/
	 d13VbRZmPvWzb6+cLVJKRq3/72XFA5ABU3EXkQ/OpJABe1nYwtWO74d2Nic/W1FTQr
	 9Kwmy3FA8SkqA==
Date: Sun, 2 Jun 2024 12:24:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, christophe.jaillet@wanadoo.fr, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/6] iio: chemical: add driver for ENS160 sensor
Message-ID: <20240602122416.02164c28@jic23-huawei>
In-Reply-To: <20240529001504.33648-3-gustavograzs@gmail.com>
References: <20240529001504.33648-1-gustavograzs@gmail.com>
	<20240529001504.33648-3-gustavograzs@gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 May 2024 21:14:20 -0300
Gustavo Silva <gustavograzs@gmail.com> wrote:

> ScioSense ENS160 is a digital metal oxide multi-gas sensor, designed
> for indoor air quality monitoring. The driver supports readings of
> CO2 and VOC, and can be accessed via both SPI and I2C.
> 
> Datasheet: https://www.sciosense.com/wp-content/uploads/2023/12/ENS160-Datasheet.pdf
> 
> Signed-off-by: Gustavo Silva <gustavograzs@gmail.com>
Hi Gustavo,

A few more comments inline.

Jonathan

> diff --git a/drivers/iio/chemical/ens160_core.c b/drivers/iio/chemical/ens160_core.c
> new file mode 100644
> index 000000000..a535f62c4
> --- /dev/null
> +++ b/drivers/iio/chemical/ens160_core.c
> @@ -0,0 +1,221 @@

...

> +static void ens160_set_idle(void *data)
> +{
> +	ens160_set_mode(data, ENS160_REG_MODE_IDLE);
> +}
> +
> +static int ens160_chip_init(struct ens160_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	unsigned int status;
> +	int ret;
> +
> +	ret = ens160_set_mode(data, ENS160_REG_MODE_RESET);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_read(data->regmap, ENS160_REG_PART_ID, &data->buf,
> +			       sizeof(data->buf));
> +	if (ret)
> +		return ret;
> +
> +	if (le16_to_cpu(data->buf) != ENS160_PART_ID)
> +		return -ENODEV;
> +
> +	ret = ens160_set_mode(data, ENS160_REG_MODE_IDLE);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, ENS160_REG_COMMAND,
> +			   ENS160_REG_COMMAND_CLRGPR);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(data->regmap, ENS160_REG_COMMAND,
> +			   ENS160_REG_COMMAND_GET_APPVER);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_read(data->regmap, ENS160_REG_GPR_READ4,
> +			       data->fw_version, sizeof(data->fw_version));
> +	if (ret)
> +		return ret;
> +
> +	dev_info(dev, "firmware version: %u.%u.%u\n", data->fw_version[2],
> +		 data->fw_version[1], data->fw_version[0]);
> +
> +	ret = ens160_set_mode(data, ENS160_REG_MODE_STANDARD);
> +	if (ret)
> +		return ret;

I'd expect to see the devm code to set this to IDLE registered here
not before this function is called.  If it makes sense after reset
then register it there.

> +
> +	ret = regmap_read(data->regmap, ENS160_REG_DEVICE_STATUS, &status);
> +	if (ret)
> +		return ret;
> +
> +	if (FIELD_GET(ENS160_STATUS_VALIDITY_FLAG, status)
> +	    != ENS160_STATUS_NORMAL)
> +		return -EINVAL;
> +
> +	return 0;
> +}
> +
> +static const struct iio_info ens160_info = {
> +	.read_raw = ens160_read_raw,
> +};
> +
> +int devm_ens160_core_probe(struct device *dev, struct regmap *regmap,
> +			   const char *name)
> +{
> +	struct ens160_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->regmap = regmap;
> +
> +	indio_dev->name = name;
> +	indio_dev->info = &ens160_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ens160_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ens160_channels);
> +
> +	ret = devm_add_action_or_reset(dev, ens160_set_idle, data);
What is this 'undoing'?  My guess is this belongs after chip_init.
Note that the expectation is that functions that return error codes
should not have side effects, so you may need to clean up manually
in ens160_chip_init() or move this devm call in there so it's immediately
after whatever it undoing.

> +	if (ret)
> +		return ret;
> +
> +	ret = ens160_chip_init(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "chip initialization failed\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +EXPORT_SYMBOL_NS(devm_ens160_core_probe, IIO_ENS160);
> +
> +MODULE_AUTHOR("Gustavo Silva <gustavograzs@gmail.com>");
> +MODULE_DESCRIPTION("ScioSense ENS160 driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/iio/chemical/ens160_i2c.c b/drivers/iio/chemical/ens160_i2c.c
> new file mode 100644
> index 000000000..2f0b08e52
> --- /dev/null
> +++ b/drivers/iio/chemical/ens160_i2c.c
> @@ -0,0 +1,60 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * ScioSense ENS160 multi-gas sensor I2C driver
> + *
> + * Copyright (c) 2024 Gustavo Silva <gustavograzs@gmail.com>
> + *
> + * 7-Bit I2C slave address is:
> + *	- 0x52 if ADDR pin LOW
> + *	- 0x53 if ADDR pin HIGH
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include "ens160.h"
> +
> +static const struct regmap_config ens160_regmap_i2c_conf = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +};
> +
> +static int ens160_i2c_probe(struct i2c_client *client)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i2c(client, &ens160_regmap_i2c_conf);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(regmap),
> +				     "Failed to register i2c regmap\n");
> +
> +	return devm_ens160_core_probe(&client->dev, regmap, "ens160_i2c");

The user tends not to care if it's spi or i2c + it's easy to tell anyway
by looking at the parent of the iio device. + the ABI is part number, not
part number with a bus prefix so some standard tools may run into problems
with this form.

So drop that _i2c and the _spi one.




