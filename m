Return-Path: <linux-iio+bounces-13208-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E84D59E81C0
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 20:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7301660A8
	for <lists+linux-iio@lfdr.de>; Sat,  7 Dec 2024 19:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF12155756;
	Sat,  7 Dec 2024 19:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QoHgQJRJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95814AD1A
	for <linux-iio@vger.kernel.org>; Sat,  7 Dec 2024 19:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733598358; cv=none; b=jHjiND6WrOoXUUEjD1yW407RbWynp5Z+5b6kv7TVUSA5ZXbxq6D7RBxrwVuGR2Rk/nIi6TGRwW20sdxBhFmNobA3FkTkvQOigUQ1JMuOWTS+0Rsym7yee3fFWZfe5TAQSQbVI4VwbhXI//eR1e7H2vWftxu5c5eAPAu0A45kLY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733598358; c=relaxed/simple;
	bh=6deeLwx0quYDy181Iq9I0XcwSODP2hD71EuJNQM8zFk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ql5iGXBStJFixY7ha3Y2e8pXgB01V6mDDVTC3QoiWn049J+Mv7sxUfedpaN2kzgS44wB+G/isqtehZ8Rxwmh5p2NQb1G4+R3YaTgXB7q2qrAmHRODjtS/0lCu6TYl87HDpq0rg5Xnki4Vhf+Em8V0ih+H+6KZc2x9aYTeslRbsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QoHgQJRJ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733598356; x=1765134356;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6deeLwx0quYDy181Iq9I0XcwSODP2hD71EuJNQM8zFk=;
  b=QoHgQJRJT0K34pLVGuUiGggWOnS/hO8VYnwGVMiUd/4yVbqaJrSSZuYJ
   JgY0NvX+izEVKwOPFaFSbATEBC7EIbKUovgiDRaUN4GvbqFaGJTowFYER
   /8cQ5R/RRnizSVAcOKCNiML0C+9HJmB4bi+0tr+GujLWjCTpZRsxfwIy0
   xxyZdiBQEMeI/yNH2Jlj2W5aeCgJ1+sXH0E62MSKHXUNMGwwRtqJOd061
   rjnE6RRjvuib0uJffPGEGDQ8ONGnab6i1O9HghyxytCAG2wTaYEXn6yMV
   cN1Krq3HdKu7ElQ82E/2UdpLaXjJaCprejdv+TZfXuDIHRssr7zIDWtV/
   w==;
X-CSE-ConnectionGUID: XP8Tb1HkQSKmdpt2DwPuOg==
X-CSE-MsgGUID: 39qfzHEmQASosIUe9g7gdA==
X-IronPort-AV: E=McAfee;i="6700,10204,11279"; a="34051221"
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; 
   d="scan'208";a="34051221"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2024 11:05:55 -0800
X-CSE-ConnectionGUID: 2DaHzy1ISLmUYMPi3XrrZA==
X-CSE-MsgGUID: p3UocLXCRWayb6kgHFPMKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,216,1728975600"; 
   d="scan'208";a="132091339"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 07 Dec 2024 11:05:53 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
	id 09BB81FF; Sat, 07 Dec 2024 21:05:51 +0200 (EET)
Date: Sat, 7 Dec 2024 21:05:51 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>, lars@metafoo.de,
	nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: adc: at91: call input_free_device() on allocated
 iio_dev
Message-ID: <Z1Scj2-FNs7VvZe7@black.fi.intel.com>
References: <20241207043045.1255409-1-joe@pf.is.s.u-tokyo.ac.jp>
 <20241207173046.375dd855@jic23-huawei>
 <Z1Sa1-SlU9ENL5CA@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1Sa1-SlU9ENL5CA@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Dec 07, 2024 at 08:58:32PM +0200, Andy Shevchenko wrote:
> On Sat, Dec 07, 2024 at 05:30:46PM +0000, Jonathan Cameron wrote:
> > On Sat,  7 Dec 2024 13:30:45 +0900
> > Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp> wrote:
> > 
> > > Current implementation of at91_ts_register() calls input_free_deivce()
> > > on st->ts_input, however, the err label can be reached before the
> > > allocated iio_dev is stored to st->ts_input. Thus call
> > > input_free_device() on input instead of st->ts_input.
> > > 
> > > Fixes: 84882b060301 ("iio: adc: at91_adc: Add support for touchscreens without TSMR")
> > > Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> > Hi Joe.
> > 
> > Good catch.  Longer term I'd like this driver to be fully converted to devm
> > managed cleanup though which would have made this bug go away.
> 
> I dunno it's good.
> 
> First of all, the message doesn't contain any pointers to real issue, because
> there is none. And this is can be checked in two clicks on Elixir. Hence, the
> all dance with Fixes tag is wrong.

Ah, sorry, I was looking to the wrong path!

> Second, the submissions is not following the researcher guidelines.

While this is true, the patch seems correct as we need to free the allocated
input.

> Please, consider dropping this.

So, patch can go, but we really need to have explanation that it's done by a
brand new static analyzer tool.

> +Cc: Greg to flag this email for not following the rules.
> Joe, I highly recommend to answer to all your patches that you sent so far that
> they should not be applied (at least in their current forms).
> 
> See also for the details: 20241204122152.1312051-1-joe@pf.is.s.u-tokyo.ac.jp.mbx.
> 
> > However, having looked at it, that conversion is a rather substantial, if simple
> > patch, so I'm fine taking this fix and maybe someone will revisit to do that
> > cleanup later.

-- 
With Best Regards,
Andy Shevchenko



