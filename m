Return-Path: <linux-iio+bounces-28005-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F17ABD3B6F1
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 20:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC0C130049DA
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 19:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BCD3921DB;
	Mon, 19 Jan 2026 19:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EiaQQh55"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83CD38F956;
	Mon, 19 Jan 2026 19:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768849944; cv=none; b=SoJcSXku6mig/0whGd5QLfuyHEAnlPN6NDQLEiGo+DSYYMDRN4ofLmsC2uNCXfEIptvLXqPWoVWPqMTKfncccD2kEc26SeUe+hL6Fpem760VoqwdNCa9ScKmX/0ogwIqDVQDLRRjgiG44ad4kBdBYAxLWTdYDw6cVAcx9aZi7ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768849944; c=relaxed/simple;
	bh=Tb0kRT0WjtyiFXAtmTAHsqvAErEBEcfZ0oq1i5TNfIQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRSsCMtcjXCYcuEYNNGZqi+qdCd4EmxdkwMZVdinHX2Sj+7vva7IcjD+xQLMdmEc0gOxO8vgcmP6dGKntrjGc2goTzJAaqtjvKm29ZDZMWW1JAIrSx1lsgOOGvHjM40ic+/udgUhoFSDj2XD3AJ9XnQpNdfPOYHG5lvbCzELdps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EiaQQh55; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768849942; x=1800385942;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tb0kRT0WjtyiFXAtmTAHsqvAErEBEcfZ0oq1i5TNfIQ=;
  b=EiaQQh55ie9UKezSlRNGrJ2IRVp4l7X2/kl9enE/C5vYlSW8BNOv7BIl
   9t9csJyk4qMNn9+Xx3ccg12v9WrekuLw6ji6pDvOODhjEhWgKFnBD816/
   Yuwxu6Awa8h76JOAH3DIXxZ7pD1VO8pPK/UumBLIDGIPW3adril2wCyoS
   9AXlkM/6U4kURP2V/UQ07/R+Stgh8ms+TT1fWcz7Z7Ozu+s31rEmZJu5h
   jDxw430OIcOdmhpe6HuBaM6UXNVhyRz+w7lmpFjBSRQYVFOgzNnrRRFDF
   g395+GtG5837sZ8va2gWqRAer2OetAVoY3sV3KTYYWqgm4x5njpGSfHY7
   w==;
X-CSE-ConnectionGUID: i7LdZQ+6S9S0SSRV6GavgQ==
X-CSE-MsgGUID: U7bYNULpS+iwvm2mQxN6tQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="87645229"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="87645229"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 11:12:21 -0800
X-CSE-ConnectionGUID: KU0e26DAT9OPv2emmSbPpA==
X-CSE-MsgGUID: hFXj06ISS0OiYXxCFP2+zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="205561794"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 11:12:17 -0800
Date: Mon, 19 Jan 2026 21:12:15 +0200
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
Subject: Re: [PATCH v1 6/8] iio: dac: ds4424: clear outputs on probe
Message-ID: <aW6CDxVzO_NWGHSh@smile.fi.intel.com>
References: <20260119182424.1660601-1-o.rempel@pengutronix.de>
 <20260119182424.1660601-7-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119182424.1660601-7-o.rempel@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 07:24:22PM +0100, Oleksij Rempel wrote:
> The DS44xx devices have no reset pin or reset bit, so output registers
> may retain preconfigured values across reboot or warm reset.
> 
> Also, the driver suspend/resume path restores from data->raw. When the
> device is first probed, data->raw is zero-initialized and may not match
> the actual hardware state. A later suspend/resume can therefore change an
> output from a preconfigured non-zero value to 0 mA.
> 
> Initialize all channels to 0 output current during probe to ensure a
> deterministic baseline and consistent suspend/resume behavior.

...

> +static int ds4424_init(struct iio_dev *indio_dev)
> +{
> +	int i, ret;

Why is 'i' signed?

> +
> +	/* Set all channels to 0 current. */
> +	for (i = 0; i < indio_dev->num_channels; i++) {

	for (unsigned int i = ...) {

> +		ret = ds4424_set_value(indio_dev, 0, &indio_dev->channels[i]);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

-- 
With Best Regards,
Andy Shevchenko



