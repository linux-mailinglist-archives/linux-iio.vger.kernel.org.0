Return-Path: <linux-iio+bounces-364-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E60937F8CF6
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 19:06:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6008BB2107A
	for <lists+linux-iio@lfdr.de>; Sat, 25 Nov 2023 18:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26C092D78D;
	Sat, 25 Nov 2023 18:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PqtyaPAk"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9B923DB;
	Sat, 25 Nov 2023 18:06:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F86BC433C7;
	Sat, 25 Nov 2023 18:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700935601;
	bh=2mqDBd/8TiifGjoo0dqWg0EWWNxd6WuCAOk85z9NRvY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PqtyaPAkDxYpd6WhEyojObVwffExmJFfl5wbfM8apViabQv8DS0zPJUXqMOSRVimI
	 gYSIwknQ50Vj3pct1jQNDDr3bDq0IaXqZbwd20X1+6+FeVCSro2zITfgzE6bFK1RU8
	 1UDbafK6CNxOTKVRhthrEAmGdaIWF3ssGrCAocFvAK9tIIrZAHl4LkmRq5EbeWfp1n
	 qdPFZSmhpXsndGbGDvaAaAPIaiqUIXhthkMSQIvvbJXL4m5YmnjC812Jr0C/4hgo3U
	 h65sDasRhnOgKIP6UPSXq2Dp6qdDRL1mP47E8FNcmtkRq04DBLUhWwQXMaJDXyYkQ9
	 FgHyH6FR/87ZQ==
Date: Sat, 25 Nov 2023 18:06:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: linux-iio@vger.kernel.org, Alexander Stein
 <alexander.stein@ew.tq-group.com>, Andre Werner
 <andre.werner@systec-electronic.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Conor Dooley <conor+dt@kernel.org>, Fabio Estevam <festevam@denx.de>,
 Guenter Roeck <linux@roeck-us.net>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Mark Brown <broonie@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>, Naresh Solanki
 <naresh.solanki@9elements.com>, Patrick Rudolph
 <patrick.rudolph@9elements.com>, Rob Herring <robh+dt@kernel.org>, Stefan
 Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>, Vincent Tremblay
 <vincent@vtremblay.dev>, devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: light: isl76682: Add ISL76682 driver
Message-ID: <20231125180631.0dadc926@jic23-huawei>
In-Reply-To: <20231121031043.327614-2-marex@denx.de>
References: <20231121031043.327614-1-marex@denx.de>
	<20231121031043.327614-2-marex@denx.de>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 21 Nov 2023 04:10:40 +0100
Marek Vasut <marex@denx.de> wrote:

> The ISL76682 is very basic ALS which only supports ALS or IR mode
> in four ranges, 1k/4k/16k/64k LUX. There is no IRQ support or any
> other fancy functionality.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
Nice little driver.

A few comments inline.

Thanks,

Jonathan

> diff --git a/drivers/iio/light/isl76682.c b/drivers/iio/light/isl76682.c
> new file mode 100644
> index 0000000000000..7f0ccd0d37539
> --- /dev/null
> +++ b/drivers/iio/light/isl76682.c
> @@ -0,0 +1,364 @@


> +
> +static int isl76682_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct isl76682_chip *chip = iio_priv(indio_dev);
> +	int ret;
> +	int i;
> +
> +	if (chan->type != IIO_LIGHT && chan->type != IIO_INTENSITY)
> +		return -EINVAL;
> +
> +	guard(mutex)(&chip->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->type) {
> +		case IIO_LIGHT:
> +			ret = isl76682_get(chip, false, val);
> +			return (ret < 0) ? ret : IIO_VAL_INT;
> +		case IIO_INTENSITY:
> +			ret = isl76682_get(chip, true, val);
> +			return (ret < 0) ? ret : IIO_VAL_INT;
> +		default:
> +			break;
return here and drop the one below.

> +		}
> +
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_SCALE:
> +		for (i = 0; i < ARRAY_SIZE(isl76682_range_table); i++) {
> +			if (chip->range != isl76682_range_table[i].range)
> +				continue;
> +
> +			*val = 0;
> +			switch (chan->type) {
> +			case IIO_LIGHT:
> +				*val2 = isl76682_range_table[i].als;
> +				return IIO_VAL_INT_PLUS_MICRO;
> +			case IIO_INTENSITY:
> +				*val2 = isl76682_range_table[i].ir;
> +				return IIO_VAL_INT_PLUS_MICRO;
> +			default:
> +				return -EINVAL;
> +			}
> +		}
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_INT_TIME:
> +		*val = 0;
> +		*val2 = ISL76682_INT_TIME_US;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static int isl76682_probe(struct i2c_client *client)
> +{
> +	const struct i2c_device_id *id = i2c_client_get_device_id(client);

For reason below, we should avoid accessing this directly.
If you need the associated data later, then use the access functions that
try the property.h accessors first and fallback to this only if this fails.
That ends up much less fragile.

> +	struct device *dev = &client->dev;
> +	struct isl76682_chip *chip;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	chip = iio_priv(indio_dev);
> +
> +	mutex_init(&chip->lock);
> +
> +	chip->regmap = devm_regmap_init_i2c(client, &isl76682_regmap_config);
> +	ret = PTR_ERR_OR_ZERO(chip->regmap);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Error initializing regmap\n");
> +
> +	chip->range = ISL76682_COMMAND_RANGE_LUX_1K;
> +
> +	ret = isl76682_clear_configure_reg(chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, isl76682_reset_action, chip);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info = &isl76682_info;
> +	indio_dev->channels = isl76682_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(isl76682_channels);
> +	indio_dev->name = id->name;

This tends to be fragile as drivers gain more entrees in the id and of table.
So the name should always be retrieved from a chip_info structure.
Given you don't need one of those yet, I'd prefer just having the string here
directly. We've been bitten by this before so I get paranoid about it :)


> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}


