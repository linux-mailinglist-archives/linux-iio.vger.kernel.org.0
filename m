Return-Path: <linux-iio+bounces-26536-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 49174C9187E
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 10:54:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2BA1C4E34C8
	for <lists+linux-iio@lfdr.de>; Fri, 28 Nov 2025 09:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE7DB306D21;
	Fri, 28 Nov 2025 09:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIIbGS6k"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC273064B1;
	Fri, 28 Nov 2025 09:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764323666; cv=none; b=tYjzgnQFx7Sqg8+fyuLVzuaesNrcyOwwJ6lFAKMwtcEKKbw4CiaTU0dDN4FWK7sTFlFP4kpeEHOYP43liun+N7AoCywO/BgMIy1liXG0D93Llm2x7BuZIqNkaWsikJelCfRPlXh9aZU3L0MMnjV4zbWPof69OvOaB9J5IpBW8+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764323666; c=relaxed/simple;
	bh=tjssuWR6KbgsD/MtimQilEnqEDcMFswBxDHSLLguTmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k/+LgEsmv0zoDgHt+frPTQ8AYviZ0qnhsmM2c2qzHpVQtai1sNOVcBpKSpCDri310ti4hkO7HT1t+kXSaAwGCV4gdRrpFhItpopVJJUfhwGvDuGYCGHIGZTuTKsk2QJTYlmHJwvYj/0WwYLywodKOxWJlMP+vdls/JgwLnQHPRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIIbGS6k; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764323664; x=1795859664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=tjssuWR6KbgsD/MtimQilEnqEDcMFswBxDHSLLguTmI=;
  b=nIIbGS6kiTc6QpJQ6p+Tu6YTNfALfPGI+HWpovthDAU4RtFqhYxKSzxy
   0QBI0HQkWVNVcX7FNQVh2bjlMRb0faXRg4U6Xlpk07//3DddEHm29c+C4
   vZn4ymITghlCvJn9kHm01pHyxYQQv1C9cQLfYqtvkYvdrLWjWMjGxuo8N
   Tu+jlJNUG+S7lUkXhceHJrMvBQ7RUbR4oTKc/ef3p8H/ikW//EvewwVry
   I1lzKRjNB0en+433MgKP39fTZJwBElG36ZyYd5E5kBD0J2/4RIUWbJCef
   8L8Rx5744zcMkwqoDf/vq45pV5j4JvkQcMk+6LYe2Up6/ARkkKOsFakzv
   g==;
X-CSE-ConnectionGUID: 8u5TEMh7R8ybFkuI2ayMow==
X-CSE-MsgGUID: WE++zOXzRySYPg9AlaHFmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11626"; a="66520796"
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="66520796"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 01:54:23 -0800
X-CSE-ConnectionGUID: UMcDwBZnQGWU7qEh8gIoTg==
X-CSE-MsgGUID: kqQ9c9qARmmi0N8QmjkGEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,232,1758610800"; 
   d="scan'208";a="193428754"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.154])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2025 01:54:20 -0800
Date: Fri, 28 Nov 2025 11:54:18 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tobias Sperling <tobias.sperling@softing.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2 2/2] iio: adc: Add ti-ads1018 driver
Message-ID: <aSlxSj7XEq7PUxsk@smile.fi.intel.com>
References: <20251127-ads1x18-v2-0-2ebfd780b633@gmail.com>
 <20251127-ads1x18-v2-2-2ebfd780b633@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251127-ads1x18-v2-2-2ebfd780b633@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Nov 27, 2025 at 10:37:11PM -0500, Kurt Borja wrote:
> Add ti-ads1018 driver for Texas Instruments ADS1018 and ADS1118 SPI
> analog-to-digital converters.
> 
> These chips' MOSI pin is shared with a data-ready interrupt. Defining
> this interrupt in devicetree is optional, therefore we only create an
> IIO trigger if one is found.
> 
> Handling this interrupt requires some considerations. When enabling the
> trigger the CS line is tied low (active), thus we need to hold
> spi_bus_lock() too, to avoid state corruption. This is done inside the
> set_trigger_state() callback, to let users use other triggers without
> wasting a bus lock.

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>

> +#include <linux/bitmap.h>
> +#include <linux/bitops.h>
> +#include <linux/bits.h>

bits.h and bitops.h are guaranteed by bitmap.h, so

#include <linux/bitmap.h>

is enough for all three.

> +#include <linux/byteorder/generic.h>
> +#include <linux/dev_printk.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/math.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>

+ types.h // E.g., u8 just a page below :-)

> +#include <linux/units.h>

...

> +static unsigned long ads1018_calc_delay(struct ads1018 *ads1018)
> +{
> +	const struct ads1018_chip_info *chip_info = ads1018->chip_info;
> +	unsigned long mode = chip_info->num_data_rate_mode_to_hz - 1;
> +	int hz = chip_info->data_rate_mode_to_hz[mode];

Can frequency be negative?

> +	/* We subtract -10% data-rate error */
> +	hz -= DIV_ROUND_UP(hz, 10);
> +
> +	/* Calculate time per sample in usecs */

Spell it fully "microseconds" or use proper unit with a Greek latter "µs".

> +	return DIV_ROUND_UP(MICROHZ_PER_HZ, hz);
> +}

...

> +static int
> +__ads1018_read_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +		   int *val, int *val2, long mask)

Better naming is something like ads1018_read_raw_unlocked() if I got
the context right.

> +{
> +	struct ads1018 *ads1018 = iio_priv(indio_dev);
> +	const struct ads1018_chip_info *chip_info = ads1018->chip_info;
> +	u8 drate_mode = ads1018_get_data_rate_mode(ads1018, chan->scan_index);
> +	u8 pga_mode = ads1018_get_pga_mode(ads1018, chan->scan_index);
> +	u8 max_drate_mode = chip_info->num_data_rate_mode_to_hz - 1;
> +	u16 cnv, cfg = 0;

Unneeded cfg assignment. See below.

> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:

> +		cfg |= ADS1018_CFG_VALID;
> +		cfg |= ADS1018_CFG_OS_TRIG;

		cfg = ADS1018_CFG_VALID | ADS1018_CFG_OS_TRIG;

> +		cfg |= FIELD_PREP(ADS1018_CFG_MUX_MASK, chan->scan_index);
> +		cfg |= FIELD_PREP(ADS1018_CFG_PGA_MASK, pga_mode);
> +		cfg |= FIELD_PREP(ADS1018_CFG_MODE_MASK, ADS1018_MODE_ONESHOT);
> +		cfg |= FIELD_PREP(ADS1018_CFG_DRATE_MASK, max_drate_mode);

+ blank line.

> +		if (chan->type == IIO_TEMP)
> +			cfg |= ADS1018_CFG_TS_MODE_EN;
> +
> +		ret = ads1018_oneshot(ads1018, cfg, &cnv);
> +		if (ret)
> +			return ret;
> +
> +		cnv >>= chan->scan_type.shift;
> +		*val = sign_extend32(cnv, chan->scan_type.realbits - 1);
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_VOLTAGE:
> +			*val = chip_info->pga_mode_to_gain[pga_mode][0];
> +			*val2 = chip_info->pga_mode_to_gain[pga_mode][1];
> +			return IIO_VAL_INT_PLUS_NANO;
> +
> +		case IIO_TEMP:
> +			*val = chip_info->temp_scale[0];
> +			*val2 = chip_info->temp_scale[1];
> +			return IIO_VAL_INT_PLUS_MICRO;
> +
> +		default:
> +			return -EOPNOTSUPP;
> +		}
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val = chip_info->data_rate_mode_to_hz[drate_mode];
> +		return IIO_VAL_INT;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}

...

> +static int
> +__ads1018_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +		    int val, int val2, long mask)

Naming...

> +{
> +	struct ads1018 *ads1018 = iio_priv(indio_dev);
> +	const struct ads1018_chip_info *info = ads1018->chip_info;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		for (int i = 0; i < info->num_pga_mode_to_gain; i++) {

Why is 'i' signed?

> +			if (val != info->pga_mode_to_gain[i][0] ||
> +			    val2 != info->pga_mode_to_gain[i][1])
> +				continue;

> +			ads1018_set_pga_mode(ads1018, chan->scan_index, i);
> +			return 0;

This is an invariant to the loop, perhaps

> +		}

> +		return -EINVAL;

		for (unsigned int i = 0; i < info->num_pga_mode_to_gain; i++) {
			if (val == info->pga_mode_to_gain[i][0] ||
			    val2 == info->pga_mode_to_gain[i][1])
				break;
		}
		if (i == info->num_pga_mode_to_gain)
			return -EINVAL;

		ads1018_set_pga_mode(ads1018, chan->scan_index, i);
		return 0;

This also will follow the traditional pattern: Check for the error cases first.

> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		for (int i = 0; i < info->num_data_rate_mode_to_hz; i++) {

Ditto, same comments as per previous loop.

> +			if (val != info->data_rate_mode_to_hz[i])
> +				continue;
> +
> +			ads1018_set_data_rate_mode(ads1018, chan->scan_index, i);
> +			return 0;
> +		}
> +
> +		return -EINVAL;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}

...

> +static int ads1018_set_trigger_state(struct iio_trigger *trig, bool state)
> +{
> +	struct ads1018 *ads1018 = iio_trigger_get_drvdata(trig);
> +	__be16 cnv;
> +
> +	/*
> +	 * We need to lock the SPI bus and tie CS low (hold_cs) to catch
> +	 * data-ready interrupts, otherwise the MISO line enters a Hi-Z state.
> +	 */
> +
> +	if (state) {
> +		spi_bus_lock(ads1018->spi->controller);
> +		ads1018_read_locked(ads1018, &cnv, true);
> +		enable_irq(ads1018->drdy_irq);
> +	} else {
> +		disable_irq(ads1018->drdy_irq);
> +		ads1018_read_locked(ads1018, &cnv, false);
> +		spi_bus_unlock(ads1018->spi->controller);
> +	}
> +
> +	return 0;

This function is basically

	if (foo)
		do this
	else
		do that

please make just two distinct functions instead.

> +}

That's how it will look like:

static void ads1018_set_trigger_enable(struct ads1018 *ads1018)
{
	__be16 cnv;

	spi_bus_lock(ads1018->spi->controller);
	ads1018_read_locked(ads1018, &cnv, true);
	enable_irq(ads1018->drdy_irq);
}

static void ads1018_set_trigger_disable(struct ads1018 *ads1018)
{
	__be16 cnv;

	disable_irq(ads1018->drdy_irq);
	ads1018_read_locked(ads1018, &cnv, false);
	spi_bus_unlock(ads1018->spi->controller);
}

static int ads1018_set_trigger_state(struct iio_trigger *trig, bool state)
{
	struct ads1018 *ads1018 = iio_trigger_get_drvdata(trig);

	/*
	 * We need to lock the SPI bus and tie CS low (hold_cs) to catch
	 * data-ready interrupts, otherwise the MISO line enters a Hi-Z state.
	 */
	if (state)
		ads1018_set_trigger_enable(ads1018);
	else
		ads1018_set_trigger_disable(ads1018);

	return 0;
}

Now is the question, can we get rid of dummy variables by checking for
the pointer in the _read_locked()? If so, the above become as simple as

static void ads1018_set_trigger_enable(struct ads1018 *ads1018)
{
	spi_bus_lock(ads1018->spi->controller);
	ads1018_read_locked(ads1018, NULL, true);
	enable_irq(ads1018->drdy_irq);
}

static void ads1018_set_trigger_disable(struct ads1018 *ads1018)
{
	disable_irq(ads1018->drdy_irq);
	ads1018_read_locked(ads1018, NULL, false);
	spi_bus_unlock(ads1018->spi->controller);
}

Or if you make _read_locked() to return the data, just ignoring it as in

	ads1018_read_locked(ads1018, ...);

...

> +static int ads1018_buffer_preenable(struct iio_dev *indio_dev)
> +{
> +	struct ads1018 *ads1018 = iio_priv(indio_dev);
> +	const struct ads1018_chip_info *chip_info = ads1018->chip_info;
> +	unsigned int pga, drate, addr;

> +	u16 cfg = 0;

Unneeded assignment.

> +	addr = find_first_bit(indio_dev->active_scan_mask,
> +			      iio_get_masklength(indio_dev));
> +	pga = ads1018_get_pga_mode(ads1018, addr);
> +	drate = ads1018_get_data_rate_mode(ads1018, addr);

> +	cfg |= ADS1018_CFG_VALID;

	cfg = ADS1018_CFG_VALID;

> +	cfg |= FIELD_PREP(ADS1018_CFG_MUX_MASK, addr);
> +	cfg |= FIELD_PREP(ADS1018_CFG_PGA_MASK, pga);
> +	cfg |= FIELD_PREP(ADS1018_CFG_MODE_MASK, ADS1018_MODE_CONTINUOUS);
> +	cfg |= FIELD_PREP(ADS1018_CFG_DRATE_MASK, drate);

+ blank line.

> +	if (chip_info->channels[addr].type == IIO_TEMP)
> +		cfg |= ADS1018_CFG_TS_MODE_EN;
> +
> +	ads1018->tx_buf[0] = cpu_to_be16(cfg);
> +	ads1018->tx_buf[1] = 0;
> +
> +	return spi_write(ads1018->spi, ads1018->tx_buf, sizeof(ads1018->tx_buf));
> +}

...

> +static irqreturn_t ads1018_trigger_handler(int irq, void *p)
> +{
> +	struct iio_poll_func *pf = p;
> +	struct iio_dev *indio_dev = pf->indio_dev;
> +	struct ads1018 *ads1018 = iio_priv(indio_dev);
> +	struct {
> +		__be16 conv;
> +		aligned_s64 ts;
> +	} scan = {};
> +	int ret;
> +
> +	if (iio_device_claim_buffer_mode(indio_dev))
> +		goto out_notify_done;
> +
> +	if (iio_trigger_using_own(indio_dev)) {
> +		disable_irq(ads1018->drdy_irq);
> +		ret = ads1018_read_locked(ads1018, &scan.conv, true);
> +		enable_irq(ads1018->drdy_irq);
> +	} else {
> +		ret = spi_read(ads1018->spi, ads1018->rx_buf,
> +			       sizeof(ads1018->rx_buf));
> +		scan.conv = ads1018->rx_buf[0];
> +	}
> +
> +	iio_device_release_buffer_mode(indio_dev);

> +	if (!ret)
> +		iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan),
> +					    pf->timestamp);

	if (ret)
		goto out_notify_done;

// see a comment about traditional pattern somewhere above.

	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);

(and yes, leave the above on a single 82 characters long line).

> +out_notify_done:
> +	iio_trigger_notify_done(ads1018->indio_trig);
> +
> +	return IRQ_HANDLED;
> +}

...

> +static int ads1018_trigger_setup(struct iio_dev *indio_dev)
> +{
> +	struct ads1018 *ads1018 = iio_priv(indio_dev);
> +	struct spi_device *spi = ads1018->spi;

	struct device *dev = &spi->dev;

> +	int ret;

	const char con_id = "drdy";

> +	ads1018->drdy_gpiod = devm_gpiod_get_optional(&spi->dev, "drdy",
> +						      GPIOD_IN);

	ads1018->drdy_gpiod = devm_gpiod_get_optional(dev, con_id, GPIOD_IN);

and so on...

// here we already make the diff 0 LoCs

> +	if (IS_ERR(ads1018->drdy_gpiod))
> +		return dev_err_probe(&spi->dev, PTR_ERR(ads1018->drdy_gpiod),
> +				     "Failed to get 'drdy' GPIO.\n");

		return dev_err_probe(dev, PTR_ERR(ads1018->drdy_gpiod),
				     "Failed to get '%s' GPIO.\n", con_id);

> +	if (spi->irq > 0) {
> +		ads1018->drdy_irq = spi->irq;
> +	} else if (ads1018->drdy_gpiod) {
> +		ads1018->drdy_irq = gpiod_to_irq(ads1018->drdy_gpiod);
> +		if (ads1018->drdy_irq < 0)
> +			return dev_err_probe(&spi->dev, ads1018->drdy_irq,
> +					     "Failed to get IRQ from 'drdy' GPIO.\n");

			return dev_err_probe(dev, ads1018->drdy_irq,
					     "Failed to get IRQ from '%s' GPIO.\n",
					     con_id);

> +	} else {
> +		return 0;
> +	}

Can be refactored to have less indentation, though

	/* Try to retrieve an IRQ from SPI core then from GPIO */
	if (spi->irq > 0)
		ads1018->drdy_irq = spi->irq;
	else if (ads1018->drdy_gpiod)
		ads1018->drdy_irq = gpiod_to_irq(ads1018->drdy_gpiod);
	if (ads1018->drdy_irq < 0)
		return dev_err_probe(dev, ads1018->drdy_irq,
				     "Failed to get IRQ from '%s' GPIO.\n", con_id);
	/* No IRQ is fine, avoid supporting triggers */
	if (ads1018->drdy_irq == 0)
		return 0;

> +	ads1018->indio_trig = devm_iio_trigger_alloc(&spi->dev, "%s-dev%d-drdy",
> +						     indio_dev->name,
> +						     iio_device_id(indio_dev));

// and here I believe we make it 1 LoC less.

> +	if (!ads1018->indio_trig)
> +		return -ENOMEM;
> +
> +	iio_trigger_set_drvdata(ads1018->indio_trig, ads1018);
> +	ads1018->indio_trig->ops = &ads1018_trigger_ops;
> +
> +	ret = devm_iio_trigger_register(&spi->dev, ads1018->indio_trig);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The "data-ready" IRQ line is shared with the MOSI pin, thus we need
> +	 * to keep it disabled until we actually request data.
> +	 */
> +	return devm_request_irq(&spi->dev, ads1018->drdy_irq, ads1018_irq_handler,
> +			       IRQF_NO_AUTOEN, ads1018->chip_info->name, ads1018);
> +}

...

> +static int ads1018_spi_probe(struct spi_device *spi)
> +{
> +	const struct ads1018_chip_info *info = spi_get_device_match_data(spi);
> +	struct iio_dev *indio_dev;
> +	struct ads1018 *ads1018;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*ads1018));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	ads1018 = iio_priv(indio_dev);
> +	ads1018->spi = spi;
> +	ads1018->chip_info = info;
> +	spi_set_drvdata(spi, ads1018);
> +
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->name = info->name;
> +	indio_dev->info = &ads1018_iio_info;
> +	indio_dev->channels = info->channels;
> +	indio_dev->num_channels = info->num_channels;
> +
> +	for (int i = 0; i < ADS1018_CHANNELS_MAX; i++) {

unsigned int

> +		ads1018->chan_data[i].data_rate_mode = ADS1018_DRATE_DEFAULT;
> +		ads1018->chan_data[i].pga_mode = ADS1018_PGA_DEFAULT;
> +	}
> +
> +	ads1018->xfer.rx_buf = ads1018->rx_buf;
> +	ads1018->xfer.len = sizeof(ads1018->rx_buf);
> +	spi_message_init_with_transfers(&ads1018->msg_read, &ads1018->xfer, 1);
> +
> +	ret = ads1018_trigger_setup(indio_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev,
> +					      iio_pollfunc_store_time,
> +					      ads1018_trigger_handler,
> +					      &ads1018_buffer_ops);
> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}

...

> +#define ADS1018_FSR_TO_SCALE(_fsr, _res) \
> +	{ 0, ((_fsr) * MICRO) / BIT(_res) }
> +
> +static const int ads1018_gain_table[][2] = {
> +	ADS1018_FSR_TO_SCALE(6144, 11),

This won't (hmm... might not? see below for the details) work on 32-bit.

> +	ADS1018_FSR_TO_SCALE(4096, 11),
> +	ADS1018_FSR_TO_SCALE(2048, 11),
> +	ADS1018_FSR_TO_SCALE(1024, 11),
> +	ADS1018_FSR_TO_SCALE(512, 11),
> +	ADS1018_FSR_TO_SCALE(256, 11),
> +};
> +
> +static const int ads1118_gain_table[][2] = {
> +	ADS1018_FSR_TO_SCALE(6144, 15),

Ditto.

> +	ADS1018_FSR_TO_SCALE(4096, 15),
> +	ADS1018_FSR_TO_SCALE(2048, 15),
> +	ADS1018_FSR_TO_SCALE(1024, 15),
> +	ADS1018_FSR_TO_SCALE(512, 15),
> +	ADS1018_FSR_TO_SCALE(256, 15),
> +};

To address that you need to divide MICRO at least by 2
(note, by 2⁶ is also possible without loosing in precision).

// Assuming that you want to keep the initialisers as is now:
#define ADS1018_FSR_TO_SCALE(_fsr, _res) \
	{ 0, ((_fsr) * (MICRO >> 6)) / BIT((_res) - 6) }

OTOH, these all are constants, so the clever compiler (even 32-bit compiler)
may do it for you and won't complain as there is no overflow in the result.

TL;DR: Try to compile this with 32-bit compiler on 32-bit machine before
changing as suggested.

...

> +static const unsigned int ads1018_data_rate_table[] = {
> +	128, 250, 490, 920, 1600, 2400, 3300

Leave trailing comma.

> +};
> +
> +static const unsigned int ads1118_data_rate_table[] = {
> +	8, 16, 32, 64, 128, 250, 475, 860

Ditto.

> +};

-- 
With Best Regards,
Andy Shevchenko



