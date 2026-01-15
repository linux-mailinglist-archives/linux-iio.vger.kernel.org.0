Return-Path: <linux-iio+bounces-27835-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 71FEED24DA2
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 14:59:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6231E3057445
	for <lists+linux-iio@lfdr.de>; Thu, 15 Jan 2026 13:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB6C3A0EAF;
	Thu, 15 Jan 2026 13:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jAGHiyib"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54AD376BD4;
	Thu, 15 Jan 2026 13:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768485523; cv=none; b=bTQTur5BXKfObT1BT1whsy4tWHeAFVTr6etmRfgatyB26P70m7jrlTsWlsT0pKkoPMfXGIdkVYJY36f0xPfHwl0ZMuA9kUYzOC50TUXdLMX8n21wkV6Xes5HtQoJDjWwEYfmnYGcaPgYWUMatNx9ZIKf6X/YPKQlnCstKYHxYYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768485523; c=relaxed/simple;
	bh=Q3r6xRJXJfZeELR/QOZUxRbe1opmU4ti5Bb3uWyHRhQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u0wWBCLWWBKgqBGSUNxS2cTx/1o5j/PD18Ko2ciOwijF2b/m2CxNp8zAoZggQ43Ez8hC1+5SppFNzAHfS1fZv87XlmLOdFSQYTILzHe5M0hzwEnbefgn4udEtdHTHocvN0odEL9rUZG03ktDkes9RkkQdWDIZsD6w3/uFgtdc1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jAGHiyib; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768485522; x=1800021522;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q3r6xRJXJfZeELR/QOZUxRbe1opmU4ti5Bb3uWyHRhQ=;
  b=jAGHiyibspEI4onU5sj/LGKXJfs/hJV368GwxrijxcRG3j4eVccH/AEI
   i1aY6RQhGqNkDbcvUgSX4vioRtqVNKqG/LnhPC4H9xnu8pq7IfQlikuX1
   a60zx9AWlifIlUjbr8BbOgCCIwg3gJ0UAP2liaSOz4CReSAPDMCvZzQNn
   Uaqn6y0tLvz0686n9G6agGOI480Qf3FnVwp9IjYxW2JanQ8kKwLaGw0Pn
   Bx9qSfVWgKf+pDCuB+/IlrwsoX8+jRoY10mt2/k76OpGVZjp/t6NqdAqX
   uENS0koOYPaXBsYeHlVHEEqK77kf6fpoobKc5FqE1GvhaLXcpMm0BOhVW
   A==;
X-CSE-ConnectionGUID: 1ePHwFFPTDKHzvBZGBeilA==
X-CSE-MsgGUID: ZKXXb+xMQ6+RsIq1++taXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11672"; a="57345136"
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="57345136"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 05:58:41 -0800
X-CSE-ConnectionGUID: m03sHXZ7T6yh/yYusM817g==
X-CSE-MsgGUID: S3Q65bGVSSqMwMSxcSG6zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,228,1763452800"; 
   d="scan'208";a="242498281"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.216])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2026 05:58:38 -0800
Date: Thu, 15 Jan 2026 15:58:36 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Francesco Lavra <flavra@baylibre.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] iio: imu: st_lsm6dsx: Add support for rotation
 sensor
Message-ID: <aWjyjLnNE-K0AyUi@smile.fi.intel.com>
References: <20260115122431.1014630-1-flavra@baylibre.com>
 <20260115122431.1014630-4-flavra@baylibre.com>
 <aWjsWzo3PXHKsdJX@lore-desk>
 <aWjwWF2XmXJb-iJI@smile.fi.intel.com>
 <aWjw7_poJUIh9HgI@lore-desk>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWjw7_poJUIh9HgI@lore-desk>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jan 15, 2026 at 02:51:43PM +0100, Lorenzo Bianconi wrote:
> On Jan 15, Andy Shevchenko wrote:
> > On Thu, Jan 15, 2026 at 02:32:11PM +0100, Lorenzo Bianconi wrote:

...

> > > > +	settings = &sensor->hw->settings->sf_settings;
> > > > +	switch (mask) {
> > > > +	case IIO_CHAN_INFO_SAMP_FREQ: {
> > > > +		u32 odr_mHz;
> > > > +		u8 odr_val;
> > > > +
> > > > +		odr_mHz = val * MILLI + val2 * MILLI / MICRO;
> > > > +		err = st_lsm6dsx_sf_get_odr_val(settings, odr_mHz, &odr_val);
> > > > +		if (err)
> > > > +			return err;
> > > > +
> > > > +		sensor->hwfifo_odr_mHz = odr_mHz;
> > > > +		return 0;
> > > 
> > > break;
> > > 
> > > > +	}
> > > > +	default:
> > > > +		return -EINVAL;
> > > 
> > > break;
> > > 
> > > > +	}
> > > 
> > > return err;
> > 
> > Why?
> 
> I guess it is more clear, but just a Nit, I can live with the current implementation.

At least what you proposed is the opposite to the style that is accepted
in IIO.

-- 
With Best Regards,
Andy Shevchenko



