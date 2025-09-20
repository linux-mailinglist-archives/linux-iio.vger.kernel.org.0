Return-Path: <linux-iio+bounces-24321-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 89811B8C71B
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 13:52:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7C5684E02CF
	for <lists+linux-iio@lfdr.de>; Sat, 20 Sep 2025 11:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBE12FC86F;
	Sat, 20 Sep 2025 11:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OgYrmYl9"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452B129E113;
	Sat, 20 Sep 2025 11:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758369114; cv=none; b=Kl7KIEEtwoGBBKbZ6OOfhgKCXQaIxgR0VGtyWp6qON7iC0joz/Ql5oATISsmkkIBbjKQq6M2amM/9QruHUVMwOdGhHQkeU7DSDgu5UOMge/4mZcZbVjcV+jMmoIybF6TytQ3KoBzVQ/kFDTqVhua3G/vE+7GMIq7tTUYJi1sZWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758369114; c=relaxed/simple;
	bh=hUee2pS6Df9fsDCtpOZFTHszvbdqBMvpIkIaknF0zP0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tuFtK9RTDCZclaHGmjLbFTfSmZ3eALINLjr9vLKh9Gu/YAH8Feys90S/1CnPaAurXEC4/0vM1oak7OcZPm3GYvmokWtdiIU9IuA/XnYqHmJcW/X05bimHMhFWC38BoMMYZBhcQSXaS3PWHu8681zOig9H5JBRa8dwAUxNEI+tok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OgYrmYl9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC2ACC4CEF7;
	Sat, 20 Sep 2025 11:51:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758369113;
	bh=hUee2pS6Df9fsDCtpOZFTHszvbdqBMvpIkIaknF0zP0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=OgYrmYl9tcNtI+afWjkFtnK5yVV1BZoh+jed5TV4vKLFecFmABX8u4tL72cQx5cbr
	 LwfakGIAyS2r7akz2v9brZ/NpHJSZXZrVqmigrEbPcRMAl/E5YEw0LeF1iCTx1k6lg
	 Yo2eSSAlH1KdrDSwV5GmkqYuK6wUFiboSg78c+aw/japlEyP6U0WPakxPFk5Bbjcv7
	 Ob4K3o2CpCGo5lP92zNDJwXZbJ+P0SEanJNUvgInrkuIAkClmiRg10ycCsnlScu9UA
	 qoZmFN1sBMN5qQyPGnqMuD9TRSfbjDfabRepq/I/4lpsHYaw7wWhJZp47M9RMx+23C
	 VS3P4aDnZqLoA==
Date: Sat, 20 Sep 2025 12:51:44 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marius Cristea <marius.cristea@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, "Andy Shevchenko" <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: temperature: add support for EMC1812
Message-ID: <20250920125144.41f70a1f@jic23-huawei>
In-Reply-To: <20250917-iio-emc1812-v1-2-0b1f74cea7ab@microchip.com>
References: <20250917-iio-emc1812-v1-0-0b1f74cea7ab@microchip.com>
	<20250917-iio-emc1812-v1-2-0b1f74cea7ab@microchip.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 17 Sep 2025 15:21:58 +0300
Marius Cristea <marius.cristea@microchip.com> wrote:

> This is the iio driver for Microchip EMC1812/13/14/15/33
> Multichannel Low-Voltage Remote Diode Sensor Family.
>=20
> Signed-off-by: Marius Cristea <marius.cristea@microchip.com>

A few minor comments inline,

Thanks,

Jonathan

> diff --git a/drivers/iio/temperature/emc1812.c b/drivers/iio/temperature/=
emc1812.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..b1f567b222026a7138e9c29d7=
39d0240f4dc726f
> --- /dev/null
> +++ b/drivers/iio/temperature/emc1812.c
> @@ -0,0 +1,792 @@


> +
> +static int emc1812_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct emc1812_priv *priv =3D iio_priv(indio_dev);
> +	unsigned int i;
> +	int ret;
> +
> +	guard(mutex)(&priv->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		for (i =3D 0; i < ARRAY_SIZE(emc1812_freq); i++)
> +			if (val =3D=3D emc1812_freq[i][0] && val2 =3D=3D emc1812_freq[i][1])
> +				break;
> +
> +		if (i =3D=3D ARRAY_SIZE(emc1812_freq))
> +			return -EINVAL;
> +
> +		ret =3D regmap_write(priv->regmap, EMC1812_CONV_ADDR, i);
> +		if (ret)
> +			return ret;
> +
> +		priv->freq_idx =3D i;
> +		break;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +		for (i =3D 0; i < ARRAY_SIZE(emc1812_3db_values_map_tbl[priv->freq_idx=
]); i++)
> +			if (val =3D=3D emc1812_3db_values_map_tbl[priv->freq_idx][i][0] &&
> +			    val2 =3D=3D emc1812_3db_values_map_tbl[priv->freq_idx][i][1])
> +				break;
> +
> +		if (i =3D=3D ARRAY_SIZE(emc1812_3db_values_map_tbl[priv->freq_idx]))
> +			return -EINVAL;
> +
> +		/*
> +		 * In emc1812_3db_values_map_tbl the second index maps:
> +		 * 0 for filter off
> +		 * 1 for filter at level 1
> +		 * 2 for filter at level 2
> +		 */
> +		if (i =3D=3D 2)
> +			i =3D 3;
> +
> +		ret =3D regmap_write(priv->regmap, EMC1812_FILTER_SEL_ADDR, i);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
Prefer early returns above so that a reader can quickly see where a particu=
lar
code path goes without needing to scroll down here to see there is nothing =
else
to do.

> +}

> +static int emc1812_init(struct emc1812_priv *priv)
> +{
> +	unsigned int i;
> +	int ret;
> +	u8 val;
> +
> +	/*
> +	 * Depending on the chip, lock channel beta 1 and/or 2 to Diode Mode
> +	 * when APDD is enabled.
> +	 */
> +	if (priv->chip->lock_beta1 && priv->apdd_en)
> +		priv->beta_values[0] =3D 0x0F;
> +	if (priv->chip->lock_beta2 && priv->apdd_en)
> +		priv->beta_values[1] =3D 0x0F;
> +
> +	/*
> +	 * Set default values in registers. APDD, RECD12 and RECD34 are active
> +	 * on 0.
> +	 * Set the device to be in Run (Active) state and converting on all
> +	 * channels.
> +	 * The temperature measurement range is -64=C2=B0C to +191.875=C2=B0C.
> +	 */
> +	val =3D FIELD_PREP(EMC1812_CFG_MSKAL, 1) |
> +	      FIELD_PREP(EMC1812_CFG_RS, 0) |
> +	      FIELD_PREP(EMC1812_CFG_ATTHM, 1) |
> +	      FIELD_PREP(EMC1812_CFG_RECD12, !priv->recd12_en) |
> +	      FIELD_PREP(EMC1812_CFG_RECD34, !priv->recd34_en) |
> +	      FIELD_PREP(EMC1812_CFG_RANGE, 1) |
> +	      FIELD_PREP(EMC1812_CFG_DA_ENA, 0) |
> +	      FIELD_PREP(EMC1812_CFG_APDD, !priv->apdd_en);
> +
> +	ret =3D regmap_write(priv->regmap, EMC1812_CFG_ADDR, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Default is 4 conversions/seconds */
/second

Odd that is the value 6.  Maybe this needs a define?
> +	ret =3D regmap_write(priv->regmap, EMC1812_CONV_ADDR, 6);
> +	if (ret)
> +		return ret;
> +	priv->freq_idx =3D 6;
> +
> +	ret =3D regmap_write(priv->regmap, EMC1812_THRM_HYS_ADDR, 0x0A);

These values are all rather non obvious.  So add a comment or where possible
defines to explain the values being set.

> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(priv->regmap, EMC1812_CONSEC_ALERT_ADDR, 0x70);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(priv->regmap, EMC1812_FILTER_SEL_ADDR, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(priv->regmap, EMC1812_HOTTEST_CFG_ADDR, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Set beta1 and beta2 compensation parameters */
> +	for (i =3D 0; i < ARRAY_SIZE(priv->beta_values); i++) {
> +		ret =3D regmap_write(priv->regmap, EMC1812_BETA_CFG_ADDR(i),
> +				   priv->beta_values[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Set ideality factor for all external channels */
> +	ret =3D regmap_write(priv->regmap, EMC1812_EXT1_IDEALITY_FACTOR_ADDR,

Perhaps a look up table for the registers and a loop?


> +			   priv->ideality_value[0]);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(priv->regmap, EMC1812_EXT2_IDEALITY_FACTOR_ADDR,
> +			   priv->ideality_value[1]);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(priv->regmap, EMC1812_EXT3_IDEALITY_FACTOR_ADDR,
> +			   priv->ideality_value[2]);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(priv->regmap, EMC1812_EXT4_IDEALITY_FACTOR_ADDR,
> +			   priv->ideality_value[3]);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
return regmap_write()

> +}
> +
> +static int emc1812_parse_fw_config(struct emc1812_priv *priv, struct dev=
ice *dev,
> +				   int device_nr_channels)
> +{
> +	unsigned int reg_nr, iio_idx, tmp;
> +	int ret;
> +
> +	priv->apdd_en =3D device_property_read_bool(dev, "microchip,enable-anti=
-parallel");
> +	priv->recd12_en =3D device_property_read_bool(dev, "microchip,parasitic=
-res-on-channel1-2");
> +	priv->recd34_en =3D device_property_read_bool(dev, "microchip,parasitic=
-res-on-channel3-4");
> +
> +	memset32(priv->beta_values, 16, ARRAY_SIZE(priv->beta_values));

I would just set the two separately. This optimisation would make sense if =
there were a lot
more entries, but not worth making things harder to read when it is only tw=
o values,
particularly when the type isn't a specific size int.

> +	device_property_read_u32(dev, "microchip,beta1", &priv->beta_values[0]);
> +	device_property_read_u32(dev, "microchip,beta2", &priv->beta_values[1]);
> +	if (priv->beta_values[0] > 16 || priv->beta_values[1] > 16)
> +		return dev_err_probe(dev, -EINVAL, "Invalid beta value\n");
> +
> +	priv->num_channels =3D device_get_child_node_count(dev) + 1;
> +
> +	if (priv->num_channels > priv->chip->phys_channels)
> +		return dev_err_probe(dev, -E2BIG, "More channels than the chip support=
s\n");
> +
> +	priv->iio_chan[0] =3D EMC1812_CHAN(0, 0, EMC1812_CH_ADDR(0));
> +

I would remove this blank line to keep the association between the channel =
and it's label
tighter. That avoids the need for an explanatory comment on what this first=
 channel is.

I'll note this code is very similar to what I commented on earlier in Victo=
rs driver so
take a look at that and see if I failed to notice anything here I picked up=
 on in that review.

> +	priv->labels[0] =3D "internal_diode";
> +	iio_idx =3D 1;
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret =3D fwnode_property_read_u32(child, "reg", &reg_nr);
> +		if (ret || reg_nr >=3D priv->chip->phys_channels)
> +			return dev_err_probe(dev, -EINVAL,
> +				     "The index of the channels does not match the chip\n");
> +
> +		ret =3D fwnode_property_read_u32(child, "microchip,ideality-factor", &=
tmp);
> +		if (ret =3D=3D 0) {
> +			if (tmp < 8  || tmp > 63)
> +				return dev_err_probe(dev, ret, "Invalid ideality value\n");
> +			priv->ideality_value[reg_nr - 1] =3D tmp;
> +		} else {
> +			priv->ideality_value[reg_nr - 1] =3D 18;
> +		}
> +
> +		fwnode_property_read_string(child, "label", &priv->labels[reg_nr]);
> +
> +		priv->iio_chan[iio_idx++] =3D EMC1812_CHAN(reg_nr, reg_nr, EMC1812_CH_=
ADDR(reg_nr));
> +	}
> +
> +	return 0;
> +}
> +
> +static int emc1812_chip_identify(struct emc1812_priv *priv, struct i2c_c=
lient *client)
> +{
> +	int ret, tmp;
> +
> +	ret =3D regmap_read(priv->regmap, EMC1812_PRODUCT_ID_ADDR, &tmp);
> +	if (ret)
> +		return ret;
> +
> +	switch (tmp) {
> +	case EMC1812_PID:
> +		priv->chip =3D &emc1812_chip_config;
> +		break;

When there is nothing else to do, I'm a big fan of early returns that
immediately let the reader know we are done.

> +	case EMC1813_PID:
> +		priv->chip =3D &emc1813_chip_config;
> +		break;
> +	case EMC1814_PID:
> +		priv->chip =3D &emc1814_chip_config;
> +		break;
> +	case EMC1815_PID:
> +		priv->chip =3D &emc1815_chip_config;
> +		break;
> +	case EMC1833_PID:
> +		priv->chip =3D &emc1833_chip_config;
> +		break;
> +	default:
> +		/*
> +		 * If failed to identify the hardware based on internal registers,
> +		 * try using fallback compatible in device tree to deal with some
> +		 * newer part number.
> +		 */
> +		priv->chip =3D i2c_get_match_data(client);
> +		if (!priv->chip)
> +			return -EINVAL;
> +		break;
> +	}
> +	return 0;
> +}
> +
> +static int emc1812_probe(struct i2c_client *client)
> +{
> +	struct device *dev =3D &client->dev;
> +	struct emc1812_priv *priv;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv =3D iio_priv(indio_dev);
> +	priv->regmap =3D devm_regmap_init_i2c(client, &emc1812_regmap_config);
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "Cannot initialize register map\n");
> +
> +	ret =3D devm_mutex_init(dev, &priv->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D emc1812_chip_identify(priv, client);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Chip identification fails\n");
> +
> +	dev_info(dev, "Device name: %s\n", priv->chip->name);

Too noisy. dev_dbg() at most, probably just drop it entirely as these are e=
asy
to query if the driver probes successfully.=20

> +
> +	ret =3D emc1812_parse_fw_config(priv, dev, priv->chip->phys_channels);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D emc1812_init(priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Cannot initialize device\n");
> +
> +	indio_dev->name =3D priv->chip->name;
> +	indio_dev->info =3D &emc1812_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D &priv->iio_chan[0];

Given it's a pointer to an array to me using priv->iio_chan seems more
logical.

> +	indio_dev->num_channels =3D priv->num_channels;
> +
> +	ret =3D devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Cannot register IIO device\n");
> +
> +	return 0;
> +}

> +static const struct of_device_id emc1812_of_match[] =3D {
> +	{
> +		.compatible =3D "microchip,emc1812",
> +		.data =3D &emc1812_chip_config
> +	},
> +	{
> +		.compatible =3D "microchip,emc1813",
> +		.data =3D &emc1813_chip_config
> +	},
> +	{
> +		.compatible =3D "microchip,emc1814",
> +		.data =3D &emc1814_chip_config
> +	},
> +	{
> +		.compatible =3D "microchip,emc1815",
> +		.data =3D &emc1815_chip_config
> +	},
> +	{
> +		.compatible =3D "microchip,emc1833",
> +		.data =3D &emc1833_chip_config

Trailing commas needed for these.  Reduces churn if we want
to set other fields in future.

> +	},
> +	{ }
> +};



