Return-Path: <linux-iio+bounces-19953-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D17C7AC4461
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 22:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9833B1795F3
	for <lists+linux-iio@lfdr.de>; Mon, 26 May 2025 20:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4CB241680;
	Mon, 26 May 2025 20:21:30 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8E323F405;
	Mon, 26 May 2025 20:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748290889; cv=none; b=hnwILK1SWBCVosq+hIENW7sjwvx2vITLUGR3i29NMtAB2tCU5OPQdeW4AQ17M27DOaq28Vxx+Dxgr7k1NAqoXClul5A3J4mHWRZ+ptfq0KRI+MjYZi+gmX8e5wlUExYVtpMcnvdHW+JvnOkNCYbL3sOO7JTfc77fBTC9CoC8JOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748290889; c=relaxed/simple;
	bh=ftWV7x+fpW/bpc2MGzzfvl/QCag+aZE7yFupYOX4tDk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LbFq+QnIGuQKXWxzUfRqdm9W5sxlXkQ9ynG3jmsqdvKSCn8U2xWilrKSu3r4cceC0CxSYwuZYoYCSp6Lqy5Xw5rIVeXCoUMJ65GmojXOc9rLLKNnYNphrEK/QR0rTJcIQ0kH/ditCtDhi5K33o6UQrIwNjfR6IksqDq92BA+TGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: OkstJNmTS0CG8gQV8YERyg==
X-CSE-MsgGUID: 9Sdr8TwzQCGJjn0eHySjFg==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="52894162"
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; 
   d="scan'208";a="52894162"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 13:21:28 -0700
X-CSE-ConnectionGUID: wZQUutUbRBqiu+xw+/JoAQ==
X-CSE-MsgGUID: xAsdwNhHSTK9qNIw8OIJvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,316,1739865600"; 
   d="scan'208";a="142511330"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2025 13:21:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uJeK2-00000000yb2-3J4s;
	Mon, 26 May 2025 23:21:22 +0300
Date: Mon, 26 May 2025 23:21:22 +0300
From: Andy Shevchenko <andy@kernel.org>
To: maudspierings@gocontroll.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Christian Heusel <christian@heusel.eu>,
	Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3] iio: common: st_sensors: Fix use of uninitialize
 device structs
Message-ID: <aDTNQkS6pTBqu2tB@smile.fi.intel.com>
References: <20250526-st_iio_fix-v3-1-039fec38707c@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250526-st_iio_fix-v3-1-039fec38707c@gocontroll.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, May 26, 2025 at 09:03:40AM +0200, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
> 
> Throughout the various probe functions &indio_dev->dev is used before it
> is initialized. This caused a kernel panic in st_sensors_power_enable()
> when the call to devm_regulator_bulk_get_enable() fails and then calls
> dev_err_probe() with the uninitialized device.
> 
> This seems to only cause a panic with dev_err_probe(), dev_err(),
> dev_warn() and dev_info() don't seem to cause a panic, but are fixed
> as well.
> 
> The issue is reported and traced here: [1]

> [1]: https://lore.kernel.org/all/AM7P189MB100986A83D2F28AF3FFAF976E39EA@AM7P189MB1009.EURP189.PROD.OUTLOOK.COM/

Make it a Link tag, e.g.,

Link: https://... [1]

> 

Drop this blank line.

> Cc: stable@vger.kernel.org
> Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
> ---

-- 
With Best Regards,
Andy Shevchenko



