Return-Path: <linux-iio+bounces-5018-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACCDE8C4761
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 21:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFDA61C20FFF
	for <lists+linux-iio@lfdr.de>; Mon, 13 May 2024 19:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D00A94500E;
	Mon, 13 May 2024 19:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="c7tcOgfg"
X-Original-To: linux-iio@vger.kernel.org
Received: from msa.smtpout.orange.fr (msa-215.smtpout.orange.fr [193.252.23.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B411E41C69;
	Mon, 13 May 2024 19:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.23.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715627588; cv=none; b=h1s5TeravhcTNIY2oiUkklM8oZWxZl308JWWiyI2I9jJLhGbnQh9sTuyCsjkWLjp5FD1P/wlEbQlRM66nwx7rSD9sFNan1z0nIhVxOBxvQdncTFdYp+lsvC3QDD5pUL74d2Cgy5hPjsP5DZcG04jhUiK1vJE5pPNLwBX/XWKELM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715627588; c=relaxed/simple;
	bh=Hb63XJGxzeW9uRlqMhyf+5kOH3Raz8tCqBLrAmWdmWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArcsaM7KHehrxHGH+N26XBVbSt98NvOX6rie7gKNOchMx0/uM7q5lsdYlX2rXH4fdhPSYDer1L/OC+zgzaoMLlQJosgTttTZhMwzZLzV7T8P7b6xuZS6a5YWlrfFhNEB6KfnGO6rRoipe2WKm6k8yfb9bZya7i+h7Y3AcLBL7Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=c7tcOgfg; arc=none smtp.client-ip=193.252.23.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 6b6XsDylUGKTX6b6Xsn9CV; Mon, 13 May 2024 21:12:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715627578;
	bh=eqtoVBkU4FBWu8XrGrpOTbs9HCWIm0hRzblZ3gj3wWE=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=c7tcOgfgz+HKqD4WXEAWaZWMSEk6lFimk/GcowyQn107UeZnj566SFoXCtjoYvCcY
	 Jm4dKqwiH2vIq2063xQJxvF9zRbDgUAuaRv87w638jNh0M1yAieBphsJOi5qsJ1drL
	 0ZiowWCahtZ0PsFH8LUakkJJX4VlWAk484qDs2wEPTpMO4qgT7PbPEw1DXQADMZv5e
	 rqwMGIEQ2JFspqDfAxtWgbrCD9lS+YCW8WoJlj9S0tADgdLTnkG6pZNuu4XCJ3GciS
	 2I99qMJ0/n89Wd1PuCEAWjmsuWNoWOmwjacp/w4Q/BcnAnH+PAjhBNNLfClMwI4Rez
	 vQGpHZdNk+qbQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Mon, 13 May 2024 21:12:58 +0200
X-ME-IP: 86.243.17.157
Message-ID: <205163e0-e2bd-4ed9-9f51-e20468f77655@wanadoo.fr>
Date: Mon, 13 May 2024 21:12:55 +0200
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] iio: chemical: add driver for ENS160 sensor
To: Gustavo Silva <gustavograzs@gmail.com>, jic23@kernel.org
Cc: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 lars@metafoo.de, gerald.loacker@wolfvision.net, devicetree@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240512210444.30824-1-gustavograzs@gmail.com>
 <20240512210444.30824-4-gustavograzs@gmail.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20240512210444.30824-4-gustavograzs@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 12/05/2024 à 23:04, Gustavo Silva a écrit :
> ScioSense ENS160 is a digital metal oxide multi-gas sensor, designed
> for indoor air quality monitoring. The driver supports readings of
> CO2 and VOC, and can be accessed via both SPI and I2C.
> 
> Signed-off-by: Gustavo Silva <gustavograzs-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> ---

Hi,
a few comments below, for what it worth.

BTW, why I'm in copy of the mail?
I'm not a maintainer, and not active on drivers/iio/chemical/
Slightly proud, but curious as well.

...

> +#define ENS160_REG_TEMP_IN		0x13
> +#define ENS160_REG_RH_IN		0x15
> +#define ENS160_REG_DEVICE_STATUS	0x20

If defining everything, maybe:
#define ENS160_REG_DATA_AQI	0x21

> +#define ENS160_REG_DATA_TVOC		0x22
> +#define ENS160_REG_DATA_ECO2		0x24
> +#define ENS160_REG_DATA_T		0x30
> +#define ENS160_REG_DATA_RH		0x32
> +#define ENS160_REG_GPR_READ4		0x4C

...

> +static int ens160_chip_init(struct ens160_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	u8 fw_version[3];
> +	__le16 part_id;
> +	unsigned int status;
> +	int ret;
> +
> +	ret = ens160_set_mode(data, ENS160_REG_MODE_RESET);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_read(data->regmap, ENS160_REG_PART_ID, &part_id,
> +			       sizeof(part_id));
> +	if (ret)
> +		return ret;
> +
> +	if (le16_to_cpu(part_id) != ENS160_PART_ID)
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
> +	msleep(ENS160_BOOTING_TIME_MS);
> +
> +	ret = regmap_bulk_read(data->regmap, ENS160_REG_GPR_READ4,
> +			       fw_version, sizeof(fw_version));
> +	if (ret)
> +		return ret;
> +
> +	msleep(ENS160_BOOTING_TIME_MS);
> +
> +	dev_info(dev, "firmware version: %u.%u.%u\n", fw_version[2],
> +		 fw_version[1], fw_version[0]);
> +
> +	ret = ens160_set_mode(data, ENS160_REG_MODE_STANDARD);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(data->regmap, ENS160_REG_DEVICE_STATUS, &status);
> +	if (ret)
> +		return ret;
> +
> +	if (FIELD_GET(ENS160_STATUS_VALIDITY_FLAG, status)
> +	    != ENS160_STATUS_NORMAL)
> +		return -EINVAL;

Just wondering how it works with the Warm-up and initial Start-up times.
If the probe is executed and the corresponding duration has not elpased, 
then the probe fails.

Is it what is expected?

> +
> +	return 0;
> +}
> +
> +static const struct iio_info ens160_info = {
> +	.read_raw = ens160_read_raw,
> +};
> +
> +int ens160_core_probe(struct device *dev, struct regmap *regmap,
> +		      const char *name)
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
> +	dev_set_drvdata(dev, indio_dev);
> +	data->regmap = regmap;
> +
> +	indio_dev->name = name;
> +	indio_dev->info = &ens160_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ens160_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ens160_channels);
> +
> +	ret = ens160_chip_init(data);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "chip initialization failed\n");

Nitpick: return dev_err_probe()

> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

...

> +static int ens160_i2c_probe(struct i2c_client *client)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i2c(client, &ens160_regmap_i2c_conf);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&client->dev, "Failed to register i2c regmap %ld\n",
> +			PTR_ERR(regmap));

Nitpick: dev_err_probe()

> +		return PTR_ERR(regmap);
> +	}

...

> +static int ens160_spi_probe(struct spi_device *spi)
> +{
> +	struct regmap *regmap;
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +
> +	regmap = devm_regmap_init_spi(spi, &ens160_regmap_spi_conf);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Failed to register spi regmap: %pe\n",
> +			regmap);

Nitpick: dev_err_probe()

CJ

> +		return PTR_ERR(regmap);
> +	}
> +
> +	return ens160_core_probe(&spi->dev, regmap, id->name);
> +}



