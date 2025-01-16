Return-Path: <linux-iio+bounces-14388-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF0AA13543
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 09:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0487D188643A
	for <lists+linux-iio@lfdr.de>; Thu, 16 Jan 2025 08:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6939B1993B9;
	Thu, 16 Jan 2025 08:27:16 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8ACB194C75;
	Thu, 16 Jan 2025 08:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737016036; cv=none; b=U/6urRCjQcXAn/jOmYI2h8EXCUZc2BkJ6ysgT5lpSa7hoGzJlUnB14BoEzb5oAv8PSoAiEWgO/bocbB1BLhD/wrwOIifwjENb4CJbk/7Pxg4a6BazMtjkhAnMJEI/bLt9TrW8KFUCZDZn32uHcoNqNtoz8IjcAJLsiKO9oHYTE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737016036; c=relaxed/simple;
	bh=kD2sAW2SNaD86onQGRP5TRYwsjZIgWoXS3RT0grLpPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RET4TuBXam9Tn8n7m7POvdR3rNlvqjMnEAukfTPzAMl3yKrfTP03fwlrUsG8923huUPIOwfa8WamtPz/JrilL3TLOOf5zXk6CVgBqImMf4HNQeY6j4fG2JYmwMFDTHzF2Cz2osIOzNcgHnckAZy5lxWApvbVGq6CIJeDWD+5DlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 5YR2ZcrpTCubcTPk3i0Fcw==
X-CSE-MsgGUID: F9Xiltk2TEWSjs13GxkXZA==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="48782036"
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; 
   d="scan'208";a="48782036"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 00:27:03 -0800
X-CSE-ConnectionGUID: mLw2ANlQT+K6DHpQ4mQeRA==
X-CSE-MsgGUID: DYnOOz/QR5SGCZPYKGfY8w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,208,1732608000"; 
   d="scan'208";a="105465390"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.154])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 00:26:59 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andy@kernel.org>)
	id 1tYLDM-00000001arN-06dE;
	Thu, 16 Jan 2025 10:26:56 +0200
Date: Thu, 16 Jan 2025 10:26:55 +0200
From: Andy Shevchenko <andy@kernel.org>
To: Antoni Pokusinski <apokusinski01@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, andrej.skvortzov@gmail.com,
	neil.armstrong@linaro.org, icenowy@aosc.io, megi@xff.cz,
	danila@jiaxyga.com, javier.carrasco.cruz@gmail.com,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v4 2/2] iio: magnetometer: si7210: add driver for Si7210
Message-ID: <Z4jCz1VXVPtEDNqB@smile.fi.intel.com>
References: <20250115201622.270130-1-apokusinski01@gmail.com>
 <20250115201622.270130-3-apokusinski01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250115201622.270130-3-apokusinski01@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Jan 15, 2025 at 09:16:22PM +0100, Antoni Pokusinski wrote:
> Silicon Labs Si7210 is an I2C Hall effect magnetic position and
> temperature sensor. The driver supports the following functionalities:
> * reading the temperature measurements
> * reading the magnetic field measurements in a single-shot mode
> * choosing the magnetic field measurement scale (20 or 200 mT)

...

> +obj-$(CONFIG_SI7210) 			+= si7210.o

Looks like TAB/space mixture in the middle.

...

> +#include <asm/byteorder.h>

asm/* usually goes after linux/*

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/math64.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +#include <linux/units.h>

...

Despite a good formatting I would still add a comment with a formula in
math-human-readable form.

> +		temp = FIELD_GET(GENMASK(14, 3), dspsig);
> +		temp = div_s64(-383 * temp * temp, 100) + 160940 * temp - 279800000;
> +		temp *= (1 + (data->temp_gain / 2048));
> +		temp += (int)(MICRO / 16) * data->temp_offset;

> +		ret = regulator_get_voltage(data->vdd);
> +		if (ret < 0)
> +			return ret;
> +
> +		temp -= 222 * div_s64(ret, MILLI);

Including this piece.

> +		*val = div_s64(temp, MILLI);

...

> +static int si7210_set_scale(struct si7210_data *data, unsigned int scale)
> +{
> +	s8 *a_otp_values;
> +	int ret;
> +
> +	if (scale == 20)
> +		a_otp_values = data->scale_20_a;
> +	else if (scale == 200)
> +		a_otp_values = data->scale_200_a;
> +	else
> +		return -EINVAL;
> +
> +	guard(mutex)(&data->fetch_lock);
> +
> +	/* Write the registers 0xCA - 0xCC */
> +	ret = regmap_bulk_write(data->regmap, SI7210_REG_A0, a_otp_values, 3);
> +	if (ret)
> +		return ret;

> +	/* Write the registers 0xCE - 0xD0 */
> +	ret = regmap_bulk_write(data->regmap, SI7210_REG_A3, &a_otp_values[3], 3);
> +	if (ret)
> +		return ret;

Just to be sure I understand the above. There are two of 24-bit values or there are
two sets of 3 byte arrays? How does datasheet refers to them? What does common sense
tell us here?

> +	data->curr_scale = scale;
> +
> +	return 0;
> +}

...

Overall LGTM, there is no need for resend as I believe the three things above
may be tweaked by Jonathan. The last one can go even if there are 2 24-bit
values, but ideally in that case we should use those as a such and apply
put_unaligned_be24/le24() whichever suits better.

-- 
With Best Regards,
Andy Shevchenko



