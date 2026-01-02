Return-Path: <linux-iio+bounces-27465-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7482DCEE882
	for <lists+linux-iio@lfdr.de>; Fri, 02 Jan 2026 13:28:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C59FE3028F7A
	for <lists+linux-iio@lfdr.de>; Fri,  2 Jan 2026 12:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582D230FC13;
	Fri,  2 Jan 2026 12:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H7CHoCoK"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D0F30FC04;
	Fri,  2 Jan 2026 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767356674; cv=none; b=ThLNLj11NjUsUu6mOq0dmta+26JSL9boec0IIbPVyIF3KJcDUanPYOaiYpKf87QUUCQPBUe7H1Jao38TWLnBTN2dCCqc5Wvghzmod/aCSRJAbDph62W0tuvBXq1QCr5+karGqSN5Kv9Fyy+TI6lWPGh7QxQWH7yMYYpWGt3hBY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767356674; c=relaxed/simple;
	bh=kKERmJHs0Bvl3xPro8w1YRmmY4tQYGnNeRNUszjCPlE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXPICVy3TR9WeHIJrAqzwq1hMVQFsbmnwmfOO/PXae0qA1X3Ew8eykaY6HGJSVtsHvte8ouR/cM1vfoGw+I8awaNeRibZ4TvkZy0DII4B6p8exkjwovsUfB/8BKfaKa+wAfFZiqTaWRazCF9HKNiLqo7ESkH2SNryIzvRfU3hpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H7CHoCoK; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767356673; x=1798892673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kKERmJHs0Bvl3xPro8w1YRmmY4tQYGnNeRNUszjCPlE=;
  b=H7CHoCoKKgNkpPpEg4jOe4Ot+g2M4c818SXXUei6bFaPjbvac8UnszB3
   LG/XyBZjly7oRrKDM5nmfINy5TRvc7HwVUmqUDe50Kk4p8vNv3OU5Tu0v
   r5sY7VuegpOBm/rhRGX/ln30xcU0qVGEbhhbXosa1GgdhjwvIY+EOn19h
   8z2pLmgk0ZWWqUPFXAKm25yrkmr1I2I5C6jgPHXHRYrjn5CuAm99DlHOC
   cMOcSXnaDNhn3I8loPmhRm+WLqaZ6meTlkP9sHGwsKC+MJkG/4JigQNdg
   RuBrCr8/yjjAwYqfcBrht0xIhZroeynLYJcxI58TCvB0FwU0GUhgNqaiD
   g==;
X-CSE-ConnectionGUID: KnlT+aOjTjiM6WoFDCOa1A==
X-CSE-MsgGUID: 8Z1WxjxnTA6av1gR0khAWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="68916959"
X-IronPort-AV: E=Sophos;i="6.21,197,1763452800"; 
   d="scan'208";a="68916959"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2026 04:24:32 -0800
X-CSE-ConnectionGUID: eTx4w8axQ1aAqF8J/f/7TA==
X-CSE-MsgGUID: NTFZNOeLTECh9y8B0vGkIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,197,1763452800"; 
   d="scan'208";a="201436926"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.46])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2026 04:24:29 -0800
Date: Fri, 2 Jan 2026 14:24:26 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: raskar.shree97@gmail.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/4] iio: proximity: rfd77402: Use kernel helper for
 result polling
Message-ID: <aVe4-rUD9aM58xhT@smile.fi.intel.com>
References: <20260101-b4-rfd77402_irq-v4-0-42cd54359e9f@gmail.com>
 <20260101-b4-rfd77402_irq-v4-3-42cd54359e9f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260101-b4-rfd77402_irq-v4-3-42cd54359e9f@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 01, 2026 at 09:47:40PM +0530, Shrikant Raskar via B4 Relay wrote:

> Replace the manually written polling loop with read_poll_timeout(),
> the kernel's standard helper for waiting on hardware status.
> This makes the code easier to read and avoids repeating the same
> polling code in the driver.

...

> index 3262af6f6882..496c1412ebf8 100644
> --- a/drivers/iio/proximity/rfd77402.c
> +++ b/drivers/iio/proximity/rfd77402.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/delay.h>
> +#include <linux/iopoll.h>

Even if the original is unsorted, try to place the new inclusion into the
longest sorted (but maybe be sparse) chain. From the given context it might
be somewhere before module.h or less likely after i2c.h.

>  #include <linux/iio/iio.h>

...

> +	/* Poll ICSR until RESULT bit is set */
> +	ret = read_poll_timeout(i2c_smbus_read_byte_data, ret,
> +				ret & RFD77402_ICSR_RESULT,
> +				10000,    /* sleep: 10ms */
> +				100000,   /* timeout: 100ms */

Instead of the noisy comments use proper multipliers

 10 * USEC_PER_MSEC
 10 * 10 * USEC_PER_MSEC

(yes, 10 * 10 is to distinguish between one iteration delay and the whole op
 timeout.)

> +				false,
> +				client, RFD77402_ICSR);
> +	if (ret < 0)
>  		goto err;

-- 
With Best Regards,
Andy Shevchenko



