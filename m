Return-Path: <linux-iio+bounces-15086-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 351DAA2B1DB
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 19:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21713A90C1
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 18:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A261A9B3F;
	Thu,  6 Feb 2025 18:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UPsD/Kxl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FF71A23AA;
	Thu,  6 Feb 2025 18:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738868184; cv=none; b=Ag+UVvJzcN6pU19j0RyX3j6IzA79fo1CyGuuFD0xOcu8/QxGZkcAFWry1/9/i8DLvzCEQeoDCOBlNaJb1lH+/MbjWcdbW4aslY2LDa8pnzRq2WD8Vu3f4BX2tTYyyXWczfxGgIHQGmZzBrBLg3UOg5KS6LhUyKizCJQUMXi92CA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738868184; c=relaxed/simple;
	bh=OVIX+I9s2Gn9nEIsO4OMzsbU9FZlTuUnVtikqRD0/u4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lYBNmh7v5AeZPVAg1RnGEaaH31NTwn/03PDdo0SKuJ0Y/rs1wUESt5XEOarQNV7974XkDyBoTDaZNiMLBsr1xBKqNBVkBceGlhX9zaZKNZTkGSsbLps6Lssjnv8+bxxNaUT2grfhjM9WtfXOdl07d08QANE4mB40jq6vyYHOsQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UPsD/Kxl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738868182; x=1770404182;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OVIX+I9s2Gn9nEIsO4OMzsbU9FZlTuUnVtikqRD0/u4=;
  b=UPsD/Kxl43vN204WBOHSeoi603l3aRjWNRmtYmFiAbb/JUoHg7zi0XoL
   qTwlRrag3kZBFuXLvgtbD5p9J4zzDAhb+NPPMR26gDsFdiJgwgwpG3/CM
   HYJp1JmyL+EtmVfrP5/N0AiCouK918u8UdOWCkTNshof9icQ/THn3EEM0
   bTq/rBJyhlUHjp9eU/J38n+L4rQz6km1s9MKfodCMRRfB7+083nYKiv0T
   20JRFwkrlvsAdQbgPrlk1NFdlYiGFGAdzuV2D3euqIzXMeWyoTylVen63
   p0d5reNY+mto9a+f1WF4dA8O5ZrvDh2nS2bmPrYCu5bZdCWadfPdCrL0X
   Q==;
X-CSE-ConnectionGUID: d8v/J7RwREmUep9EhE62ng==
X-CSE-MsgGUID: pBx36a8XQG6hMA03JWFE7A==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50129494"
X-IronPort-AV: E=Sophos;i="6.13,265,1732608000"; 
   d="scan'208";a="50129494"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:56:21 -0800
X-CSE-ConnectionGUID: 76E51o4ORZKr0zRu6nVOxA==
X-CSE-MsgGUID: sJ1vyTjsTNGLJLvZagFQzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="116235177"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:56:16 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tg72q-00000008oyh-2O83;
	Thu, 06 Feb 2025 20:56:12 +0200
Date: Thu, 6 Feb 2025 20:56:12 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Raag Jadav <raag.jadav@intel.com>
Cc: kernel test robot <lkp@intel.com>, gregkh@linuxfoundation.org,
	rafael@kernel.org, linus.walleij@linaro.org,
	mika.westerberg@linux.intel.com, dmitry.torokhov@gmail.com,
	lgirdwood@gmail.com, broonie@kernel.org, sre@kernel.org,
	jic23@kernel.org, przemyslaw.kitszel@intel.com,
	oe-kbuild-all@lists.linux.dev, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
	linux-sound@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 01/20] driver core: Split devres APIs to
 device/devres.h
Message-ID: <Z6UFzP7M4ng_17s_@smile.fi.intel.com>
References: <20250203080902.1864382-2-raag.jadav@intel.com>
 <202502060025.XJwUub6I-lkp@intel.com>
 <Z6RS-A2FFjYuPoyn@black.fi.intel.com>
 <Z6TRcWCKe__oxCUV@smile.fi.intel.com>
 <Z6TRveCRK7LFwSNV@smile.fi.intel.com>
 <Z6T7PE2Qpw4VbQyn@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6T7PE2Qpw4VbQyn@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 06, 2025 at 08:11:08PM +0200, Raag Jadav wrote:
> On Thu, Feb 06, 2025 at 05:14:05PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 06, 2025 at 05:12:49PM +0200, Andy Shevchenko wrote:
> > > On Thu, Feb 06, 2025 at 08:13:12AM +0200, Raag Jadav wrote:
> > > > On Thu, Feb 06, 2025 at 12:27:03AM +0800, kernel test robot wrote:

...

> > > > >    102	
> > > > >    103	static inline
> > > > >    104	void __iomem *devm_ioremap_resource(struct device *dev, const struct resource *res)
> > > > >    105	{
> > > > >  > 106		return ERR_PTR(-EINVAL);
> > > > >    107	}
> > > > >    108	
> > > > 
> > > > Andy, are we expecting this?
> > > 
> > > Oh, no, it's sparse error, but easy to fix. Need to have
> > > 
> > > 		return IOMEM_ERR_PTR(-EINVAL);
> > 
> > But isn't it the original issue? I mean that it was already before this series.
> 
> For all this time?

Yep. 0-day bot doesn't complain on pre-existed issues, but in case one touches
the line it becomes a new issue from its point of view.

> > If so, perhaps you can fix all sparse errors like this in the devres* code.
> 
> With a fixes tag?

Maybe.

-- 
With Best Regards,
Andy Shevchenko



