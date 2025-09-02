Return-Path: <linux-iio+bounces-23644-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C11B2B40595
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 15:55:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218161882630
	for <lists+linux-iio@lfdr.de>; Tue,  2 Sep 2025 13:50:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712F4320A0C;
	Tue,  2 Sep 2025 13:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ia/68Pgi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38910320A0D;
	Tue,  2 Sep 2025 13:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820744; cv=none; b=tLMijSCEWzITbJKTYbJmygYEo/2sz/RT4kJzEG8l2iEyS14rSOeCkhy5BqeMNAudFNjrTc8s4mgN3UQtYPd9xktHdRbo9L7DSK03yCKailrc4EA4p5qnAeueNRWL/u2ABTsi3WaE4QhxFY7qRIU2H/YLiKeiXQkSJvS6LJyMBag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820744; c=relaxed/simple;
	bh=JH5P3IDHc7LCboAyQz0aQeZJeOogjX44bTOclUA/WqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L8sGcgD8ph4MMuAmc/anqxcS+BAOsluCA10AOPugo5gD9JzuYU/keFZxCflJzQERsUqHk0Uhpr0nga6KOKAuz8hUHUv3Ao4LQkbBP5AEluTZgAnTqKKcfM750ROEyq9kpPLU27SfHjRWqNA5hCJ3SD2SMunqlg41YJSQHFqjqPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ia/68Pgi; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756820742; x=1788356742;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JH5P3IDHc7LCboAyQz0aQeZJeOogjX44bTOclUA/WqI=;
  b=Ia/68PgiCkiDBj/1FNxqYl532tiXqqce70N80Oex+ZjllYc3Qi85JwNz
   8UHO9H1O7Kc3PA6/nPKuYpUJYUJih4OZ88wNuaW+RHD9VFZSe+k+75HdW
   1eb/TsE9vTRyO50X4K9rE5xAqcEspsLuy3beEQhYfeEx18uemw+B/UnbL
   3K/1H892AutIKWWiKAuruKEn8asZVmWDgSI5+XYN5cwh/BnU+H9WYA6X0
   fDSKgfpr/tyOuSDiFEI0O7LCihrLv4VPNwqbDaC+3efUPPMO2TXAfLNh/
   ih62hbJziBYdfOtKfiAqjiTXWTI41gQQ2XcgL9joYrFBb/MiJRZFl8d+Y
   A==;
X-CSE-ConnectionGUID: dbGcqmwERGi2QaMR0QjK+w==
X-CSE-MsgGUID: guTrB4RPSwycyrG8dPyBeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11541"; a="61734847"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="61734847"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 06:45:41 -0700
X-CSE-ConnectionGUID: VFR4p0NlS62dSyxJfanLyA==
X-CSE-MsgGUID: EYgPQK2VQcyjbgFyeaiKSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; 
   d="scan'208";a="170572828"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2025 06:45:37 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1utRKI-0000000Ahui-0vbg;
	Tue, 02 Sep 2025 16:45:34 +0300
Date: Tue, 2 Sep 2025 16:45:33 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marilene Andrade Garcia <marilene.agarcia@gmail.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Marcelo Schmitt <Marcelo.Schmitt@analog.com>,
	Ceclan Dumitru <dumitru.ceclan@analog.com>,
	Jonathan Santos <Jonathan.Santos@analog.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>
Subject: Re: [PATCH v10 2/2] iio: adc: max14001: New driver
Message-ID: <aLb0_TKn96nGbk6l@smile.fi.intel.com>
References: <cover.1756816682.git.marilene.agarcia@gmail.com>
 <f3ea9c127b7836cc978def5d906740c6da1cfb1e.1756816682.git.marilene.agarcia@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f3ea9c127b7836cc978def5d906740c6da1cfb1e.1756816682.git.marilene.agarcia@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Sep 02, 2025 at 10:16:12AM -0300, Marilene Andrade Garcia wrote:
> The MAX14001/MAX14002 is configurable, isolated 10-bit ADCs for multi-range 
> binary inputs. In addition to ADC readings, the MAX14001/MAX14002 offers 
> more features, like a binary comparator, a filtered reading that can 
> provide the average of the last 2, 4, or 8 ADC readings, and an inrush 
> comparator that triggers the inrush current. There is also a fault feature 
> that can diagnose seven possible fault conditions. And an option to select 
> an external or internal ADC voltage reference.
> 
> MAX14001/MAX14002 features implemented so far:
> - Raw ADC reading.
> - Filtered ADC average reading with the default configuration.
> - MV fault disable.
> - Selection of external or internal ADC voltage reference, depending on
> whether it is declared in the device tree.

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitrev.h>
> +#include <linux/bits.h>
> +#include <linux/byteorder/generic.h>
> +#include <linux/device.h>

> +#include <linux/iio/iio.h>
> +#include <linux/iio/types.h>

Please, move this group...

> +#include <linux/kernel.h>

This header must not be used in a driver like this.
Please, replace it with the headers that you are actually used.

> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>


...to be here (and add a blank line above).

...

> +#define MAX14001_REG_VERIFICATION(x)	((x) + 0x10)
> +
> +#define MAX14001_REG_CFG_EXRF		BIT(5)

Is it REG? I'm lost in the naming(s) and value(s) in this driver.

...

> +#define MAX14001_WRITE_WEN		0x294

Also, what's this? Shouldn't it be a (WRITE_EN | 0x94) ?

...

> +enum max14001_chip_model {
> +	max14001,
> +	max14002,
> +};

No need, just make the data structures separate.

...

> +struct max14001_state {
> +	const struct max14001_chip_info *chip_info;
> +	struct spi_device *spi;
> +	int vref_mv;

Can it be _mV? This will follow the real unit spelling.
(And yes, we have such suffixes in the variable names ion the kernel.)

> +	/*
> +	 * lock protect against multiple concurrent accesses, RMW sequence,
> +	 * and SPI transfer.
> +	 */
> +	struct mutex lock;

+ mutex.h

> +	/*
> +	 * The following buffers will be bit-reversed during device
> +	 * communication, because the device transmits and receives data
> +	 * LSB-first.
> +	 * DMA (thus cache coherency maintenance) requires the transfer
> +	 * buffers to live in their own cache lines.
> +	 */
> +	__be16 spi_tx_buffer __aligned(IIO_DMA_MINALIGN);
> +	__be16 spi_rx_buffer;
> +};

...

> +static int max14001_read(struct max14001_state *st, u16 reg_addr, u16 *reg_data)
> +{
> +	struct spi_transfer xfers[] = {
> +		{
> +			.tx_buf = &st->spi_tx_buffer,
> +			.len = sizeof(st->spi_tx_buffer),
> +			.cs_change = 1,
> +		}, {
> +			.rx_buf = &st->spi_rx_buffer,
> +			.len = sizeof(st->spi_rx_buffer),
> +		},
> +	};
> +	int ret;
> +
> +	/*
> +	 * Prepare SPI transmit buffer 16 bit-value big-endian format and
> +	 * reverses bit order to align with the LSB-first input on SDI port
> +	 * in order to meet the device communication requirements.
> +	 */
> +	st->spi_tx_buffer = FIELD_PREP(MAX14001_MASK_ADDR, reg_addr);
> +	st->spi_tx_buffer = bitrev16(cpu_to_be16(st->spi_tx_buffer));

Use temporary variable. There are two issues with the above:

1) the usual pattern is to avoid putting data to the external buffers /
variables until it's ready (this will be more robust against potential
synchronisation issues);

2) it's simply hard to read and follow; also it's prone to mistakes if
something more comes in the future among these lines.

> +	ret = spi_sync_transfer(st->spi, xfers, ARRAY_SIZE(xfers));
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Convert received 16-bit value from big-endian to cpu-endian format
> +	 * and reverses bit order.
> +	 */
> +	st->spi_rx_buffer = bitrev16(be16_to_cpu(st->spi_rx_buffer));
> +	*reg_data = FIELD_GET(MAX14001_MASK_DATA, st->spi_rx_buffer);
> +
> +	return 0;
> +}

...

> +static int max14001_write(struct max14001_state *st, u16 reg_addr, u16 reg_data)
> +{
> +	/*
> +	 * Prepare SPI transmit buffer 16 bit-value big-endian format and
> +	 * reverses bit order to align with the LSB-first input on SDI port
> +	 * in order to meet the device communication requirements.
> +	 */
> +	st->spi_tx_buffer = FIELD_PREP(MAX14001_MASK_ADDR, reg_addr) |
> +			    FIELD_PREP(MAX14001_SET_WRITE_BIT, 1) |
> +			    FIELD_PREP(MAX14001_MASK_DATA, reg_data);
> +	st->spi_tx_buffer = bitrev16(cpu_to_be16(st->spi_tx_buffer));

Ditto.

> +	return spi_write(st->spi, &st->spi_tx_buffer, sizeof(st->spi_tx_buffer));
> +}

...

> +static int max14001_write_single_reg(struct max14001_state *st, u16 reg_addr,
> +				     u16 reg_data)
> +{
> +	int ret;
> +
> +	/* Enable register write */
> +	ret = max14001_write(st, MAX14001_REG_WEN, MAX14001_WRITE_WEN);
> +	if (ret)
> +		return ret;
> +
> +	/* Write data into register */
> +	ret = max14001_write(st, reg_addr, reg_data);
> +	if (ret)
> +		return ret;

> +	/* Disable register write */
> +	ret = max14001_write(st, MAX14001_REG_WEN, 0);
> +	if (ret)
> +		return ret;
> +
> +	return ret;

Are you expecting anything than 0 here? Why?

Also the whole block is simply

	return max14001_write(st, MAX14001_REG_WEN, 0);

> +}

...

> +static int max14001_read_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct max14001_state *st = iio_priv(indio_dev);
> +	u16 reg_data;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:

Use scoped_guard() from cleanup.h.

> +		mutex_lock(&st->lock);
> +		ret = max14001_read(st, MAX14001_REG_ADC, &reg_data);
> +		mutex_unlock(&st->lock);
> +		if (ret)
> +			return ret;
> +
> +		*val = reg_data;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_AVERAGE_RAW:
> +		mutex_lock(&st->lock);
> +		ret = max14001_read(st, MAX14001_REG_FADC, &reg_data);
> +		mutex_unlock(&st->lock);

Ditto.

> +		if (ret)
> +			return ret;
> +
> +		*val = reg_data;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = st->vref_mv;
> +		*val2 = 10;
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	default:
> +		return -EINVAL;
> +	}
> +}

...

> +static const struct iio_chan_spec max14001_channel[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_AVERAGE_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +	}

Leave a trailing comma. It's not a terminator entry.

> +};

...

> +static int max14001_disable_mv_fault(struct max14001_state *st)
> +{
> +	u16 reg_addr;

It's enough to call it reg.

> +	int ret;
> +
> +	/* Enable SPI Registers Write */
> +	ret = max14001_write(st, MAX14001_REG_WEN, MAX14001_WRITE_WEN);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * Reads all registers and writes the values back to their appropriate
> +	 * verification registers to clear the Memory Validation fault.
> +	 */
> +	for (reg_addr = MAX14001_REG_FLTEN; reg_addr <= MAX14001_REG_ENBL; reg_addr++) {
> +		ret = max14001_write_verification_reg(st, reg_addr);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	/* Disable SPI Registers Write */
> +	return max14001_write(st, MAX14001_REG_WEN, 0);
> +}

...

> +static int max14001_probe(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev;
> +	struct max14001_state *st;
> +	struct device *dev = &spi->dev;
> +	int ret, ext_vrefin = 0;
> +	u16 reg_data;

Call it 'value' ('reg' part is redundant, and 'data' may be ambiguous in this function).

> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +	st->chip_info = spi_get_device_match_data(spi);
> +	if (!st->chip_info)
> +		return dev_err_probe(dev, -ENODEV, "Failed to get match data\n");
> +
> +	indio_dev->name = st->chip_info->name;
> +	indio_dev->info = &max14001_info;
> +	indio_dev->channels = max14001_channel;
> +	indio_dev->num_channels = ARRAY_SIZE(max14001_channel);
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +			"Failed to enable specified Vdd supply\n");
> +
> +	ret = devm_regulator_get_enable(dev, "vddl");
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +			"Failed to enable specified Vddl supply\n");
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "vrefin");
> +	if (ret < 0) {
> +		st->vref_mv = 1250000 / 1000;

(MICRO / MILLI)

> +	} else {
> +		st->vref_mv = ret / 1000;

Ditto.

> +		ext_vrefin = 1;
> +	}

And with deduplication refactored code:

	ret = devm_regulator_get_enable_read_voltage(dev, "vrefin");
	if (ret < 0)
		ret = 1250000;
	else
		ext_vrefin = 1;
	st->vref_mv = ret / (MICRO / MILLI);

> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +			"Failed to init the mutex\n");

One line and do not interleave vref related pieces. I.o.w. move this block
upper before this line "ret = devm_regulator_get_enable(dev, "vdd");".

> +	if (ext_vrefin) {
> +		/*
> +		 * Configure the MAX14001/MAX14002 to use an external voltage
> +		 * reference source for the ADC.
> +		 */
> +		ret = max14001_read(st, MAX14001_REG_CFG, &reg_data);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				"Failed to read Configuration Register\n");

Indentation issue. Note, for the lines ending with string literals there is no
line limit for a long time (10+ years)

> +		reg_data |= FIELD_PREP(MAX14001_REG_CFG_EXRF, 1);

FIELD_MODIFY() ?

> +		ret = max14001_write_single_reg(st, MAX14001_REG_CFG, reg_data);
> +		if (ret)
> +			return dev_err_probe(dev, ret,
> +				"Failed to set Configuration Register\n");

As per above.

> +	}
> +
> +	ret = max14001_disable_mv_fault(st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +			"Failed to disable MV Fault\n");

One line.

> +	return devm_iio_device_register(dev, indio_dev);
> +}

...

> +static const struct of_device_id max14001_of_match[] = {
> +	{ .compatible = "adi,max14001",
> +	  .data = &max14001_chip_info_tbl[max14001], },
> +	{ .compatible = "adi,max14002",
> +	  .data = &max14001_chip_info_tbl[max14002], },
> +	{ }

After splitting this hard-to-read style will be just as

	{ .compatible = "adi,max14001", .data = &max14001_chip_info },
	{ .compatible = "adi,max14002", .data = &max14002_chip_info },

> +};


-- 
With Best Regards,
Andy Shevchenko



