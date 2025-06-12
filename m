Return-Path: <linux-iio+bounces-20552-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D102AD711E
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 15:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E32E3A1BC8
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 13:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E0823C51D;
	Thu, 12 Jun 2025 13:05:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CpMkoQBu"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED57623BCF5;
	Thu, 12 Jun 2025 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749733547; cv=none; b=dGwOt8MbOJ4T/VYezUY9vXwLoBMx5coT2DFGEQ6fLk5hJpSHG3Hqg0tB0ZjBQl+n70ZR6SxDvvu7S3jFAJBUFhm0WLVdZlj4qlAyEzia8GEwmrHj2hKFjUOEsdfKZdPCOm+V5PpekG0GBCrR5J8espG236wFXSGp4JZLWn61y60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749733547; c=relaxed/simple;
	bh=HqX+EkBkxxR3OrGDdI5mWSDb4biR9oPPEN2emnhsHYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcuUk9GNpDV56+gQxauo0AcGYv1lNkN0z50o8haap/HrZXFWKPpVjIGHaPAuBO2tGBta4jH8DbLzjkUlxvSiO1PaEsGouV6/DIA1Q/+d5hzErKsa32WrVDHomt6XfNOm5cXNXOmBIhlXzPfSBWUvAW5y40KfC6MMXw4K6jbE0DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CpMkoQBu; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749733546; x=1781269546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HqX+EkBkxxR3OrGDdI5mWSDb4biR9oPPEN2emnhsHYo=;
  b=CpMkoQBu8tyXLw3ulPQqIbhv5MA2Fo5jHaFr6mqemnbpcoZtFwehFEXH
   KQF+dp7twmIChB92xsv67Q0nQmclEUoogCqsg7vQko3zsMt8F5EqEzifz
   BF0mjcgLWiJzrgq0RSUvcqTApwOQH6ovNG44S47CyAE//CaLJwvKZyiDJ
   vjzBQV7b2LKaB2cS37NMDc3VPwTOGSZPBOByOqLxuM+ssI74AED579Upr
   XMjUAC77S7VVegqJLX+V3+vJsV48/nHvO+oTb12lLNPAFhiBtNnvDt0oB
   5IjCJtw5HCHnhMVHZOCIRVLdP2EE/Iz//2Eg6hSK1ccSIQ2ZChRWmrOji
   g==;
X-CSE-ConnectionGUID: fGR3YVpTRTm5xOZiTljcFw==
X-CSE-MsgGUID: r4CRrE4RQDCHQDpjfRx3Tw==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="51017711"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="51017711"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 06:05:43 -0700
X-CSE-ConnectionGUID: ONa+O7mhRhS2siv9DGxE7w==
X-CSE-MsgGUID: jQHobO3eRXa0uY0nrXm0DA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="178489845"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 06:05:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uPhcg-00000005xJt-2X4b;
	Thu, 12 Jun 2025 16:05:38 +0300
Date: Thu, 12 Jun 2025 16:05:38 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/5] iio: amplifiers: ada4250: use dev_err_probe()
Message-ID: <aErQojKzbI6al1vn@smile.fi.intel.com>
References: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-0-bf85ddea79f2@baylibre.com>
 <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-5-bf85ddea79f2@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v3-5-bf85ddea79f2@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 11, 2025 at 04:33:05PM -0500, David Lechner wrote:
> Use dev_err_probe() when returning an error in the probe function.

...

>  	mutex_init(&st->lock);

Side note. Switch to devm?

...

>  	ret = ada4250_init(st);

Is this used only in ->probe() stage? If so, please also move to
dev_err_probe() there.

> -	if (ret) {
> -		dev_err(&spi->dev, "ADA4250 init failed\n");
> -		return ret;
> -	}
> +	if (ret)
> +		return dev_err_probe(&spi->dev, ret, "ADA4250 init failed\n");
>  
>  	return devm_iio_device_register(&spi->dev, indio_dev);

-- 
With Best Regards,
Andy Shevchenko



