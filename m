Return-Path: <linux-iio+bounces-15848-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8533CA3D9C6
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 13:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 991D719C1D8D
	for <lists+linux-iio@lfdr.de>; Thu, 20 Feb 2025 12:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E10E1F4E27;
	Thu, 20 Feb 2025 12:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DbzWuNxQ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406791F236E;
	Thu, 20 Feb 2025 12:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740053978; cv=none; b=VD1dxvjhDUXrD1WMcnfhpF+vlGpBzEYOpq8AyAk+eWOuXaLsJ5tB3XKKFK11ZgWEsTjKGuio3zG0XS8nHCnzzWjstW+S9X3uaDXzrA5WknF3fv6wj4KfX8nhPZ3ImBk4sGOopLt5thZGJZDHYrgWXsqPMcuq/5IBkqLvNeHHiL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740053978; c=relaxed/simple;
	bh=tP/lrI/hGS2N+0F6CChethc1EFm2eSLcncvZeP8SRJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rzfLdZrIrbi3U8438TEEXzlkQeKMSw4yL4kTMzmMzCai8Cng7MkiEAfGclP52a5qxTKIYjmna3z0MkbWRGAf0Qb5D0uyXZtC74loXhfQUUGr6KoDpKl0GbaKqHDI5L5OYcyqP84nVbeS4Tay1tUN8uXLT/LwP3qiW7tBvXKoFqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DbzWuNxQ; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740053977; x=1771589977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tP/lrI/hGS2N+0F6CChethc1EFm2eSLcncvZeP8SRJo=;
  b=DbzWuNxQSxrlgnFMToo+yuJBfWZOqvzPoggbxULHsUDE9MueAJSO1pR+
   rmQOPLsf25itQMbc5vRh/nLIg3TXU2lCpWMdkkTATkuJtfk2/eHPGkvBz
   ySvJkHVa0f/xYAsSmKUYUO7f2wnX8gxFYRSddFoCB6HiUhbrvuF+9vyHa
   Dk6V1MdMqQgGPX1KADLbMzIupkpZBdvpvZcY539jBCKjC5szrPvzD4dFH
   xHXznqTJjw8AXYQGh+qoIK+May3rgGFJZJLevig1pOhBHESHiN0LnU1lD
   QCHF6JRWsdRnTPdL9DlsWovwMlle4u+NjiBgwRypZ4LsbtQhBfueZVmyJ
   A==;
X-CSE-ConnectionGUID: Tbg1prMTRTinm5xL/TdwRA==
X-CSE-MsgGUID: aSZZHJMkRqSjATekEhnfIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="40061245"
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="40061245"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 04:19:37 -0800
X-CSE-ConnectionGUID: E7ISxJ4DRGey/xI2cmAihA==
X-CSE-MsgGUID: YgoXLhqOTAqm4U1QtjBxkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,301,1732608000"; 
   d="scan'208";a="115222212"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 04:19:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tl5Wc-0000000DKIh-3Mdu;
	Thu, 20 Feb 2025 14:19:30 +0200
Date: Thu, 20 Feb 2025 14:19:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: arnd@arndb.de, gregkh@linuxfoundation.org, rafael@kernel.org,
	linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
	dmitry.torokhov@gmail.com, jic23@kernel.org,
	przemyslaw.kitszel@intel.com, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v5 00/12] Split devres APIs to device/devres.h and
 introduce devm_kmemdup_array()
Message-ID: <Z7cd0q6-nO1rnUIm@smile.fi.intel.com>
References: <20250212062513.2254767-1-raag.jadav@intel.com>
 <Z6yAbfVtm8nlZzqu@smile.fi.intel.com>
 <Z6zKrvdPYPKPcjk2@black.fi.intel.com>
 <Z6zYnt4-6KDwErjU@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6zYnt4-6KDwErjU@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 12, 2025 at 07:21:34PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 12, 2025 at 06:22:06PM +0200, Raag Jadav wrote:
> > On Wed, Feb 12, 2025 at 01:05:17PM +0200, Andy Shevchenko wrote:
> > > On Wed, Feb 12, 2025 at 11:55:01AM +0530, Raag Jadav wrote:
> > > > This series
> > > > 
> > > > 1. Splits device/devres.h for the users that are only interested in devres APIs.
> > > >    Original work by Andy Shevchenko:
> > > >    https://lore.kernel.org/r/20241203195340.855879-1-andriy.shevchenko@linux.intel.com
> > > > 
> > > > 2. Introduces a more robust and cleaner devm_kmemdup_array() helper and uses it
> > > >    across drivers.
> > > > 
> > > > The idea behind embedding both work into a single series is to make the review
> > > > process easier and reduce conflicts while merging.
> > > > 
> > > > Current proposal is to merge initial patches with an immutable tag (volunteered
> > > > by Andy) for other subsystems to use. Feel free to share a better alternative.
> > > 
> > > > v5: Move IOMEM_ERR_PTR() to err.h (Andy)
> > > >     Reduce distribution to pinctrl/iio/input patches
> > > 
> > > Weren't there two more patches that were actually Acked by Jonathan?
> > 
> > Nope, iio only has one user each.
> 
> Okay, so we basically waiting then for Greg KH to review / ack the couple of
> patches (2 and 4) and Dmitry and Jonathan one patch for each.

I'm going to apply this series to Intel pin control tree soon and share
an immutable tag TWIMC, please tell me if it shouldn't be the case.

-- 
With Best Regards,
Andy Shevchenko



