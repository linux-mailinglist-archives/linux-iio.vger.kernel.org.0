Return-Path: <linux-iio+bounces-25896-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D6419C329A4
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 19:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8240234C39B
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 18:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C9B33C523;
	Tue,  4 Nov 2025 18:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O1jS+qqB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58421FF1B4;
	Tue,  4 Nov 2025 18:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280439; cv=none; b=KanzOwjucdte15LZph1B4MkUH1IZKB+226nH867LbZEKYu5BfiyNNbjXqyHLFw2mW6O7wSA0fY2Gm+x9uuDT0N4hi+M1lslp9yoyVMILoA9uOpgTnxN4aGovMLmvWP7Gew6VVoKZT0e29Ru/vaKlsygYvQIoywZt9iHhcZD/UUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280439; c=relaxed/simple;
	bh=O5RvaqHOvrsqAaN64GAmKPSMHBDHIU8ImAJ4wQw+YSg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kih2GGL1VZRbF4K2R8+0+YEX0HMTpfnIRp9sDualO6gtoqUWP4vmf5jiMJp8/vzJJVNDxOXnM19fDqA2en8oU8BNsIQfdhrOAnkHvCnKdKwp2FInFWj7e+ZuyExdA7N6LB2LTdAKa50a3eU37LNA4TG8TApEgMy7O1yTcHk+f0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O1jS+qqB; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762280438; x=1793816438;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=O5RvaqHOvrsqAaN64GAmKPSMHBDHIU8ImAJ4wQw+YSg=;
  b=O1jS+qqBHY67K31rCydI4Yqp/d3Qkd4sHg/aGk8J1sxmr4l/5+SnSKxs
   qfcYUkmf88oE6tKewM4TNDdZXg8nxJRvHXxj28F91636ETN5nxUDZO5nq
   tslFxSBZy37L/2BgH1/mK3mYtumCLFkq5EdFZexDmVc77fgAPiOudaIno
   mubJlmBYEgQy7YLMZ6vZsi+STjwNJuk0xozWGwrKUXa9+vpIddkOvc4+U
   NzBgPZCtbR7Qu+jbIvcdy6I5rP22Q0bvj3V9mxobDsWSnnsdPIP9AhvCw
   LWPKshSBr8JXBpMvtkmyPSY9VPOL2ALylyEo30hZWzxtdGZMnZkFDnyeN
   w==;
X-CSE-ConnectionGUID: rWfwPYATRiyJFd5LFIEVUA==
X-CSE-MsgGUID: w4yJKFYMRvmfqHgwCizlfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="75834822"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="75834822"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:20:37 -0800
X-CSE-ConnectionGUID: 6sOkKGiwSMaalj6XZzTvGA==
X-CSE-MsgGUID: rWK4S1vwRVK0xToKjdBHCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="191583481"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:20:35 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGLdw-00000005XZr-0hZs;
	Tue, 04 Nov 2025 20:20:32 +0200
Date: Tue, 4 Nov 2025 20:20:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: nuno.sa@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v4 07/12] iio: dac: ad5446: Separate I2C/SPI into
 different drivers
Message-ID: <aQpD7zx7D6sQOAdC@smile.fi.intel.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
 <20251104-dev-add-ad5542-v4-7-6fe35458bf8c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251104-dev-add-ad5542-v4-7-6fe35458bf8c@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 04, 2025 at 03:35:12PM +0000, Nuno Sá via B4 Relay wrote:
> 
> Properly separate the I2C and SPI drivers into two different drivers
> living in their own source file (as usual). So that no need for the
> hacky ifdefery.

...

> +#include <linux/iio/iio.h>
> +#include <linux/mutex.h>
> +#include <linux/types.h>
> +
> +struct device;
> +
> +extern const struct iio_chan_spec_ext_info ad5446_ext_info_powerdown[];
> +
> +#define _AD5446_CHANNEL(bits, storage, _shift, ext) { \
> +	.type = IIO_VOLTAGE, \
> +	.indexed = 1, \
> +	.output = 1, \

> +	.channel = 0, \

Unneeded.

> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE), \
> +	.scan_type = { \
> +		.sign = 'u', \
> +		.realbits = (bits), \
> +		.storagebits = (storage), \
> +		.shift = (_shift), \
> +		}, \
> +	.ext_info = (ext), \
> +}
> +
> +#define AD5446_CHANNEL(bits, storage, shift) \
> +	_AD5446_CHANNEL(bits, storage, shift, NULL)
> +#define AD5446_CHANNEL_POWERDOWN(bits, storage, shift) \
> +	_AD5446_CHANNEL(bits, storage, shift, ad5446_ext_info_powerdown)
> +
> +/**
> + * struct ad5446_state - driver instance specific data
> + * @dev:		this device
> + * @chip_info:		chip model specific constants, available modes etc
> + * @vref_mv:		actual reference voltage used
> + * @cached_val:		store/retrieve values during power down
> + * @pwr_down_mode:	power down mode (1k, 100k or tristate)
> + * @pwr_down:		true if the device is in power down
> + * @lock:		lock to protect the data buffer during write ops
> + */
> +struct ad5446_state {
> +	struct device *dev;
> +	const struct ad5446_chip_info *chip_info;
> +	unsigned short vref_mv;

_mV?

> +	unsigned int cached_val;
> +	unsigned int pwr_down_mode;
> +	unsigned int pwr_down;
> +	/* mutex to protect device shared data */
> +	struct mutex lock;
> +	union {
> +		__be16 d16;
> +		u8 d24[3];
> +	} __aligned(IIO_DMA_MINALIGN);
> +};
> +
> +/**
> + * struct ad5446_chip_info - chip specific information
> + * @channel:		channel spec for the DAC
> + * @int_vref_mv:	AD5620/40/60: the internal reference voltage
> + * @write:		chip specific helper function to write to the register
> + */
> +struct ad5446_chip_info {
> +	struct iio_chan_spec channel;
> +	u16 int_vref_mv;

_mV?

> +	int (*write)(struct ad5446_state *st, unsigned int val);
> +};
> +
> +int ad5446_probe(struct device *dev, const char *name,
> +		 const struct ad5446_chip_info *chip_info);
> +
> +#endif

-- 
With Best Regards,
Andy Shevchenko



