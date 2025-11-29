Return-Path: <linux-iio+bounces-26561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D93C93F36
	for <lists+linux-iio@lfdr.de>; Sat, 29 Nov 2025 15:21:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8873A5ED0
	for <lists+linux-iio@lfdr.de>; Sat, 29 Nov 2025 14:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE1030DD27;
	Sat, 29 Nov 2025 14:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gnl7+dd/"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70F0F205E02;
	Sat, 29 Nov 2025 14:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764426108; cv=none; b=SseLbE+tpunJhTxxo2l9FpnWroHM/iWdP/ld9jcfNF9XQ2KzrwuKXDT+lCNnc5GTPPzWNJrViTeGeh4iPFpaFY3UBu5CmuO949qJn65J5MGim9OWNFzUCr5kzukg70i46ZKFbBfhUQ4Yaqm8s1vaISXwE4jwMf6j99kHspVNx1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764426108; c=relaxed/simple;
	bh=UdDbD5UtZgU/9GIr/N6IdLUsM5nwsb0t+buYE61fspA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UkAzSfGdrN4Z8VieiHibHasxQM6dznWdTAZpvKLEOOllj54T9wt/SX2wn9HB0GhzvbetOz0kEh5Odnq3eihdAzyLWhB8CEkPpMyPjp7EWtPdIjEp9uRsyLjadkIqLkKKOJ3xVM3reW54iMjAiHP04HooXm5WVp3M3/QvlE0i9a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gnl7+dd/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764426107; x=1795962107;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=UdDbD5UtZgU/9GIr/N6IdLUsM5nwsb0t+buYE61fspA=;
  b=gnl7+dd/sJmaEQoJp8+n7VZy/HoHjY8tsXRr4iO4GXCxqa6tGRmRBUox
   0qI+2cWx0DsvJgxW77m/i2EaNRZEbgQbSkOusBNYnQvdmdWEjZdQofMTD
   vw0qVqKrNoFlWh0Vr94/JejHsxYDztt238DbItCOah884ZvGj/qu+pv3W
   wXMQbTcMyG0Ub1mx7G1tfkzRDhqtZIl48mswstZrTAQZwh7W/nYT4jrij
   hugEJ6KyDAewNfTUz1e3PzK+VP36u8KutDVlzdOFVvjjr160q/equP2PX
   Ef7jhXqb+jLLdN+30CIX1Zg+fb1kYkblwYEa02N1p1HYlhiVT+SL0hwqP
   w==;
X-CSE-ConnectionGUID: RoW91CGJTcmLoKlFxEuKaw==
X-CSE-MsgGUID: Rakh417nQei+Tzhp97WkyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11627"; a="89070756"
X-IronPort-AV: E=Sophos;i="6.20,236,1758610800"; 
   d="scan'208";a="89070756"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 06:21:46 -0800
X-CSE-ConnectionGUID: l6/GZCkJQ7Kj/tixSQk0iA==
X-CSE-MsgGUID: XgHuhJcOT3WBAhUw9NUrWw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,236,1758610800"; 
   d="scan'208";a="193453296"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 06:21:42 -0800
Date: Sat, 29 Nov 2025 16:21:40 +0200
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
Subject: Re: [PATCH v3 2/2] iio: adc: Add ti-ads1018 driver
Message-ID: <aSsBdJZDWcadxEHC@smile.fi.intel.com>
References: <20251128-ads1x18-v3-0-a6ebab815b2d@gmail.com>
 <20251128-ads1x18-v3-2-a6ebab815b2d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128-ads1x18-v3-2-a6ebab815b2d@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Nov 28, 2025 at 10:47:13PM -0500, Kurt Borja wrote:
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

Thank you for the update, my comments below.

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitmap.h>

> +#include <linux/byteorder/generic.h>

Must be asm/byteorder.h after the linux/* generic group...

> +#include <linux/dev_printk.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/interrupt.h>
> +#include <linux/math.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/spi/spi.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +

...here

#include <asm/byteorder.h>
+ blank line.

...

> +static void ads1018_set_data_rate_mode(struct ads1018 *ads1018, unsigned int address,
> +				       u8 val)

It's a bit too long.

static void ads1018_set_data_rate_mode(struct ads1018 *ads1018,
				       unsigned int address, u8 val)

...

> +static void ads1018_set_pga_mode(struct ads1018 *ads1018, unsigned int address,
> +				 u8 val)

This is not so, but I would resplit logically, either

static void ads1018_set_pga_mode(struct ads1018 *ads1018, unsigned int address, u8 val)

(however it's significantly longer than 80 limit)

OR

static void ads1018_set_pga_mode(struct ads1018 *ads1018,
				 unsigned int address, u8 val)

(better and consistent with the above).

...

> +/**
> + * ads1018_calc_delay - Calculates an appropriate delay for a single-shot
> + *			reading

Having this on a single line is fine I suppose.

> + * @ad1018: Device data
> + *
> + * Calculates an appropriate delay for a single shot reading, assuming the
> + * device's maximum data-rate is used.
> + *
> + * Context: Expects iio_device_claim_direct() is held.
> + *
> + * Return: Delay in microseconds.

Does 0 have any special meaning?

> + */

...

> +	/* We subtract 10% data-rate error */
> +	hz -= DIV_ROUND_UP(hz, 10);

Hmm... For delays I expect to see adding 10% to have a good margin.

...

> + * Context: Expects spi_bus_lock() is held.

Do we have a lockdep assert for this?

...

> +static int ads1018_read_unlocked(struct ads1018 *ads1018, __be16 *cnv, bool hold_cs)

Hmm... Don't we want to return value in CPU order? I don't know the answer
here, and IIRC IIO triggers might be actually good with endianess conversion
done, if required, in user space.

...

> + * Context: Expects iio_device_claim_direct() is held.

Jonathan et al., do we have lockdep assert available for this?
I really prefer to see the code for it, while comment is good,
it is not good enough.

...

> +static int
> +ads1018_write_raw_unlocked(struct iio_dev *indio_dev, struct iio_chan_spec const *chan,
> +			   int val, int val2, long mask)
> +{
> +	struct ads1018 *ads1018 = iio_priv(indio_dev);
> +	const struct ads1018_chip_info *info = ads1018->chip_info;
> +	unsigned int i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		for (i = 0; i < info->num_pga_mode_to_gain; i++) {
> +			if (val == info->pga_mode_to_gain[i][0] &&
> +			    val2 == info->pga_mode_to_gain[i][1])
> +				break;
> +		}

> +

You can remove this blank line as the condition is tighten with the for-loop.
But up to you, I'm fine with either.

> +		if (i == info->num_pga_mode_to_gain)
> +			return -EINVAL;
> +
> +		ads1018_set_pga_mode(ads1018, chan->scan_index, i);
> +		return 0;
> +
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		for (i = 0; i < info->num_data_rate_mode_to_hz; i++) {
> +			if (val == info->data_rate_mode_to_hz[i])
> +				break;
> +		}

> +

Ditto.

> +		if (i == info->num_data_rate_mode_to_hz)
> +			return -EINVAL;
> +
> +		ads1018_set_data_rate_mode(ads1018, chan->scan_index, i);
> +		return 0;
> +
> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}

...

> +	if (iio_device_claim_buffer_mode(indio_dev))
> +		goto out_notify_done;
> +
> +	if (iio_trigger_using_own(indio_dev)) {
> +		disable_irq(ads1018->drdy_irq);
> +		ret = ads1018_read_unlocked(ads1018, &scan.conv, true);
> +		enable_irq(ads1018->drdy_irq);
> +	} else {
> +		ret = spi_read(ads1018->spi, ads1018->rx_buf, sizeof(ads1018->rx_buf));
> +		scan.conv = ads1018->rx_buf[0];
> +	}
> +
> +	iio_device_release_buffer_mode(indio_dev);
> +
> +	if (ret)
> +		goto out_notify_done;
> +
> +	iio_push_to_buffers_with_ts(indio_dev, &scan, sizeof(scan), pf->timestamp);
> +
> +out_notify_done:
> +	iio_trigger_notify_done(ads1018->indio_trig);

Jonathan et al., maybe we need an ACQUIRE() class for this? It will solve
the conditional scoped guard case, no?

...

> +static int ads1018_trigger_setup(struct iio_dev *indio_dev)
> +{
> +	struct ads1018 *ads1018 = iio_priv(indio_dev);
> +	struct spi_device *spi = ads1018->spi;
> +	struct device *dev = &spi->dev;
> +	const char *con_id = "drdy";
> +	int ret;
> +
> +	ads1018->drdy_gpiod = devm_gpiod_get_optional(dev, con_id, GPIOD_IN);
> +	if (IS_ERR(ads1018->drdy_gpiod))
> +		return dev_err_probe(dev, PTR_ERR(ads1018->drdy_gpiod),
> +				     "Failed to get %s GPIO.\n", con_id);
> +
> +	/* First try to get IRQ from SPI core, then from GPIO */
> +	if (spi->irq > 0)
> +		ads1018->drdy_irq = spi->irq;
> +	else if (ads1018->drdy_gpiod)
> +		ads1018->drdy_irq = gpiod_to_irq(ads1018->drdy_gpiod);
> +	if (ads1018->drdy_irq < 0)
> +		return dev_err_probe(dev, ads1018->drdy_irq,
> +				     "Failed to get IRQ from %s GPIO.\n", con_id);
> +
> +	/* An IRQ line is only an optional requirement for the IIO trigger */
> +	if (ads1018->drdy_irq == 0)
> +		return 0;
> +
> +	ads1018->indio_trig = devm_iio_trigger_alloc(dev, "%s-dev%d-drdy", indio_dev->name,
> +						     iio_device_id(indio_dev));

	ads1018->indio_trig = devm_iio_trigger_alloc(dev, "%s-dev%d-%s",
						     indio_dev->name,
						     iio_device_id(indio_dev),
						     con_id);

This also will be kept below 80 limit.

> +	if (!ads1018->indio_trig)
> +		return -ENOMEM;
> +
> +	iio_trigger_set_drvdata(ads1018->indio_trig, ads1018);
> +	ads1018->indio_trig->ops = &ads1018_trigger_ops;
> +
> +	ret = devm_iio_trigger_register(dev, ads1018->indio_trig);
> +	if (ret)
> +		return ret;
> +
> +	/*
> +	 * The "data-ready" IRQ line is shared with the MOSI pin, thus we need
> +	 * to keep it disabled until we actually request data.
> +	 */
> +	return devm_request_irq(dev, ads1018->drdy_irq, ads1018_irq_handler,
> +				IRQF_NO_AUTOEN, ads1018->chip_info->name, ads1018);
> +}

...

> +static int ads1018_spi_probe(struct spi_device *spi)
> +{
> +	const struct ads1018_chip_info *info = spi_get_device_match_data(spi);

	struct device *dev = &spi->dev;

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
> +	for (unsigned int i = 0; i < ADS1018_CHANNELS_MAX; i++) {
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

> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, iio_pollfunc_store_time,
> +					      ads1018_trigger_handler, &ads1018_buffer_ops);

Too long. With the above done

	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
					      iio_pollfunc_store_time,
					      ads1018_trigger_handler,
					      &ads1018_buffer_ops);

> +	if (ret)
> +		return ret;
> +
> +	return devm_iio_device_register(&spi->dev, indio_dev);
> +}

...

> +/**
> + * ADS1018_FSR_TO_SCALE - Converts FSR into scale
> + * @_fsr: Full-scale range in millivolts
> + * @_res: ADC resolution

Add here something like this:

*
* The macro is crafted to avoid potential overflows on 32-bit machines.
* This imposes restrictions to the possible values for @_fsr (less
* than 274878), and @_res (great or equal to 6 bits).
*

> + * Return: Scale in IIO_VAL_INT_PLUS_NANO format
> + */
> +#define ADS1018_FSR_TO_SCALE(_fsr, _res) \
> +	{ 0, ((_fsr) * (MICRO >> 6)) / BIT((_res) - 6) }

-- 
With Best Regards,
Andy Shevchenko



