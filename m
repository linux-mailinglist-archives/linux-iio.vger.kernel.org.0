Return-Path: <linux-iio+bounces-19049-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24F68AA87F4
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 18:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E13AC1898D26
	for <lists+linux-iio@lfdr.de>; Sun,  4 May 2025 16:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C43451C860E;
	Sun,  4 May 2025 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLZukjEm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3FB10E9;
	Sun,  4 May 2025 16:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746375626; cv=none; b=DGQ1PwhT41AToMqJXBcGu98ru20mysHZ0fpJv64GH9BcqJhB81lpmNnn83E10Zwg/G0OroQFNmlqPT0etbPvun5/DTYQ16cz+uTpVVBro1nJ6USFb85CxP0pBM5C2Endo4Cl6dEzlQQiRCZhtM5LNLB4L5tWk+Gh5PMMkrJGdjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746375626; c=relaxed/simple;
	bh=xAwsdo+ocUhq1JajKyAqZo7xgX18UaJCVvE97QiZwZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GnZon9qDb3II85h352NlWi8IOMpNs6YhmS8TYfuCbfGSLshVfuFrfFx/tTVtdj45ihiS6MWdihEUwdrXgu92KoZRNebURiYn8fx50Bl5w+tfV/znCsa6N0AN1sWQTNqu2esJxjx4Tho4ND+CKokPZkNa4IjNxoVYRPce4Y4pFXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oLZukjEm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A754C4CEE7;
	Sun,  4 May 2025 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746375625;
	bh=xAwsdo+ocUhq1JajKyAqZo7xgX18UaJCVvE97QiZwZQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oLZukjEmExT0aJ63btVlVYX1SysM0GqH647MtRBZZDvpKLV/g81an8WG3Uj1Jwwa5
	 bKcJi4pVN0TJ8PYG0HPJkxFb9ukZ34BUggB/foNl0teyom2t8f//Pptzse5u5aZ+MO
	 JG9XUstWYRJxNUGguaf6CzjT11OB7kQyynDPS/PJv6OGe1RAAApjdv2CxihyNOt7pO
	 W+eM0JXHjS8ClTWJ5dneQsyGyLekDROUcGtyz5wXSgGAAoNI0AX0p3YfLxlnae3ddU
	 ok2n+BcvXkvnZIIKDGNFNTK/GWy23mghDKcuyHDWBZpQ8aneFejx2Hzz4w0WTiZGpU
	 gee43NuiYbWjw==
Date: Sun, 4 May 2025 17:20:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Sayyad Abid <sayyad.abid16@gmail.com>
Cc: linux-iio@vger.kernel.org, lars@metafoo.de, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, dlechner@baylibre.com,
 nuno.sa@analog.com, javier.carrasco.cruz@gmail.com,
 olivier.moysan@foss.st.com, gstols@baylibre.com, tgamblin@baylibre.com,
 alisadariana@gmail.com, eblanc@baylibre.com, antoniu.miclaus@analog.com,
 andriy.shevchenko@linux.intel.com, stefan.popa@analog.com,
 ramona.gradinariu@analog.com, herve.codina@bootlin.com,
 tobias.sperling@softing.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/5] iio: adc: ti-ads1262.c: add initial driver for
 TI ADS1262 ADC
Message-ID: <20250504172014.2c807456@jic23-huawei>
In-Reply-To: <20250501100043.325423-2-sayyad.abid16@gmail.com>
References: <20250501100043.325423-1-sayyad.abid16@gmail.com>
	<20250501100043.325423-2-sayyad.abid16@gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 May 2025 15:30:39 +0530
Sayyad Abid <sayyad.abid16@gmail.com> wrote:

> Add the core driver file `ti-ads1262.c` for the TI ADS1262 ADC.
> This initial version implements basic IIO functionality for device
> probe via SPI and reading raw voltage samples from input channels.
> 
> Signed-off-by: Sayyad Abid <sayyad.abid16@gmail.com>
A few additional comments from me (some probably overlap!)

Jonathan

> ---
>  drivers/iio/adc/ti-ads1262.c | 438 +++++++++++++++++++++++++++++++++++
>  1 file changed, 438 insertions(+)
>  create mode 100644 drivers/iio/adc/ti-ads1262.c
> 
> diff --git a/drivers/iio/adc/ti-ads1262.c b/drivers/iio/adc/ti-ads1262.c
> new file mode 100644
> index 000000000000..ef34c528ffeb
> --- /dev/null
> +++ b/drivers/iio/adc/ti-ads1262.c
> @@ -0,0 +1,438 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * IIO driver for Texas Instruments ADS1662 32-bit ADC
> + *
> + * Datasheet: https://www.ti.com/product/ADS1262
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/delay.h>
> +#include <linux/spi/spi.h>
> +#include <linux/unaligned.h>
> +
> +#include <linux/iio/iio.h>
> +#include <linux/iio/buffer.h>
> +#include <linux/iio/triggered_buffer.h>
I'm not seeing these being used yet.

> +/**
> + * struct ads1262_private - ADS1262 ADC private data structure
> + * @spi: SPI device structure
> + * @reset_gpio: GPIO descriptor for reset pin
> + * @prev_channel: Previously selected channel for MUX configuration
> + * @cmd_buffer: Buffer for SPI command transfers
> + * @rx_buffer: Buffer for SPI data reception
> + */
> +struct ads1262_private {
> +	struct spi_device *spi;
> +	struct gpio_desc *reset_gpio;
> +	u8 prev_channel;
> +	u8 cmd_buffer[ADS1262_SPI_CMD_BUFFER_SIZE];

You seem to use cmd_buffer directly in spi calls so that needs the __aligned(IIO_DMA_MINALIGN)
marking. You can probably just have one on that as long as you don't ever edit that
whilst rx_buffer is still in use.

> +	u8 rx_buffer[ADS1262_SPI_RDATA_BUFFER_SIZE] __aligned(IIO_DMA_MINALIGN);
> +};
> +
> +#define ADS1262_CHAN(index)						\
> +{									\
> +	.type = IIO_VOLTAGE,						\
> +	.indexed = 1,							\
> +	.channel = index,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.scan_index = index,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = ADS1262_BITS_PER_SAMPLE,			\
> +		.storagebits = 32,					\
> +		.endianness = IIO_CPU					\
> +	},								\
> +}
> +
> +#define ADS1262_DIFF_CHAN(index, pos_channel, neg_channel)		\
> +{									\
> +	.type = IIO_VOLTAGE,						\
> +	.indexed = 1,							\
> +	.channel = pos_channel,						\
> +	.channel2 = neg_channel,					\
> +	.differential = 1,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.scan_index = index,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = ADS1262_BITS_PER_SAMPLE,			\
> +		.storagebits = 32,					\
> +		.endianness = IIO_CPU					\
> +	},								\
> +}
> +
> +#define ADS1262_TEMP_CHAN(index)					\
> +{									\
> +	.type = IIO_TEMP,						\
> +	.indexed = 1,							\
> +	.channel = index,						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |			\
> +			     BIT(IIO_CHAN_INFO_SCALE) |			\
> +			     BIT(IIO_CHAN_INFO_SAMP_FREQ),		\

Is the sampling frequency independent for each channel?
Or is this a case where we want them separate as the overall sampling frequency
is directly related to how many channels are enabled?  Odd to just have
this for the temp channel.

> +	.scan_index = index,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = ADS1262_BITS_PER_SAMPLE,			\
> +		.storagebits = 32,					\
> +		.endianness = IIO_BE,					\
> +	},								\
> +}
> +
> +static const struct iio_chan_spec ads1262_channels[] = {
> +	/* Single ended channels*/
> +	ADS1262_CHAN(0),
> +	ADS1262_CHAN(1),
> +	ADS1262_CHAN(2),
> +	ADS1262_CHAN(3),
> +	ADS1262_CHAN(4),
> +	ADS1262_CHAN(5),
> +	ADS1262_CHAN(6),
> +	ADS1262_CHAN(7),
> +	ADS1262_CHAN(8),
> +	ADS1262_CHAN(9),
> +	/* The channel at index 10 is AINCOM, which is the common ground
Comment syntax
	/*
	 * The channel

> +	 * of the ADC. It is not a valid channel for the user.
> +	 */
> +
> +	/* Temperature and Monitor channels */
> +	ADS1262_TEMP_CHAN(11),	/* TEMP SENSOR */
> +	ADS1262_CHAN(12),	/* AVDD MON */
> +	ADS1262_CHAN(13),	/* DVDD MON */
> +	ADS1262_CHAN(14),	/* TDAC TEST */
> +	/* Differential channels */
> +	ADS1262_DIFF_CHAN(15, 0, 1),	/* AIN0 - AIN1 */
> +	ADS1262_DIFF_CHAN(16, 2, 3),	/* AIN2 - AIN3 */
> +	ADS1262_DIFF_CHAN(17, 4, 5),	/* AIN4 - AIN5 */
> +	ADS1262_DIFF_CHAN(18, 6, 7),	/* AIN6 - AIN7 */
> +	ADS1262_DIFF_CHAN(19, 8, 9),	/* AIN8 - AIN9 */
> +};
> +
> +static int ads1262_write_cmd(struct ads1262_private *priv, u8 command)
> +{
> +	struct spi_transfer xfer = {
> +		.tx_buf = priv->cmd_buffer,
> +		.rx_buf = priv->rx_buffer,
> +		.len = ADS1262_SPI_RDATA_BUFFER_SIZE,
> +		.speed_hz = ADS1262_CLK_RATE_HZ,
> +	};
> +
> +	priv->cmd_buffer[0] = command;
> +
> +	return spi_sync_transfer(priv->spi, &xfer, 1);
> +}
> +
> +static int ads1262_reg_write(void *context, unsigned int reg, unsigned int val)
> +{
> +	struct ads1262_private *priv = context;
> +
> +	priv->cmd_buffer[0] = ADS1262_CMD_WREG | reg;
> +	priv->cmd_buffer[1] = 0;
> +	priv->cmd_buffer[2] = val;
> +
> +	return spi_write(priv->spi, &priv->cmd_buffer[0], 3);
> +}
> +
> +static int ads1262_reg_read(void *context, unsigned int reg)
> +{
> +	struct ads1262_private *priv = context;
> +	struct spi_transfer reg_read_xfer = {
> +		.tx_buf = priv->cmd_buffer,
> +		.rx_buf = priv->cmd_buffer,
> +		.len = 3,
> +		.speed_hz = ADS1262_CLK_RATE_HZ,
> +	};
> +	int ret;
> +
> +	priv->cmd_buffer[0] = ADS1262_CMD_RREG | reg;
> +	priv->cmd_buffer[1] = 0;
> +	priv->cmd_buffer[2] = 0;
> +
> +	ret = spi_sync_transfer(priv->spi, &reg_read_xfer, 1);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
	return spi_sync_transfer()
> +}
> +
> +static int ads1262_reset(struct iio_dev *indio_dev)
> +{
> +	struct ads1262_private *priv = iio_priv(indio_dev);
> +
> +	if (priv->reset_gpio) {
> +		gpiod_set_value(priv->reset_gpio, 0);
> +		usleep_range(200, 300);
> +		gpiod_set_value(priv->reset_gpio, 1);
		return 0;
	}

	return ads1262_write_cmd();


> +	} else {
> +		return ads1262_write_cmd(priv, ADS1262_CMD_RESET);
> +	}
> +	return 0;
> +}
> +
> +static int ads1262_init(struct iio_dev *indio_dev)
> +{
> +	struct ads1262_private *priv = iio_priv(indio_dev);
> +	int ret = 0;
> +
> +	ret = ads1262_reset(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	/* 10 milliseconds settling time for the ADC to stabilize */
> +	fsleep(ADS1262_SETTLE_TIME_USECS);

This is probably better placed in the reset function as it is part
of that overall action.  I added a comment asking why there wasn't one there
before seeing this.

> +
> +	/* Clearing the RESET bit in the power register to detect ADC reset */
> +	ret = ads1262_reg_write(priv, ADS1262_REG_POWER, ADS1262_INTREF_ENABLE);

I'd be tempted to do this in the _reset() function as well given
it is really just another part of that.

> +	if (ret)
> +		return ret;
> +
> +	/* Setting the ADC to one-shot conversion mode */
> +	ret = ads1262_reg_write(priv, ADS1262_REG_MODE0, ADS1262_MODE0_ONE_SHOT);
> +	if (ret)
> +		return ret;
> +
> +	ret = ads1262_reg_read(priv, ADS1262_REG_INPMUX);
> +	if (ret)
> +		return ret;
> +
> +	priv->prev_channel = priv->cmd_buffer[2];
> +
> +	return ret;
> +}
> +
> +static int ads1262_get_samp_freq(struct ads1262_private *priv, int *val)
> +{
> +	unsigned long samp_freq;
> +	int ret;
> +
> +	ret = ads1262_reg_read(priv, ADS1262_REG_MODE2);
> +	if (ret)
> +		return ret;
> +
> +	samp_freq = priv->cmd_buffer[2];
There are multiple calls that use this structure. I'd kind of
expect to see some locking to prevent them racing against each other.
Note sysfs etc provide no prevention against such races.
> +
> +	*val = (samp_freq & ADS1262_MASK_MODE2_DR);

No brackets needed.

> +
> +	return IIO_VAL_INT;
> +}
> +
> +/**
> + * ads1262_read - Read a single sample from the ADC
> + * @priv: Pointer to the ADS1262 private data structure
> + * @chan: Pointer to the IIO channel specification
> + * @val: Pointer to store the read value
> + *
> + * Reads a single sample from the specified ADC channel. For differential
> + * channels, it sets up the MUX with both channels. For single-ended channels,
> + * it uses the channel number and AINCOM (0x0A).
> + *
> + * Return: 0 on success, negative error code on failure
> + */
> +static int ads1262_read(struct ads1262_private *priv,
> +			struct iio_chan_spec const *chan, int *val)
> +{
> +	u8 mux_value;
> +	int ret;
> +
> +	if (chan->differential) {
> +		mux_value = (chan->channel << 4) | chan->channel2;

FIELD_PREP() and appropriate masks would make it easier to see what is
going on here.

> +	} else {
> +		/* For single-ended channels, use the channel number on one end
		/*
		 * For single-ended channels...

> +		 * and AINCOM (0x0A) on the other end
> +		 */
> +		mux_value = (chan->channel << 4) | 0x0A;
> +	}
> +
> +	if (mux_value != priv->prev_channel) {
Noting stops this racing with another read of a different channel.
Given you are trying to keep state consistent you need
a mutex in your priv structure to serialize them.

> +		ret = ads1262_write_cmd(priv, ADS1262_CMD_STOP1);
> +		if (ret)
> +			return ret;
> +
> +		ret = ads1262_reg_write(priv, ADS1262_REG_INPMUX, mux_value);
> +		if (ret)
> +			return ret;
> +
> +		priv->prev_channel = mux_value;
> +	}
> +
> +	ret = ads1262_write_cmd(priv, ADS1262_CMD_START1);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(1000, 2000);
> +
> +	*val = sign_extend64(get_unaligned_be32(priv->rx_buffer + 1),
> +			     ADS1262_BITS_PER_SAMPLE - 1);
> +
> +	return 0;
> +}
> +
> +static int ads1262_read_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct ads1262_private *spi = iio_priv(indio_dev);
> +	s64 temp;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ads1262_read(spi, chan, val);
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = ADS1262_VOLTAGE_INT_REF_uV;
> +			*val2 = chan->scan_type.realbits;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		case IIO_TEMP:
> +			temp = (s64)ADS1262_VOLTAGE_INT_REF_uV * MILLI;
> +			temp /= ADS1262_TEMP_SENSITIVITY_uV_per_C;
> +			*val = temp;
> +			*val2 = chan->scan_type.realbits;
> +			return IIO_VAL_FRACTIONAL_LOG2;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ads1262_get_samp_freq(spi, val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info ads1262_info = {
> +	.read_raw = ads1262_read_raw,
> +};
> +
> +static void ads1262_stop(void *ptr)
> +{
> +	struct ads1262_private *adc = ptr;
> +
> +	ads1262_write_cmd(adc, ADS1262_CMD_STOP1);
> +}
> +
> +static int ads1262_probe(struct spi_device *spi)
> +{
> +	struct ads1262_private *adc;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*adc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	adc = iio_priv(indio_dev);
> +	adc->spi = spi;
> +
> +	spi->mode = SPI_MODE_1;
> +	spi->max_speed_hz = ADS1262_SPI_BUS_SPEED_SLOW;

David covered these...

> +	spi_set_drvdata(spi, indio_dev);
> +
> +	indio_dev->dev.parent = &spi->dev;
> +	indio_dev->name = spi_get_device_id(spi)->name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ads1262_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ads1262_channels);
> +	indio_dev->info = &ads1262_info;
> +
> +	ret = ads1262_reg_read(adc, ADS1262_REG_ID);
> +	if (ret)
> +		return ret;
> +
> +	if (adc->rx_buffer[2] != ADS1262_REG_ID)
> +		dev_err_probe(&spi->dev, -EINVAL, "Wrong device ID 0x%x\n",
> +			      adc->rx_buffer[2]);
> +
> +	ret = devm_add_action_or_reset(&spi->dev, ads1262_stop, adc);

Which call is this 'undoing'.  Generally I'd expect to only see
a devm callback register after what it is setting up.
Here I'm assuming that stop is undoing something in init?
If so register this after ads1262_init()


> +	if (ret)
> +		return ret;
> +
> +	ret = ads1262_init(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}
> +
> +static struct spi_device_id ads1262_id_table[] = {
> +	{ "ads1262" },
> +	{}
	
	{ }

> +};
> +MODULE_DEVICE_TABLE(spi, ads1262_id_table);
> +
> +static const struct of_device_id ads1262_of_match[] = {
> +	{ .compatible = "ti,ads1262" },
> +	{},

	{ }

Random choice I made for IIO as I'd like consistency.
> +};
> +MODULE_DEVICE_TABLE(of, ads1262_of_match);


