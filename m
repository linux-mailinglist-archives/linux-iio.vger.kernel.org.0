Return-Path: <linux-iio+bounces-27075-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 220F0CBBC49
	for <lists+linux-iio@lfdr.de>; Sun, 14 Dec 2025 16:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1100300763B
	for <lists+linux-iio@lfdr.de>; Sun, 14 Dec 2025 15:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650EC286D5C;
	Sun, 14 Dec 2025 15:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDssLOw/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BAB285CAA;
	Sun, 14 Dec 2025 15:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765725011; cv=none; b=iw/KUZe9U468zPvg2W0eu3YodP6WkrPqVQp55b1cMGN8PBQm98nggMYyU2Oi9mBeulWcvzMuK3gR1pCddhCHJg8DYPEeT4hLng/AdXYMOOm/qFpNqGjgNQb2dewIncNTWNqAJ5+9aa5ucw9LU0E7OnDyVkm/jdLMKur0RnDiOz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765725011; c=relaxed/simple;
	bh=tTajTZxuRKktLqOyplqR5swnGojT4l6zDRF4/PQYxyc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fUWJ7Jjfr3qMgkxDSbQg+9n/cS966AtRvKYQNXeaSoVrq0IJ8NwFicq9zS+DCrb5GiKLipPj3sbEPHVrUtumUxn79Lvchbzk6UIVGLOPHbS86LIpQfS+3tyqjEP1zVzlIF9hiF1qGUwFRam37AmlN4cDXU7cpWwgCE9W/8QZG3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDssLOw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C5DC4CEF1;
	Sun, 14 Dec 2025 15:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765725010;
	bh=tTajTZxuRKktLqOyplqR5swnGojT4l6zDRF4/PQYxyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pDssLOw/ZnGcvwmRCxmSWrU34kh7bkzXhaXY3gEqAX6uhPtJJJH6YbqDhh/a5R0iX
	 ii9or0xaQr2JAYG+D3iPt0yVi7G0Cc3Z58cOPW3mEJ4tDeH8quhIf5he9P9V2L3r01
	 B+0QWct+5mqNcnYBQFwRBcC/5m76xvJfqDxdx6tnlCdr4P4avSoL+6MgEoJ1h6JquK
	 Se+e8mhcRbOg6a9cFxEJ1EFpJ3hv3w4/ttV7810o9XbeJtt9ZslS4FvRsnFeEjEon3
	 MOq3YeukUdCv3XwFm1VNTOscEp21caDZypD/9RQGn2GVx7wujzdMHMYLCryyEd1Bui
	 30m/YO9x6gZUQ==
Date: Sun, 14 Dec 2025 15:10:01 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iio: dac: adding support for Microchip
 MCP47FEB02
Message-ID: <20251214151001.5e3690ca@jic23-huawei>
In-Reply-To: <20251209-mcp47feb02-v3-2-bb0ba9052f4f@microchip.com>
References: <20251209-mcp47feb02-v3-0-bb0ba9052f4f@microchip.com>
	<20251209-mcp47feb02-v3-2-bb0ba9052f4f@microchip.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 9 Dec 2025 18:06:24 +0200
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> This is the iio driver for Microchip MCP47F(E/V)B(0/1/2)1,
> MCP47F(E/V)B(0/1/2)2, MCP47F(E/V)B(0/1/2)4 and MCP47F(E/V)B(0/1/2)8 series
> of buffered voltage output Digital-to-Analog Converters with nonvolatile or
> volatile memory and an I2C Interface.
> 
> The families support up to 8 output channels.
> 
> The devices can be 8-bit, 10-bit and 12-bit.
> 
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
Hi Ariana,

Given you are going to be doing a v4, a few really minor things inline.

thanks,

Jonathan

> diff --git a/drivers/iio/dac/mcp47feb02.c b/drivers/iio/dac/mcp47feb02.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..40c68767a98f165a3ab91d4a8610b69badf3d3a5
> --- /dev/null
> +++ b/drivers/iio/dac/mcp47feb02.c

> +
> +/**
> + * struct mcp47feb02_data - chip configuration
> + * @chdata: options configured for each channel on the device
> + * @lock: prevents concurrent reads/writes to driver's state members
> + * @info: pointer to features struct
> + * @scale_1: scales set on channels that are based on Vref1
> + * @scale: scales set on channels that are based on Vref/Vref0
> + * @active_channels_mask: enabled channels
> + * @client: the i2c-client attached to the device
> + * @regmap: regmap for directly accessing device register
> + * @vref1_buffered: Vref1 buffer is enabled
> + * @vref_buffered: Vref/Vref0 buffer is enabled
> + * @phys_channels: physical channels on the device
> + * @labels: table with channels labels
> + * @use_vref1: vref1-supply is defined
> + * @use_vref: vref-supply is defined
> + */
> +struct mcp47feb02_data {
> +	struct mcp47feb02_channel_data chdata[MCP47FEB02_MAX_CH];
> +	struct mutex lock; /* prevents concurrent reads/writes to driver's state members */
> +	const struct mcp47feb02_features *info;

See below comment.  Rethink that structure element just to avoid confusiong
with iio_dev->info which is a very different thing from this.

> + static ssize_t store_eeprom_store(struct device *dev, struct device_attribute *attr,
> +				  const char *buf, size_t len)
> +{
> +	struct mcp47feb02_data *data = iio_priv(dev_to_iio_dev(dev));
> +	unsigned int i, val, val1, eewa_val;
> +	bool state;
> +	int ret;
> +
> +	ret = kstrtobool(buf, &state);
> +	if (ret)
> +		return ret;
> +
> +	if (!state)
> +		return 0;
> +
> +	/*
> +	 * Verify DAC Wiper and DAC Configuratioin are unlocked. If both are disabled,

Configuration

Give comments a quick spell check.

> +	 * writing to EEPROM is available.
> +	 */
> +	ret = regmap_read(data->regmap, MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR, &val);
> +	if (ret)
> +		return ret;
> +

...


> +static int mcp47feb02_parse_fw(struct iio_dev *indio_dev, const struct mcp47feb02_features *info)
> +{
> +	struct iio_chan_spec chanspec = mcp47febxx_ch_template;
> +	struct mcp47feb02_data *data = iio_priv(indio_dev);
> +	struct device *dev = &data->client->dev;
> +	struct iio_chan_spec *channels;
> +	u32 num_channels;
> +	u8 chan_idx = 0;
> +	u32 reg = 0;

I would keep scope more local where possible. In this case that means moving the
declaration of reg into the device_for_each_child_node_scoped() loop body.
That will also make it much more obvious why it needs initialization.

Similar applies in a few other places.

> +	int ret;
> +
> +	guard(mutex)(&data->lock);
> +
> +	num_channels = device_get_child_node_count(dev);
> +	if (num_channels > info->phys_channels)
> +		return dev_err_probe(dev, -EINVAL, "More channels than the chip supports\n");
> +
> +	if (!num_channels)
> +		return dev_err_probe(dev, -EINVAL, "No channel specified in the devicetree.\n");
> +
> +	channels = devm_kcalloc(dev, num_channels, sizeof(*channels), GFP_KERNEL);
> +	if (!channels)
> +		return -ENOMEM;
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Invalid channel number\n");
> +
> +		if (reg >= info->phys_channels)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "The index of the channels does not match the chip\n");
> +
> +		set_bit(reg, &data->active_channels_mask);
> +
> +		ret = fwnode_property_read_string(child, "label", &data->labels[reg]);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "%s: invalid label\n",
> +					     fwnode_get_name(child));
> +
> +		chanspec.address = reg;
> +		chanspec.channel = reg;
> +		channels[chan_idx] = chanspec;
> +		chan_idx++;
> +	}
> +
> +	indio_dev->num_channels = num_channels;
> +	indio_dev->channels = channels;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	data->phys_channels = info->phys_channels;
> +
> +	/*
> +	 * Check if microchip,vref-buffered and microchip,vref1-buffered are defined
> +	 * in the devicetree
> +	 */
> +	data->vref_buffered = device_property_read_bool(dev, "microchip,vref-buffered");
> +
> +	if (info->have_ext_vref1)
> +		data->vref1_buffered = device_property_read_bool(dev, "microchip,vref1-buffered");
> +
> +	return 0;
> +}


> +
> +static int mcp47feb02_probe(struct i2c_client *client)
> +{
> +	const struct mcp47feb02_features *info;
> +	struct device *dev = &client->dev;
> +	struct mcp47feb02_data *data;
> +	struct iio_dev *indio_dev;
> +	int vref1_mV = 0;
> +	int vref_mV = 0;
> +	int vdd_mV = 0;

Always initialized before use so no need to set this here.
Different for this one and the vref ones where they are optional
and hence we do need the zeros.

> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +	info = i2c_get_match_data(client);
> +	if (!info)
> +		return -EINVAL;
> +
> +	data->info = info;
> +
> +	if (info->have_eeprom) {
> +		data->regmap = devm_regmap_init_i2c(client, &mcp47feb02_regmap_config);
> +		indio_dev->info = &mcp47feb02_info;
> +	} else {
> +		data->regmap = devm_regmap_init_i2c(client, &mcp47fvb02_regmap_config);
> +		indio_dev->info = &mcp47fvb02_info;
> +	}
> +
> +	if (IS_ERR(data->regmap))
> +		return dev_err_probe(dev, PTR_ERR(data->regmap), "Error initializing i2c regmap\n");
> +
> +	indio_dev->name = info->name;

Given we have this info and the indio_dev->info used very near together
and they are complete unrelated things I'd rename the mcp47feb02_features to
features or similar.

> +
> +	ret = mcp47feb02_parse_fw(indio_dev, info);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Error parsing firmware data\n");
> +
> +	ret = devm_mutex_init(dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "vdd");
> +	if (ret < 0)
> +		return ret;
> +
> +	vdd_mV = ret / 1000;
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (ret > 0) {
> +		vref_mV = ret / 1000;
> +		data->use_vref = true;
> +	} else {
> +		dev_dbg(dev, "using internal band gap as voltage reference.\n");
> +		dev_dbg(dev, "Vref is unavailable.\n");
> +	}
> +
> +	if (info->have_ext_vref1) {
> +		ret = devm_regulator_get_enable_read_voltage(dev, "vref1");
> +		if (ret > 0) {
> +			vref1_mV = ret / 1000;
> +			data->use_vref1 = true;
> +		} else {
> +			dev_dbg(dev, "using internal band gap as voltage reference 1.\n");
> +			dev_dbg(dev, "Vref1 is unavailable.\n");
> +		}
> +	}
> +
> +	ret = mcp47feb02_init_ctrl_regs(data);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Error initialising vref register\n");
> +
> +	ret = mcp47feb02_init_ch_scales(data, vdd_mV, vref_mV, vref1_mV);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id mcp47feb02_id[] = {
> +	{ "mcp47feb01", (kernel_ulong_t)&mcp47feb01_chip_info },
> +	{ "mcp47feb11", (kernel_ulong_t)&mcp47feb11_chip_info },
> +	{ "mcp47feb21", (kernel_ulong_t)&mcp47feb21_chip_info },
> +	{ "mcp47feb02", (kernel_ulong_t)&mcp47feb02_chip_info },
> +	{ "mcp47feb12", (kernel_ulong_t)&mcp47feb12_chip_info },
> +	{ "mcp47feb22", (kernel_ulong_t)&mcp47feb22_chip_info },
> +	{ "mcp47feb04", (kernel_ulong_t)&mcp47feb04_chip_info },
> +	{ "mcp47feb14", (kernel_ulong_t)&mcp47feb14_chip_info },
> +	{ "mcp47feb24", (kernel_ulong_t)&mcp47feb24_chip_info },
> +	{ "mcp47feb08", (kernel_ulong_t)&mcp47feb08_chip_info },
> +	{ "mcp47feb18", (kernel_ulong_t)&mcp47feb18_chip_info },
> +	{ "mcp47feb28", (kernel_ulong_t)&mcp47feb28_chip_info },
> +	{ "mcp47fvb01", (kernel_ulong_t)&mcp47fvb01_chip_info },
> +	{ "mcp47fvb11", (kernel_ulong_t)&mcp47fvb11_chip_info },
> +	{ "mcp47fvb21", (kernel_ulong_t)&mcp47fvb21_chip_info },
> +	{ "mcp47fvb02", (kernel_ulong_t)&mcp47fvb02_chip_info },
> +	{ "mcp47fvb12", (kernel_ulong_t)&mcp47fvb12_chip_info },
> +	{ "mcp47fvb22", (kernel_ulong_t)&mcp47fvb22_chip_info },
> +	{ "mcp47fvb04", (kernel_ulong_t)&mcp47fvb04_chip_info },
> +	{ "mcp47fvb14", (kernel_ulong_t)&mcp47fvb14_chip_info },
> +	{ "mcp47fvb24", (kernel_ulong_t)&mcp47fvb24_chip_info },
> +	{ "mcp47fvb08", (kernel_ulong_t)&mcp47fvb08_chip_info },
> +	{ "mcp47fvb18", (kernel_ulong_t)&mcp47fvb18_chip_info },
> +	{ "mcp47fvb28", (kernel_ulong_t)&mcp47fvb28_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mcp47feb02_id);
> +
> +static const struct of_device_id mcp47feb02_of_match[] = {
> +	{ .compatible = "microchip,mcp47feb01", .data = &mcp47feb01_chip_info },
> +	{ .compatible = "microchip,mcp47feb11", .data = &mcp47feb11_chip_info },
> +	{ .compatible = "microchip,mcp47feb21", .data = &mcp47feb21_chip_info },

Whilst I can see you've grouped these by properties, I think it would probably
be better to just put them in alpha numeric order.  That makes it more obvious
where new parts belong if they are added in future.

Same applies to the array above.

> +	{ .compatible = "microchip,mcp47feb02", .data = &mcp47feb02_chip_info },
> +	{ .compatible = "microchip,mcp47feb12", .data = &mcp47feb12_chip_info },
> +	{ .compatible = "microchip,mcp47feb22", .data = &mcp47feb22_chip_info },
> +	{ .compatible = "microchip,mcp47feb04", .data = &mcp47feb04_chip_info },
> +	{ .compatible = "microchip,mcp47feb14", .data = &mcp47feb14_chip_info },
> +	{ .compatible = "microchip,mcp47feb24", .data = &mcp47feb24_chip_info },
> +	{ .compatible = "microchip,mcp47feb08", .data = &mcp47feb08_chip_info },
> +	{ .compatible = "microchip,mcp47feb18", .data = &mcp47feb18_chip_info },
> +	{ .compatible = "microchip,mcp47feb28", .data = &mcp47feb28_chip_info },
> +	{ .compatible = "microchip,mcp47fvb01", .data = &mcp47fvb01_chip_info },
> +	{ .compatible = "microchip,mcp47fvb11", .data = &mcp47fvb11_chip_info },
> +	{ .compatible = "microchip,mcp47fvb21", .data = &mcp47fvb21_chip_info },
> +	{ .compatible = "microchip,mcp47fvb02", .data = &mcp47fvb02_chip_info },
> +	{ .compatible = "microchip,mcp47fvb12", .data = &mcp47fvb12_chip_info },
> +	{ .compatible = "microchip,mcp47fvb22", .data = &mcp47fvb22_chip_info },
> +	{ .compatible = "microchip,mcp47fvb04", .data = &mcp47fvb04_chip_info },
> +	{ .compatible = "microchip,mcp47fvb14",	.data = &mcp47fvb14_chip_info },
> +	{ .compatible = "microchip,mcp47fvb24", .data = &mcp47fvb24_chip_info },
> +	{ .compatible = "microchip,mcp47fvb08", .data = &mcp47fvb08_chip_info },
> +	{ .compatible = "microchip,mcp47fvb18", .data = &mcp47fvb18_chip_info },
> +	{ .compatible = "microchip,mcp47fvb28", .data = &mcp47fvb28_chip_info },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mcp47feb02_of_match);

