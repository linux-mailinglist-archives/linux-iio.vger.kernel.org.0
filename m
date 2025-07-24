Return-Path: <linux-iio+bounces-21963-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A99DB109C9
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 13:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD0121CE3C96
	for <lists+linux-iio@lfdr.de>; Thu, 24 Jul 2025 11:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F672BE65F;
	Thu, 24 Jul 2025 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KXfE7Ccq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A972D2BE64D;
	Thu, 24 Jul 2025 11:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753358377; cv=none; b=PMvakwA1HOulXH/fcm3mkWRsHLKkfymWqYWhPFnRoV64JW4R+QVAtk47Hcnv4rTky3+tWvIeG0B/g7Zb4+kDwJ4aEVmtvs4HmJoX36HkEqPB/dR6dPHS5QFT28fvoCQRmPYkzlFfKhkGC5/lHa80gqf3fcIuajz7oFTBc8lUcWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753358377; c=relaxed/simple;
	bh=CMH0l4+WonwuVb8Q3WHTY7onH6od/lW182gr3U40Jno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hRQJ1zSACbERKFaSOb66ZjH5VtWd5BLHW8Hg+wbDSPr30vSoTDxsDxoVW6S7ANr6rT+zc3P14QFEDWlEoadlQdj2QonlpvEAG5Ydf7ZA7iWFsIUEfGTOxjIuGMr2/CQq3ge1pIoTDApIfCJfWMASz1wcUiWd4wIidRPju2wocNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KXfE7Ccq; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753358376; x=1784894376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CMH0l4+WonwuVb8Q3WHTY7onH6od/lW182gr3U40Jno=;
  b=KXfE7CcqkI2GFKdz0Y95/pRAjQiibZmvnBI7U3wTCO4rpQFIQ00tNDux
   iLmV++e9QrO97/AF6M1HRbfzLYy1IMa8OsBY0fCTJnuelG894+0Fk2oVa
   VAXfMPDQQUJ5hsS8UV0KobEB/zv6FzDROFK+i6vP1CFqgbL1DA/NFyxFy
   9Y0Gl5yl8SJ9hQGiT0XjRfGTlutFaF+dFWjB7cJ8iz7qS2VNXqVG+az2J
   5oAjubpbaaGU35BYfqWp8MEHlHXUalVPjBQMMyJr6WySbeidUx53HgQk1
   8Smlp6/K46RPsyLmvC5CaFD9urJV5HMNktmGlQzkXOdi7CsAcdslBp7FS
   A==;
X-CSE-ConnectionGUID: ArRKWj5lS66r87ImMMhLwg==
X-CSE-MsgGUID: whe/abxkSj+MPgAGVpLzhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55758467"
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="55758467"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 04:59:35 -0700
X-CSE-ConnectionGUID: cny3gf/USReosG6t0rfpww==
X-CSE-MsgGUID: AKV3lkFcRtWuU8Uu4+azDQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,337,1744095600"; 
   d="scan'208";a="160501958"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 04:59:30 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ueube-00000000Ypn-0Frq;
	Thu, 24 Jul 2025 14:59:26 +0300
Date: Thu, 24 Jul 2025 14:59:25 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lakshay Piplani <lakshay.piplani@nxp.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, marcelo.schmitt1@gmail.com,
	gregkh@linuxfoundation.org, viro@zeniv.linux.org.uk,
	peterz@infradead.org, jstephan@baylibre.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
	vikash.bansal@nxp.com, priyanka.jain@nxp.com,
	shashank.rebbapragada@nxp.com, Frank.Li@nxp.com,
	carlos.song@nxp.com, xiaoning.wang@nxp.com, haibo.chen@nxp.com
Subject: Re: [PATCH 2/2] iio: temperature: Add driver for NXP P3T175x
 temperature sensor.
Message-ID: <aIIgHV38kKsPVCUN@smile.fi.intel.com>
References: <20250724083951.2273717-1-lakshay.piplani@nxp.com>
 <20250724083951.2273717-2-lakshay.piplani@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250724083951.2273717-2-lakshay.piplani@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 24, 2025 at 02:09:51PM +0530, Lakshay Piplani wrote:
> Add support for the NXP P3T175x (P3T1755/P3T1750)
> family of temperature sensor devices. These devices
> communicates via both I2C or I3C interfaces.

...

>  drivers/iio/temperature/p3t/Kconfig        |  89 ++++
>  drivers/iio/temperature/p3t/Makefile       |   5 +
>  drivers/iio/temperature/p3t/p3t1755.h      |  60 +++
>  drivers/iio/temperature/p3t/p3t1755_core.c | 513 +++++++++++++++++++++

>  drivers/iio/temperature/p3t/p3t1755_i2c.c  | 142 ++++++
>  drivers/iio/temperature/p3t/p3t1755_i3c.c  | 147 ++++++

Please, split glue drivers in a separate patches. At bare minimum it will help
reviewing the core part.

...

> +// Conversion rate table: maps bits to sampling frequency
> +static const struct {
> +	u8 bits;
> +	int freq_hz;

Can frequency be negative?

> +} p3t1755_samp_freqs[] = {
> +	{ 0x00, 36 }, // 27.5 ms
> +	{ 0x01, 18 }, // 55 ms (default)
> +	{ 0x02, 9 }, // 110 ms
> +	{ 0x03, 4 }, // 220 ms

If you need ms, make the field to be ms and not Hz.
Otherwise drop unneeded comments. Conversion from Hz to s is straightforward
for the 101 in school for physics.

> +};

...

> +int p3t1755_fault_queue_to_bits(int val)
> +{
> +	int i;

Why signed?

> +	for (i = 0; i < ARRAY_SIZE(p3t1755_fault_queue_values); i++)
> +		if (p3t1755_fault_queue_values[i] == val)
> +			return i;
> +	return -EINVAL;
> +}

...

> +int p3t1755_get_temp_and_limits(struct p3t1755_data *data,
> +				int *temp_mc, int *thigh_mc, int *tlow_mc)
> +{
> +	u8 buf[2];

Not a proper bitwise endianess-aware type?

> +	int ret;
> +
> +	ret = regmap_bulk_read(data->regmap, P3T1755_REG_TEMP, buf, 2);
> +	if (ret) {
> +		dev_dbg(data->dev, "Failed to read TEMP register: %d\n", ret);
> +		return ret;
> +	}
> +	*temp_mc = (((buf[0] << 8) | buf[1]) >> 4) * P3T1755_RESOLUTION_10UC / 1000;

Use constant from units.h or from time.h.

> +	dev_dbg(data->dev, "TEMP raw: 0x%02x%02x, temp_mc: %d\n",
> +		buf[0], buf[1], *temp_mc);

Printing raw with proper 126-bit type will be easier.

> +	ret = regmap_bulk_read(data->regmap, P3T1755_REG_HIGH_LIM, buf, 2);

sizeof()

> +	if (ret) {
> +		dev_dbg(data->dev, "Failed to read HIGH_LIM register: %d\n", ret);
> +		return ret;
> +	}
> +	*thigh_mc = (((buf[0] << 8) | buf[1]) >> 4) * P3T1755_RESOLUTION_10UC / 1000;
> +	dev_dbg(data->dev, "HIGH_LIM raw: 0x%02x%02x, thigh_mc: %d\n",
> +		buf[0], buf[1], *thigh_mc);
> +
> +	ret = regmap_bulk_read(data->regmap, P3T1755_REG_LOW_LIM, buf, 2);
> +	if (ret) {
> +		dev_dbg(data->dev, "Failed to read LOW_LIM register: %d\n", ret);
> +		return ret;
> +	}
> +	*tlow_mc = (((buf[0] << 8) | buf[1]) >> 4) * P3T1755_RESOLUTION_10UC / 1000;
> +	dev_dbg(data->dev, "LOW_LIM raw: 0x%02x%02x, tlow_mc: %d\n",
> +		buf[0], buf[1], *tlow_mc);
> +
> +	dev_dbg(data->dev, "Successfully read all temperature values\n");
> +	return 0;
> +}

...

> +#include <linux/kernel.h>

No way this header should be in a new code.

> +#include <linux/module.h>
> +#include <linux/i2c.h>
> +#include <linux/slab.h>
> +#include <linux/regmap.h>

> +#include <linux/of.h>

Neither this.

Hint: use device property API (or fwnode in the cases where no struct device is
available).

> +#include <linux/iio/iio.h>
> +#include <linux/iio/events.h>


-- 
With Best Regards,
Andy Shevchenko



