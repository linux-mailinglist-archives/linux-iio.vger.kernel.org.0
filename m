Return-Path: <linux-iio+bounces-28006-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D29FBD3B710
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 20:16:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20ED03076E8F
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 19:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F943904F9;
	Mon, 19 Jan 2026 19:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DkIlPK/T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1DA366DD7;
	Mon, 19 Jan 2026 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768850099; cv=none; b=plRWJI+rl9j9z8dcj8Yc3zkXI0OcNl1WVv7YDrz/r7lRSHq6sa40W7A1q1iP6OsPrUsIchGRQOaraS5zx7p+W9pwn0GKnhz/SuFESXtjDrottK1T1ryMHteH1kEw0sObZI5Sg0L5Aa5gr1yM7ZM5ezWEnWetCffpfjpVwcwmv7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768850099; c=relaxed/simple;
	bh=AKpD63otdSoRlDi5tGD75lU8s03M5nSieFRR8LjZn4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNqwEmWtu1XEFilDNc6RaW4lLfMuO+3YU6bspfkPrlWB5qjwyKyDAwI6fZg0KL3iLJPowfsSFG7yIHlANM4Zu1xajXA5Xsu5gfUPgPAeI6bTH4JFSFRN+yBK657s6jvcoLvThoj8QbXJ3umhsjHm1l+axlcNgj5CPkSAHCtGW9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DkIlPK/T; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768850099; x=1800386099;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AKpD63otdSoRlDi5tGD75lU8s03M5nSieFRR8LjZn4k=;
  b=DkIlPK/TAHKLra1NInrXwtgSiJPE5USCu3ARcjorlQD9Monri9HV+bOH
   H4Bp3xLlv8XDpAVNhfCslyh9FOSvLJTYdLMccoU2RR8xWcQXnkQQ09+o7
   lHQ1NJo0X5CQELyprFzQR2DYnE9BSsroopkgPQK6Pipt0lKFsthLrmpsc
   bFjonEahEj0xCb6neIbD5yZnVM8sSo7y0u5/4bgXCezu6Y3NKOwOUMT01
   F8CmQWOPPxfSu1bGFUCSrbGMalthwnaFWSF/ZVBFO/WGAVSYf85OmQysN
   KYX1fZlHg1C30RgTw8k9YylDbzhKKjismc7Vp2gI4UuVquGmh7YoPNdet
   w==;
X-CSE-ConnectionGUID: OkXlR7zUSGyGx7yi+tQIJw==
X-CSE-MsgGUID: Gir7sxWVToWynmEpgVyqwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="69961922"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="69961922"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 11:14:59 -0800
X-CSE-ConnectionGUID: Ru5AqZLhQBOcDC0vzsBTGg==
X-CSE-MsgGUID: BlGsif33QPKl5EDE5csa5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="206188027"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 11:14:55 -0800
Date: Mon, 19 Jan 2026 21:14:53 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	David Jander <david@protonic.nl>
Subject: Re: [PATCH v1 7/8] iio: dac: ds4424: ratelimit read errors and use
 device context
Message-ID: <aW6Crdsu614Xt4yF@smile.fi.intel.com>
References: <20260119182424.1660601-1-o.rempel@pengutronix.de>
 <20260119182424.1660601-8-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119182424.1660601-8-o.rempel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 07:24:23PM +0100, Oleksij Rempel wrote:
> Replace pr_err() with dev_err_ratelimited() in the RAW read path to avoid
> log spam on repeated I2C failures and to include the device context.
> 
> Use %pe to print errno names for faster debugging.

...

> -			pr_err("%s : ds4424_get_value returned %d\n",
> -							__func__, ret);
> +			dev_err_ratelimited(&indio_dev->dev,
> +					    "%s: ds4424_get_value failed %pe\n",
> +					    __func__, ERR_PTR(ret));

Too many information in the output now. __func__ obviously is redundant from
pr_*() limits, since you have now device, no need to have that, I believe. In
general, if you want to use __func__ it's most likely that the message itself
is badly written (not so unique). Rephrasing helps. Also "ds4424_get_value()"
will hint the user that this is about returned value from the call to the
function.

>  			return ret;

-- 
With Best Regards,
Andy Shevchenko



