Return-Path: <linux-iio+bounces-18282-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E45A93C8F
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 20:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0421E19E614C
	for <lists+linux-iio@lfdr.de>; Fri, 18 Apr 2025 18:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417B22206A9;
	Fri, 18 Apr 2025 18:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A0Xmkm6b"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEED6433C4;
	Fri, 18 Apr 2025 18:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744999684; cv=none; b=i6pXyjtucIh2uaalBOT0shL/RQw5bfsEEyptfWYLsMHwcUFbGEsbOClCYJwg8kWa/zCLRPadmtMTe0+eydGigEcdp3s0i+oEUlUSczZOqEKYYpds9N8/KX0Xg/NN0BMhP/mGRMlgsbTpKa7POW5eZ7fqTvrUtkPCm3nyZZ9oUDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744999684; c=relaxed/simple;
	bh=gGQdP/eC/Wk8OVZFjpPkwv75nfXzG6OnkV1OYWkD0e8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rFuOxSA/3pz0cGC1LStoZASXRuk0dfazzC8wP5R4E+XRX+WVwvKNgq8fbs7cWNpdYK1g4nSYVrBSru/WcfmAiuV7+rjFXS/DTvKaN2yexvF/PELai/AUd6kvTqBf5AfPSdnEdr15SO6WqKicYJv025U6ZpMwzhiKP1/DzAfDKrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A0Xmkm6b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C02C4CEE2;
	Fri, 18 Apr 2025 18:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744999683;
	bh=gGQdP/eC/Wk8OVZFjpPkwv75nfXzG6OnkV1OYWkD0e8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A0Xmkm6bGOilRyMOoxugxohlL3Vim20B5jsCIBJRSok4Ymm47wYdtatu2a5A3oRlG
	 TEsqOLh7nP4FSnXesTCXjAD5cD7VZMmkShsDraidWI7Y+HfdhAnrPJjzd3Q5Tu3Ww1
	 37tJDAFgYweNUxo04fqs+ohQCrr0RPhoEV8cwwrYgFc7xmNjwu+D4STQIpY0RjvB/L
	 s53a26vr1Tkzxb6ZyPMBKDd+G9267uGuqjvqzeHIdbjbsulqCpGT/L+Noo/QcBCuOT
	 Qekkw66CJz5BKMw3K3wrGfudcnG+q2N9pAtysxE35okGG3HKeFK4A1KHtEgradRrEW
	 Xbun2d+OzAkWQ==
Date: Fri, 18 Apr 2025 19:07:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <victor.duicu@microchip.com>
Cc: <andy@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
 <marius.cristea@microchip.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] iio: temperature: add support for MCP998X
Message-ID: <20250418190757.2b007737@jic23-huawei>
In-Reply-To: <20250415132623.14913-3-victor.duicu@microchip.com>
References: <20250415132623.14913-1-victor.duicu@microchip.com>
	<20250415132623.14913-3-victor.duicu@microchip.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Apr 2025 16:26:23 +0300
<victor.duicu@microchip.com> wrote:

> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This is the driver for Microchip MCP998X/33 and MCP998XD/33D
> Multichannel Automotive Monitor Family.
> 
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
Hi Victor,

Various comments inline,

Thanks,

Jonathan

> ---
>  .../testing/sysfs-bus-iio-temperature-mcp9982 |  17 +
>  MAINTAINERS                                   |   7 +
>  drivers/iio/temperature/Kconfig               |  10 +
>  drivers/iio/temperature/Makefile              |   1 +
>  drivers/iio/temperature/mcp9982.c             | 794 ++++++++++++++++++
>  5 files changed, 829 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-temperature-mcp9982
>  create mode 100644 drivers/iio/temperature/mcp9982.c
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-temperature-mcp9982 b/Documentation/ABI/testing/sysfs-bus-iio-temperature-mcp9982
> new file mode 100644
> index 000000000000..de3360fb05be
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-temperature-mcp9982
> @@ -0,0 +1,17 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/running_average_window

As later in review, I think we can control this via the low pass filter 3dB point
and use standard ABI.

> +KernelVersion:	6.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		This attribute controls the number of samples for the 
> +		running average window applied to External Channel 1.
> +		Using this method the temperature spikes are reduced.
> +		X is the IIO index of the device.
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/running_average_window_available
> +KernelVersion:	6.14
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading returns a list with the possible number of samples used
> +		in the running average window. The window can be composed of 1,
> +		4 or 8 previous samples. X is the IIO index of the device.
> +

> diff --git a/drivers/iio/temperature/mcp9982.c b/drivers/iio/temperature/mcp9982.c
> new file mode 100644
> index 000000000000..f4edc7b6a437
> --- /dev/null
> +++ b/drivers/iio/temperature/mcp9982.c
> @@ -0,0 +1,794 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for MCP998X/33 and MCP998XD/33D Multichannel Automotive Temperature Monitor Family
> + *
> + * Copyright (C) 2025 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Victor Duicu <victor.duicu@microchip.com>
> + *
> + * Datasheet can be found here:
> + * https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP998X-Family-Data-Sheet-DS20006827.pdf
> + *
This line doesn't add anything.  (one of my more trivial common comments :)
> + */

> +
> +/* Running average window can be set as:
/*
 * Running average window...
for IIO multiline comments.

> + * - 1 sample
> + * - 4 samples
> + * - 8 samples
> + */
> +#define MCP9982_RUNNING_AVERAGE_WINDOW_AVAILABLE	"1 4 8"
> +
> +/* The maximum number of channels a member of the family can have */
> +#define MCP9982_MAX_NUM_CHANNELS		5
> +
> +#define MCP9982_CHAN(index, si, __address) ({ \
> +	struct iio_chan_spec __chan = { \
> +		.type = IIO_TEMP, \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +		.info_mask_shared_by_all_available = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +		.channel = index, \
> +		.address = __address, \
> +		.scan_index = si, \
> +		.scan_type = { \
> +			.sign = 'u', \
> +			.realbits = 8, \
> +			.storagebits = 8, \
> +			.endianness = IIO_CPU \
Odd concept for 1 byte ;)  Anyhow it defaults to IIO_CPU anyway so I'd not set it
explicitly.

> +		}, \
> +		.indexed = 1, \
> +	}; \
> +	__chan; \
> +})
> +
> +enum mcp9982_ids {

This should go away after changed suggested later.
> +	MCP9933,
> +	MCP9933D,
> +	MCP9982,
> +	MCP9982D,
> +	MCP9983,
> +	MCP9983D,
> +	MCP9984,
> +	MCP9984D,
> +	MCP9985,
> +	MCP9985D,
> +};
> +
> +/*
/** as it's kernel doc.

> + * struct mcp9982_features - features of a mcp9982 instance
> + * @phys_channels:	number of physical channels supported by the chip
> + * @name:		chip's name
> + */
> +struct mcp9982_features {
> +	u8		phys_channels;
> +	const char	*name;
> +};
> +
> +static const struct mcp9982_features mcp9982_chip_config[] = {
As later, use separate structures for these.
> +	[MCP9933] = {
> +	    .name = "mcp9933",
> +	    .phys_channels = 3,
> +	},
> +	[MCP9933D] = {
> +	    .name = "mcp9933D",
> +	    .phys_channels = 3,
> +	},
> +	[MCP9982] = {
> +	    .name = "mcp9982",
> +	    .phys_channels = 2,
> +	},
> +	[MCP9982D] = {
> +	    .name = "mcp9982D",
> +	    .phys_channels = 2,
> +	},
> +	[MCP9983] = {
> +	    .name = "mcp9983",
> +	    .phys_channels = 3,
> +	},
> +	[MCP9983D] = {
> +	    .name = "mcp9983D",
> +	    .phys_channels = 3,
> +	},
> +	[MCP9984] = {
> +	    .name = "mcp9984",
> +	    .phys_channels = 4,
> +	},
> +	[MCP9984D] = {
> +	    .name = "mcp9984D",
> +	    .phys_channels = 4,
> +	},
> +	[MCP9985] = {
> +	    .name = "mcp9985",
> +	    .phys_channels = 5,
> +	},
> +	[MCP9985D] = {
> +	    .name = "mcp9985D",
> +	    .phys_channels = 5,
> +	},
> +};
> +
> +static const int mcp9982_fractional_values[] = {
> +	0,
> +	125000,
> +	250000,
> +	375000,
> +	500000,
> +	625000,
> +	750000,
> +	875000,
> +};
> +
> +static const int mcp9982_conv_rate[][2] = {
> +	{0, 62500},
> +	{0, 125000},
> +	{0, 250000},
> +	{0, 500000},
> +	{1, 0},
> +	{2, 0},
> +	{4, 0},
> +	{8, 0},
> +	{16, 0},
> +	{32, 0},
> +	{64, 0},
> +};
	{ 64, 0 },
etc


> +
> +/**
> + * struct mcp9992_priv - information about chip parameters
> + * @client:			the i2c-client attached to the device
> + * @regmap:			device register map
> + * @iio_info			iio_info
> + * @iio_chan			specifications of channels
> + * @num_channels		number of physical channels
> + * @lock			synchronize access to driver's state members
> + * @running_avg			number of samples in the running average window
> + * @hysteresis			value of temperature hysteresis
> + * @temp_range_code		coded value representing the set temperature range
> + * @labels			labels of the channels
> + * @chip_name			name of the chip present
> + * @beta_user_value		value given by the user for beta on channel 1 and 2
> + * @apdd			state of anti-parallel diode mode
> + * @recd12			state of REC on channels 1 and 2
> + * @recd34			state of REC on channels 3 and 4
> + * @ideality_user_value		values given by user to ideality factor for all channels
> + */
> +

No blank line here.

> +struct mcp9982_priv {
> +	struct i2c_client *client;
Why do we need this after probe?  Either get the dev from regmap
or store that directly rather than the i2c_client.

> +	struct regmap *regmap;
> +	struct iio_info iio_info;

As below. I'm not sure why we need this.

> +
> +	struct iio_chan_spec *iio_chan;
> +	u8 num_channels;
> +
> +	/*
> +	 * Synchronize access to private members, and ensure
> +	 * atomicity of consecutive regmap operations.
> +	 */
> +	struct mutex lock;
> +
> +	int running_avg;
> +	int hysteresis;
> +	int temp_range_code;
> +	char *labels[MCP9982_MAX_NUM_CHANNELS];
> +	char *chip_name;
> +	int beta_user_value[2];
> +	int apdd;
> +	int recd12;
> +	int recd34;
> +	int ideality_user_value[4];
> +};

> +}
> +
> +static int mcp9982_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			    int *val, int *val2, long mask)
> +{
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +	int ret, val3, HIGH_BYTE, LOW_BYTE;

Capitals not compliant with kernel coding style.

> +
> +	/* Write in ONESHOT register to take a new reading */

Drop and comments that are fairly obvious.  Maybe that 1 needs a define
though.

> +	ret = regmap_write(priv->regmap, MCP9982_ONE_SHOT_ADDR, 1);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&priv->lock);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		HIGH_BYTE = MCP9982_INT_HIGH_BYTE_ADDR(chan->channel);
> +		LOW_BYTE = MCP9982_INT_LOW_BYTE_ADDR(chan->channel);
Drop the local variables and put the macros inline.
> +
> +		ret = regmap_read(priv->regmap, HIGH_BYTE, val);
> +		if (ret)
> +			return ret;
> +
> +		if (priv->temp_range_code)
> +			*val -= MCP9982_TEMP_OFFSET;
> +
> +		ret = regmap_read(priv->regmap, LOW_BYTE, val2);
> +		if (ret)
> +			return ret;
> +
> +		*val2 = mcp9982_fractional_values[*val2 >> 5];

Why 5?  Maybe needs a define or at minimum a comment.

> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		ret = regmap_read(priv->regmap, MCP9982_CONV_ADDR, &val3);

why val3?

> +		if (ret)
> +			return ret;
> +
> +		*val = mcp9982_conv_rate[val3][0];
> +		*val2 = mcp9982_conv_rate[val3][1];
> +
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +
> +static int mcp9982_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			     int val, int val2, long mask)
> +{
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +	struct device *dev = &priv->client->dev;
> +	int i;
> +	int status = 0;
> +
> +	guard(mutex)(&priv->lock);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		for (i = 0; i < ARRAY_SIZE(mcp9982_conv_rate); i++) {
> +			if (val == mcp9982_conv_rate[i][0] &&
> +			    val2 == mcp9982_conv_rate[i][1]){
> +				status = 1;
> +				break;
> +			}
> +		}
> +		if (!status)

		if (i == ARRAY_SIZE(mcp9982_conv_rate);

and get rid of status.  Simply breaking early is sufficient.

> +			return dev_err_probe(dev, -EINVAL, "Sampling Frequency is invalid\n");
> +
> +		return regmap_write(priv->regmap, MCP9982_CONV_ADDR, i);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t mcp9982_running_average_window_show(struct device *dev,
> +						   struct device_attribute *attr, char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +
> +	return sprintf(buf, "%u sample(s)\n", priv->running_avg);

Should read and write in same format. So no units - for that people have to go
look at the ABI docs.

> +}
> +
> +static ssize_t mcp9982_running_average_window_avail_show(struct device *dev,
> +							 struct device_attribute *attr, char *buf)
> +{
> +	return sprintf(buf, "%s\n", MCP9982_RUNNING_AVERAGE_WINDOW_AVAILABLE);
> +}
> +
> +static ssize_t mcp9982_running_average_window_store(struct device *dev,
> +						    struct device_attribute *attr,
> +						    const char *buf, size_t count)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +	int val, ret, reg_val;
> +
> +	if (kstrtouint(buf, 10, &val)) {
> +		dev_err(dev, "Value is not a number\n");
Just return -EINVAL.

As a general rule - error message that can be triggered directly by userspace
based on it's input are bad because they can be used to flush out a log in
an attack on a system.  

> +		return -EINVAL;
> +	}
> +
> +	switch (val) {
> +	case 1:
> +		reg_val = 0;
> +		break;
> +	case 4:
> +		reg_val = 1;
> +		break;
> +	case 8:
> +		reg_val = 3;
> +		break;
> +	default:
> +		dev_err(dev, "Value is invalid\n");
no need for an error message here. Returning -EINVAL should be enough
> +		return -EINVAL;
> +	}
> +
> +	guard(mutex)(&priv->lock);
> +
> +	ret = regmap_write(priv->regmap, MCP9982_RUNNING_AVG_ADDR, reg_val);
> +	priv->running_avg = val;
> +
> +	return count;
> +}
> +
> +static IIO_DEVICE_ATTR(running_average_window, 0644, mcp9982_running_average_window_show,
> +		       mcp9982_running_average_window_store, 0);

Hmm.  A running average is a low pass filter.  Can we control this instead via
standard ABI and the 3dB point?  Take a look at the filter ABI in
Documentation/ABI/testing/sysfs-bus-iio

Custom ABI is rarely used in real cases because the tools tend not to know about it
so we avoid it if we possibly can.

> +
> +static IIO_DEVICE_ATTR(running_average_window_available, 0444,
> +		       mcp9982_running_average_window_avail_show, NULL, 1);
> +
> +static int mcp9982_prep_custom_attributes(struct mcp9982_priv *priv, struct iio_dev *indio_dev)
> +{
> +	struct attribute **mcp9982_custom_attr;
> +	struct attribute_group *mcp9982_group;
> +	struct device *dev = &priv->client->dev;
> +
> +	mcp9982_group = devm_kzalloc(dev, sizeof(*mcp9982_group), GFP_KERNEL);
> +	if (!mcp9982_group)
> +		return -ENOMEM;
> +
> +	mcp9982_custom_attr = devm_kzalloc(dev, MCP9982_NR_CUSTOM_ATTR *
> +					   sizeof(*mcp9982_group) + 1, GFP_KERNEL);
> +	if (!mcp9982_custom_attr)
> +		return -ENOMEM;
> +
> +	mcp9982_custom_attr[0] = MCP9982_DEV_ATTR(running_average_window);
> +	mcp9982_custom_attr[1] = MCP9982_DEV_ATTR(running_average_window_available);

These seem fixed, why the allocation rather than a static const array etc?

> +
> +	mcp9982_group->attrs = mcp9982_custom_attr;
> +	priv->iio_info.attrs = mcp9982_group;

Isn't priv->iio_info pointing to something static const?
You'll need to duplicate it if you want to modify like this.

> +
> +	return 0;
> +}
> +
> +static const struct iio_info mcp9982_info = {
> +	.read_raw = mcp9982_read_raw,
> +	.read_label = mcp9982_read_label,
> +	.read_avail = mcp9982_read_avail,
> +	.write_raw_get_fmt = mcp9982_write_raw_get_fmt,
> +	.write_raw = mcp9982_write_raw,
> +};
> +
> +static int mcp9982_init(struct mcp9982_priv *priv)
> +{
> +	int ret, i;
> +	u8 val;
> +
> +	val = FIELD_PREP(MCP9982_CFG_MSKAL, MCP9982_CFG_MSKAL_DEFAULT) |
> +	      FIELD_PREP(MCP9982_CFG_RS, MCP9982_CFG_RS_DEFAULT) |
> +	      FIELD_PREP(MCP9982_CFG_ATTHM, MCP9982_CFG_ATTHM_DEFAULT) |
> +	      FIELD_PREP(MCP9982_CFG_RECD12, priv->recd12) |
> +	      FIELD_PREP(MCP9982_CFG_RECD34, priv->recd34) |
> +	      FIELD_PREP(MCP9982_CFG_RANGE, priv->temp_range_code) |
> +	      FIELD_PREP(MCP9982_CFG_DA_ENA, MCP9982_CFG_DA_ENA_DEFAULT) |
> +	      FIELD_PREP(MCP9982_CFG_APDD, priv->apdd);
> +	ret = regmap_write(priv->regmap, MCP9982_CFG_ADDR, val);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_CONV_ADDR, MCP9982_SAMPLING_FREQ_CODE_DEFAULT);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_HYS_ADDR, priv->hysteresis);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(priv->regmap, MCP9982_CONSEC_ALRT_ADDR, MCP9982_CONSEC_ALRT_DEFAULT);
> +	if (ret)
> +		return ret;
> +
> +	/* RUNNING AVG DEFAULT is 0 */
I don't think the comment adds anything that isn't obvious from the code.
> +	ret = regmap_write(priv->regmap, MCP9982_RUNNING_AVG_ADDR, 0);
> +	if (ret)
> +		return ret;
> +	priv->running_avg = 1;
> +
> +	/* HOTTEST CFG DEFAULT is 0 */
same here
> +	ret = regmap_write(priv->regmap, MCP9982_HOTTEST_CFG_ADDR, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Set beta compensation for all channels */
and here
> +	for (i = 0; i < 2; i++) {
Why 2? Can we get that from size of something?
> +		ret = regmap_write(priv->regmap, MCP9982_EXT_BETA_CFG_ADDR(i),
> +				   priv->beta_user_value[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Set ideality factor for all channels */
> +	for (i = 0; i < 4; i++) {
Why 4?  Can we get that from size of something?
> +		ret = regmap_write(priv->regmap, MCP9982_EXT_IDEAL_ADDR(i),
> +				   priv->ideality_user_value[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int mcp9982_parse_of_fw(struct iio_dev *indio_dev)
> +{
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +	struct device *dev = &priv->client->dev;
> +	int ret, reg_nr, iio_idx, i;
> +
> +	if (device_property_present(dev, "microchip,temp-hysteresis")) {
> +		ret = device_property_read_u32(dev, "microchip,temp-hysteresis", &priv->hysteresis);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Cannot read hysteresis property\n");
> +
> +		if (priv->hysteresis > MCP9982_HYSTERESIS_MAX_VALUE)
> +			return dev_err_probe(dev, ret,
> +					     "Hysteresis value is higher than maximum\n");
> +	} else {
> +		priv->hysteresis = MCP9982_HYSTERESIS_DEFAULT;
> +	}
Usual trick for these is to assume any error means fallback to default. Allowing
simpler option of:
	priv->hysteresis = MCP9...

	device_property_read_u32(dev, "microchip,....);
	//don't check error.

	if (priv->hysteresis > MCP_...)
		return dev_err_probe();
Which is fine if pointless on the default value as well.

The slight loss is this doesn't catch missformatted properties.  Advantage
is simpler and shorter code.

> +
> +	if (device_property_present(dev, "microchip,extended-temp-range"))

Bool rather than present check.

> +		priv->temp_range_code = 1;
> +	else
> +		priv->temp_range_code = MCP9982_TEMP_RANGE_DEFAULT;
> +
> +	if (device_property_present(dev, "microchip,beta-channel1")) {
> +		ret = device_property_read_u32(dev, "microchip,beta-channel1",
> +					       &priv->beta_user_value[0]);
> +		if (ret)
> +			return ret;
> +
> +		if (priv->beta_user_value[0] > MCP9982_BETA_MAX_VALUE)
> +			return dev_err_probe(dev, -EINVAL, "Beta 1 value is higher than max\n");
> +	} else {
> +		priv->beta_user_value[0] = MCP9982_BETA_AUTODETECT_ENABLE;

As above - can set default and not check error on the property read to give
simpler code.

> +	}
> +
> +	if (device_property_present(dev, "microchip,beta-channel2")) {
> +		ret = device_property_read_u32(dev, "microchip,beta-channel2",
> +					       &priv->beta_user_value[1]);
> +		if (ret)
> +			return ret;
> +
> +		if (priv->beta_user_value[1] > MCP9982_BETA_MAX_VALUE)
> +			return dev_err_probe(dev, -EINVAL, "Beta 2 value is higher than max\n");
> +	} else {
> +		priv->beta_user_value[1] = MCP9982_BETA_AUTODETECT_ENABLE;
> +	}
> +
> +	if (device_property_present(dev, "microchip,apdd-state"))
> +		priv->apdd = 0;
> +	else
> +		priv->apdd = MCP9982_APDD_DEFAULT;
> +
> +	if (device_property_present(dev, "microchip,recd12"))
> +		priv->recd12 = 0;
> +	else
> +		priv->recd12 = MCP9982_RECD_DEFAULT;
> +
> +	if (device_property_present(dev, "microchip,recd34"))
> +		priv->recd34 = 0;
> +	else
> +		priv->recd34 = MCP9982_RECD_DEFAULT;
> +
> +	ret = device_property_read_string(dev, "compatible", (const char **)&priv->chip_name);
This is doing a bad patch to the stuff that we do by getting the match data directly
from the tables provided i2c_get_match_data()
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Cannot read compatible property\n");
> +
> +	priv->chip_name = &priv->chip_name[10];
Why 10?

> +	priv->num_channels = device_get_child_node_count(dev) + 1;
> +
> +	for (i = 0; i < 10; i++)
> +		if (strcmp(priv->chip_name, mcp9982_chip_config[i].name) == 0)

Why the search, just get it directly from what the firmware provided?


> +			break;
> +	if (priv->num_channels > mcp9982_chip_config[i].phys_channels)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "The number of channels does not match the chip\n");
> +
> +	priv->iio_chan = devm_kzalloc(dev, priv->num_channels * sizeof(*priv->iio_chan),
> +				      GFP_KERNEL);
> +	if (!priv->iio_chan)
> +		return -ENOMEM;
> +
> +	/* first channel is internal and always present */
> +	priv->iio_chan[0] = MCP9982_CHAN(MCP9982_CHAN_INT, MCP9982_CHAN_INT,
> +					 MCP9982_INT_HIGH_BYTE_ADDR(0));
> +	priv->labels[0] = "internal diode";
> +	iio_idx++;
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg_nr);
> +		if (reg_nr >= mcp9982_chip_config[i].phys_channels)
> +			return dev_err_probe(dev, -EINVAL,
> +				     "The index of the channels does not match the chip\n");
> +
> +		if (fwnode_property_present(child, "microchip,ideality-factor")) {
> +			ret = fwnode_property_read_u32(child, "microchip,ideality-factor",
> +						       &priv->ideality_user_value[reg_nr - 1]);
> +			if (priv->ideality_user_value[reg_nr - 1] > MCP9982_IDEALITY_MAX_VALUE)
> +				return dev_err_probe(dev, -EINVAL,
> +				     "The ideality value is higher than maximum\n");
> +		} else {
> +			priv->ideality_user_value[reg_nr - 1] = MCP9982_IDEALITY_FACTOR_DEFAULT;
> +		}
> +
> +		ret = fwnode_property_read_string(child, "label",
> +						  (const char **)&priv->labels[reg_nr]);
> +
> +		priv->iio_chan[iio_idx++] = MCP9982_CHAN(reg_nr, reg_nr,
> +							 MCP9982_INT_HIGH_BYTE_ADDR(reg_nr));
> +	}
> +
> +	return 0;
> +}
> +
> +static int mcp9982_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct mcp9982_priv *priv;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*priv));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	priv = iio_priv(indio_dev);
> +	priv->client = client;
> +	i2c_set_clientdata(client, indio_dev);

Used?

> +
> +	priv->regmap = devm_regmap_init_i2c(client, &mcp9982_regmap_config);
> +	if (IS_ERR(priv->regmap))
> +		return dev_err_probe(dev, PTR_ERR(priv->regmap),
> +				     "Cannot initialize register map\n");
> +
> +	ret = devm_mutex_init(dev, &priv->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = mcp9982_parse_of_fw(indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Parameter parsing error\n");
> +
> +	ret = mcp9982_init(priv);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Cannot initialize device\n");
> +
> +	priv->iio_info = mcp9982_info;
Why do you need this copy?
> +
> +	indio_dev->name = priv->chip_name;
> +	indio_dev->info = &priv->iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = priv->iio_chan;
> +	indio_dev->num_channels = priv->num_channels;
> +
> +	ret = mcp9982_prep_custom_attributes(priv, indio_dev);
> +	if (ret < 0)
> +		return dev_err_probe(&client->dev, ret,
> +				     "Can't configure custom attributes for MCP9982 device\n");
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Cannot register IIO device\n");
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id mcp9982_id[] = {
> +	{ .name = "mcp9933", .driver_data = (kernel_ulong_t)&mcp9982_chip_config[MCP9933] },
> +	{ .name = "mcp9933D", .driver_data = (kernel_ulong_t)&mcp9982_chip_config[MCP9933D] },
> +	{ .name = "mcp9982", .driver_data = (kernel_ulong_t)&mcp9982_chip_config[MCP9982] },
> +	{ .name = "mcp9982D", .driver_data = (kernel_ulong_t)&mcp9982_chip_config[MCP9982D] },
> +	{ .name = "mcp9983", .driver_data = (kernel_ulong_t)&mcp9982_chip_config[MCP9983] },
> +	{ .name = "mcp9983D", .driver_data = (kernel_ulong_t)&mcp9982_chip_config[MCP9983D] },
> +	{ .name = "mcp9984", .driver_data = (kernel_ulong_t)&mcp9982_chip_config[MCP9984] },
> +	{ .name = "mcp9984D", .driver_data = (kernel_ulong_t)&mcp9982_chip_config[MCP9984D] },
> +	{ .name = "mcp9985", .driver_data = (kernel_ulong_t)&mcp9982_chip_config[MCP9985] },
> +	{ .name = "mcp9985D", .driver_data = (kernel_ulong_t)&mcp9982_chip_config[MCP9985D] },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mcp9982_id);
> +
> +static const struct of_device_id mcp9982_of_match[] = {
> +	{
> +		.compatible = "microchip,mcp9933",
> +		.data = &mcp9982_chip_config[MCP9933]
For these, named structures now preferred over an array.  It tends to end up ever so slightly
simpler and also gets rid of need for the enum.

Also you set .data but I'm not spotting where you read it.

> +	},
> +	{

kernel style still let you do
	}, {
and save a bunch of lines.

Jonathan


