Return-Path: <linux-iio+bounces-23500-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D49B3CF17
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 21:35:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6DB62045BB
	for <lists+linux-iio@lfdr.de>; Sat, 30 Aug 2025 19:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6627A2DE70A;
	Sat, 30 Aug 2025 19:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I9kR3ht/"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E44942A8C;
	Sat, 30 Aug 2025 19:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756582496; cv=none; b=Un6enJmPTo/iCOnzdgp5hR3r/QQ6BnlAYdMYibCBJCi6IEiRWgdM4xagrYzD3rAZMeyKdEdLMraBYuEpTWsAbM1ctC+KxMD6tm+wehkYXrwjRevZSivacyb7u6A0NGxIioMpS5/VWvljaOspJdRmPghuMsnNnLp5vAXjbGN3z0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756582496; c=relaxed/simple;
	bh=k2lX4RtwlSIenNxC+6rKn/33k8gMOJEl99vjUv10qjk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOiv/Dox0BgP6MSH0O8s+ANo4Ywn6lTfu7zZq15R1NyUxduqGe3g+wP02ixE72L4e3zfc0GYnhCocbi3AupqPghtBzUHjgL8afpED0yAR2CFs+d/cVPhwNvrGqDiCGE/afaY30Xxjp5JN/vFdivrJgyAYE4jgsqXjJ9ZjrNM820=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I9kR3ht/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8789CC4CEEB;
	Sat, 30 Aug 2025 19:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756582495;
	bh=k2lX4RtwlSIenNxC+6rKn/33k8gMOJEl99vjUv10qjk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=I9kR3ht/Ul4bgtNu2lQju7flghcjGVm1B4xEknRLvqq/eH2OrvHAhgtA6xI87+n4c
	 jO8AZ0dqgm7HawuSYydR4ORPPvtCFUQ+bkgsm1pjFFwKz1rFxwT9j9uC2H+MWYNcZ/
	 feDD7LdLFD/k/sINrbeTEWNYpzpdBkYYH+y1XWUa7SAfOHJTdAfD4n/9Ze5z6R0ToQ
	 Kbeg2VCbULg/kNhZK1PceuZcZGNbdNilzJZqreJ2D81EYb4C7PxyfdiAfCfZEr+Qkz
	 lVpSWZot7tNgaoYnV5EKlXzB15hyoZId9cNylJoxhF97qElx9OW6FgiLhKCA5+BxLt
	 IKJK5CL1jTSFA==
Date: Sat, 30 Aug 2025 20:34:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <victor.duicu@microchip.com>
Cc: <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <marius.cristea@microchip.com>, <linux-iio@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] iio: temperature: add support for MCP998X
Message-ID: <20250830203446.5c164f74@jic23-huawei>
In-Reply-To: <20250829143447.18893-3-victor.duicu@microchip.com>
References: <20250829143447.18893-1-victor.duicu@microchip.com>
	<20250829143447.18893-3-victor.duicu@microchip.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.50; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Aug 2025 17:34:47 +0300
<victor.duicu@microchip.com> wrote:

> From: Victor Duicu <victor.duicu@microchip.com>
> 
> This is the driver for Microchip MCP998X/33 and MCP998XD/33D
> Multichannel Automotive Temperature Monitor Family.
> 
> Signed-off-by: Victor Duicu <victor.duicu@microchip.com>
Tried to avoid duplication with other reviewers but probably failed!

Jonathan

> diff --git a/drivers/iio/temperature/mcp9982.c b/drivers/iio/temperature/mcp9982.c
> new file mode 100644
> index 000000000000..2f0b9c4674fb
> --- /dev/null
> +++ b/drivers/iio/temperature/mcp9982.c

> +
> +static const struct regmap_config mcp9982_regmap_config = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.rd_table = &mcp9982_regmap_rd_table,
> +	.wr_table = &mcp9982_regmap_wr_table,
> +	.volatile_reg = mcp9982_is_volatile_reg,
> +};
> +
> +/**
> + * struct mcp9992_priv - information about chip parameters
> + * @regmap:			device register map
> + * @chip			pointer to structure holding chip features
> + * @lock			synchronize access to driver's state members
> + * @iio_chan			specifications of channels
> + * @labels			labels of the channels
> + * @ideality_value		ideality factor value for each external channel
> + * @sampl_idx			index representing the current sampling frequency
> + * @time_limit			time when it is safe to read
> + * @recd34_enable		state of REC on channels 3 and 4

Spell out REC fully. It's not a well enough known term anyone reading that comment
might be expected to know what it means.

> + * @recd12_enable		state of REC on channels 1 and 2
> + * @apdd_enable			state of anti-parallel diode mode
> + * @run_state			chip is in run state, otherwise is in standby state
> + * @wait_before_read		whether we need to wait a delay before reading a new value
> + * @num_channels		number of active physical channels
> + */
> +struct mcp9982_priv {
> +	struct regmap *regmap;
> +	const struct mcp9982_features *chip;
> +	/*
> +	 * Synchronize access to private members, and ensure atomicity of
> +	 * consecutive regmap operations.
> +	 */
> +	struct mutex lock;
> +	struct iio_chan_spec *iio_chan;
> +	const char *labels[MCP9982_MAX_NUM_CHANNELS];
> +	unsigned int ideality_value[4];
> +	unsigned int sampl_idx;
> +	unsigned long  time_limit;
> +	bool recd34_enable;
> +	bool recd12_enable;
> +	bool apdd_enable;
> +	bool run_state;
> +	bool wait_before_read;
> +	u8 num_channels;
> +};


> +static int mcp9982_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan, int val,
> +			     int val2, long mask)
> +{
> +	unsigned int i, start, previous_sampl_idx;
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +	int ret;
> +	unsigned long new_time_limit;
> +
> +	start = 0;
> +	guard(mutex)(&priv->lock);
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		previous_sampl_idx = priv->sampl_idx;
> +		/*
> +		 * For MCP998XD and MCP9933D sampling frequency can't
> +		 * be set lower than 1.

wrap at 80 chars, not 70ish.

> +		 */
> +		if (priv->chip->hw_thermal_shutdown)
> +			start = 4;
> +		for (i = start; i < ARRAY_SIZE(mcp9982_conv_rate); i++)
> +			if (val == mcp9982_conv_rate[i][0] &&
> +			    val2 == mcp9982_conv_rate[i][1])
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
> +
> +		/*
> +		 * in Run mode, when changing the frequency, wait a delay based
In Run mode,
> +		 * on the previous value to ensure the new value becomes active
> +		 */
> +		if (priv->run_state) {
> +			new_time_limit = jiffies +
> +					   msecs_to_jiffies(mcp9982_delay_ms[previous_sampl_idx]);
> +			if (time_after(new_time_limit, priv->time_limit)) {
> +				priv->time_limit = new_time_limit;
> +				priv->wait_before_read = true;
> +			}
> +			return 0;
> +		}
> +
> +		break;
>

> +static int mcp9982_init(struct mcp9982_priv *priv)
> +{
> +	int ret;
> +	unsigned int i;
> +	u8 val;
> +
> +	/* Chips 82/83 and 82D/83D do not support anti-parallel diode mode */
> +	if (!priv->chip->allow_apdd)
> +		priv->apdd_enable = 0;
> +
> +	/*
> +	 * Chips with "D" work in Run state and those without work
> +	 * in Standby state
> +	 */
> +	if (priv->chip->hw_thermal_shutdown)
> +		priv->run_state = 1;
> +	else
> +		priv->run_state = 0;


	runstate = priv->chip->hw_thermal_shutdown;

> +
> +	/*
> +	 * For chips with "D" in the name set the below parameters to default to
> +	 * ensure that hardware shutdown feature can't be overridden.
> +	 */
> +	if (priv->chip->hw_thermal_shutdown) {
> +		priv->recd12_enable = true;
> +		priv->recd34_enable = true;
> +	}
> +
> +	/*
> +	 * Set default values in registers. APDD, RECD12 and RECD34 are active
> +	 * on 0.

Probably add a line break between those sentences. I think the first one
is applying to all these writes, whereas second sentence is just about this one.

> +	 */
> +	val = FIELD_PREP(MCP9982_CFG_MSKAL, 1) |
> +	      FIELD_PREP(MCP9982_CFG_RS, !priv->run_state) |
> +	      FIELD_PREP(MCP9982_CFG_ATTHM, 1) |
> +	      FIELD_PREP(MCP9982_CFG_RECD12, !priv->recd12_enable) |
> +	      FIELD_PREP(MCP9982_CFG_RECD34, !priv->recd34_enable) |
> +	      FIELD_PREP(MCP9982_CFG_RANGE, 1) | FIELD_PREP(MCP9982_CFG_DA_ENA, 0) |
> +	      FIELD_PREP(MCP9982_CFG_APDD, !priv->apdd_enable);
> +
> +	ret = regmap_write(priv->regmap, MCP9982_CFG_ADDR, val);
> +	if (ret)
> +		return ret;
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
> +	/* Set auto-detection beta compensation for channels 1 and 2 */
> +	for (i = 0; i < 2; i++) {
> +		ret = regmap_write(priv->regmap, MCP9982_EXT_BETA_CFG_ADDR(i),
> +				   MCP9982_BETA_AUTODETECT);
> +		if (ret)
> +			return ret;
> +	}
> +	/* Set ideality factor for all external channels */
> +	for (i = 0; i < ARRAY_SIZE(priv->ideality_value); i++) {
> +		ret = regmap_write(priv->regmap, MCP9982_EXT_IDEAL_ADDR(i),
> +				   priv->ideality_value[i]);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	priv->wait_before_read = false;
> +	priv->time_limit = jiffies;
> +
> +	return 0;
> +}
> +
> +static int mcp9982_parse_of_config(struct iio_dev *indio_dev, struct device *dev,
> +				   int device_nr_channels)
> +{
> +	unsigned int reg_nr, iio_idx;
> +	struct mcp9982_priv *priv = iio_priv(indio_dev);
> +
> +	priv->apdd_enable = device_property_read_bool(dev,
> +						      "microchip,enable-anti-parallel");
I'd suggestion these are more readable as.

	priv->apdd_enable =
		device_property_read_bool(dev, "microchip,enable-anti-parallel");

> +
> +	priv->recd12_enable = device_property_read_bool(dev,
> +							"microchip,parasitic-res-on-channel1-2");
> +
> +	priv->recd34_enable = device_property_read_bool(dev,
> +							"microchip,parasitic-res-on-channel3-4");
> +
> +	priv->num_channels = device_get_child_node_count(dev) + 1;
> +
> +	if (priv->num_channels > device_nr_channels)
> +		return dev_err_probe(dev, -E2BIG,
> +				     "More channels than the chip supports\n");
> +
> +	priv->iio_chan = devm_kcalloc(dev, priv->num_channels,
> +				      sizeof(*priv->iio_chan), GFP_KERNEL);

Seems channels can't be more than 6(?)  I'd just directly embed a large enough array
in priv so no allocation here necessary.

> +	if (!priv->iio_chan)
> +		return -ENOMEM;
> +
> +	priv->iio_chan[0] = MCP9982_CHAN(0, 0, MCP9982_INT_VALUE_ADDR(0));
> +
> +	priv->labels[0] = "internal diode";
> +	iio_idx++;
> +	device_for_each_child_node_scoped(dev, child) {
> +		fwnode_property_read_u32(child, "reg", &reg_nr);
> +		if (!reg_nr || reg_nr >= device_nr_channels)
> +			return dev_err_probe(dev, -EINVAL,
> +				     "The index of the channels does not match the chip\n");
> +
> +		priv->ideality_value[reg_nr - 1] = 18;
> +		if (fwnode_property_present(child, "microchip,ideality-factor")) {
> +			fwnode_property_read_u32(child, "microchip,ideality-factor",
> +						 &priv->ideality_value[reg_nr - 1]);
> +			if (priv->ideality_value[reg_nr - 1] > 63)
> +				return dev_err_probe(dev, -EOVERFLOW,
> +				     "The ideality value is higher than maximum\n");
> +		}
> +
> +		fwnode_property_read_string(child, "label",
> +					    &priv->labels[reg_nr]);
> +
> +		priv->iio_chan[iio_idx++] = MCP9982_CHAN(reg_nr, reg_nr,
> +							 MCP9982_INT_VALUE_ADDR(reg_nr));
> +	}
> +
> +	return 0;
> +}
> +
> +static int mcp9982_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
...


> +	ret = mcp9982_parse_of_config(indio_dev, &client->dev, chip->phys_channels);

parse_fw_config as its not DT specific (which is excellent!)
Also use dev.


> +	if (ret)
> +		return dev_err_probe(dev, ret, "Parameter parsing error\n");

