Return-Path: <linux-iio+bounces-20055-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30314AC9541
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 19:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F6F3A220F5
	for <lists+linux-iio@lfdr.de>; Fri, 30 May 2025 17:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A475275862;
	Fri, 30 May 2025 17:51:51 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD33262FD1;
	Fri, 30 May 2025 17:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748627511; cv=none; b=n+s96iQVPMQpuHuD4uM16Dj1Dtyxi/ePc7DXAZxroB2Blm2XfzDnTX2IESYCQdG5Lra0rZCuyavyUWqUIT0naeoHHWYsXL9PRyt++pf6m+dtiPIfdlJR6QsCF5NUktMqzznlaHALQUYudsrebQmmdthrvyH4GOkf6tGuUFb9uvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748627511; c=relaxed/simple;
	bh=4glJh4nhklPrnkGM5a9SUGxv+OdnSbFstN9xhw0M7sI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1AgmdHiGmK+5WCHHtAtL5WGhcLiuggu5LK535B5Rd1+zMssTwXYIHXz/dDY0X4j94/jEvbYAGKZ/a5qCij1qk2tVt/v5ysMM/ohOsUkN5+DfwyKh5I+I077WOeTmOwwG0aBYpA039s2VvgdUY+T1hcaiBL93LiALo+5nit+I+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: fB0BIYvDQDmpvyyEGXHR8g==
X-CSE-MsgGUID: w22ba/XiSYypHQbzA0jlmQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11449"; a="49848524"
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="49848524"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 10:51:49 -0700
X-CSE-ConnectionGUID: 8FZKRsOPQGGlocHuaAMexA==
X-CSE-MsgGUID: VCRWgnKFSxCtSTRPECEGrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,196,1744095600"; 
   d="scan'208";a="144917425"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2025 10:51:47 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1uL3tQ-000000024c6-2xsi;
	Fri, 30 May 2025 20:51:44 +0300
Date: Fri, 30 May 2025 20:51:44 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Sean Nyekjaer <sean@geanix.com>, Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] iio: accel: fxls8962af: Fix use after free in
 fxls8962af_fifo_flush
Message-ID: <aDnwMDGDf3-KUb3J@smile.fi.intel.com>
References: <20250524-fxlsrace-v1-1-dec506dc87ae@geanix.com>
 <ed40509d-9627-43ce-b209-ca07674988ff@baylibre.com>
 <CAHp75VeAOFXuxsiAEwJ=dMJ8NZsyA7E-h4L=2ZgpprdUXU2EUA@mail.gmail.com>
 <67c33f11-0196-44f4-9cdd-762618cb88be@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <67c33f11-0196-44f4-9cdd-762618cb88be@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 29, 2025 at 01:49:16PM -0500, David Lechner wrote:
> On 5/29/25 1:16 PM, Andy Shevchenko wrote:
> > On Thu, May 29, 2025 at 7:02 PM David Lechner <dlechner@baylibre.com> wrote:
> >> On 5/24/25 5:34 AM, Sean Nyekjaer wrote:

...

> >> fxls8962af_suspend() calls enable_irq_wake(data->irq); before disabling the
> >> interrupt by calling fxls8962af_buffer_predisable(indio_dev);
> >>
> >> It seems like the order should be reversed.
> > 
> > AFAIU the wake capability of IRQ line is orthogonal to the interrupt
> > controller enabling (unmasking) / disabling (masking) the line itself.
> > Or did you mean something else?
> 
> I don't know enough about how suspend/wake stuff works to say for sure.
> 
> I just saw the comment:
> 
> 	/*
> 	 * Disable buffer, as the buffer is so small the device will wake
> 	 * almost immediately.
> 	 */
> 
> so I assumed someone had observed something like this happening already.
> If an interrupt occurs between enable_irq_wake() and actually
> going into a low power mode, what effect does it have? I ask because I
> don't know.

To be a "wake source" means to be capable of signaling to the system that wake
is needed. If an event comes after enabling an IRQ line to be a wake source,
that should wakeup the system (independently if that IRQ line is disabled or
not on the IRQ controller side).

-- 
With Best Regards,
Andy Shevchenko



