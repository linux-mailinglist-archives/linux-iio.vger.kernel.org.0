Return-Path: <linux-iio+bounces-18329-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CE6A94417
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 17:03:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFD1E17B16C
	for <lists+linux-iio@lfdr.de>; Sat, 19 Apr 2025 15:03:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 005A81D432D;
	Sat, 19 Apr 2025 15:03:21 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3C1171A1;
	Sat, 19 Apr 2025 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745075000; cv=none; b=QnxsSPZiBK4n7vDnRTuCY5wAB0b7cpE4g9R/z6lrXyGUEh8F+zSpdcEPs2n9VvCjdI3fiEdakZSAvaogAtZiXtlJj6KWkl7mmezr2fStL8sQCcCAlCganRfwCcR0oJXmOzSvXyIUkrvLpRCoFT1NgXV8B6WZ/CTLP8zmL56qAzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745075000; c=relaxed/simple;
	bh=vHpS0EOUKOHvUmrrsu3bCjDD09un1f06BTLzyFjP/HA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mL8bSRorKGzm17rw0gBr3pup/NZNkpYW1l/gCqzg5SRncH68U+q6D/SkYI7d+2xEEJ9g1UjAHwVNIqI1AUILg0jDmpgF4PWjksdT1GTNJ3mwkHD29u7mXZI/ehw8XUKMXqjFigyYUzrn1DeYzTewggj4PKVXPKNizf3Gk0R+i0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: hVmOVozcSWarKpdua547Bw==
X-CSE-MsgGUID: or+H6hU5Riy0cHhGFiOU2w==
X-IronPort-AV: E=McAfee;i="6700,10204,11408"; a="57664685"
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="57664685"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 08:03:17 -0700
X-CSE-ConnectionGUID: 1zEt/x4wRNOyYkhI+wDheQ==
X-CSE-MsgGUID: 1jXqXl0rTy+4WZWHFFyFZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,224,1739865600"; 
   d="scan'208";a="132319883"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2025 08:03:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1u69ip-0000000DqU2-2roN;
	Sat, 19 Apr 2025 18:03:11 +0300
Date: Sat, 19 Apr 2025 18:03:11 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: amplifiers: ada4250: use DMA-safe memory for
 regmap_bulk_read()
Message-ID: <aAO7Lw13xrEGmZLL@smile.fi.intel.com>
References: <20250418-iio-amplifiers-ada4250-simplify-data-buffer-in-init-v1-1-7e7bd6dad423@baylibre.com>
 <CAHp75Vdxdbqu6qkbuo5y4jADOH_h9Re6m8icSj3Je4hnVsha0g@mail.gmail.com>
 <ed5c4b46-0b3f-4278-ba8e-6f6977f18429@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed5c4b46-0b3f-4278-ba8e-6f6977f18429@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Fri, Apr 18, 2025 at 02:09:04PM -0500, David Lechner wrote:
> On 4/18/25 1:58 PM, Andy Shevchenko wrote:
> > пʼятниця, 18 квітня 2025 р. David Lechner <dlechner@baylibre.com <mailto:dlechner@baylibre.com>> пише:
> > 
> >     Use DMA-safe memory instead of stack-allocated memory for the call to
> >     regmap_bulk_read() in the ada4250_init() function as this could be used
> >     directly by a SPI controller.
> > 
> > Sorry, but can you elaborate more on this? If driver doesn’t override the
> > callbacks the regmap SPI uses spi_write_then_read() which is supposed to be
> > dma safe. 
> 
> Ah, I didn't dig that far down. Will send a new patch that just cleans up the
> unnecessary alignment and unaligned call.

But do you have a real life issue with that? Coincidentally we discussed
similar case in another driver with colleague of mine, and he insists that it
might be still broken (somewhere).

> (Also can't believe you sent HTML mail!)

Yeah, Gmail from the phone can't actually send a plain text :-(
Very strange from Google, while I understand that the case most
likely is for business, where HTML is a standard (sic!) for emails.

-- 
With Best Regards,
Andy Shevchenko



