Return-Path: <linux-iio+bounces-20648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B18AD9CD5
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 15:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAE6F7A538E
	for <lists+linux-iio@lfdr.de>; Sat, 14 Jun 2025 13:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D892D1DC07D;
	Sat, 14 Jun 2025 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Io2zvua1"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864541FC8;
	Sat, 14 Jun 2025 13:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749907126; cv=none; b=fnHD25KFeN+yESLZ/ajwwcp7C/orUSzITWV5chcrRaGSMoourrkkuBGIiX2KIJn6g6QpF0kciEauAJWcRMRTscqHTfq00to/ReaMjKNxhiY+tf3NIY5HaIHAdd1kNxpFITJNIZCePU9+N/0UOiISRrECAR3VHQnOG65sOI3H01o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749907126; c=relaxed/simple;
	bh=MkutEkey0gL89ixB0J8dofg0Dgbw8omZ7Idxb0DZGWo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k8jRond1gof/XfCc7pYe5j6s5XpOjy/HBdriN+lJpkaGM5uD3J1jLF+URP2l8PPGaveFmCFbEiV43XM3cPYf4yS3bCOrTOoAsyR/9OnTRj20yMf0qUGKexLQakMrYaXZv4QPPiPtlZcC5HI9hq5PqTpmRfMYwJt7MXXkxqtd508=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Io2zvua1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A799C4CEEB;
	Sat, 14 Jun 2025 13:18:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749907126;
	bh=MkutEkey0gL89ixB0J8dofg0Dgbw8omZ7Idxb0DZGWo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Io2zvua1PtcxzivzpCOQSWcUe35dSfgDcNrTQerUQPEALwon8koWDlLccwU/FIffq
	 3IqfaG8g/vD2cmD7a3A8s+NzRd6EyDgiAolkid+6x8x+htsOBN2b36T9J4PLIMjGvE
	 8CGTtgdgpPcoldThM4K6VCCgo48avjFxTxoshblbAa/EhpQrMsAvmb1C5dRB8tXjqa
	 8whnNKzRoYuXrxH3GVfOj/XTFqCIwKHXi5ZPIsHcKRbRetodcxixdSiYrJAi/zxeZ1
	 szfrysMaDJA9ogLtghFeXC1SxN7zfH8GkO/MmjMoFKMWkiO0cuFH2I/n6WksoxKpnF
	 6KRvu9eADhnFA==
Date: Sat, 14 Jun 2025 14:18:37 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <victor.duicu@microchip.com>
Cc: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <marius.cristea@microchip.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: temperature: add support for MCP998X
Message-ID: <20250614141837.06d6e82f@jic23-huawei>
In-Reply-To: <20250613130207.8560-3-victor.duicu@microchip.com>
References: <20250613130207.8560-1-victor.duicu@microchip.com>
	<20250613130207.8560-3-victor.duicu@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 13 Jun 2025 16:02:07 +0300
<victor.duicu@microchip.com> wrote:

> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This is the driver for Microchip MCP998X/33 and MCP998XD/33D
> Multichannel Automotive Temperature Monitor Family.
> 
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
Hi Victor,

Some comments from me to add to what Andy called out.
Hopefully I've avoided too much duplication!

Thanks,

Jonathan

> diff --git a/drivers/iio/temperature/mcp9982.c b/drivers/iio/temperature/mcp9982.c
> new file mode 100644
> index 000000000000..b1ae77c6e691
> --- /dev/null
> +++ b/drivers/iio/temperature/mcp9982.c
> @@ -0,0 +1,778 @@

> +/**
> + * struct mcp9982_features - features of a mcp9982 instance
> + * @name:		chip's name
> + * @phys_channels:	number of physical channels supported by the chip
> + */
> +struct mcp9982_features {
> +	const char	*name;
> +	u8		phys_channels;

As below. Add a few more fields for the stuff you were getting from string
matching.

> +};

> +static const unsigned int mcp9982_window_size[3] = {1, 4, 8};
{ 1, 4, 8, };
is style preference for IIO code and consistent with the
rest of this driver.

> +
> +/*
> + * (Sampling_Frequency * 1000000) / (Window_Size * 2)
> + */

Single line comment syntax 

> +static unsigned int mcp9982_calc_all_3db_values(void)
> +{
> +	u32 denominator, remainder;
> +	unsigned int i, j;
> +	u64 numerator;
> +
> +	for (i = 0; i < ARRAY_SIZE(mcp9982_window_size); i++)
Coding style is a little ambiguous around what is a single statement vs multi statements
but here I think {} for the outer loop would help readability a tiny bit.

> +		for (j = 0; j <  ARRAY_SIZE(mcp9982_sampl_fr); j++) {
> +			numerator = MICRO * mcp9982_sampl_fr[j][0];
> +			denominator = 2 * mcp9982_window_size[i] * mcp9982_sampl_fr[j][1];
> +			remainder = do_div(numerator, denominator);
> +			remainder = do_div(numerator, MICRO);
> +			mcp9982_3db_values_map_tbl[j][i][0] = numerator;
> +			mcp9982_3db_values_map_tbl[j][i][1] = remainder;
> +		}
> +	return 0;
> +}

> +/**
> + * struct mcp9992_priv - information about chip parameters
> + * @regmap:			device register map
> + * @num_channels		number of physical channels
> + * @extended_temp_range		use extended temperature range or not
> + * @recd34_enable		state of REC on channels 3 and 4
> + * @recd12_enable		state of REC on channels 1 and 2
> + * @beta_values			beta compensation value for external channel 1 and 2
> + * @lock			synchronize access to driver's state members
> + * @iio_chan			specifications of channels
> + * @labels			labels of the channels
> + * @ideality_value		ideality factor value for each external channel
> + * @sampl_idx			index representing the current sampling frequency
> + * @dev_name			name of the device
> + * @apdd_enable			state of anti-parallel diode mode
> + */
> +struct mcp9982_priv {
> +	struct regmap *regmap;
> +	u8 num_channels;
> +	bool extended_temp_range;
> +	bool recd34_enable;
> +	bool recd12_enable;
> +	unsigned int beta_values[2];
> +	/*
> +	 * Synchronize access to private members, and ensure
> +	 * atomicity of consecutive regmap operations.

wrap at 80

> +	 */
> +	struct mutex lock;
> +	struct iio_chan_spec *iio_chan;
> +	const char *labels[MCP9982_MAX_NUM_CHANNELS];
> +	unsigned int ideality_value[4];
> +	unsigned int sampl_idx;
> +	const char *dev_name;

I'd store a pointer to chip in here rather than just the name.
Particularly as there are other flags to add to it.

> +	bool apdd_enable;
> +};


> +static int mcp9982_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	unsigned int index, idx, tmp_reg;
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +	int ret;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_ONE_SHOT_ADDR, 1);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&priv->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = regmap_read(priv->regmap, MCP9982_INT_VALUE_ADDR(chan->channel), val);
> +		if (ret)
> +			return ret;
> +
> +		/* The extended temperature range is offset by 64 degrees C */
> +		if (priv->extended_temp_range)
> +			*val -= 64;

Why is this here and in offset below?  Userspace should be doing the maths for us.

> +
> +		ret = regmap_read(priv->regmap, MCP9982_FRAC_VALUE_ADDR(chan->channel), val2);
> +		if (ret)
> +			return ret;
> +
> +		/* Only the 3 MSB in fractional registers are used */
> +		*val2 = mcp9982_fractional_values[*val2 >> 5];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = mcp9982_conv_rate[priv->sampl_idx][0];
> +		*val2 = mcp9982_conv_rate[priv->sampl_idx][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> +
> +		ret = regmap_read(priv->regmap, MCP9982_RUNNING_AVG_ADDR, &tmp_reg);
> +		if (ret)
> +			return ret;
> +		/*
> +		 * In Filter Selection Register values 1 and 2
> +		 * are mapped to the same setting.
> +		 */
> +		switch (tmp_reg) {
> +		case 0:
> +			idx = 0;
> +			break;
> +		case 1:
> +		case 2:
> +			idx = 1;
> +			break;
> +		default:
> +			idx = 2;
> +			break;
> +		}
> +
> +		*val = mcp9982_3db_values_map_tbl[priv->sampl_idx][idx][0];
> +		*val2 = mcp9982_3db_values_map_tbl[priv->sampl_idx][idx][1];
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_HYSTERESIS:
> +		ret = regmap_read(priv->regmap, MCP9982_HYS_ADDR, &index);
> +		if (ret)
> +			return ret;
> +
> +		*val = index;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (priv->extended_temp_range)
> +			*val = -64;

As above. I'd expect to only see this -64 here - not in _RAW as well.

> +		else
> +			*val = 0;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static int mcp9982_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +	int ret;
> +	unsigned int i;
> +	unsigned int start = 0;
> +
> +	guard(mutex)(&priv->lock);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		/*
> +		 * For MCP998XD and MCP9933D sampling frequency can't
> +		 * be set lower than 1.
> +		 */
> +		if (strchr(priv->dev_name, 'd'))

Encode this in the features structure as a specific field.
In general don't use string matching for this stuff as it ends up fragile
when new device support is added over time and people don't notice this
hiding in here.

> +			start = 4;
> +		for (i = start; i < ARRAY_SIZE(mcp9982_conv_rate); i++)
> +			if (val == mcp9982_conv_rate[i][0] && val2 == mcp9982_conv_rate[i][1])
> +				break;
> +
> +		if (i == ARRAY_SIZE(mcp9982_conv_rate))
> +			return -EINVAL;
> +
> +		ret = regmap_write(priv->regmap, MCP9982_CONV_ADDR, i);
> +		if (ret)
> +			return ret;
> +
> +		priv->sampl_idx = i;
> +		return 0;


> +static int mcp9982_init(struct mcp9982_priv *priv)
> +{
> +	int ret;
> +	unsigned int i;
> +	u8 val;
> +
> +	/*
> +	 * For chips with "D" in the name

Very short wrap. Aim for 80 chars.

> +	 * set the below parameters to default to
> +	 * ensure that hardware shutdown feature
> +	 * can't be overridden.
> +	 */
> +	if (strchr(priv->dev_name, 'd')) {

As above. Don't match on strings - store the thing as a flag in the per
device type features structure.

> +		priv->recd12_enable = true;
> +		priv->recd34_enable = true;
> +		for (i = 0; i < 2; i++)
> +			priv->beta_values[i] = 16;
> +		for (i = 0; i < 4; i++)
> +			priv->ideality_value[i] = 18;
> +	}
> +
> +	/*
> +	 * Set default values in registers.
> +	 * APDD, RECD12 and RECD34 are active on 0.
> +	 */
> +	val = FIELD_PREP(MCP9982_CFG_MSKAL, 1) | FIELD_PREP(MCP9982_CFG_RS, 1) |
> +	      FIELD_PREP(MCP9982_CFG_ATTHM, 1) |
> +	      FIELD_PREP(MCP9982_CFG_RECD12, !priv->recd12_enable) |
> +	      FIELD_PREP(MCP9982_CFG_RECD34, !priv->recd34_enable) |
> +	      FIELD_PREP(MCP9982_CFG_RANGE, 0) | FIELD_PREP(MCP9982_CFG_DA_ENA, 0) |
> +	      FIELD_PREP(MCP9982_CFG_APDD, !priv->apdd_enable);
> +
> +	ret = regmap_write(priv->regmap, MCP9982_CFG_ADDR, val);
> +	if (ret)
> +		return ret;
> +	priv->extended_temp_range = false;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_CONV_ADDR, 6);
> +	if (ret)
> +		return ret;
> +	priv->sampl_idx = 6;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_HYS_ADDR, 10);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_CONSEC_ALRT_ADDR, 112);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_RUNNING_AVG_ADDR, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_HOTTEST_CFG_ADDR, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Set beta compensation for channels 1 and 2 */
> +	for (i = 0; i < 2; i++) {
> +		ret = regmap_write(priv->regmap, MCP9982_EXT_BETA_CFG_ADDR(i),
> +				   priv->beta_values[i]);
> +		if (ret)
> +			return ret;
> +	}
> +	/* Set ideality factor for all external channels */
> +	for (i = 0; i < 4; i++) {
> +		ret = regmap_write(priv->regmap, MCP9982_EXT_IDEAL_ADDR(i),
> +				   priv->ideality_value[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

> +
> +static const struct i2c_device_id mcp9982_id[] = {
> +	{ .name = "mcp9933", .driver_data = (kernel_ulong_t)&mcp9933_chip_config },
> +	{ .name = "mcp9933d", .driver_data = (kernel_ulong_t)&mcp9933d_chip_config },
> +	{ .name = "mcp9982", .driver_data = (kernel_ulong_t)&mcp9982_chip_config },
> +	{ .name = "mcp9982d", .driver_data = (kernel_ulong_t)&mcp9982d_chip_config },
> +	{ .name = "mcp9983", .driver_data = (kernel_ulong_t)&mcp9983_chip_config },
> +	{ .name = "mcp9983d", .driver_data = (kernel_ulong_t)&mcp9983d_chip_config },
> +	{ .name = "mcp9984", .driver_data = (kernel_ulong_t)&mcp9984_chip_config },
> +	{ .name = "mcp9984d", .driver_data = (kernel_ulong_t)&mcp9984d_chip_config },
> +	{ .name = "mcp9985", .driver_data = (kernel_ulong_t)&mcp9985_chip_config },
> +	{ .name = "mcp9985d", .driver_data = (kernel_ulong_t)&mcp9985d_chip_config },
> +	{ }
David mentioned the other day that there is an effort to remove the need for
the kernel_ulong_t here but it relies on
	{ "mcp9985d", &mcp9984d_chip_config },
style entries.

https://lore.kernel.org/all/1c7946f1-d712-4baa-8243-be6a55eec528@baylibre.com/

I wasn't aware of that effort but seems sensible to me!


> +};
> +MODULE_DEVICE_TABLE(i2c, mcp9982_id);


