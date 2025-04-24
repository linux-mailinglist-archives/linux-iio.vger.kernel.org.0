Return-Path: <linux-iio+bounces-18597-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D587A9AB32
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 12:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8EB4A7BAF38
	for <lists+linux-iio@lfdr.de>; Thu, 24 Apr 2025 10:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B827622C321;
	Thu, 24 Apr 2025 10:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MzWv1Xvz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9C3221578;
	Thu, 24 Apr 2025 10:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745491189; cv=none; b=RV4x712eeZycPgfS65nam5rVZahMKFiGISbLSbUaO+O4I5dSdTyBA8M49SrqVIVHfgUNLBNMYGGyrWIK3JEt13lkUD5JVmVV3i7KCR+vu5Z8X+QWtawiKWPMhuKdXFCwpCN1xdTGr76Xx4DTq01xZS5IJ58VRZtbQijXfSC3hOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745491189; c=relaxed/simple;
	bh=rdwz2WKjtDd7DtaGFTRBxPVQpUbJvrKlMywrM9IrdH8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jtxU7JgzIyqUyVl7Cm1Ij6LC+UPU5NeqLgU+jBJdWhlWeS43tPVQl5obzH4y1HwWxXQrxQygerqS6dcLv6250kxfAkJ1U/6/bETy6PVFjRCtrAYJHjRoYu8icdmJS7YUuBLVqCbvoOtXCD7P1nHI83xzr0CViVg6xzmHK8YsifQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MzWv1Xvz; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745491188; x=1777027188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rdwz2WKjtDd7DtaGFTRBxPVQpUbJvrKlMywrM9IrdH8=;
  b=MzWv1XvzvsqdQfFf2XQQNOOhXSNn9df9t7WfVQTT5flYVQrHczba6YP4
   Ls4+lDlLegRXDY5cXrTSJ9DjXS8q0feoNcIhaIRN6wHT+Y0Fm3PQJwpVY
   pHRl9LN/cPlCd2YZE1+sM1lW5StJ6vqXMEsX4pQEg5fKT2XsGO26uEvXr
   iG9KUvR6WuPEFP6kOOEFIXqGqPDtBmSbeqiMMuR1OOYtD2PALGiRKBT9B
   KJLjSJTJ69xhYhnWZYrw52z23QndW3+vYRJnYdmg5+O5U2ij4SqxK8btn
   jtuNQdxbysZXiX2iSNurCNgujz4fIIiUSwMffvy+OTfcihPkGmrqF95is
   w==;
X-CSE-ConnectionGUID: 7bJAJOoFRiKAZqChI90yyg==
X-CSE-MsgGUID: kBo04iLHQXGnxcyoSmXs9g==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47289739"
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="47289739"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 03:39:47 -0700
X-CSE-ConnectionGUID: DBEXrH2ESruBurCLFBO1fA==
X-CSE-MsgGUID: rTPUAwrMTEu1Uk6IMch+vA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,235,1739865600"; 
   d="scan'208";a="137374405"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2025 03:39:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u7tzW-0000000FWzS-1P71;
	Thu, 24 Apr 2025 13:39:38 +0300
Date: Thu, 24 Apr 2025 13:39:38 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Eason Yang <j2anfernee@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	javier.carrasco.cruz@gmail.com, gstols@baylibre.com,
	olivier.moysan@foss.st.com, alisadariana@gmail.com,
	tgamblin@baylibre.com, antoniu.miclaus@analog.com,
	eblanc@baylibre.com, joao.goncalves@toradex.com,
	ramona.gradinariu@analog.com, marcelo.schmitt@analog.com,
	matteomartelli3@gmail.com, chanh@os.amperecomputing.com,
	KWLIU@nuvoton.com, yhyang2@nuvoton.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] iio: adc: add support for Nuvoton NCT7201
Message-ID: <aAoU6iWGPkqjon7Z@smile.fi.intel.com>
References: <20250424083000.908113-1-j2anfernee@gmail.com>
 <20250424083000.908113-3-j2anfernee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424083000.908113-3-j2anfernee@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Apr 24, 2025 at 04:30:00PM +0800, Eason Yang wrote:
> Add Nuvoton NCT7201/NCT7202 system voltage monitor 12-bit ADC driver
> 
> NCT7201/NCT7202 supports up to 12 analog voltage monitor inputs and up
> to 4 SMBus addresses by ADDR pin. Meanwhile, ALERT# hardware event pins
> for independent alarm signals, and all the threshold values could be set
> for system protection without any timing delay. It also supports reset
> input RSTIN# to recover system from a fault condition.
> 
> Currently, only single-edge mode conversion and threshold events are
> supported.

Very good, from my point of view it's almost ready, a few nit-picks below.

...

> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>

> +#include <linux/device.h>

It seems this is not used, but missing
dev_printk.h
Am I mistaken?

> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/types.h>
> +#include <linux/unaligned.h>

...

> +static int nct7201_write_event_value(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     enum iio_event_type type,
> +				     enum iio_event_direction dir,
> +				     enum iio_event_info info,
> +				     int val, int val2)
> +{
> +	struct nct7201_chip_info *chip = iio_priv(indio_dev);
> +	int  err;
> +
> +	if (chan->type != IIO_VOLTAGE)
> +		return -EOPNOTSUPP;
> +
> +	if (info != IIO_EV_INFO_VALUE)
> +		return -EOPNOTSUPP;
> +
> +	if (dir == IIO_EV_DIR_FALLING)
> +		err = regmap_write(chip->regmap16, NCT7201_REG_VIN_LOW_LIMIT(chan->address),
> +				   FIELD_PREP(NCT7201_REG_VIN_MASK, val));
> +	else
> +		err = regmap_write(chip->regmap16, NCT7201_REG_VIN_HIGH_LIMIT(chan->address),
> +				   FIELD_PREP(NCT7201_REG_VIN_MASK, val));

> +	if (err)
> +		return err;
> +
> +	return 0;

	return err;

> +}

...

> +	/*
> +	 * After about 25 msecs, the device should be ready and then the power-up
> +	 * bit will be set to 1. If not, wait for it.
> +	 */
> +	fsleep(25000);

25 * USEC_PER_MSEC ?

...

> +	/* Enable Channel */
> +	if (chip->num_vin_channels <= 8) {
> +		err = regmap_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE,
> +				   GENMASK(chip->num_vin_channels - 1, 0));

> +		if (err)
> +			return dev_err_probe(dev, err, "Failed to enable channel\n");

This...

> +	} else {
> +		err = regmap_bulk_write(chip->regmap, NCT7201_REG_CHANNEL_ENABLE,
> +					&data, sizeof(data));

> +		if (err)
> +			return dev_err_probe(dev2, err, "Failed to enable channel\n");

...and this are identical, deduplicate by moving outside of if-else.

> +	}


-- 
With Best Regards,
Andy Shevchenko



