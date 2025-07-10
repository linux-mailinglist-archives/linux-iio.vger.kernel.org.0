Return-Path: <linux-iio+bounces-21525-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49078AFFE24
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 11:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A66E1C47BDD
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 09:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726B42BE7B1;
	Thu, 10 Jul 2025 09:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pk5TCklL"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26CC292B37;
	Thu, 10 Jul 2025 09:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139799; cv=none; b=tdT2U7SBtQwfgCVC2gCXR1E7ccEx8LUCUI/0e92k/Kxm2w/nn5xMDYej96NSjdRWVukQknbR012Ut/aaNiHM7RRe6J1m+LFWTK2CAgF52SW3jHdJf5BfxRRNfAmZ1h+TvTA8ZmOPK1Ty1qV1VTA7frqQ8BTUTvyWyFYEyrsHNTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139799; c=relaxed/simple;
	bh=FfyeP/NDyN7nfFZ6wzcvSd4IG6KdqSyCylHKZr3tP1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b+fZ7CcjDNyo3eoXUCaOMgITabVELur15Ho49ACJyNjdqXKz+1DNEUKyp4lFP5FBpCiBPYgNbNwLoHpfRM9Am7QyVidotksZiFNcUyy2Pp9OyeYa20HATF3CQkmHjQ2E3QoTi44u2Yoz+XkdEhkx4yUckUMxudCZjnDY5wurWLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pk5TCklL; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752139798; x=1783675798;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FfyeP/NDyN7nfFZ6wzcvSd4IG6KdqSyCylHKZr3tP1Y=;
  b=Pk5TCklLp/5vP7aGDUqz3G/p6GY0BAlhhjBek8bHHsywkGvM+JDrRLcs
   bqIbYCP4mWmq96z/t+Q+vaBdXDGTtYyvqY3virPkrZ27kVAJiHMosu9JB
   3VNkuBa84x+OEMkEh5rhH2PetlC9qmyM7ZBf5Y32eBSITUpXCA6sjblCg
   7cV6AHCNkqRfOxD4uVllWSmpaLvYxewubVyraxXouALhzq5CvjsvFxnPB
   pznJZ+LoAPSxMpKwoHQMl9BKnBd2mkOkCWeTI8etBGBCdFfUOk7lKNsyW
   XkEV1XzphIunZBX21RHQSd01zGfeFxnUglJLmGdiN087Io+FOO3KUcfLy
   Q==;
X-CSE-ConnectionGUID: aVs7HyjNTAG21ZkErQw7CQ==
X-CSE-MsgGUID: xNvCV9aRTxeLzOwu0DtOgA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54130745"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54130745"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:29:57 -0700
X-CSE-ConnectionGUID: +Qa7pN1SRby0WTK7MhNp3w==
X-CSE-MsgGUID: t8ai8+ECQD2mAtDj4NnN9A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="186995337"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:29:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uZnbD-0000000E9ji-3joE;
	Thu, 10 Jul 2025 12:29:51 +0300
Date: Thu, 10 Jul 2025 12:29:51 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: remi.buisson@tdk.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 2/8] iio: imu: inv_icm45600: add new inv_icm45600
 driver
Message-ID: <aG-ID7O3HgVc1EOX@smile.fi.intel.com>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
 <20250710-add_newport_driver-v2-2-bf76d8142ef2@tdk.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710-add_newport_driver-v2-2-bf76d8142ef2@tdk.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 10, 2025 at 08:57:57AM +0000, Remi Buisson via B4 Relay wrote:
> From: Remi Buisson <remi.buisson@tdk.com>
> 
> Core component of a new driver for InvenSense ICM-45600 devices.
> It includes registers definition, main probe/setup, and device
> utility functions.
> 
> ICM-456xx devices are latest generation of 6-axis IMU,
> gyroscope+accelerometer and temperature sensor. This device
> includes a 8K FIFO, supports I2C/I3C/SPI, and provides
> intelligent motion features like pedometer, tilt detection,
> and tap detection.

...

> +	INV_ICM45600_SENSOR_MODE_NB

What does the _NB stand for? Number of Bullets?

...

> +struct inv_icm45600_sensor_conf {
> +	int mode;
> +	int fs;
> +	int odr;
> +	int filter;

Any of them can hold negative value?

> +};

...

> +#define INV_ICM45600_SENSOR_CONF_INIT		{-1, -1, -1, -1}

Unused.


> +#include <linux/bitfield.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/iio/iio.h>
> +#include <linux/interrupt.h>
> +#include <linux/irq.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>

...

> +static int inv_icm45600_ireg_read(struct regmap *map, unsigned int reg,
> +				   u8 *data, size_t count)
> +{
> +	int ret;
> +	u8 addr[2];
> +	ssize_t i;
> +	unsigned int d;
> +
> +	addr[0] = FIELD_GET(INV_ICM45600_REG_BANK_MASK, reg);
> +	addr[1] = FIELD_GET(INV_ICM45600_REG_ADDR_MASK, reg);
> +
> +	/* Burst write address. */
> +	ret = regmap_bulk_write(map, INV_ICM45600_REG_IREG_ADDR, addr, 2);

sizeof()?

> +	udelay(INV_ICM45600_IREG_DELAY_US);

See below. This is also weird.

> +	if (ret)
> +		return ret;
> +
> +	/* Read the data. */
> +	for (i = 0; i < count; i++) {
> +		ret = regmap_read(map, INV_ICM45600_REG_IREG_DATA, &d);
> +		data[i] = d;
> +		udelay(INV_ICM45600_IREG_DELAY_US);

Can fsleep() be used here?

> +		if (ret)
> +			return ret;

This is weird. First you assign a garbage to the output, delay and return
an error. It seems entire code is broken...
Please, fix all these and try again, I stop my review here.

> +	}
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



