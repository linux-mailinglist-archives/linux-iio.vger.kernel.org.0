Return-Path: <linux-iio+bounces-19833-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2206BAC27CC
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 18:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E423BA280
	for <lists+linux-iio@lfdr.de>; Fri, 23 May 2025 16:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEE7D2957B6;
	Fri, 23 May 2025 16:45:18 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D385421A928;
	Fri, 23 May 2025 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748018718; cv=none; b=hTI42KYdMILb3Boesv3RdA7FLZxBmEwb9MS08tSgNW/vGmsASNVxI3fcjaGld9BSEXgWF8X0yZT1llTRMXYYS9bQcp8kWnrEXESHS+aTUdoHP53Wbnmc3FTSdk0jOg+iSIwyTQ2GZ28aWKC9N3lYggtQeQXe5/ZEdipTrzmbDo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748018718; c=relaxed/simple;
	bh=iqq6proiPad7zCnnyqS7vt9XU3p9OgUqLr53guax7Qg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XAQjXCjiIA8YtOLgEbYfzonXFhjs7w0HZ96nF+sHeqq8kAS1efp0OS6/GdUcs8M188G5Pss+R90hKolIJd/g7zyDXz244/Ia0lVDb69d/Gh/g0TU/NFRtvPFxWw3cxukT30qH3hk898+kP4nAg2gQ6OuXRzBdr8BUu//K4UFRvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: Lbnw8lpmQtq/nmgreid7IQ==
X-CSE-MsgGUID: WXhK7PsbRB6xzbG2dcDhWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="60716686"
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="60716686"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 09:45:16 -0700
X-CSE-ConnectionGUID: Lg3Oi+C9SEWfimaPWzparQ==
X-CSE-MsgGUID: a7CDcy2pSXKy5aVb+y88qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,309,1739865600"; 
   d="scan'208";a="141770857"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 09:45:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uIVWA-000000006bu-2z58;
	Fri, 23 May 2025 19:45:10 +0300
Date: Fri, 23 May 2025 19:45:10 +0300
From: Andy Shevchenko <andy@kernel.org>
To: maudspierings@gocontroll.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Christian Heusel <christian@heusel.eu>,
	Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] iio: common: st_sensors: Fix use of uninitialize
 device structs
Message-ID: <aDCmFm5fso98w3AV@smile.fi.intel.com>
References: <20250522-st_iio_fix-v2-1-07a32655a996@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522-st_iio_fix-v2-1-07a32655a996@gocontroll.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 22, 2025 at 01:18:55PM +0200, Maud Spierings via B4 Relay wrote:
> 
> Throughout the various probe functions &indio_dev->dev is used before it
> is initialized. This caused a kernel panic in st_sensors_power_enable

st_sensors_power_enable()

> when the call to devm_regulator_bulk_get_enable() fails and then calls
> dev_err_probe() with the uninitialized device.
> 
> This seems to only cause a panic with dev_err_probe(), dev_err,

dev_err()

> dev_warn and dev_info don't seem to cause a panic, but are fixed

dev_warn()
dev_info()

> as well.

> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---
> When I search for general &indio_dev->dev usage, I see quite a lot more
> hits, but I am not sure if there are issues with those too.
> 
> This issue has existed for a long time it seems and therefore it is
> nearly impossible to find a proper fixes tag. I would love to see it at
> least backported to 6.12 as that is where I encountered it, and I
> believe the patch should apply without conflicts.

> The investigation into this issue can be found in this thread [1]
> 
> [1]: https://lore.kernel.org/all/AM7P189MB100986A83D2F28AF3FFAF976E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM/

Shouldn't it be moved to the commit message as Link tag?

...

> -		return dev_err_probe(&indio_dev->dev, err,
> +		return dev_err_probe(parent, err,
>  				     "unable to enable supplies\n");

Now it can be put on one line (yes, only 1 or 2 characters longer than 80).

...

> -		dev_info(&indio_dev->dev,
> +		dev_info(parent,
>  			 "interrupts on the rising edge\n");

Ditto.

...

> -		dev_info(&indio_dev->dev,
> +		dev_info(parent,
>  			 "interrupts active high level\n");

Ditto.

-- 
With Best Regards,
Andy Shevchenko



