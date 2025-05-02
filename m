Return-Path: <linux-iio+bounces-18982-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B48AA709F
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 13:28:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F235163E1E
	for <lists+linux-iio@lfdr.de>; Fri,  2 May 2025 11:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41CFC24293D;
	Fri,  2 May 2025 11:28:53 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0611B22D4C8;
	Fri,  2 May 2025 11:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746185333; cv=none; b=MobC4IhPX4rvkCGc9Hc7W6P2u87+PRD/7nYcKoFytfJcCnTNnQCl1tkq9eftK9rr7eiw8ZSKVmB+koU3QCbQY/SkFCxAIVsGDRxrDBnPI2lBcvtNgUUHfHci+2xuVgPcV22U7io0ykr+TA0zDdBNL0aBpvfDKWhl22yqPyCsG0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746185333; c=relaxed/simple;
	bh=c813GU9aKgZ1nG5T21yMR6Xr/qjUWSBf81Dv32OYtwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EOcPki+q4qNDl7lHT+d0mhWkKmgYv9AVsRiQ9uRO7xqpPHnU2Ma9dypEnspqiYiDQnHrg1PcpGjqOVrfn9mhsmCZibXkXYcN3z2JxKXrFzUJXgG6fiqXqJeKMk/WsXRU6WqDuhaRXSnaX59ltv7KY2gA1hA49dklVzey7y5PjW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: Rj33D1daRTGjKrsjo9+Knw==
X-CSE-MsgGUID: 089xNzFsQQGLVGw8vDGtgg==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="47588044"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="47588044"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 04:28:51 -0700
X-CSE-ConnectionGUID: uD7/euwnTrGGWhh1wjDIYw==
X-CSE-MsgGUID: NuqXUdeGQCGhBhE2U5vhxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="135599524"
Received: from smile.fi.intel.com ([10.237.72.55])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 04:28:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uAoZP-00000002BE9-1ije;
	Fri, 02 May 2025 14:28:43 +0300
Date: Fri, 2 May 2025 14:28:43 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ana-Maria Cusco <ana-maria.cusco@analog.com>, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v2 2/7] iio: adc: Add basic support for AD4170
Message-ID: <aBSsa-QnloxBbBN8@smile.fi.intel.com>
References: <cover.1745841276.git.marcelo.schmitt@analog.com>
 <01ac3a81f9aa7f1fe48478ff60c0033dd02aefb1.1745841276.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <01ac3a81f9aa7f1fe48478ff60c0033dd02aefb1.1745841276.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 28, 2025 at 09:28:03AM -0300, Marcelo Schmitt wrote:
> From: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> 
> Add support for the AD4170 ADC with the following features:
> - Single-shot read.
> - Analog front end PGA configuration.
> - Digital filter and sampling frequency configuration.
> - Calibration gain and offset configuration.
> - Differential and pseudo-differential input configuration.

...

> +/*
> + * Copyright (C) 2024 Analog Devices, Inc.

My calendar shows 2025...

> + * Author: Ana-Maria Cusco <ana-maria.cusco@analog.com>
> + * Author: Marcelo Schmitt <marcelo.schmitt@analog.com>
> + */

...

> +#define AD4170_DEFAULT_SAMP_RATE			(125 * KILO)

HZ_PER_KHZ ?

...

> +/* Internal and external clock properties */
> +#define AD4170_INT_CLOCK_16MHZ				(16 * MEGA)

HZ_PER_MHZ

> +#define AD4170_EXT_CLOCK_MHZ_MIN			(1 * MEGA)
> +#define AD4170_EXT_CLOCK_MHZ_MAX			(17 * MEGA)

Ditto. But are you sure that it's 17 and not 16?

...

> +static const unsigned int ad4170_sinc3_filt_fs_tbl[] = {
> +	4, 8, 12, 16, 20, 40, 48, 80, 100, 256, 500, 1000, 5000, 8332, 10000,
> +	25000, 50000, 65532,

Please, make something like 4 or 8 per line with a comment.

	4, 8, 12, 16, 20, 40, 48, 80,			/*  0 -  7 */
	...						/*  8 - 15 */
	...

> +};

...

> +struct ad4170_chan_info {
> +	int setup_num; /* Index to access state setup_infos array */
> +	struct ad4170_setup setup; /* cached setup */
> +	int input_range_uv;
> +	u32 scale_tbl[10][2];
> +	int offset_tbl[10];
> +	bool initialized;
> +	bool enabled;

`pahole` approved?

> +};

...

> +struct ad4170_state {

Ditto.

> +	struct regmap *regmap;
> +	struct spi_device *spi;
> +	int vrefs_uv[AD4170_MAX_SUP];
> +	struct mutex lock; /* Protect read-modify-write and multi write sequences */
> +	struct iio_chan_spec chans[AD4170_MAX_CHANNELS];
> +	struct ad4170_chan_info chan_infos[AD4170_MAX_CHANNELS];
> +	struct ad4170_setup_info setup_infos[AD4170_MAX_SETUPS];
> +	u32 mclk_hz;
> +	int pins_fn[AD4170_NUM_ANALOG_PINS];
> +	u32 int_pin_sel;
> +	int sps_tbl[ARRAY_SIZE(ad4170_filt_names)][AD4170_MAX_FS_TBL_SIZE][2];
> +	struct completion completion;
> +	/*
> +	 * DMA (thus cache coherency maintenance) requires the transfer buffers
> +	 * to live in their own cache lines.
> +	 */
> +	u8 tx_buf[AD4170_SPI_MAX_XFER_LEN] __aligned(IIO_DMA_MINALIGN);
> +	u8 rx_buf[AD4170_SPI_MAX_XFER_LEN];
> +};

...

> +static int ad4170_debugfs_reg_access(struct iio_dev *indio_dev,
> +				     unsigned int reg, unsigned int writeval,
> +				     unsigned int *readval)
> +{
> +	struct ad4170_state *st = iio_priv(indio_dev);

> +	int ret = -EINVAL;

Redundant assignment.

> +	if (readval)
> +		ret = regmap_read(st->regmap, reg, readval);
> +	else
> +		ret = regmap_write(st->regmap, reg, writeval);
> +
> +	return ret;
> +}

...

> +static int ad4170_find_setup(struct ad4170_state *st,
> +			     struct ad4170_setup *target_setup,
> +			     unsigned int *setup_num, bool *overwrite)
> +{
> +	unsigned int i;
> +
> +	*setup_num = AD4170_INVALID_SETUP;
> +	*overwrite = false;
> +
> +	for (i = 0; i < AD4170_MAX_SETUPS; i++) {
> +		struct ad4170_setup_info *setup_info = &st->setup_infos[i];
> +
> +		/* Immediately accept a matching setup. */
> +		if (!memcmp(target_setup, &setup_info->setup,
> +			    sizeof(*target_setup))) {

Does this handle paddings okay?

> +			*setup_num = i;
> +			return 0;
> +		}
> +
> +		/* Ignore all setups which are used by enabled channels. */
> +		if (setup_info->enabled_channels)
> +			continue;
> +
> +		/* Find the least used slot. */
> +		if (*setup_num == AD4170_INVALID_SETUP ||
> +		    setup_info->channels < st->setup_infos[*setup_num].channels)
> +			*setup_num = i;
> +	}
> +
> +	if (*setup_num == AD4170_INVALID_SETUP)
> +		return -EINVAL;
> +
> +	*overwrite = true;
> +	return 0;
> +}

...

> +static int ad4170_link_channel_setup(struct ad4170_state *st,
> +				     unsigned int chan_addr,
> +				     unsigned int setup_num)
> +{
> +	struct ad4170_setup_info *setup_info = &st->setup_infos[setup_num];
> +	struct ad4170_chan_info *chan_info = &st->chan_infos[chan_addr];
> +	int ret;
> +
> +	ret = regmap_update_bits(st->regmap, AD4170_CHAN_SETUP_REG(chan_addr),
> +				 AD4170_CHAN_SETUP_SETUP_MSK,

> +				 FIELD_PREP(AD4170_CHAN_SETUP_SETUP_MSK,
> +					    setup_num));

I think it's fine to have these two on one line.

> +	if (ret)
> +		return ret;
> +
> +	chan_info->setup_num = setup_num;
> +	setup_info->channels++;
> +	return 0;
> +}

...

> +	/* Case 4 */
> +	if (on_enable && chan_info->setup_num != AD4170_INVALID_SETUP)
> +		return 0;
> +
> +	if (!on_enable && !chan_info->enabled) {
> +		if (chan_info->setup_num != AD4170_INVALID_SETUP)
> +			/* Case 3 */
> +			ad4170_unlink_channel(st, chan_addr);
> +
> +		/* Cases 3 & 5 */
> +		return 0;
> +	}

I believe this can be refactored a bit.

	/* Cases 3, 4, and 5 */
	if (chan_info->setup_num != AD4170_INVALID_SETUP) {
		/* Case 4 */
		if (on_enable)
			return 0;

		/* Case 3 */
		if (!chan_info->enabled) {
			ad4170_unlink_channel(st, chan_addr);
			return 0;
		}
	} else if (!on_enable && !chan_info->enabled) {
		/* Case 5 */
		return 0;
	}

In my opinion it gives each case separated and hence better understanding of
the code flow. For the curiosity one may check the object file sizes (with help
of bloat-o-meter script).

...

> +static int ad4170_set_filter_type(struct iio_dev *indio_dev,
> +				  struct iio_chan_spec const *chan,
> +				  unsigned int val)
> +{
> +	struct ad4170_state *st = iio_priv(indio_dev);
> +	struct ad4170_chan_info *chan_info = &st->chan_infos[chan->address];
> +	struct ad4170_setup *setup = &chan_info->setup;
> +	unsigned int old_filter_fs, old_filter, filter_type_conf;

> +	int ret = 0;

Redundant assignment.

...

> +	switch (ain_n) {
> +	case AD4170_CHAN_MAP_AVDD_AVSS_N:
> +		*ain_voltage = (st->vrefs_uv[AD4170_AVDD_SUP]
> +				- st->vrefs_uv[AD4170_AVSS_SUP]) / 5;

Please use better indentation and split.

	... tmp;

		tmp = st->vrefs_uv[AD4170_AVDD_SUP] - st->vrefs_uv[AD4170_AVSS_SUP];
		*ain_voltage = tmp / 5;

> +		return 0;
> +	case AD4170_CHAN_MAP_IOVDD_DGND_N:
> +		*ain_voltage = st->vrefs_uv[AD4170_IOVDD_SUP] / 5;
> +		return 0;
> +	case AD4170_CHAN_MAP_AVSS:
> +		*ain_voltage = st->vrefs_uv[AD4170_AVSS_SUP];
> +		return 0;
> +	case AD4170_CHAN_MAP_DGND:
> +		*ain_voltage = 0;
> +		return 0;
> +	case AD4170_CHAN_MAP_REFIN1_P:
> +		if (st->vrefs_uv[AD4170_REFIN1P_SUP] == -ENODEV)
> +			return dev_err_probe(dev, -ENODEV,
> +					     "input set to REFIN+ but ref not provided\n");
> +
> +		*ain_voltage = st->vrefs_uv[AD4170_REFIN1P_SUP];
> +		return 0;
> +	case AD4170_CHAN_MAP_REFIN1_N:
> +		if (st->vrefs_uv[AD4170_REFIN1N_SUP] == -ENODEV)
> +			return dev_err_probe(dev, -ENODEV,
> +					     "input set to REFIN- but ref not provided\n");
> +
> +		*ain_voltage = st->vrefs_uv[AD4170_REFIN1N_SUP];
> +		return 0;
> +	case AD4170_CHAN_MAP_REFIN2_P:
> +		if (st->vrefs_uv[AD4170_REFIN2P_SUP] == -ENODEV)
> +			return dev_err_probe(dev, -ENODEV,
> +					     "input set to REFIN2+ but ref not provided\n");
> +
> +		*ain_voltage = st->vrefs_uv[AD4170_REFIN2P_SUP];
> +		return 0;
> +	case AD4170_CHAN_MAP_REFIN2_N:
> +		if (st->vrefs_uv[AD4170_REFIN2N_SUP] == -ENODEV)
> +			return dev_err_probe(dev, -ENODEV,
> +					     "input set to REFIN2- but ref not provided\n");
> +
> +		*ain_voltage = st->vrefs_uv[AD4170_REFIN2N_SUP];
> +		return 0;
> +	case AD4170_CHAN_MAP_REFOUT:
> +		/* REFOUT is 2.5V relative to AVSS so take that into account */
> +		*ain_voltage = st->vrefs_uv[AD4170_AVSS_SUP] + (2500 * MILLI);

Using 2500000 here is probably slightly better choice as MILLI a bit ambiguous
(since the result is in MICROvolts).

> +		return 0;
> +	}

> +	return -EINVAL;

Make this default case.

...

> +static int ad4170_validate_channel(struct ad4170_state *st,
> +				   struct iio_chan_spec const *chan)
> +{
> +	int ret;
> +
> +	ret = ad4170_validate_channel_input(st, chan->channel, false);
> +	if (ret < 0)

Why ' < 0'? Same Q to all similar checks. (And here you even have it
inconsistent with the below)

> +		return ret;
> +
> +	return ad4170_validate_channel_input(st, chan->channel2,
> +					     !chan->differential);
> +}

...

> +static int ad4170_get_input_range(struct ad4170_state *st,
> +				  struct iio_chan_spec const *chan,
> +				  unsigned int ch_reg, unsigned int ref_sel)
> +{
> +	bool bipolar = chan->scan_type.sign == 's';
> +	struct device *dev = &st->spi->dev;
> +	int refp, refn, ain_voltage, ret;
> +
> +	switch (ref_sel) {
> +	case AD4170_REF_REFIN1:
> +		if (st->vrefs_uv[AD4170_REFIN1P_SUP] == -ENODEV ||
> +		    st->vrefs_uv[AD4170_REFIN1N_SUP] == -ENODEV)
> +			return dev_err_probe(dev, -ENODEV,
> +					     "REFIN+, REFIN− selected but not provided\n");

Maybe

					     "REFIN± selected but not provided\n");

?

> +		refp = st->vrefs_uv[AD4170_REFIN1P_SUP];
> +		refn = st->vrefs_uv[AD4170_REFIN1N_SUP];
> +		break;
> +	case AD4170_REF_REFIN2:
> +		if (st->vrefs_uv[AD4170_REFIN2P_SUP] == -ENODEV ||
> +		    st->vrefs_uv[AD4170_REFIN2N_SUP] == -ENODEV)
> +			return dev_err_probe(dev, -ENODEV,
> +					     "REFIN2+, REFIN2− selected but not provided\n");

Ditto.

> +		refp = st->vrefs_uv[AD4170_REFIN2P_SUP];
> +		refn = st->vrefs_uv[AD4170_REFIN2N_SUP];
> +		break;
> +	case AD4170_REF_AVDD:
> +		refp = st->vrefs_uv[AD4170_AVDD_SUP];
> +		refn = st->vrefs_uv[AD4170_AVSS_SUP];
> +		break;
> +	case AD4170_REF_REFOUT:
> +		/* REFOUT is 2.5 V relative to AVSS */
> +		refp = st->vrefs_uv[AD4170_AVSS_SUP] + (2500 * MILLI);

2500000 ? Perhaps define this constant. I see it second time already.

> +		refn = st->vrefs_uv[AD4170_AVSS_SUP];
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

> +	/*
> +	 * Find out the analog input range from the channel type, polarity, and
> +	 * voltage reference selection.
> +	 * AD4170 channels are either differential or pseudo-differential.
> +	 * Diff input voltage range: −VREF/gain to +VREF/gain (datasheet page 6)
> +	 * Pseudo-diff input voltage range: 0 to VREF/gain (datasheet page 6)
> +	 */
> +	if (chan->differential) {
> +		if (!bipolar)
> +			return dev_err_probe(&st->spi->dev, -EINVAL,
> +					     "Channel %u differential unipolar\n",
> +					     ch_reg);
> +
> +		/*
> +		 * Differential bipolar channel.
> +		 * avss-supply is never above 0V.
> +		 * Assuming refin1n-supply not above 0V.
> +		 * Assuming refin2n-supply not above 0V.
> +		 */
> +		return refp + abs(refn);
> +	}
> +	/*
> +	 * Some configurations can lead to invalid setups.
> +	 * For example, if AVSS = -2.5V, REF_SELECT set to REFOUT (REFOUT/AVSS),
> +	 * and pseudo-diff channel configuration set, then the input range
> +	 * should go from 0V to +VREF (single-ended - datasheet pg 10), but
> +	 * REFOUT/AVSS range would be -2.5V to 0V.
> +	 * Check the positive reference is higher than 0V for pseudo-diff
> +	 * channels.
> +	 */
> +	if (refp <= 0)
> +		return dev_err_probe(&st->spi->dev, -EINVAL,
> +				     "REF+ <= GND for pseudo-diff chan %u\n",
> +				     ch_reg);
> +
> +	if (bipolar)
> +		return refp;
> +
> +	/*
> +	 * Pseudo-differential unipolar channel.
> +	 * Input expected to swing from IN- to +VREF.
> +	 */
> +	ret = ad4170_get_ain_voltage_uv(st, chan->channel2, &ain_voltage);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (refp - ain_voltage <= 0)
> +		return dev_err_probe(&st->spi->dev, -EINVAL,
> +				     "Negative input >= REF+ for pseudo-diff chan %u\n",
> +				     ch_reg);
> +
> +	return refp - ain_voltage;
> +}

...

> +	settling_time_ms = DIV_ROUND_UP(6291164 * MILLI, st->mclk_hz);

Would it work on 32-bit? int*long == long.

...

> +	ret = ad4170_get_ain_voltage_uv(st, chan->channel2, &ainm_voltage);
> +	if (ret < 0)

Why ' < 0' ?

> +		return dev_err_probe(&st->spi->dev, ret,

	struct device = &st->spi->dev;


> +				     "Failed to fill scale table\n");

will help in this and many other cases to make them shorter.

...

> +		nv = (u64)chan_info->input_range_uv * NANO;
> +		lshift = (pga >> 3 & 1);  /* handle cases 8 and 9 */

		lshift = !!(pga & BIT(3));

?

> +		rshift = precision_bits - bipolar + (pga & 0x7) - lshift;

GENMASK() ?

> +		chan_info->scale_tbl[pga][0] = 0;
> +		chan_info->scale_tbl[pga][1] = div_u64(nv >> rshift, MILLI);

...

> +	for (i = 0; i < filt_fs_tbl_size; i++) {
> +		if (st->sps_tbl[f_type][i][0] == val &&
> +		    st->sps_tbl[f_type][i][1] == val2)
> +			break;
> +	}
> +	if (i >= filt_fs_tbl_size)

Why '>' ?

> +		return -EINVAL;

...

> +	ret = fwnode_property_read_u32_array(child, "diff-channels", pins,
> +					     ARRAY_SIZE(pins));
> +	if (!ret) {

Use usual patter, checking for errors first.

> +		chan->differential = true;
> +		chan->channel = pins[0];
> +		chan->channel2 = pins[1];
> +		return 0;
> +	}
> +	return dev_err_probe(dev, ret,
> +		"Channel must define one of diff-channels or single-channel.\n");
> +}

...

> +static int ad4170_parse_channels(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	unsigned int num_channels;
> +	unsigned int chan_num;
> +	int ret;
> +
> +	num_channels = device_get_child_node_count(dev);

> +

Redundant blank line.

> +	if (num_channels > AD4170_MAX_CHANNELS)
> +		return dev_err_probe(dev, -EINVAL, "Too many channels\n");
> +
> +	device_for_each_child_node_scoped(dev, child) {
> +		ret = ad4170_parse_channel_node(indio_dev, child, chan_num++);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	indio_dev->num_channels = num_channels;
> +	indio_dev->channels = st->chans;
> +	return 0;
> +}

...

> +static int ad4170_parse_firmware(struct iio_dev *indio_dev)
> +{
> +	struct ad4170_state *st = iio_priv(indio_dev);
> +	struct device *dev = &st->spi->dev;
> +	int reg_data, ret, i;

Why i is signed? Ditto for many similar cases.

> +	st->mclk_hz = AD4170_INT_CLOCK_16MHZ;
> +
> +	for (i = 0; i < AD4170_NUM_ANALOG_PINS; i++)
> +		st->pins_fn[i] = AD4170_PIN_UNASIGNED;
> +
> +	/* On power on, device defaults to using SDO pin for data ready signal */
> +	st->int_pin_sel = AD4170_INT_PIN_SDO;
> +	ret = device_property_match_property_string(dev, "interrupt-names",
> +						    ad4170_int_pin_names,
> +						    ARRAY_SIZE(ad4170_int_pin_names));
> +	if (ret >= 0)
> +		st->int_pin_sel = ret;
> +
> +	reg_data = FIELD_PREP(AD4170_PIN_MUXING_DIG_AUX1_CTRL_MSK,
> +			      st->int_pin_sel == AD4170_INT_PIN_DIG_AUX1 ?
> +			      AD4170_PIN_MUXING_DIG_AUX1_RDY :
> +			      AD4170_PIN_MUXING_DIG_AUX1_DISABLED);
> +
> +	ret = regmap_update_bits(st->regmap, AD4170_PIN_MUXING_REG,
> +				 AD4170_PIN_MUXING_DIG_AUX1_CTRL_MSK, reg_data);
> +	if (ret)
> +		return ret;
> +
> +	return ad4170_parse_channels(indio_dev);
> +}

...

This was really hard to review and I am sure I missed something.

Please, split this to 3+ patches (basic + feature1 + feature2 + ...).

-- 
With Best Regards,
Andy Shevchenko



