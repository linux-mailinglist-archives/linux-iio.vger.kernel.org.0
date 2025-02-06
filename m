Return-Path: <linux-iio+bounces-15074-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A01A2AC3C
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 16:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAB3D3A8AAC
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 15:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D72D51EDA0D;
	Thu,  6 Feb 2025 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HAMAfu77"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D011A5B9B;
	Thu,  6 Feb 2025 15:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738854870; cv=none; b=tE936cdcJHxTrp+1LMp7rSvxtjO7gN2WTQtwZSajzQa3HJ6ocRZi4lpU8RWHyX09WGjAdjzTooynqNutbJkJ3uVBch3VVxAECHyZCc5iwQS4/JkqIOv0asW5Fay5K6t6c1m/S3yDfJXV0qKmbxHCtrsqq7MuVv3K2Ld4PbiRJyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738854870; c=relaxed/simple;
	bh=t9cqZ73hIkX27lcJLtc+ipmxM7vC2a5RxdsIIVAnrsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J8PIjL+SDnrpG/9/ZDWjduoZII/pmtDvXQhz7B4Tm9jiwHb1mt4uIV6vHXqmtxiUCs+8EgucGCONVkM7yOm0BAlaJZ/+jxqEVYXKDKyL0yyixRJMJJreVklQDbZPOW/GeQzWmw80tyYhdiHkUkTo6G7DcqNUQNQ7b0AEkuxA/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HAMAfu77; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738854869; x=1770390869;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=t9cqZ73hIkX27lcJLtc+ipmxM7vC2a5RxdsIIVAnrsk=;
  b=HAMAfu77ZBVsmu20c9imTIv/7e43R1qj310gq/wawx2sWTbHMxn4p/eR
   NgygL9HvqkkrZCFthVL3ciaKYwg7ewXd5xCVSu3TybPyNneNCmHjblvw7
   PIwCVQMwbnl3RDVBAWLOP7rV7ryH5K9Yt63bknyHHB/auFPo2yYUfCA/k
   HD4Su9GoLANPv4f25PErCimYHEe3FaYCuEEMWyMtDQrBg3QVlYGkrGk2e
   QSn5o1LZKZkBgrV9UIsPR8QLKAOANNqAmKCje2wbPOMz2jFU4879WyQhi
   J2322jVMTFPWw+IIINz5iCkQc8I7v1H8/SoXV5PK7j1o0BLrye8BWOoUU
   w==;
X-CSE-ConnectionGUID: ZcgDtTWdRDS2r0w0mKWuWw==
X-CSE-MsgGUID: l3JBex9qSqSmR3NqNK1G+g==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42296130"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="42296130"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 07:14:28 -0800
X-CSE-ConnectionGUID: ygznJFoSRH2VjRKbP8U1mg==
X-CSE-MsgGUID: 9cOaqXNrQDSU5OfiOKsN0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="111084299"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 07:14:23 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tg3Zt-00000008l7W-3Qru;
	Thu, 06 Feb 2025 17:14:05 +0200
Date: Thu, 6 Feb 2025 17:14:05 +0200
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
Message-ID: <Z6TRveCRK7LFwSNV@smile.fi.intel.com>
References: <20250203080902.1864382-2-raag.jadav@intel.com>
 <202502060025.XJwUub6I-lkp@intel.com>
 <Z6RS-A2FFjYuPoyn@black.fi.intel.com>
 <Z6TRcWCKe__oxCUV@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6TRcWCKe__oxCUV@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 06, 2025 at 05:12:49PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 06, 2025 at 08:13:12AM +0200, Raag Jadav wrote:
> > On Thu, Feb 06, 2025 at 12:27:03AM +0800, kernel test robot wrote:

...

> > >    102	
> > >    103	static inline
> > >    104	void __iomem *devm_ioremap_resource(struct device *dev, const struct resource *res)
> > >    105	{
> > >  > 106		return ERR_PTR(-EINVAL);
> > >    107	}
> > >    108	
> > 
> > Andy, are we expecting this?
> 
> Oh, no, it's sparse error, but easy to fix. Need to have
> 
> 		return IOMEM_ERR_PTR(-EINVAL);

But isn't it the original issue? I mean that it was already before this series.
If so, perhaps you can fix all sparse errors like this in the devres* code.

-- 
With Best Regards,
Andy Shevchenko



