Return-Path: <linux-iio+bounces-15958-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67EE7A409C9
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 16:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00ABF19C6A3D
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 15:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BC71D86E6;
	Sat, 22 Feb 2025 15:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NfE3D0ul"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 596CE1CDA3F;
	Sat, 22 Feb 2025 15:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740239821; cv=none; b=BEIfIZ/GxVe/+c5W1xZZ5WGnFK2NlTOKyU4M82GFsUGsbSkYiZgVh3FtGeyUc3Z5A5g7vMUEB+pUFtHKbY96etSsfJVreVTaAo2ng3/B1YLm5g38qdHKLPEUPdSOSRbRILwqMEFYLSwGQP2dUra8c1daid3th/0WsdKddgoxAEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740239821; c=relaxed/simple;
	bh=X9W99eyKCCVl+jjs+X+HEG5aWdDTZJ6O9eeXlGZgHIo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b4Ru2QY5xWdlTG72pKeQhvAOo/ZpaETiNClVsfZwaEZu7gp2dj1SHqWLJoRT4xutjiztaP9YM0JldJJKOiUnHXevzx4bQTR5RjfkCXIX7eKmZMB+4vcju/tNChtGgbQVJcB54ZGiJkau5CYYjzEICrO9YZ0O5DmDopPuzUfUhOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NfE3D0ul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658E4C4CEE4;
	Sat, 22 Feb 2025 15:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740239820;
	bh=X9W99eyKCCVl+jjs+X+HEG5aWdDTZJ6O9eeXlGZgHIo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NfE3D0ullPSwME2gEhJw0c44jhYZs5BBr7UUwuqFk2V40WucOM3O482iEfGDtes49
	 a0C6QJFbP92YzLZYDav2t65AW34dqIT0nCD/48QXQXdbBnCLiyIl/OCUsx4Txsx231
	 rWPSvr9wSpFjmK9fE0gFS6cXEY0D8vzIGPBX6FmVBGyaHVfwN7Mh4J5p9Xbtk6BRWl
	 cJtxvxTBE6fdwX/+WTy4Fgg1jU3zCEZulclQ+Zr0Fzh6ihG95XM0hFEv9xuzNr7ug3
	 DInfASsVVhOYEoMxt3NVuaxGWpi+ghgE2BRBbKXfYxYUeCf5m6SBvjjGBHZFBDqLF/
	 qga1Nx127Iltw==
Date: Sat, 22 Feb 2025 15:56:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Eason Yang <j2anfernee@gmail.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
 venture@google.com, yuenn@google.com, benjaminfair@google.com,
 lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com, javier.carrasco.cruz@gmail.com,
 andriy.shevchenko@linux.intel.com, gstols@baylibre.com,
 olivier.moysan@foss.st.com, mitrutzceclan@gmail.com, tgamblin@baylibre.com,
 matteomartelli3@gmail.com, marcelo.schmitt@analog.com,
 alisadariana@gmail.com, joao.goncalves@toradex.com,
 thomas.bonnefille@bootlin.com, ramona.nechita@analog.com,
 herve.codina@bootlin.com, chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
 yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: adc: add support for Nuvoton NCT7201
Message-ID: <20250222155646.7fa6375a@jic23-huawei>
In-Reply-To: <20250221090918.1487689-3-j2anfernee@gmail.com>
References: <20250221090918.1487689-1-j2anfernee@gmail.com>
	<20250221090918.1487689-3-j2anfernee@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Feb 2025 17:09:18 +0800
Eason Yang <j2anfernee@gmail.com> wrote:

> Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> 
> NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up to
> 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins for
> independent alarm signals, and the all threshold values could be set for
> system protection without any timing delay. It also supports reset input
> RSTIN# to recover system from a fault condition.
> 
> Currently, only single-edge mode conversion and threshold events support.
> 
> Signed-off-by: Eason Yang <j2anfernee@gmail.com>
Hi Eason

A few comments from me. May well overlap in some places with other feedback.

Jonathan

> diff --git a/drivers/iio/adc/nct7201.c b/drivers/iio/adc/nct7201.c
> new file mode 100644
> index 000000000000..c5d1540bcc00
> --- /dev/null
> +++ b/drivers/iio/adc/nct7201.c
> @@ -0,0 +1,487 @@

> +
> +#define NCT7201_VOLTAGE_CHANNEL(chan, addr)				\
> +	{								\
> +		.type = IIO_VOLTAGE,					\
> +		.indexed = 1,						\
> +		.channel = chan,					\
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +		.address = addr,					\
> +		.event_spec = nct7201_events,				\
> +		.num_event_specs = ARRAY_SIZE(nct7201_events),		\
> +	}
> +
> +static const struct iio_chan_spec nct7201_channels[] = {
> +	NCT7201_VOLTAGE_CHANNEL(1, 0),
> +	NCT7201_VOLTAGE_CHANNEL(2, 1),
> +	NCT7201_VOLTAGE_CHANNEL(3, 2),
> +	NCT7201_VOLTAGE_CHANNEL(4, 3),
> +	NCT7201_VOLTAGE_CHANNEL(5, 4),
> +	NCT7201_VOLTAGE_CHANNEL(6, 5),
> +	NCT7201_VOLTAGE_CHANNEL(7, 6),
> +	NCT7201_VOLTAGE_CHANNEL(8, 7),
> +};
> +
> +static const struct iio_chan_spec nct7202_channels[] = {
> +	NCT7201_VOLTAGE_CHANNEL(1, 0),
> +	NCT7201_VOLTAGE_CHANNEL(2, 1),
> +	NCT7201_VOLTAGE_CHANNEL(3, 2),
> +	NCT7201_VOLTAGE_CHANNEL(4, 3),
> +	NCT7201_VOLTAGE_CHANNEL(5, 4),
> +	NCT7201_VOLTAGE_CHANNEL(6, 5),
> +	NCT7201_VOLTAGE_CHANNEL(7, 6),
> +	NCT7201_VOLTAGE_CHANNEL(8, 7),
> +	NCT7201_VOLTAGE_CHANNEL(9, 8),
> +	NCT7201_VOLTAGE_CHANNEL(10, 9),
> +	NCT7201_VOLTAGE_CHANNEL(11, 10),
> +	NCT7201_VOLTAGE_CHANNEL(12, 11),
We normally number channels from 0 which would simplify this but I don't really
mind if you want to keep the offset of 1.  Maybe just have one macro
parameter though and do the +1 in the macro.
> +};

> +static int nct7201_read_event_value(struct iio_dev *indio_dev,
> +				    const struct iio_chan_spec *chan,
> +				    enum iio_event_type type,
> +				    enum iio_event_direction dir,
> +				    enum iio_event_info info,
> +				    int *val, int *val2)
> +{
> +	struct nct7201_chip_info *chip = iio_priv(indio_dev);
> +	u16 volt;
> +	unsigned int value;
> +	int err;
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EINVAL;
> +
> +	if (dir == IIO_EV_DIR_FALLING) {
> +		err = regmap_read(chip->regmap16, NCT7201_REG_VIN_LOW_LIMIT(chan->address),
> +				  &value);
> +		if (err < 0)
> +			return err;
> +		volt = value;
> +	} else {
> +		err = regmap_read(chip->regmap16, NCT7201_REG_VIN_HIGH_LIMIT(chan->address),
> +				  &value);
> +		if (err < 0)
> +			return err;
> +		volt = value;
No real point in assigning to volt here, 
> +	}
> +
> +	*val = FIELD_GET(NCT7201_REG_VIN_MASK, volt);
> +
> +	return IIO_VAL_INT;
> +}
> +
> +static int nct7201_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int val, int val2)
> +{
> +	struct nct7201_chip_info *chip = iio_priv(indio_dev);
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EOPNOTSUPP;
> +
> +	if (dir == IIO_EV_DIR_FALLING)
> +		regmap_write(chip->regmap16, NCT7201_REG_VIN_LOW_LIMIT(chan->address),
> +			     FIELD_PREP(NCT7201_REG_VIN_MASK, val));
> +	else
> +		regmap_write(chip->regmap16, NCT7201_REG_VIN_HIGH_LIMIT(chan->address),
> +			     FIELD_PREP(NCT7201_REG_VIN_MASK, val));
Check for error returns.
> +
> +	return 0;
> +}
> +
> +static int nct7201_read_event_config(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir)
> +{
> +	struct nct7201_chip_info *chip = iio_priv(indio_dev);
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	return !!(chip->vin_mask & BIT(chan->address));
> +}
> +
> +static int nct7201_write_event_config(struct iio_dev *indio_dev,
> +				      const struct iio_chan_spec *chan,
> +				      enum iio_event_type type,
> +				      enum iio_event_direction dir,
> +				      bool state)
> +{
> +	struct nct7201_chip_info *chip = iio_priv(indio_dev);
> +	unsigned int mask;
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	mask = BIT(chan->address);
> +
> +	if (!state && (chip->vin_mask & mask))
> +		chip->vin_mask &= ~mask;
> +	else if (state && !(chip->vin_mask & mask))
> +		chip->vin_mask |= mask;
> +
> +	if (chip->num_vin_channels <= 8)
> +		regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1, chip->vin_mask);
> +	else
> +		regmap_bulk_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
> +				  &chip->vin_mask, sizeof(chip->vin_mask));

Check errors on these writes.

> +
> +	return 0;
> +}

> +static int nct7201_init_chip(struct nct7201_chip_info *chip)
> +{
> +	u8 data[2];
> +	unsigned int value;
> +	int err;
> +
> +	regmap_write(chip->regmap, NCT7201_REG_CONFIGURATION,
> +		     NCT7201_BIT_CONFIGURATION_RESET);

Check for errors on all accesses to the device.  It can get
fiddly in paths where you are already handling an error but
that's not the case here.

> +
> +	/*
> +	 * After about 25 msecs, the device should be ready and then
> +	 * the Power Up bit will be set to 1. If not, wait for it.

Wrap to 80 chars.

> +	 */
> +	mdelay(25);
> +	err = regmap_read(chip->regmap, NCT7201_REG_BUSY_STATUS, &value);
> +	if (err < 0)
> +		return err;
> +	if (!(value & NCT7201_BIT_PWR_UP))
> +		return dev_err_probe(&chip->client->dev, -EIO,
> +				     "Failed to power up after reset\n");
> +
> +	/* Enable Channel */
> +	if (chip->num_vin_channels <= 8) {
> +		data[0] = NCT7201_REG_CHANNEL_ENABLE_1_MASK;
> +		err = regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1, data[0]);
> +		if (err < 0)
> +			return dev_err_probe(&chip->client->dev, -EIO,
> +					     "Failed to write NCT7201_REG_CHANNEL_ENABLE_1\n");
> +	} else {
> +		data[0] = NCT7201_REG_CHANNEL_ENABLE_1_MASK;
> +		data[1] = NCT7201_REG_CHANNEL_ENABLE_2_MASK;
> +		err = regmap_bulk_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE_1,
> +					data, ARRAY_SIZE(data));
> +		if (err < 0)
> +			return dev_err_probe(&chip->client->dev, -EIO,
> +					    "Failed to write NCT7201_REG_CHANNEL_ENABLE_1 and NCT7201_REG_CHANNEL_ENABLE_2\n");
> +	}
> +
> +	value = get_unaligned_le16(data);
> +	chip->vin_mask = value;

Local variable doesn't seem to add any benefits so just assign vin_mask directly.

> +
> +	/* Start monitoring if needed */
> +	err = regmap_read(chip->regmap, NCT7201_REG_CONFIGURATION, &value);
> +	if (err < 0)
> +		return dev_err_probe(&chip->client->dev, -EIO,
> +				     "Failed to read NCT7201_REG_CONFIGURATION\n");
> +
> +	regmap_set_bits(chip->regmap, NCT7201_REG_CONFIGURATION, NCT7201_BIT_CONFIGURATION_START);
> +
> +	return 0;
> +}
> +
> +static int nct7201_probe(struct i2c_client *client)
> +{
> +	const struct nct7201_adc_model_data *model_data;
> +	struct nct7201_chip_info *chip;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	model_data = i2c_get_match_data(client);
> +	if (!model_data)
> +		return -EINVAL;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*chip));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +	chip = iio_priv(indio_dev);
> +
> +	chip->regmap = devm_regmap_init_i2c(client, &nct7201_regmap8_config);
> +	if (IS_ERR(chip->regmap))
> +		return dev_err_probe(&client->dev, PTR_ERR(chip->regmap),
> +			"Failed to init regmap\n");

Where it doesn't lead to really long lines, align all parameters to just
after the opening bracket.


> +
> +	chip->regmap16 = devm_regmap_init_i2c(client, &nct7201_regmap16_config);
> +	if (IS_ERR(chip->regmap16))
> +		return dev_err_probe(&client->dev, PTR_ERR(chip->regmap16),
> +			"Failed to init regmap16\n");
> +
> +	chip->num_vin_channels = model_data->num_vin_channels;
> +
> +	ret = devm_mutex_init(&client->dev, &chip->access_lock);
> +	if (ret)
> +		return ret;
> +
> +	chip->client = client;
> +
> +	ret = nct7201_init_chip(chip);
> +	if (ret < 0)
> +		return ret;
> +
> +	indio_dev->name = model_data->model_name;
> +	indio_dev->channels = model_data->channels;
> +	indio_dev->num_channels = model_data->num_channels;
> +	if (client->irq)
> +		indio_dev->info = &nct7201_info;
> +	else
> +		indio_dev->info = &nct7201_info_no_irq;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(&client->dev, indio_dev);
> +}



