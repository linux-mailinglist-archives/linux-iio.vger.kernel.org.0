Return-Path: <linux-iio+bounces-8888-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD0A59650AB
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 22:18:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56A1E1F217ED
	for <lists+linux-iio@lfdr.de>; Thu, 29 Aug 2024 20:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D41761BB68E;
	Thu, 29 Aug 2024 20:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Al6imJ8D"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C374E1BAEDE;
	Thu, 29 Aug 2024 20:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962714; cv=none; b=o9b0i7MjIN8jKCUocQeCcvlT4nwPXlV7GQ5JknnVCjQ6jSaAxYgBWuJGLwEF/L/XKTcJ948anz0Sno2SlpP/1bRWaOOExjM0ARmsmH+Dr/cbrVsd0aqNJjx8V1QclnK0povqYaRRIiqGkonqOMMG3FSR7tMrp8P8Kkp9JnoaGPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962714; c=relaxed/simple;
	bh=SKWfYrbBH0IoRJ/3tiqPCXJ5zpPI+w9UX0N3O8LojwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XQ1iO7ArXpgOLRa4GYDf/7dCnat0mczASCtCy1TprqGiVbFkmIb1eX+mLgLQyrUNuC8ocfr7pcNLAQ7m7dz3OorN67QRpU6OF0gQIxWu18L5yNVjqTe6N5Z3S7V+BiWUE0vKoX6RQMOy7hAg1+ZDhve0mll2cc697HeRrayoJQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Al6imJ8D; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724962713; x=1756498713;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SKWfYrbBH0IoRJ/3tiqPCXJ5zpPI+w9UX0N3O8LojwM=;
  b=Al6imJ8DledFZGYRGw7GZxoaM46NvseFe4A8hnfiBkIb6ia1zxFrKYVO
   NnarmasluwOxVoHzTzpAt0ochUQKDKwz0ptng5ZMBtCJKCHUCmJDiWhPj
   Td4MSwHh5BHRUB84yrGH27M8bbWChHNAsY4dRi7e7HrfsaKUXa6QCJP/Z
   A12yBjE/r5E8lQvWR2tSCSGhABkFhn4C8LKHSpXl8tHSVeLM1YGlfAfHK
   7XbRF9J4kH7JPdsr2yQGC8RCdE4aGm+m4cV3cxdJxwuwZk2PVksKNCaLL
   UgQnr9pRSLNmzIj7IzeNbigZrEjNjBGaSzSTnP24y+Gcl2Z429/3dZWFp
   A==;
X-CSE-ConnectionGUID: 0uxEcvlyR8KJyKAjA5Y05w==
X-CSE-MsgGUID: 4r4iOB6DSei0maF5qUMcew==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34992815"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34992815"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 13:18:32 -0700
X-CSE-ConnectionGUID: 8MEbzyTCSCGD5Ve/3diPvw==
X-CSE-MsgGUID: 5Q+KPRAZSs65U8HIgdNAVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="86922584"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 13:18:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1sjlb7-000000039IC-169l;
	Thu, 29 Aug 2024 23:18:25 +0300
Date: Thu, 29 Aug 2024 23:18:25 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v4 2/7] iio: pressure: bmp280: Add support for bmp280
 soft reset
Message-ID: <ZtDXkZQh689PGtrb@smile.fi.intel.com>
References: <20240828205128.92145-1-vassilisamir@gmail.com>
 <20240828205128.92145-3-vassilisamir@gmail.com>
 <ZtBlLqLgpi2h6kMl@smile.fi.intel.com>
 <20240829190004.GB3493@vamoiridPC>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829190004.GB3493@vamoiridPC>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Aug 29, 2024 at 09:00:04PM +0200, Vasileios Amoiridis wrote:
> On Thu, Aug 29, 2024 at 03:10:22PM +0300, Andy Shevchenko wrote:
> > On Wed, Aug 28, 2024 at 10:51:22PM +0200, Vasileios Amoiridis wrote:

...

> > Yes, it's up to 84 characters long, but I think it improves readability.
> 
> In all the previous cases though, shouldn't checkpatch.pl generate errors?

No, much earlier than 100 characters relaxed limit was introduced, checkpatch
stopped complaining on long string literals.

> I didn't notice that they were below 80 chars and I never checked more
> because checkpatch.pl didn't say anything...

Exactly! This is old (6+ years?) feature.

-- 
With Best Regards,
Andy Shevchenko



