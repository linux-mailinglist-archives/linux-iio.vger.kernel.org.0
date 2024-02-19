Return-Path: <linux-iio+bounces-2761-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 353FA85A254
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 12:46:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D62B21F25BA5
	for <lists+linux-iio@lfdr.de>; Mon, 19 Feb 2024 11:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 115702E40A;
	Mon, 19 Feb 2024 11:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mnQQrV8q"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5086B2D61B;
	Mon, 19 Feb 2024 11:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708343115; cv=none; b=HVU26oI1/R7pRI62iwqZZHltNj5xGCqzggZ+HFR8B1V3GqTwFbyY+MhnhAVj8UHe29UqKYzcIc4ZDfFuJgYeQm4KbHvVt8IUu6KTqX3GiRRr5PP3n7KETFDnKClO7nOt5XFRURw4cueqOZMSGeFaP7XBjRn4kvL0xRkItZ612Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708343115; c=relaxed/simple;
	bh=ioLY6KFvH94t5iatXSvogujUGr8NSazHUMQUA5pIOq8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KO+GhVqw+GQL5tabMSo2y+nerc/f401zwI+wzAGHfuZWIAgcQouy4Y2J5R/vqXVF47UPfBoPHlwnGvy7etO39+X4Qe/2OerbsrFK8xW6bg5arXEj+V9+pSvHUpbFIpQPp4D0C2PdOKuKzXXHD/bhXNFsv43jKGoVxHkfynYnlGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mnQQrV8q; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708343114; x=1739879114;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ioLY6KFvH94t5iatXSvogujUGr8NSazHUMQUA5pIOq8=;
  b=mnQQrV8q98YDNiNA6QeCPnL8RNWbj7GhP3jGI8Q4oRfGQjgXP8BhJoUN
   pfIp5YNygw5+KcmIjRWhTY2bS5pY1reCTNqFaBpb1Ftdp7i0Nnb8Xt0ni
   eXF6Sep/BokrmSuI+2I+rLLCo2BDs0cgY08VBg4diy0XpUrKSRg27wAQh
   vXyDgrEMOKuG4zr5JCZx0leLfhn4EHpVcq3xuJa0/tNq5lsOshL2dTqrl
   xNQsajHAww1X9ijYHhAkl1q0LJRyPACJM2jNnbSq4Gu+GZ0xWOmbckGua
   OwdoW37lt5nCIdOMpAiPWNkEGXUj9Ccw7vR/QsvR8xwJc42qnjngKKtec
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="19949529"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="19949529"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:45:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10988"; a="912861564"
X-IronPort-AV: E=Sophos;i="6.06,170,1705392000"; 
   d="scan'208";a="912861564"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2024 03:45:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rc252-00000005oHy-0EFa;
	Mon, 19 Feb 2024 13:45:04 +0200
Date: Mon, 19 Feb 2024 13:45:03 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Mihail Chindris <mihail.chindris@analog.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Marek Vasut <marex@denx.de>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	Marius Cristea <marius.cristea@microchip.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 09/15] iio: adc: stm32: Use
 device_for_each_child_node_scoped()
Message-ID: <ZdM_P93vVIrBHkmg@smile.fi.intel.com>
References: <20240217164249.921878-1-jic23@kernel.org>
 <20240217164249.921878-10-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240217164249.921878-10-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Feb 17, 2024 at 04:42:43PM +0000, Jonathan Cameron wrote:
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Switching to the _scoped() version removes the need for manual
> calling of fwnode_handle_put() in the paths where the code
> exits the loop early. In this case that's all in error paths.
> 
> Note this includes a probable fix as in one path an error message was
> printed with ret == 0.
> 
> Took advantage of dev_err_probe() to futher simplify things given no
> longer a need for the goto err.

...

>  	const struct stm32_adc_info *adc_info = adc->cfg->adc_info;

I believe with

	struct device *dev = &indio_dev->dev;

you can make the below neater.
Also see some side notes.

> -	struct fwnode_handle *child;
>  	const char *name;
>  	int val, scan_index = 0, ret;
>  	bool differential;
>  	u32 vin[2];

...

>  		if (!ret) {

Not a fan of this pattern, below we have two different patterns for the cases
like this :-(

> +			if (strlen(name) >= STM32_ADC_CH_SZ)
> +				return dev_err_probe(&indio_dev->dev, -EINVAL,
> +						     "Label %s exceeds %d characters\n",
> +						     name, STM32_ADC_CH_SZ);
> +
>  			strscpy(adc->chan_name[val], name, STM32_ADC_CH_SZ);
>  			ret = stm32_adc_populate_int_ch(indio_dev, name, val);
>  			if (ret == -ENOENT)
>  				continue;
>  			else if (ret)


This 'else' is redundant.

> +				return ret;
> +		} else if (ret != -EINVAL)

This also...

> +			return dev_err_probe(&indio_dev->dev, ret, "Invalid label\n");

...if you first do like

		if (ret && ret != -EINVAL)
			return dev_err_probe(...);
		if (!ret) {

Another option

		if (ret) {
			if (ret != -EINVAL)
				return dev_err_probe(...);
		} else {

...

>  		differential = false;
>  		ret = fwnode_property_read_u32_array(child, "diff-channels", vin, 2);

ARRAY_SIZE()?

>  		/* diff-channels is optional */

...

>  		if (!ret) {
> +			if (vin[0] != val || vin[1] >= adc_info->max_channels)
> +				return dev_err_probe(&indio_dev->dev, -EINVAL,
> +						     "Invalid channel in%d-in%d\n",
> +						     vin[0], vin[1]);
>  		} else if (ret != -EINVAL) {
> -			dev_err(&indio_dev->dev, "Invalid diff-channels property %d\n", ret);
> -			goto err;
> +			return dev_err_probe(&indio_dev->dev, ret,
> +					     "Invalid diff-channels property\n");
>  		}

As per above?

-- 
With Best Regards,
Andy Shevchenko



