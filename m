Return-Path: <linux-iio+bounces-27468-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 134B1CEE8F1
	for <lists+linux-iio@lfdr.de>; Fri, 02 Jan 2026 13:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E5BF43007DA4
	for <lists+linux-iio@lfdr.de>; Fri,  2 Jan 2026 12:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D11BA30FC23;
	Fri,  2 Jan 2026 12:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DJhxJsoj"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D050E30F930
	for <linux-iio@vger.kernel.org>; Fri,  2 Jan 2026 12:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767357761; cv=none; b=H/d3XziA+5vSBLTYS3L4QQIAqNGxt01pA+RR1qh/zj5V5sXUgoSF6bXLB3buoVdsclO2DReRW4d5GTOTncw8/gGG+uTGzaypb110oCxpaidnnF+ojluMiljoUsfuCfwEm2KoO6YmTS3HTXj2bB7fsoaXv8har+Uhf0wABH3zL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767357761; c=relaxed/simple;
	bh=HOm2IqfYzkNKgPwQOHGaizp/0DxRn/rEw1rMl9/sFrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eH0+pHX8b5XOfQ/pqlzD4rxLJrwoThv0AUDGNmPEizE9HbOhvAU2gxfBCwCR9ix+iUWSoFJYczzRK70HsOUSCGMlO3Ee32EGyivxv8eSVMwByougWPmisFsj15SlFkGDZnmtcVVu5cdk6/VPeH/qQZt1AvBTqlbAzoW3+Swf8ZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DJhxJsoj; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767357760; x=1798893760;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=HOm2IqfYzkNKgPwQOHGaizp/0DxRn/rEw1rMl9/sFrI=;
  b=DJhxJsojQAKXIH6vHjR6z5+mPsJ/ReQJIdFdMzWkMgA4GUrCfQ+Ilfi1
   mQ0AonfkuA53mjNPWuVfBT5emV7uoVLxqp14buIi9mA/HyHISoLYzl1hG
   IWInOZTtalg/M8FxbPL+pAh5ZHt3hbGSCi59RKuh3FG8sFwyHA54f7zhq
   kfplodhn6z3gX57PHBU1oZYhfYIdzzLgtykBlwUpqBDLl7L79qLCj1AWj
   ojnfUgUlqqf/HBURl3w8QQlXkmRdzLG8SktMATcOEeWhiXl5Kk4dBJ6dm
   leeIm+SJguguSdOOGHVSuo7/R6chSLTgJVrcGcjoOqprIOwDqTdtsbeUI
   w==;
X-CSE-ConnectionGUID: yAsX6Zu4TJed3WLZ+SR1rg==
X-CSE-MsgGUID: QbVgMbYOT92QNpJRJjlWjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11658"; a="68887999"
X-IronPort-AV: E=Sophos;i="6.21,197,1763452800"; 
   d="scan'208";a="68887999"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2026 04:42:39 -0800
X-CSE-ConnectionGUID: ymCxGoXpTsKQNsdJdorXWQ==
X-CSE-MsgGUID: Hvg2IWDgR9+ew9tOYAHGVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,197,1763452800"; 
   d="scan'208";a="201571676"
Received: from ncintean-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.46])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2026 04:42:36 -0800
Date: Fri, 2 Jan 2026 14:42:31 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, nuno.sa@analog.com,
	linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: Re: [PATCH 3/6] iio: buffer-dma: Turn iio_dma_buffer_init() void
Message-ID: <aVe9N4rvCEaI6OyP@smile.fi.intel.com>
References: <20251203-iio-dmabuf-improvs-v1-0-0e4907ce7322@analog.com>
 <20251203-iio-dmabuf-improvs-v1-3-0e4907ce7322@analog.com>
 <aTBmriwVrMwlKiXX@smile.fi.intel.com>
 <760dce5b5721ae6e46daeac03b96df7b009db3ce.camel@gmail.com>
 <CAHp75Ve5TF76gOVgxxW_RGqD10L40EC+gu3URfwrKk-gkh7Q4g@mail.gmail.com>
 <9b92a721cefe9ace63b15d049c463f4c26079d9d.camel@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9b92a721cefe9ace63b15d049c463f4c26079d9d.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 02, 2026 at 10:25:20AM +0000, Nuno Sá wrote:
> On Sat, 2025-12-27 at 16:02 +0200, Andy Shevchenko wrote:
> > On Fri, Dec 19, 2025 at 5:03 PM Nuno Sá <noname.nuno@gmail.com> wrote:
> > > On Wed, 2025-12-03 at 18:34 +0200, Andy Shevchenko wrote:
> > > > On Wed, Dec 03, 2025 at 03:11:38PM +0000, Nuno Sá via B4 Relay wrote:

...

> > > > > While at it, fix a mismatch between the function declaration and definition
> > > > > regarding the struct device (dma_dev != dev).
> > > > 
> > > > So, all others use simple dev?
> > > 
> > > Totally forgot about this. What do you mean by the above? If other functions in the
> > > header use just dev? If so, the one I changed is the only one that uses struct device
> > > (in that header). It is also consistent with what we have for the devm_iio_dmaengine_*
> > > APIs.
> > 
> > Does the device, that is physical, DMA? Or is it a separate device for
> > that purpose? I mean that naming may suggest that they are different
> > devices. The original Q was about APIs. Are all of them, after your
> > patch, use the same device semantically?
> 
> This device is the DMA capable device which provides the DMA chan

A side note, DMA capable device and device that provides DMA chan depending on
the topology can be still different devices. So, the sentence above makes a
little sense to me due to "DMA capable device which provides DMA chan" passage.

> which indeed is not the same as the struct device in the devm APIs (that one
> is the consumer). So dma_dev might be a better name even though the docs
> already make it clear.

Thanks for confirming this!

-- 
With Best Regards,
Andy Shevchenko



