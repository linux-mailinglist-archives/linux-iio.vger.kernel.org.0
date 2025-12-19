Return-Path: <linux-iio+bounces-27230-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 781FFCD1258
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 18:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3B6E30699F8
	for <lists+linux-iio@lfdr.de>; Fri, 19 Dec 2025 17:25:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613F933C195;
	Fri, 19 Dec 2025 17:25:19 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A828933C526;
	Fri, 19 Dec 2025 17:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766165119; cv=none; b=JPGRtIneZnjanFaunsdcdPHN7hDYS5m7OI/uJAO1zgpg8ugYua9D7r/e5nBvZ4IhzPQNYIpNT6tYWw3TAk94MDPsDAhqRkmMiB+TVNpiX5regzb09pIqkkdRc6MzYPPuizdc7lwmvhJhui/XgRimnktkKD9jpej5I2UYD+AjdQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766165119; c=relaxed/simple;
	bh=2w+DYCeMPk4/HycoIpp2rzdmdOGFmloapcqs7tnJV2Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eizPAo5T4kQ29RIyLz9kxeFrhmKVHSnZIZnYDOFce0fF/GGEgjtF3KkqgkPJ/+VW3HEx+ezgSw0KlfGu3WrtLGzfQOlLpED3PJExBkUtSuXNg1xuR5jr6zhs7DXHZkS5CPRcoWeiTY2N2M9gWj7TkazAa8ytCAkfgviiZlbpJ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.224.83])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXvY71shzzHnGk1;
	Sat, 20 Dec 2025 01:24:43 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id BEB644056C;
	Sat, 20 Dec 2025 01:25:12 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Fri, 19 Dec
 2025 17:25:11 +0000
Date: Fri, 19 Dec 2025 17:25:10 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Janani Sunil <janani.sunil@analog.com>
CC: Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich
	<Michael.Hennerich@analog.com>, Alexandru Ardelean
	<alexandru.ardelean@analog.com>, Jonathan Cameron <jic23@kernel.org>, "Rob
 Herring" <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH 3/3] iio: dac: Add MAX22007 DAC driver support
Message-ID: <20251219172510.00007208@huawei.com>
In-Reply-To: <20251219-max22007-dev-v1-3-242da2c2b868@analog.com>
References: <20251219-max22007-dev-v1-0-242da2c2b868@analog.com>
	<20251219-max22007-dev-v1-3-242da2c2b868@analog.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Fri, 19 Dec 2025 16:31:17 +0100
Janani Sunil <janani.sunil@analog.com> wrote:

> Add support for the MAX22007 4 channel DAC
> that drives a voltage or current output on each channel.
wrap to 75 chars rather than 50-60ish
> 
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
Hi Janani

A few minor things inline.  Also add turning on any required
power supplies.  See how other drivers do it with a single call
in in probe. If your board is using always on supplies it will just
work as a stub regulator will be provided by the regulator core.


Thanks,

Jonathan

> diff --git a/drivers/iio/dac/max22007.c b/drivers/iio/dac/max22007.c
> new file mode 100644
> index 000000000000..0d57fee27367
> --- /dev/null
> +++ b/drivers/iio/dac/max22007.c
> @@ -0,0 +1,487 @@

> +
> +#define MAX22007_NUM_CHANNELS				4
> +#define MAX22007_REV_ID_REG				0x00
> +#define MAX22007_STAT_INTR_REG				0x01
> +#define MAX22007_INTERRUPT_EN_REG			0x02
> +#define MAX22007_CONFIG_REG				0x03
> +#define MAX22007_CONTROL_REG				0x04
> +#define MAX22007_CHANNEL_MODE_REG			0x05
> +#define MAX22007_SOFT_RESET_REG				0x06
> +#define MAX22007_DAC_CHANNEL_REG(ch)			(0x07 + (ch))
> +#define MAX22007_GPIO_CTRL_REG				0x0B
> +#define MAX22007_GPIO_DATA_REG				0x0C
> +#define MAX22007_GPI_EDGE_INT_CTRL_REG			0x0D
> +#define MAX22007_GPI_INT_STATUS_REG			0x0E
> +
> +/* Channel mask definitions */
> +#define     MAX22007_CH_MODE_CH_MASK(channel)		BIT(12 + (channel))
maybe use x or ch rather than channel to shorten the defines a little.

> +#define     MAX22007_CH_PWR_CH_MASK(channel)		BIT(8 + (channel))
> +#define     MAX22007_DAC_LATCH_MODE_MASK(channel)	BIT(12 + (channel))
> +#define     MAX22007_LDAC_UPDATE_MASK(channel)		BIT(12 + (channel))
> +#define     MAX22007_SW_RST_MASK			BIT(8)
> +#define     MAX22007_SW_CLR_MASK			BIT(12)
> +#define     MAX22007_SOFT_RESET_BITS_MASK		(MAX22007_SW_RST_MASK | \
> +	    MAX22007_SW_CLR_MASK)

Align after (

> +#define     MAX22007_DAC_DATA_MASK			GENMASK(15, 4)
> +#define     MAX22007_DAC_MAX_RAW			GENMASK(11, 0)
> +#define     MAX22007_CRC8_POLYNOMIAL			0x8C
> +#define     MAX22007_CRC_EN_MASK			BIT(0)
> +#define     MAX22007_RW_MASK				BIT(0)
> +#define     MAX22007_CRC_OVERHEAD			1
> +
> +/* Field value preparation macros with masking */
> +#define     MAX22007_CH_PWR_VAL(channel, val)	(((val) & 0x1) << (8 + (channel)))
> +#define     MAX22007_CH_MODE_VAL(channel, val)	(((val) & 0x1) << (12 + (channel)))
> +#define     MAX22007_DAC_LATCH_MODE_VAL(channel, val)	(((val) & 0x1) << (12 + (channel)))
> +
> +static u8 max22007_crc8_table[256];
> +
> +enum max22007_channel_mode {
> +	MAX22007_VOLTAGE_MODE,
> +	MAX22007_CURRENT_MODE
Add trailing comma. Not obvious there will never be more if other devices are supported
by the driver.

I'd also give these explicit values given they are written to HW.
= 0, 
= 1,

> +};
> +
> +enum max22007_channel_power {
> +	MAX22007_CH_POWER_OFF,
> +	MAX22007_CH_POWER_ON,
This isn't bringing value over renaming the field mask define
to MAX22007_CH_PWRON_CH_MASK()
and using 0 / 1 as appropriate.

> +};
> +
> +struct max22007_state {
> +	struct spi_device *spi;
> +	struct regmap *regmap;
> +	struct iio_chan_spec *iio_chan;

I'd go with iio_chans just to make it clear there can be multiple.

> +	u8 tx_buf[4] __aligned(IIO_DMA_MINALIGN);
> +	u8 rx_buf[4];
> +};
> +
> +static int max22007_spi_read(void *context, const void *reg, size_t reg_size,
> +			     void *val, size_t val_size)
> +{
> +	struct max22007_state *st = context;
> +	u8 calculated_crc, received_crc;
> +	u8 crc_data[3];
> +	int ret;
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->tx_buf,
> +		.rx_buf = st->rx_buf,
> +	};
> +
> +	xfer.len = reg_size + val_size + MAX22007_CRC_OVERHEAD;
> +
> +	memcpy(st->tx_buf, reg, reg_size);
> +
> +	ret = spi_sync_transfer(st->spi, &xfer, 1);
> +	if (ret) {
> +		dev_err(&st->spi->dev, "SPI transfer failed: %d\n", ret);
> +		return ret;
> +	}
> +
> +	crc_data[0] = st->tx_buf[0];
> +	crc_data[1] = st->rx_buf[1];
> +	crc_data[2] = st->rx_buf[2]

The use of only the first byte for tx and later for rx suggest this a
spi_write_then_read()

Using that should simplify your code a little particularly as it doesn't need
dma safe buffers (bounces anyway).

I'd be tempted to check reg_size == 1 then hard code that through this function.


> +
> +	calculated_crc = crc8(max22007_crc8_table, crc_data, 3, 0x00);
> +	received_crc = st->rx_buf[3];
> +
> +	if (calculated_crc != received_crc) {
> +		dev_err(&st->spi->dev, "CRC mismatch on read register %02x:\n", *(u8 *)reg);
> +		return -EIO;
> +	}
> +
> +	/* Ignore the dummy byte 0 */
> +	memcpy(val, &st->rx_buf[1], val_size);
> +
> +	return 0;
> +}
> +
> +static int max22007_spi_write(void *context, const void *data, size_t count)
> +{
> +	struct max22007_state *st = context;
> +	struct spi_transfer xfer = {
> +		.tx_buf = st->tx_buf,
> +		.rx_buf = st->rx_buf,
> +	};
> +
> +	memset(st->tx_buf, 0, sizeof(st->tx_buf));
> +
> +	xfer.len = count + MAX22007_CRC_OVERHEAD;
> +
> +	memcpy(st->tx_buf, data, count);
> +	st->tx_buf[count] = crc8(max22007_crc8_table, st->tx_buf,
> +				 sizeof(st->tx_buf) - 1, 0x00);
> +
> +	return spi_sync_transfer(st->spi, &xfer, 1);
> +}

> +static int max22007_write_channel_data(struct max22007_state *state, unsigned int channel,
> +				       unsigned int data)
> +{
> +	unsigned int reg_val;
> +
> +	if (data > MAX22007_DAC_MAX_RAW)
> +		return -EINVAL;
> +
> +	reg_val = FIELD_PREP(MAX22007_DAC_DATA_MASK, data);
> +
> +	return regmap_write(state->regmap, MAX22007_DAC_CHANNEL_REG(channel), reg_val);
> +}
> +
> +static int max22007_read_channel_data(struct max22007_state *state, unsigned int channel,

Where it doesn't hurt readability my preference is still to stay nearer to 80 chars.

> +				      int *data)
> +{
> +	int ret;
> +	unsigned int reg_val;
> +
> +	ret = regmap_read(state->regmap, MAX22007_DAC_CHANNEL_REG(channel), &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	*data = FIELD_GET(MAX22007_DAC_DATA_MASK, reg_val);
> +
> +	return 0;
> +}
> +
> +static int max22007_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max22007_state *st = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = max22007_read_channel_data(st, chan->channel, val);
> +		if (ret)
> +			return ret;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_VOLTAGE) {
> +			*val = 5 * 2500;  /* 5 * Vref(2.5V) in mV */
> +			*val2 = 12;  /* 12-bit DAC resolution (2^12) */

Given resolution is the same either way, drop that out of the if / else
		if (chan->type == IIO_VOLTAGE)
			*val = ...
		else
			*val = ...
		val2 = 12; /* 12-bit DAC resolution */

The 2^12 is a bit confusing so I'd drop that bit.

> +		} else {
> +			*val = 25;  /* Vref / (2 * Rsense) = 2500mV / 100 */
> +			*val2 = 12;  /* 12-bit DAC resolution (2^12) */
> +		}
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}


> +static const struct iio_chan_spec_ext_info max22007_ext_info[] = {
> +	{
> +		.name = "powerdown",
> +		.read = max22007_read_dac_powerdown,
> +		.write = max22007_write_dac_powerdown,
> +		.shared = IIO_SEPARATE,
> +	},
> +	{ },
No trailing comma for a 'terminating' entry like this. We don't want
to make it easy to add stuff after.
> +};
> +
> +static const struct iio_chan_spec max22007_channel_template = {
> +	.output = 1,
> +	.indexed = 1,
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) | BIT(IIO_CHAN_INFO_SCALE),
> +	.ext_info = max22007_ext_info,
> +};
> +
> +static int max22007_parse_channel_cfg(struct max22007_state *st, u8 *num_channels)
> +{
> +	struct device *dev = &st->spi->dev;
> +	struct iio_chan_spec *iio_chan;
> +	int ret, num_chan = 0, i = 0;
Please don't mix declarations that assign with those that don't. It makes
it to easy to miss which ones are in which category.
	int num_chan = 0, i = 0;
	int ret;

> +	u32 reg;
> +
> +	num_chan = device_get_child_node_count(dev);
> +	if (!num_chan)
> +		return dev_err_probe(dev, -ENODEV, "no channels configured\n");
> +
> +	st->iio_chan = devm_kcalloc(dev, num_chan, sizeof(*st->iio_chan), GFP_KERNEL);
> +	if (!st->iio_chan)
> +		return -ENOMEM;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		const char *channel_type_str;
> +		enum max22007_channel_mode mode;
> +
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "failed to read reg property of %pfwP\n", child);
> +
> +		if (reg >= MAX22007_NUM_CHANNELS)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "reg out of range in %pfwP\n", child);
> +
> +		iio_chan = &st->iio_chan[i];
> +
> +		*iio_chan = max22007_channel_template;
The template is only used here so I'd be tempted to just do
		*iio_chan = (struct iio_chan_spec) {
			.output = 1,
			.indexed = 1,
			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
					      BIT(IIO_CHAN_INFO_SCALE),
			.ext_info = max22007_ext_info,
			.channel = reg,
		};
inline here.
Or after other changes suggested below you can do

		st->iio_chan[i++] = (struct iio_chan_spec) {
			.output = 1,
			.indexed = 1,
			.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
					      BIT(IIO_CHAN_INFO_SCALE),
			.ext_info = max22007_ext_info,
			.channel = reg,
			.type = chan_type,
		}

> +		iio_chan->channel = reg;
> +
> +		ret = fwnode_property_read_string(child, "adi,type", &channel_type_str);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +					     "missing adi,type property for %pfwP\n", child);
> +
> +		if (strcmp(channel_type_str, "current") == 0) {
> +			mode = MAX22007_CURRENT_MODE;
> +			iio_chan->type = IIO_CURRENT;
> +		} else if (strcmp(channel_type_str, "voltage") == 0) {
> +			mode = MAX22007_VOLTAGE_MODE;
> +			iio_chan->type = IIO_VOLTAGE;
> +		} else {
> +			return dev_err_probe(dev, -EINVAL,
> +					     "invalid adi,type '%s' for %pfwP\n",
> +					     channel_type_str, child);
> +		}

If you do this to set a local type variable before the *iio_chan =
suggestion above, can assign it when filling in the rest of the chan_spec

> +
> +		ret = regmap_update_bits(st->regmap, MAX22007_CHANNEL_MODE_REG,
> +					 MAX22007_CH_MODE_CH_MASK(reg),
> +					 MAX22007_CH_MODE_VAL(reg, mode));
> +		if (ret)
> +			return ret;
> +
> +		/* Set DAC to transparent mode (immediate update) */
> +		ret = regmap_update_bits(st->regmap, MAX22007_CONFIG_REG,
> +					 MAX22007_DAC_LATCH_MODE_MASK(reg),
> +					 MAX22007_DAC_LATCH_MODE_VAL(reg, 1));
> +		if (ret)
> +			return ret;
> +
> +		i++;
With other changes suggested above, i will only be used in one place I think
so you can do the ++ inline at that point. See above for details.

		
> +	}
> +
> +	*num_channels = num_chan;
> +
> +	return 0;
> +}
> +
> +static int max22007_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct max22007_state *state;
> +	struct gpio_desc *reset_gpio;
> +	u8 num_channels;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
Use a local
	struct device *dev = &spi->dev;
to shorten all the places you have &spi->dev currently in this function.

> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	state = iio_priv(indio_dev);
> +	state->spi = spi;
> +
> +	crc8_populate_lsb(max22007_crc8_table, MAX22007_CRC8_POLYNOMIAL);
> +
> +	state->regmap = devm_regmap_init(&spi->dev, &max22007_regmap_bus, state,
> +					 &max22007_regmap_config);
> +	if (IS_ERR(state->regmap))
> +		return dev_err_probe(&spi->dev, PTR_ERR(state->regmap),
> +				     "Failed to initialize regmap\n");
> +
> +	reset_gpio = devm_gpiod_get_optional(&spi->dev, "reset", GPIOD_OUT_LOW);

What sets the gpio high? I'd expect a transition from what is requested here
to what is set in the set_value() below.

> +	if (IS_ERR(reset_gpio))
> +		return dev_err_probe(&spi->dev, PTR_ERR(reset_gpio),
> +				     "Failed to get reset GPIO\n");
> +
> +	if (reset_gpio) {
> +		gpiod_set_value_cansleep(reset_gpio, 0);
> +	} else {
> +		ret = regmap_write(state->regmap, MAX22007_SOFT_RESET_REG,
> +				   MAX22007_SOFT_RESET_BITS_MASK);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	ret = regmap_update_bits(state->regmap, MAX22007_CONFIG_REG,
> +				 MAX22007_CRC_EN_MASK,
> +				 MAX22007_CRC_EN_MASK);

regmap_set_bits() saves repeating the mask.

> +	if (ret)
> +		return ret;
> +
> +	ret = max22007_parse_channel_cfg(state, &num_channels);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->info = &max22007_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = state->iio_chan;
> +	indio_dev->num_channels = num_channels;
> +	indio_dev->name = "max22007";
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}



