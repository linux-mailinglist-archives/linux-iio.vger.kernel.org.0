Return-Path: <linux-iio+bounces-25897-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C82EAC32A13
	for <lists+linux-iio@lfdr.de>; Tue, 04 Nov 2025 19:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 768CF3B3332
	for <lists+linux-iio@lfdr.de>; Tue,  4 Nov 2025 18:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0891F31E10F;
	Tue,  4 Nov 2025 18:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZeXt/Zx+"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F921EB1A4;
	Tue,  4 Nov 2025 18:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762280596; cv=none; b=K/Z1leWkHf5kMQwngZQsrw1zMzGE2SAVFAMFlRzQobaa3zX9CLgmW+YyTYNtIc2PjY344uQHyjuBfFtVxz7YWQkViigW59M44qqNvD0a/I5DASHaMNzyJgDUpLgvEb0Tq2+9+Mr2SWfR3rsY8tm/JHqAAXS/DlvOpRib4GPwKWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762280596; c=relaxed/simple;
	bh=qipXzjZ693kWM+AZ/RIROVELXEE6fEONI00jx4ELHk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHDg60fCEsGqnSlzk4VFJayrlbIAGk5Cxko9dOOW6Iyzkqm6sEp79/xBri5apKcAHYmWGuryvv12+qn5N4ZlZgk+zyCt5gVb45QyTDK7euQDSRcKF7xe/r8ENImJMW+YxyB/2cYTG0NSGF3HdRrmEkgboyLm2m1wA/Leu1MvB5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZeXt/Zx+; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762280596; x=1793816596;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qipXzjZ693kWM+AZ/RIROVELXEE6fEONI00jx4ELHk0=;
  b=ZeXt/Zx+tlRK5lLm7kMls1bpsxcGVZhBBM10uBk8rmxZ7o0lyeY+HA1u
   ImNP1JpFdVDKyz+xbwaBbUSs74n6zA/qk9v0GzixNaidfHFheRHF7kA9H
   NgAKMk2V2lbTKIfa9J2QbAOOdm6yoePYIYxW/Tcvnl8n5BEVkoIp8q2e1
   NWoUHLIGj3NIfPKBcPgx9/3hhyW6C+nxbjOVyK+R/+WJrBWuRbRovEngY
   ORJL4mpBJVo3B0UOy5X9kFWK6K7lBN0O0kv4iJnsx+2XPrNyyIyO7Id70
   YTt+60fURkfLhLjtN8OLjMRsWCmQ2ZiMptufHVMSKLbXCpU6jS/ATCHxm
   g==;
X-CSE-ConnectionGUID: B5tGkvhEQxSEmBX2IU48rg==
X-CSE-MsgGUID: x57/k9VgRgStXyCrr+rMSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64292834"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64292834"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:23:15 -0800
X-CSE-ConnectionGUID: YQQmmwOrS5m4djZjV9ekfA==
X-CSE-MsgGUID: WYPk+VbqQqSjWCzditOPoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="187676362"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.146])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 10:23:12 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vGLgT-00000005Xbu-2yj6;
	Tue, 04 Nov 2025 20:23:09 +0200
Date: Tue, 4 Nov 2025 20:23:09 +0200
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
Subject: Re: [PATCH v4 09/12] iio: dac: ad5446: Make use of the cleanup
 helpers
Message-ID: <aQpEjYRQTDolSIXO@smile.fi.intel.com>
References: <20251104-dev-add-ad5542-v4-0-6fe35458bf8c@analog.com>
 <20251104-dev-add-ad5542-v4-9-6fe35458bf8c@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251104-dev-add-ad5542-v4-9-6fe35458bf8c@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Nov 04, 2025 at 03:35:14PM +0000, Nuno Sá via B4 Relay wrote:

> Use the auto unlocking helpers from cleanup.h. Allows for some code
> simplification.
> 
> While at it, don't use the ternary operator in
> ad5446_write_dac_powerdown() and add an helper function to write the DAC
> code. The reason for the function was purely to avoid having to use
> unreachable().

...

> +static int ad5446_write_dac_raw(struct iio_dev *indio_dev,
> +				const struct iio_chan_spec *chan,
> +				int val)
> +{
> +	struct ad5446_state *st = iio_priv(indio_dev);

> +	if (val >= (1 << chan->scan_type.realbits) || val < 0)
> +		return -EINVAL;

BIT() ?
in_range() ?

> +	val <<= chan->scan_type.shift;
> +	guard(mutex)(&st->lock);
> +
> +	st->cached_val = val;
> +	if (st->pwr_down)
> +		return 0;
> +
> +	return st->chip_info->write(st, val);
> +}


-- 
With Best Regards,
Andy Shevchenko



