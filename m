Return-Path: <linux-iio+bounces-28038-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA95D3C0BB
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 08:42:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D87BC4F5B9A
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 07:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1B83A0B05;
	Tue, 20 Jan 2026 07:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kx3mVPSz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68F1126BF7
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768893795; cv=none; b=D7LSERFN8iyqJcWTKQVkXShqOcdgElIXANzsUYNekPp7mMz+cfMCl+P6SG/uc/woWxNQleou7HdycMKteNk4qepdEkVPIcNZAZoqjICZnTSaWKr8j5n6w0ZSfJBaUS3WtztPwRau6resnPAzmzOpdoMfqq0pryO2BBaHa+KwR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768893795; c=relaxed/simple;
	bh=Imd2JpzS9RS1TW8yV870dqi2NFavHwMiaxkdg+/BTZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LY6i5Q2jJCBUeOQIFwy8EIH9VKGTjIeGgRelES/iQIX62dYk8fkF+nlZXnDqzrbJdJ228xS4WMgAdkoyRBR0FAjNpLSWfcWgsz0E7eVA520phkenf1aLvRGxqpP8pzqQs5ioYzwfhf29oE3b7ZMYra5V70pMCr0qR77Lq0Lwqf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kx3mVPSz; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768893792; x=1800429792;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Imd2JpzS9RS1TW8yV870dqi2NFavHwMiaxkdg+/BTZE=;
  b=kx3mVPSzVl97ujQdCu84V2vdtfBfyN2fxr89BB3aNkLf/4sZy3aesuY2
   OOh9Jk2KJbcBSt0vvFx6F8QPFtIzcL1TD+pgeH7Qefr9qJItR95Sa42/c
   GLHTx5Aue84QAEfxVvxV1owdna0f98ZyLr5sQDJadsqS0//XxS0Opxe7d
   66PiolQPyjPSt5FvrkbP+rU1qT01L/5bzVo1/KOqKPpzsDnKUKumXApCK
   ZniVNklcIYHKpGFCNsbdPiSH9CsecNRSmvcIt410D1mKPYeXzX7B+zA5Z
   MRaPZBDLD8ppaJfM75oq7joI+JwhTWqt3GbeEP0KxqLe1rqlPSVcgQ8Uv
   Q==;
X-CSE-ConnectionGUID: dz3+1JsLRbieGRM39rOUHA==
X-CSE-MsgGUID: AhJ1VWG3ShKW6WdXqLQC3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73960672"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="73960672"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:23:09 -0800
X-CSE-ConnectionGUID: /K6b5nZgSyKhLKIGBlwPtg==
X-CSE-MsgGUID: Reu5VZJCQJa9hzPpsrHOig==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="228974970"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:23:07 -0800
Date: Tue, 20 Jan 2026 09:23:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Frank Li <Frank.Li@nxp.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 2/2] iio: magn: mmc5633: Add some ifdef / __maybe_unused
 until stubs available
Message-ID: <aW8tWECNSvLTTKU8@smile.fi.intel.com>
References: <20260119221736.804825-1-jic23@kernel.org>
 <20260119221736.804825-3-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119221736.804825-3-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 10:17:36PM +0000, Jonathan Cameron wrote:

> The I3C tree has Frank Li's fix for the case of I3C not being built

> https://lore.kernel.org/all/20251230145718.4088694-1-Frank.Li@nxp.com/

Make it a Link tag

> Given those will only be available upstream at the next merge window
> and the ordering of merge of I3C vs IIO is uncertain, apply some temporary
> stubs in the driver to avoid build issues.
> 
> This can be reverted next cycle.

Link: ... [1]

> Fixes: 6e5f6bf2e3f0 ("iio: magnetometer: Add mmc5633 sensor")
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202512280443.lOhY75Df-lkp@intel.com/
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

...

>  static int mmc5633_read_measurement(struct mmc5633_data *data, int address, void *buf, size_t sz)
>  {
>  	struct device *dev = regmap_get_device(data->regmap);
>  	u8 data_cmd[2], status[2];
> -	unsigned int val, ready;
> +	unsigned int val;
> +	unsigned int ready __maybe_unused;
>  	int ret;

Reversed xmas tree ordering?

...

> +#ifdef CONFIG_I3C
>  		ret = i3c_device_do_xfers(data->i3cdev, xfers_wr_cmd,
>  					  ARRAY_SIZE(xfers_wr_cmd), I3C_HDR_DDR);
> +#else

> +		return -EOPNOTSUPP;

I would do one point of return, id est

		ret = -EOPNOTSUPP;

> +#endif
>  		if (ret < 0)
>  			return ret;

...

> +#ifdef CONFIG_I3C
>  		ret = read_poll_timeout(i3c_device_do_xfers, val,
>  					val || (status[0] & ready),
>  					10 * USEC_PER_MSEC,
>  					100 * 10 * USEC_PER_MSEC, 0,
>  					data->i3cdev, xfers_rd_sta_cmd,
>  					ARRAY_SIZE(xfers_rd_sta_cmd), I3C_HDR_DDR);
> +#else
> +		ret = -EOPNOTSUPP;
> +#endif
>  		if (ret) {
>  			dev_err(dev, "data not ready\n");
>  			return ret;
>  		}

Ditto.

-- 
With Best Regards,
Andy Shevchenko



