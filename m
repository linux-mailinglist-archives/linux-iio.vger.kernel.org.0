Return-Path: <linux-iio+bounces-23094-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5BFB2F3BF
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 11:23:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7443AA22BDC
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 09:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 840C02E7F2D;
	Thu, 21 Aug 2025 09:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cMcRzcND"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4040E2E7F2C;
	Thu, 21 Aug 2025 09:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768062; cv=none; b=I6Wh9AoNfC/SigOnDKXnTU6frKl3PVYZnDclgPbZxwLFZWNrfeHjVDoWsG104/ziE4/++5b2OcmqqHBfrRS3hRvaNDPjZcAVj173yGTOkXK6kcJ4N72BrRFn9Lm35Th2fqbwi+N9jYEm3YHxevniSt4E47HNrbojWDcCg6rz3eU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768062; c=relaxed/simple;
	bh=vU4EYdc/EKoe2WBmkLeZxO2806sbca6uZyVv9w0qr8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVxK70wO6KKnrHElITfsQuxv8BhFZx0n5Yz0k3Nbc3jdkO/TvJUL4e1X9QZTkQ9eSh0oTT4DE6kesJ3SeJ8TZ3HGcU3fR+ds0VmOoASf4dlnax/iCeDVH59ty49n2QfPX/H/01vd7DDG40EnIMGWi3obps9ycmHSgiw1YvzPzoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cMcRzcND; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755768060; x=1787304060;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vU4EYdc/EKoe2WBmkLeZxO2806sbca6uZyVv9w0qr8s=;
  b=cMcRzcNDmaI09CvS+gA/WjT43yGoNBtgMVHwUIucigrSj1WCe2aG1eyt
   c8P+o9uPjKm/iZkG8K9YfGJLAXgqUUryKJSJYmU1mhCQOi9Y5uvoTKPlU
   f9AMfK3rtyHJa8y+xv3yjd752suvwnNbTj2ZqwqybiTU+k7etNA3jhEif
   dHxxWtV6AAD/ZGUi3umORdloA50VZwwZI88VAGaUh4/REjlD3dkOZgYmi
   dRt1LbEMNChsfo4pYsYKJcXChBNJTqL+86RTcvL9Dl9qrZn59DT9FB/Id
   ahzM+/TofaeOAMwcmYMxwYFxortw8Y1Cl6/G99PHaYCy06LSDb7TAMpBG
   g==;
X-CSE-ConnectionGUID: /o5yjpQtSEeED8L23mCGHw==
X-CSE-MsgGUID: t4fbmDz9Qhup3uVE3PZVsA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="83471154"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="83471154"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 02:21:00 -0700
X-CSE-ConnectionGUID: fiYNp7w5RfuNh0l9nedrUQ==
X-CSE-MsgGUID: NcNxE3BVTcyY9WQ0piuGlg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="167577746"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 02:20:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1up1TZ-00000007BPf-2glW;
	Thu, 21 Aug 2025 12:20:53 +0300
Date: Thu, 21 Aug 2025 12:20:53 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: remi.buisson@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v5 3/9] iio: imu: inv_icm45600: add buffer support in iio
 devices
Message-ID: <aKbk9WYtfb5L5la4@smile.fi.intel.com>
References: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
 <20250820-add_newport_driver-v5-3-2fc9f13dddee@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250820-add_newport_driver-v5-3-2fc9f13dddee@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 20, 2025 at 02:24:21PM +0000, Remi Buisson via B4 Relay wrote:
> 
> Add FIFO control functions.
> Support hwfifo watermark by multiplexing gyro and accel settings.
> Support hwfifo flush.

...

> +#define INV_ICM45600_SENSOR_CONF_KEEP_VALUES {U8_MAX, U8_MAX, U8_MAX, U8_MAX, }

When one line, no need to have inner trailing comma, besides that missed space.

...

> +{
> +	unsigned int mask, val;
> +	int ret;
> +
> +	/* Update only FIFO EN bits. */
> +	mask = INV_ICM45600_FIFO_CONFIG3_GYRO_EN |
> +	       INV_ICM45600_FIFO_CONFIG3_ACCEL_EN;

> +	val = 0;

Why not to put it under else branch?

> +	if ((fifo_en & INV_ICM45600_SENSOR_GYRO) || (fifo_en & INV_ICM45600_SENSOR_ACCEL))
> +		val = (INV_ICM45600_FIFO_CONFIG3_GYRO_EN | INV_ICM45600_FIFO_CONFIG3_ACCEL_EN);
> +
> +	ret = regmap_update_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG3, mask, val);
> +	if (ret)
> +		return ret;
> +
> +	st->fifo.en = fifo_en;
> +	inv_icm45600_buffer_update_fifo_period(st);
> +
> +	return 0;
> +}

...

> +static unsigned int inv_icm45600_wm_truncate(unsigned int watermark, size_t packet_size,
> +					     unsigned int fifo_period)
> +{
> +	size_t watermark_max, grace_samples;
> +
> +	/* Keep 20ms for processing FIFO. fifo_period is in ns */
> +	grace_samples = (20U * 1000000U) / fifo_period;

We have NSEC_PER_MSEC, other similar constants, check respective time.h and units.h.

> +	if (grace_samples < 1)
> +		grace_samples = 1;
> +
> +	watermark_max = INV_ICM45600_FIFO_SIZE_MAX / packet_size;
> +	watermark_max -= grace_samples;
> +
> +	return min(watermark, watermark_max);

Where is the header for min()?

> +}

...

> +/**
> + * inv_icm45600_buffer_update_watermark - update watermark FIFO threshold
> + * @st:	driver internal state

> + * Returns 0 on success, a negative error code otherwise.

Return section is missed and has to be the last one. Please, read how to create
proper kernel-doc.

> + * FIFO watermark threshold is computed based on the required watermark values
> + * set for gyro and accel sensors. Since watermark is all about acceptable data
> + * latency, use the smallest setting between the 2. It means choosing the
> + * smallest latency but this is not as simple as choosing the smallest watermark
> + * value. Latency depends on watermark and ODR. It requires several steps:
> + * 1) compute gyro and accel latencies and choose the smallest value.
> + * 2) adapt the chosen latency so that it is a multiple of both gyro and accel
> + *    ones. Otherwise it is possible that you don't meet a requirement. (for
> + *    example with gyro @100Hz wm 4 and accel @100Hz with wm 6, choosing the
> + *    value of 4 will not meet accel latency requirement because 6 is not a
> + *    multiple of 4. You need to use the value 2.)
> + * 3) Since all periods are multiple of each others, watermark is computed by
> + *    dividing this computed latency by the smallest period, which corresponds
> + *    to the FIFO frequency.
> + */
> +int inv_icm45600_buffer_update_watermark(struct inv_icm45600_state *st)
> +{
> +	const size_t packet_size = sizeof(struct inv_icm45600_fifo_2sensors_packet);
> +	unsigned int wm_gyro, wm_accel, watermark;
> +	u32 period_gyro, period_accel, period;
> +	u32 latency_gyro, latency_accel, latency;
> +
> +	/* Compute sensors latency, depending on sensor watermark and odr. */
> +	wm_gyro = inv_icm45600_wm_truncate(st->fifo.watermark.gyro, packet_size,
> +					   st->fifo.period);
> +	wm_accel = inv_icm45600_wm_truncate(st->fifo.watermark.accel, packet_size,
> +					    st->fifo.period);
> +	/* Use us for odr to avoid overflow using 32 bits values. */
> +	period_gyro = inv_icm45600_odr_to_period(st->conf.gyro.odr) / 1000UL;
> +	period_accel = inv_icm45600_odr_to_period(st->conf.accel.odr) / 1000UL;

Replace 1000UL by the respective predefined constants.

> +	latency_gyro = period_gyro * wm_gyro;
> +	latency_accel = period_accel * wm_accel;
> +
> +	/* 0 value for watermark means that the sensor is turned off. */
> +	if (wm_gyro == 0 && wm_accel == 0)
> +		return 0;
> +
> +	if (latency_gyro == 0) {
> +		watermark = wm_accel;
> +		st->fifo.watermark.eff_accel = wm_accel;
> +	} else if (latency_accel == 0) {
> +		watermark = wm_gyro;
> +		st->fifo.watermark.eff_gyro = wm_gyro;
> +	} else {
> +		/* Compute the smallest latency that is a multiple of both. */
> +		if (latency_gyro <= latency_accel)
> +			latency = latency_gyro - (latency_accel % latency_gyro);
> +		else
> +			latency = latency_accel - (latency_gyro % latency_accel);
> +		/* Use the shortest period. */
> +		period = min(period_gyro, period_accel);
> +		/* All this works because periods are multiple of each others. */
> +		watermark = max(latency / period, 1);
> +		/* Update effective watermark. */
> +		st->fifo.watermark.eff_gyro = max(latency / period_gyro, 1);
> +		st->fifo.watermark.eff_accel = max(latency / period_accel, 1);
> +	}
> +
> +

One blank line is enough.

> +	st->buffer.u16 = cpu_to_le16(watermark);
> +	return regmap_bulk_write(st->map, INV_ICM45600_REG_FIFO_WATERMARK,
> +				 &st->buffer.u16, sizeof(st->buffer.u16));
> +}

...

...

> +	if (sensor == INV_ICM45600_SENSOR_GYRO)
> +		ret = inv_icm45600_set_gyro_conf(st, &conf, sleep);
> +	else
> +		ret = inv_icm45600_set_accel_conf(st, &conf, sleep);
> +
> +	return ret;

Just return directly in the branches.

...

> +int inv_icm45600_buffer_fifo_read(struct inv_icm45600_state *st)
> +{
> +	const ssize_t packet_size = sizeof(struct inv_icm45600_fifo_2sensors_packet);
> +	__le16 *raw_fifo_count;
> +	size_t fifo_nb, i;
> +	ssize_t size;
> +	const struct inv_icm45600_fifo_sensor_data *accel, *gyro;
> +	const __le16 *timestamp;
> +	const s8 *temp;
> +	unsigned int odr;
> +	int ret;
> +
> +	/* Reset all samples counters. */
> +	st->fifo.count = 0;
> +	st->fifo.nb.gyro = 0;
> +	st->fifo.nb.accel = 0;
> +	st->fifo.nb.total = 0;
> +
> +	/* Read FIFO count value. */
> +	raw_fifo_count = &st->buffer.u16;
> +	ret = regmap_bulk_read(st->map, INV_ICM45600_REG_FIFO_COUNT,
> +			       raw_fifo_count, sizeof(*raw_fifo_count));
> +	if (ret)
> +		return ret;

+ blank line

> +	fifo_nb = le16_to_cpup(raw_fifo_count);
> +
> +	/* Check and limit number of samples if requested. */
> +	if (fifo_nb == 0)
> +		return 0;

Better to reformat as

	/* Check and limit number of samples if requested. */
	fifo_nb = le16_to_cpup(raw_fifo_count);
	if (fifo_nb == 0)
		return 0;

> +	/* Try to read all FIFO data in internal buffer. */
> +	st->fifo.count = fifo_nb * packet_size;
> +	ret = regmap_noinc_read(st->map, INV_ICM45600_REG_FIFO_DATA,
> +				st->fifo.data, st->fifo.count);
> +	if (ret == -ENOTSUPP || ret == -EFBIG) {

Strictly speaking this is a bit of layering issue, do we have other means to
check the support before even trying?

> +		/* Read full fifo is not supported, read samples one by one. */
> +		ret = 0;
> +		for (i = 0; i < st->fifo.count && ret == 0; i += packet_size)
> +			ret = regmap_noinc_read(st->map, INV_ICM45600_REG_FIFO_DATA,
> +						&st->fifo.data[i], packet_size);
> +	}
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < st->fifo.count; i += size) {
> +		size = inv_icm45600_fifo_decode_packet(&st->fifo.data[i], &accel, &gyro,
> +						       &temp, &timestamp, &odr);
> +		if (size <= 0)

Doesn't size < 0 is an error condition that should be returned?

> +			break;
> +		if (gyro != NULL && inv_icm45600_fifo_is_data_valid(gyro))
> +			st->fifo.nb.gyro++;
> +		if (accel != NULL && inv_icm45600_fifo_is_data_valid(accel))
> +			st->fifo.nb.accel++;

Drop ' != NULL' parts.

> +		st->fifo.nb.total++;
> +	}
> +
> +	return 0;
> +}

...

> +int inv_icm45600_buffer_init(struct inv_icm45600_state *st)
> +{
> +	int ret;
> +	unsigned int val;
> +
> +	st->fifo.watermark.eff_gyro = 1;
> +	st->fifo.watermark.eff_accel = 1;
> +
> +	/* Disable all FIFO EN bits. */
> +	ret = regmap_write(st->map, INV_ICM45600_REG_FIFO_CONFIG3, 0);
> +	if (ret)
> +		return ret;
> +
> +	/* Disable FIFO and set depth. */
> +	val = FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
> +			 INV_ICM45600_FIFO_CONFIG0_MODE_BYPASS);
> +	val |= INV_ICM45600_FIFO_CONFIG0_FIFO_DEPTH_MAX;

FIELD_MODIFY()

> +	ret = regmap_write(st->map, INV_ICM45600_REG_FIFO_CONFIG0, val);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable only timestamp in fifo, disable compression. */
> +	ret = regmap_write(st->map, INV_ICM45600_REG_FIFO_CONFIG4,
> +			   INV_ICM45600_FIFO_CONFIG4_TMST_FSYNC_EN);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable FIFO continuous watermark interrupt. */
> +	return regmap_set_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG2,
> +			       INV_ICM45600_REG_FIFO_CONFIG2_WM_GT_TH);
> +}

...

> +#ifndef INV_ICM45600_BUFFER_H_
> +#define INV_ICM45600_BUFFER_H_
> +
> +#include <linux/bits.h>
> +#include <linux/iio/iio.h>
> +#include <linux/types.h>

IWYU, please.

...

> +/* FIFO data packet */
> +struct inv_icm45600_fifo_sensor_data {
> +	__le16 x;
> +	__le16 y;
> +	__le16 z;
> +} __packed;

Why __packed? Do you expect this to be on unaligned addresses?

...

> +#define INV_ICM45600_DATA_INVALID		S16_MIN

limits.h?

...

> +static inline s16 inv_icm45600_fifo_get_sensor_data(__le16 d)
> +{
> +	return le16_to_cpu(d);

asm/byteorder.h ?

> +}

...

> +static inline bool
> +inv_icm45600_fifo_is_data_valid(const struct inv_icm45600_fifo_sensor_data *s)
> +{
> +	s16 x, y, z;
> +
> +	x = inv_icm45600_fifo_get_sensor_data(s->x);
> +	y = inv_icm45600_fifo_get_sensor_data(s->y);
> +	z = inv_icm45600_fifo_get_sensor_data(s->z);
> +
> +	if (x == INV_ICM45600_DATA_INVALID &&
> +	    y == INV_ICM45600_DATA_INVALID &&
> +	    z == INV_ICM45600_DATA_INVALID)
> +		return false;
> +
> +	return true;

'if' can be avoided. But it's up to you. All depends on the readability of the
end result.

> +}

...

> +/**
> + * inv_icm45600_irq_init() - initialize int pin and interrupt handler
> + * @st:		driver internal state
> + * @irq:	irq number
> + * @irq_type:	irq trigger type
> + * @open_drain:	true if irq is open drain, false for push-pull
> + *
> + * Returns 0 on success, a negative error code otherwise.

kernel-doc validation...

> + */

...

> +	st->fifo.data = devm_kzalloc(dev, 8192, GFP_KERNEL);
> +	if (!st->fifo.data)
> +		return dev_err_probe(dev, -ENOMEM, "Cannot allocate fifo memory\n");

HAve you checked what will happen in this case? Please, take a look and update
the code accordingly.

...

> -	scoped_guard(mutex, &st->lock)
> +	scoped_guard(mutex, &st->lock) {

Ah, nice. It should have been done in the first place and put a comment to that
patch that scoped_guard() {} used specifically for limiting churn in the next
changes.

>  		/* Restore sensors state. */
>  		ret = inv_icm45600_set_pwr_mgmt0(st, st->suspended.gyro,

> -						st->suspended.accel, NULL);
> +						 st->suspended.accel, NULL);

Stray change.

> +		if (ret)
> +			return ret;
> +
> +		/* Restore FIFO data streaming. */
> +		if (st->fifo.on) {
> +			struct inv_icm45600_sensor_state *gyro_st = iio_priv(st->indio_gyro);
> +			struct inv_icm45600_sensor_state *accel_st = iio_priv(st->indio_accel);
> +			unsigned int val;
> +
> +			inv_sensors_timestamp_reset(&gyro_st->ts);
> +			inv_sensors_timestamp_reset(&accel_st->ts);
> +			val = FIELD_PREP(INV_ICM45600_FIFO_CONFIG0_MODE_MASK,
> +					 INV_ICM45600_FIFO_CONFIG0_MODE_STREAM);
> +			ret = regmap_update_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG0,
> +						 INV_ICM45600_FIFO_CONFIG0_MODE_MASK, val);
> +			if (ret)
> +				return ret;
> +			/* FIFO_CONFIG3_IF_EN must only be set at end of FIFO the configuration */
> +			ret = regmap_set_bits(st->map, INV_ICM45600_REG_FIFO_CONFIG3,
> +					      INV_ICM45600_FIFO_CONFIG3_IF_EN);

This relies on the code elsewhere, much better to return here if an error
condition happened.

> +		}
> +	}

-- 
With Best Regards,
Andy Shevchenko



