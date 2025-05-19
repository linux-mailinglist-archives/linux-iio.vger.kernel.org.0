Return-Path: <linux-iio+bounces-19664-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A59EAABBBEA
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 13:04:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40CF03A4FDA
	for <lists+linux-iio@lfdr.de>; Mon, 19 May 2025 11:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5A826C39C;
	Mon, 19 May 2025 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NM8V/f7P"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2511C5D59;
	Mon, 19 May 2025 11:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747652659; cv=none; b=B45WWcITcjFa62J+LDD376+9anZpQh+nLg41WBCXnnwd+EekWGcGdhw2fDG6BhTXJ8L7mrn/o/kJRMY0TlDPjxKTFGKGBWgSllUTqKS6Gwz6bTnWI9IjSdMW2MsWB7IM/WuP6FU6tar9x7AD1+5lRglhyRJsGLdY90ZtQvdnnt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747652659; c=relaxed/simple;
	bh=IFqYdA5CJmC5pnMDWMZMrcHc0IELQjmqxnRh7eOMbVU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoNVZqpeeDgK+fbzeHk3aBXrAmjm5y8kOBg/HZgm3zCLFzSSJa8IcxRUIYbV3FsjZTi+AHGGZCj8veApFGsK5SGvpTmwQ1x9Ut2rqMxCrobYnTvbKJdwMRMjsUvqVZztUBuRFG2ZTfKzi/OgaLK7Nqt866FJopiGYK1PQknUL/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NM8V/f7P; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747652658; x=1779188658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=IFqYdA5CJmC5pnMDWMZMrcHc0IELQjmqxnRh7eOMbVU=;
  b=NM8V/f7PQacW2CwOJK66l8BgE5WqPP8S3gURdsylOCaWPv3Vru3peCFn
   BCetZOrtHo8tIhtH+AasI++N/FxHFSmFlB1P2c/JRWSKMEb94HNJ4deqo
   aEgxWFu5hoKmJGvz12KFdAmBIh6javT2X9VMs+4JvFFvcH/RSsye3wV4/
   xQWdiXsGzI6ah13oB8uWk1IZExHN09aCXeMMwlN02BfYfJ4HVbtj7VV0E
   lnpireuvubPTF+skbWwvTIA1CDyhVOKcm4Sfw4vvtfniuTmJPMuEnYzNS
   jhZlFFXqcCi4SR5+9jT7970j6aZQky8TRXBnjP7w8Xd/LMnrWcTAW5+ow
   w==;
X-CSE-ConnectionGUID: UaSfB3STT9OwPTW2Vrc04w==
X-CSE-MsgGUID: uybaOrHOTYmv9DD/fNEaJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11437"; a="74947753"
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="74947753"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:04:17 -0700
X-CSE-ConnectionGUID: PjVnlk5jSzeKs83Q8Pz5tA==
X-CSE-MsgGUID: 5jNkiY8aRCK/wLvmbgswFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,300,1739865600"; 
   d="scan'208";a="176453314"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 04:04:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uGyHx-000000030Ul-49Cx;
	Mon, 19 May 2025 14:04:09 +0300
Date: Mon, 19 May 2025 14:04:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Andreas Klinger <ak@it-klinger.de>
Cc: jic23@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, lars@metafoo.de,
	javier.carrasco.cruz@gmail.com, mazziesaccount@gmail.com,
	arthur.becker@sentec.com, perdaniel.olsson@axis.com,
	mgonellabolduc@dimonoff.com, muditsharma.info@gmail.com,
	clamor95@gmail.com, emil.gedenryd@axis.com,
	devicetree@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: light: add support for veml6046x00 RGBIR
 color sensor
Message-ID: <aCsQKUwGeq4Ed4ai@smile.fi.intel.com>
References: <20250519060804.80464-1-ak@it-klinger.de>
 <20250519060804.80464-3-ak@it-klinger.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250519060804.80464-3-ak@it-klinger.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 19, 2025 at 08:08:03AM +0200, Andreas Klinger wrote:
> Add Vishay VEML6046X00 high accuracy RGBIR color sensor.
> 
> This sensor provides three colour (red, green and blue) as well as one
> infrared (IR) channel through I2C.
> 
> Support direct and buffered mode.
> 
> An optional interrupt for signaling green colour threshold underflow or
> overflow is not supported so far.

> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/regmap.h>
> +#include <linux/time.h>
> +#include <linux/types.h>
> +#include <linux/units.h>

...

> +/*
> + * veml6046x00_gain_pd - translation from gain index (used in the driver) to
> + * gain (sensor) and PD
> + * @gain_sen:	Gain used in the sensor as described in the datasheet of the
> + *		sensor
> + * @pd:		Photodiode size in the sensor

This is made to look like kernel-doc, but it's not marked as a such, why?

> + */
> +struct veml6046x00_gain_pd {
> +	int gain_sen;
> +	int pd;
> +};

...

> +/*
> + * Factors for lux / raw count in dependency of integration time (IT) as rows
> + * and driver gain in columns

Missing period at the end. Please, fix all your multi-line comments
accordingly.

> + */

...

> +	ret = regmap_clear_bits(data->regmap, VEML6046X00_REG_CONF0,
> +							VEML6046X00_CONF0_ON_0);

Something wrong with the indentation. Please, fix all places like this...

> +	if (ret) {
> +		dev_err(dev, "Failed to set bit for power on %d\n", ret);
> +		return ret;
> +	}
> +
> +	return regmap_clear_bits(data->regmap, VEML6046X00_REG_CONF1,
> +							VEML6046X00_CONF1_ON_1);

...or like this.

> +}

...

> +static int veml6046x00_get_it_index(struct veml6046x00_data *data)
> +{
> +	int ret;
> +	int reg;

Why the 'reg' is signed? regmap API doesn't operate on signed values. Please
fix all places in your code.

> +
> +	ret = regmap_field_read(data->rf.it, &reg);
> +	if (ret)
> +		return ret;
> +
> +	/* register value is identical with index of array */
> +	if ((reg < 0) || (reg >= ARRAY_SIZE(veml6046x00_it)))

in_range() ?

> +		return -EINVAL;
> +
> +	return reg;
> +}

...

> +static int veml6046x00_get_it_usec(struct veml6046x00_data *data, int *it_usec)

Same comments as per above function.

...

> +static int veml6046x00_get_val_gain_idx(struct veml6046x00_data *data, int val,
> +								int val2)
> +{
> +	u32 i;

Why fixed-width type? Wouldn't unsigned int i work?
Please, fix in all places. The rule of thumb is to use fixed-width types either
when it's HW / protocol specific, or when the respective API uses the same type.
Otherwise use PODs.

> +	int it_idx;
> +
> +	it_idx = veml6046x00_get_it_index(data);
> +	if (it_idx < 0)
> +		return it_idx;
> +
> +	for (i = 0; i < ARRAY_SIZE(veml6046x00_it_gains[it_idx]); i++) {
> +		if ((veml6046x00_it_gains[it_idx][i][0] == val) &&
> +		    (veml6046x00_it_gains[it_idx][i][1] == val2)) {
> +			return i;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}

...

> +static int veml6046x00_wait_data_available(struct iio_dev *iio, int usecs)
> +{
> +	struct veml6046x00_data *data = iio_priv(iio);
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int ret, i, cnt = 2;
> +	u8 reg[2];
> +
> +	for (i = 0; i < cnt; i++) {
> +		/*
> +		 * Note from the vendor, but not explicitly in the datasheet: we
> +		 * should always read both registers together
> +		 */
> +		ret = regmap_bulk_read(data->regmap, VEML6046X00_REG_INT_L,

Please, drop _L if not used as a single byte access.

> +							&reg, sizeof(reg));
> +		if (ret) {
> +			dev_err(dev,
> +				"Failed to read interrupt register %d\n", ret);
> +			return -EIO;
> +		}
> +
> +		if (reg[1] & VEML6046X00_INT_DRDY)
> +			return 1;
> +
> +		fsleep(usecs);
> +	}
> +
> +	return 0;
> +}

...

> +	/* integration time + 10 % to ensure completion */
> +	fsleep(it_usec + it_usec / 10);

I would suggest  / 8 as it gives much better code generation. Divisions are
slow and hard.

> +	ret = veml6046x00_wait_data_available(iio, it_usec * 10);

Also it won't mess with semantics of '10' here.

> +	if (ret != 1)

Can it return negative error? If not, why is error code shadowed?

> +		goto no_data;

...

> +static int veml6046x00_validate_part_id(struct veml6046x00_data *data)
> +{
> +	struct device *dev = regmap_get_device(data->regmap);
> +	int part_id, ret;
> +	__le16 reg;
> +
> +	ret = regmap_bulk_read(data->regmap, VEML6046X00_REG_ID,
> +							&reg, sizeof(reg));
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to read ID\n");
> +
> +	part_id = le16_to_cpu(reg);
> +	if (part_id != 0x0001)

Here you put 4 digits...

> +		dev_info(dev, "Unknown ID %#02x\n", part_id);

...and here you are expecting that it may be two only. Please, make these two
consistent.

> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



