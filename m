Return-Path: <linux-iio+bounces-5630-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386978D75AA
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 15:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32EC41C20E02
	for <lists+linux-iio@lfdr.de>; Sun,  2 Jun 2024 13:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4501D3CF7E;
	Sun,  2 Jun 2024 13:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unxCPKgf"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4083BBC1;
	Sun,  2 Jun 2024 13:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717334535; cv=none; b=YL+JyVlaZjjoMaUJ9UO0G2amu72VQrhJChaiVmXBfSoi+MCJ5E0SiMo3YTfVdD+HYYeEYsFfLp7uiVyLQ7gm6gALkOmWiiJqQWZA92cOS6cOryMzwI2bwgk95uEb5/tHXkA3vpiLsmAMsdbKk/0dK6IY824yBRSIO80SOCfFcoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717334535; c=relaxed/simple;
	bh=oHVVffAxvtAhXS+j6pB4u46B0FyQhzmWOd8cOg7DKMg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GQ87GQUbSBq0cIORf8dzP3C+SYUi6Sm91CKpUchtqFcDIhWpgNZ7VOHYwt1vGIbp+y+ZPjdltr6DmdbS6JrrP5948W8t/1csRE6voGJUwk+dMzyYcN6o8K3yr4uW/xwRk170ZvFECDPRNWAYcx6m73oehmWrKuc7F3J6GYXnDFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=unxCPKgf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAB6C4AF07;
	Sun,  2 Jun 2024 13:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717334534;
	bh=oHVVffAxvtAhXS+j6pB4u46B0FyQhzmWOd8cOg7DKMg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=unxCPKgfvztHyfT67Up2/ga6P4UCg4RDWOrhEyStu8nPEYuLZyn8a1eWHaCeJr0J4
	 ehC4AsmE6wYgb1t9JNk4DRZIIfxdgqB1npHLJqhTcrWNJrKfnnvNwQTieb5q20PFXN
	 OZmz+goOwpZBq5Mnm76b8BJIoAgr6S3ydN6f9t2H7zRa33F/o0mLZAPrTOoxk6nLPl
	 dU3Ql7ytKClLR/HyFiidXseT4diIkr/yN8UUp2JRYThEd/xM89jHtXZd9a5hgTRJdJ
	 nv/Kj5WvrTMaF5TxINb8G5/6Tq+Mrq7FYIqA6TjTx+txMG/y7yAjnU5awEw5cC9sM1
	 R7C+rvXCBHngA==
Date: Sun, 2 Jun 2024 14:22:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Arthur Becker via B4 Relay <devnull+arthur.becker.sentec.com@kernel.org>
Cc: arthur.becker@sentec.com, Lars-Peter Clausen <lars@metafoo.de>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] iio: light: driver for Vishay VEML6040
Message-ID: <20240602142205.520c2635@jic23-huawei>
In-Reply-To: <20240527-veml6040-v3-1-6f3bbfd42960@sentec.com>
References: <20240527-veml6040-v3-0-6f3bbfd42960@sentec.com>
	<20240527-veml6040-v3-1-6f3bbfd42960@sentec.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 May 2024 17:12:08 +0200
Arthur Becker via B4 Relay <devnull+arthur.becker.sentec.com@kernel.org> wrote:

> From: Arthur Becker <arthur.becker@sentec.com>
> 
> Implements driver for the Vishay VEML6040 rgbw light sensor.
> 
> Included functionality: setting the integration time and reading the raw
> values for the four channels
> 
> Not yet implemented: setting the measurements to 'Manual Force Mode' (Auto
> measurements off, and adding a measurement trigger)
> 
> Datasheet: https://www.vishay.com/docs/84276/veml6040.pdf
> Signed-off-by: Arthur Becker <arthur.becker@sentec.com>

Hi Arthur,

A few really trivial things inline. I'd have just tidied them up whilst
applying, but I think you are doing a v4 anyway to merge the bindings
so I'll leave the requested tweaks to you.

Jonathan


> diff --git a/drivers/iio/light/veml6040.c b/drivers/iio/light/veml6040.c
> new file mode 100644
> index 000000000000..2ea00d57c38b
> --- /dev/null
> +++ b/drivers/iio/light/veml6040.c



> +static int veml6040_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct veml6040_data *data;
> +	struct iio_dev *indio_dev;
> +	struct regmap *regmap;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return dev_err_probe(dev, -EOPNOTSUPP,
> +				     "I2C adapter doesn't support plain I2C\n");
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return dev_err_probe(dev, -ENOMEM,
> +				     "IIO device allocation failed\n");
> +
> +	regmap = devm_regmap_init_i2c(client, &veml6040_regmap_config);
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap),
> +				     "Regmap setup failed\n");
> +
> +	data = iio_priv(indio_dev);
> +	i2c_set_clientdata(client, indio_dev);

I don't think this is used. If it isn't, don't set it.

> +	data->client = client;
> +	data->regmap = regmap;
> +
> +	indio_dev->name = "veml6040";
> +	indio_dev->info = &veml6040_info;
> +	indio_dev->channels = veml6040_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(veml6040_channels);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return ret;
> +
> +	int init_config =

Generally we are still sticking to traditional C rules so keep the
local variable definition at the top of the file.
The only common exception is when cleanup.h functionality is involved and
we want to ensure ordering by moving the variable definitions into the code.

> +		FIELD_PREP(VEML6040_CONF_IT_MSK, VEML6040_CONF_IT_40_MS) |
> +		FIELD_PREP(VEML6040_CONF_AF_MSK, 0) |
> +		FIELD_PREP(VEML6040_CONF_SD_MSK, 0);
> +
> +	ret = regmap_write(regmap, VEML6040_CONF_REG, init_config);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Could not set initial config\n");
> +
> +	ret = devm_add_action_or_reset(dev, veml6040_shutdown_action, data);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

> +
> +static struct i2c_driver veml6040_driver = {
> +	.probe = veml6040_probe,
> +	.id_table = veml6040_id_table,
> +	.driver = {
> +		.name = "veml6040",
> +		.of_match_table = veml6040_of_match,
> +	},
> +};
> +

Trivial: Common practice is no new line here as the macro is
very tightly coupled to the structure.

> +module_i2c_driver(veml6040_driver);
> +
> +MODULE_DESCRIPTION("veml6040 RGBW light sensor driver");
> +MODULE_AUTHOR("Arthur Becker <arthur.becker@sentec.com>");
> +MODULE_LICENSE("GPL");
> 


