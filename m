Return-Path: <linux-iio+bounces-18567-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4EBAA99580
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 18:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D01A3463A27
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 16:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 340F42853F2;
	Wed, 23 Apr 2025 16:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Zsf17bVd"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AADF280CF8;
	Wed, 23 Apr 2025 16:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426377; cv=none; b=JxIaIo3MIWJMX4WTP+GQwj/OjeEjtHUeAes94ZWOR1PoVGwSYnHwoT36WOJiuWem8WH4ku16Kh80d/rxe12ynazkOS1oJL0xm6SiEZH9c4N3ZA3H5JVxmgHihOkk2cGm/pma+n2I6mCkUTs7SUvxDmgKC7Vfpk04f0sxtYO3RTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426377; c=relaxed/simple;
	bh=lAxjSVyMJzqkueCmSww3ABBh9mUZYx7qAEOzxC88JdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fGmKyUIs/vHeM4NutMv1VqZJaNidlMAq7vK+dtuB3OeWSLS34x6aUUPGgjoGRtEngUxnj63Txsv+LnG49Q8GzCR1kW/ZjprqLOIVS5x9DURM8vcO0UxFEa1PRxOfW4HaJ+W7c8E0geMkpPef270I0nMI04tDC1SkIrmXadgTI1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Zsf17bVd; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1745426376; x=1776962376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lAxjSVyMJzqkueCmSww3ABBh9mUZYx7qAEOzxC88JdQ=;
  b=Zsf17bVdzNf3ixruNhPFqj7v2ZL9fOIXRWYgf3FgkkDwN7HAO/SUXJjv
   BXJuqH4/b5rrFx8FNhXU+F2kKFMhleWDDYobWUzNyaYQs0A0KpRr5yfiU
   N+foQyo25r46oLte+IMRdEyUDRtK+jQNq7okHlePxyIPjBmo/oi6K2Olb
   I5ADmJtGJdlRIR97BxibXsnPfQ4I0ll0vAGVbAqfjYvqX7lfh7pCs4yhw
   4DMdHdz5BePZ19gYIClpOWZF5BEzufGeqYY7ryYhLT2e39UU0SMVJf+Qm
   lGl8tZwgWVHNlFUzGYo9UQV0WlWDdAWZZFz2lMv8c0hwcLo5LiHmU758z
   w==;
X-CSE-ConnectionGUID: 7u/M0pEnQ3yaEfvUYFSlQw==
X-CSE-MsgGUID: /nwysUugRgKsPFuTSAReEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="50694024"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="50694024"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:39:35 -0700
X-CSE-ConnectionGUID: UFZXG+LDTOGAoQ0FlW8QgA==
X-CSE-MsgGUID: p5WpkxnJTNGEECytXNPK/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="132255613"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:39:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1u7d8C-0000000F7Ow-1FyN;
	Wed, 23 Apr 2025 19:39:28 +0300
Date: Wed, 23 Apr 2025 19:39:28 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Kent Gustavsson <kent@minoris.se>, Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kent Gustavsson <nedo80@gmail.com>, devicetree@vger.kernel.org,
	Lukas Rauber <lukas.rauber@janitza.de>
Subject: Re: [PATCH 3/3] iio: adc: mcp3911: add reset management
Message-ID: <aAkXwHNWPvb_wayc@smile.fi.intel.com>
References: <20250423-mcp3911-fixes-v1-0-5bd0b68ec481@gmail.com>
 <20250423-mcp3911-fixes-v1-3-5bd0b68ec481@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423-mcp3911-fixes-v1-3-5bd0b68ec481@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 23, 2025 at 04:46:51PM +0200, Marcus Folkesson wrote:
> Add support for optional HW reset.
> If specified, a reset will be asserted during driver probe.

...

> +		return dev_err_probe(dev, PTR_ERR(gpio_reset),
> +				     "Cannot get reset GPIO\n");

+ dev_printk.h

...

> +		dev_dbg(dev, "gpio reset de-asserted.\n");

How useful is this?

...

> +		/* Settling time after Hard Reset Mode (determined experimentally):
> +		 *  330 micro-seconds are too few; 470 micro-seconds are sufficient.
> +		 * Just in case, we add some safety factor... */

/*
 * Please, fix the nulti-line comment
 * style. This one can serve you as an
 * example.
 */

> +		fsleep(680);

Why not simply 500? or 600?


-- 
With Best Regards,
Andy Shevchenko



