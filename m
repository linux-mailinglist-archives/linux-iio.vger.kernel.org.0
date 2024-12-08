Return-Path: <linux-iio+bounces-13236-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B3B9E8705
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AD92814A0
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 17:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE0611662EF;
	Sun,  8 Dec 2024 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jYt4e97a"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCDE145324;
	Sun,  8 Dec 2024 17:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733678569; cv=none; b=elRBelxZCW4+1KS7983+n1tuVwTXooQhw5KpM788VKsDDlBmktOKqw6F+ZSa7u+DpN7cWP+S2fm8Jro8jzqbT+5kQxwnsW5TMW/w94/ygKuNGdZ8RzDVFLAf018CtzfOSw414gXCkS1bEQL7Vjle08bJvwmTOg81ZxheR6N9ewk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733678569; c=relaxed/simple;
	bh=CnFzzpu/t2T7ISYlDidZoBSSn6jeFN2Utrep7B+tRzo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gKj92LzMVLIqi406ZzqXHQMhj8AROqtA2/+Xn0PGAs2YaWY6k0iXG+R50q2drHwczQPht8x8jbMA+Niwexb7tldZu+GTKwxKymaTHuBZ/RgcgHKyJetbQkt4Npjjp6EoN/NUhUq0jEbEe3/IQM2n0soHy8w5UWjL1VzQKOxfYrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jYt4e97a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8476C4CED2;
	Sun,  8 Dec 2024 17:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733678569;
	bh=CnFzzpu/t2T7ISYlDidZoBSSn6jeFN2Utrep7B+tRzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jYt4e97aZhp8uhaJI0bJ4bqU//5L97mLWWacgXBbkWexcLA3XQoIfIFTakx9/XxsN
	 76e3M3KLDGhDV9MMwHpY/ACOI8kT7G6Hi8KiK5AZd1WTfq6MxDU7gPKvpVRXzH0V6W
	 B8t5xTEB/FELMvAcsXb96x1uiYsn74PnG0ytRAF1PlnqVmA4qMLSV76ddnaftflcu/
	 JFlDonzNdSXBdJymUMUzHXhZZNKE+OLcvyju2j3TJPWl+p3Lnl/DIe4bO88keCG+F1
	 SrLYS1BdKlsaCwFzfv9Y+hRZc5sxBePyFgVAgSXZRDrkyYsMk0nrAXAsWr8KHW4HBc
	 VpShZ6Gqq+iKw==
Date: Sun, 8 Dec 2024 17:22:36 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Eason Yang <j2anfernee@gmail.com>
Cc: avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
 venture@google.com, yuenn@google.com, benjaminfair@google.com,
 lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com, javier.carrasco.cruz@gmail.com,
 andriy.shevchenko@linux.intel.com, marcelo.schmitt@analog.com,
 olivier.moysan@foss.st.com, mitrutzceclan@gmail.com, tgamblin@baylibre.com,
 matteomartelli3@gmail.com, alisadariana@gmail.com, gstols@baylibre.com,
 thomas.bonnefille@bootlin.com, ramona.nechita@analog.com,
 mike.looijmans@topic.nl, chanh@os.amperecomputing.com, KWLIU@nuvoton.com,
 yhyang2@nuvoton.com, openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add Nuvoton NCT720x ADC driver
Message-ID: <20241208172236.18441e64@jic23-huawei>
In-Reply-To: <20241203091540.3695650-3-j2anfernee@gmail.com>
References: <20241203091540.3695650-1-j2anfernee@gmail.com>
	<20241203091540.3695650-3-j2anfernee@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  3 Dec 2024 17:15:40 +0800
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
Hi Eason,

Given you have some good reviews already I only took a very quick glance
through.  A few things inline

Jonathan

> diff --git a/drivers/iio/adc/nct720x.c b/drivers/iio/adc/nct720x.c
> new file mode 100644
> index 000000000000..b28b5f4d7d70
> --- /dev/null
> +++ b/drivers/iio/adc/nct720x.c

> +
> +static int nct720x_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int val, int val2)
> +{
> +	struct nct720x_chip_info *chip = iio_priv(indio_dev);
> +	int index, err = 0;
> +	long v1, v2, volt;
> +
> +	index = nct720x_chan_to_index[chan->address];
> +	volt = (val * NCT720X_IN_SCALING_FACTOR) / NCT720X_IN_SCALING;
> +	v1 = volt >> 5;
> +	v2 = (volt & REG_VIN_LIMIT_LSB_MASK) << 3;
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	if (info == IIO_EV_INFO_VALUE) {
> +		if (dir == IIO_EV_DIR_FALLING) {
> +			guard(mutex)(&chip->access_lock);

Might as well move this up one level as it is called in both legs.

> +			err = regmap_write(chip->regmap, REG_VIN_LOW_LIMIT[index], v1);
> +			if (err < 0)
> +				dev_err(&indio_dev->dev, "Failed to write REG_VIN%d_LOW_LIMIT\n",
> +					index + 1);
> +
> +			err = regmap_write(chip->regmap, REG_VIN_LOW_LIMIT_LSB[index], v2);
> +			if (err < 0)
> +				dev_err(&indio_dev->dev, "Failed to write REG_VIN%d_LOW_LIMIT_LSB\n",
> +					index + 1);
> +
> +		} else {
> +			guard(mutex)(&chip->access_lock);
> +			err = regmap_write(chip->regmap, REG_VIN_HIGH_LIMIT[index], v1);
> +			if (err < 0)
> +				dev_err(&indio_dev->dev, "Failed to write REG_VIN%d_HIGH_LIMIT\n",
> +					index + 1);
> +
> +			err = regmap_write(chip->regmap, REG_VIN_HIGH_LIMIT_LSB[index], v2);
> +			if (err < 0)
> +				dev_err(&indio_dev->dev, "Failed to write REG_VIN%d_HIGH_LIMIT_LSB\n",
> +					index + 1);
> +		}
> +	}
> +	return err;
> +}

> +
> +static const struct iio_info nct720x_info = {
> +	.read_raw = nct720x_read_raw,
> +	.read_event_config = nct720x_read_event_config,
> +	.write_event_config = nct720x_write_event_config,
> +	.read_event_value = nct720x_read_event_value,
> +	.write_event_value = nct720x_write_event_value,

Given you are supporting with and without interrupts, should probably pick between
versions of this that have the event config part and one that doesn't.

> +};
> +
> +static const struct nct720x_adc_model_data nct7201_model_data = {
> +	.model_name = "nct7201",
> +	.channels = nct7201_channels,
> +	.num_channels = ARRAY_SIZE(nct7201_channels),
> +	.vin_max = 8,
> +};
> +
> +static const struct nct720x_adc_model_data nct7202_model_data = {
> +	.model_name = "nct7202",
> +	.channels = nct7202_channels,
> +	.num_channels = ARRAY_SIZE(nct7202_channels),
> +	.vin_max = 12,
> +};
> +
> +static int nct720x_init_chip(struct nct720x_chip_info *chip)
> +{
> +	u8 data[2];
> +	unsigned int value;
> +	int err;
> +
> +	err = regmap_write(chip->regmap, REG_CONFIGURATION, BIT_CONFIGURATION_RESET);
> +	if (err) {
> +		dev_err(&chip->client->dev, "Failed to write REG_CONFIGURATION\n");
> +		return err;
> +	}
> +
> +	/*
> +	 * After about 25 msecs, the device should be ready and then
> +	 * the Power Up bit will be set to 1. If not, wait for it.
> +	 */
> +	mdelay(25);
> +	err  = regmap_read(chip->regmap, REG_BUSY_STATUS, &value);
> +	if (err < 0)
> +		return err;
> +	if (!(value & BIT_PWR_UP))
> +		return err;
> +
> +	/* Enable Channel */
> +	err = regmap_write(chip->regmap, REG_CHANNEL_ENABLE_1, REG_CHANNEL_ENABLE_1_MASK);
> +	if (err) {
> +		dev_err(&chip->client->dev, "Failed to write REG_CHANNEL_ENABLE_1\n");
> +		return err;
> +	}
> +
> +	if (chip->vin_max == 12) {
> +		err = regmap_write(chip->regmap, REG_CHANNEL_ENABLE_2, REG_CHANNEL_ENABLE_2_MASK);
> +		if (err) {
> +			dev_err(&chip->client->dev, "Failed to write REG_CHANNEL_ENABLE_2\n");
> +			return err;
> +		}
> +	}
> +
> +	guard(mutex)(&chip->access_lock);
> +	err  = regmap_read(chip->regmap, REG_CHANNEL_ENABLE_1, &value);
> +	if (err < 0)
> +		return err;
> +	data[0] = (u8)value;
> +
> +	err  = regmap_read(chip->regmap, REG_CHANNEL_ENABLE_2, &value);
> +	if (err < 0)
> +		return err;

Here I think you can use a bulk read as the registers are next to each other.

> +	data[1] = (u8)value;
> +
> +	value = get_unaligned_le16(data);
> +	chip->vin_mask = value;
> +
> +	/* Start monitoring if needed */
> +	err = regmap_read(chip->regmap, REG_CONFIGURATION, &value);
> +	if (err < 0) {
> +		dev_err(&chip->client->dev, "Failed to read REG_CONFIGURATION\n");
> +		return value;
> +	}
> +
> +	value |= BIT_CONFIGURATION_START;
> +	err = regmap_write(chip->regmap, REG_CONFIGURATION, value);
> +	if (err < 0) {
> +		dev_err(&chip->client->dev, "Failed to write REG_CONFIGURATION\n");
> +		return err;
> +	}
> +
> +	return 0;
> +}

