Return-Path: <linux-iio+bounces-15073-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 848A0A2AC32
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 16:13:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A582188A787
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 15:13:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6C1F1EDA04;
	Thu,  6 Feb 2025 15:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f52nrzr2"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5DA1A5B9B;
	Thu,  6 Feb 2025 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738854778; cv=none; b=TzD3S7jQs549Cgg85wCR4149cZ3AXYzKLeL0jGtFQn6XTfQsPh91iehjucutw97GvHzV9h/cpPs+2XGKTCCm1lUrw6Wxmx8WiT53+XRQ91djW4ATYH58+wKoAA+wH5j3dxr7AbqlTYdBPMPxrB8d7HDNPFHMl2HNaFAixGdC6Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738854778; c=relaxed/simple;
	bh=RJROzD70sbLf/RKSEZXXu1DnnrsB6KPPwD5H/f13nuM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jK3zRy5ODLgAG1YA3FzqmhmGBUbQU8PNtDINiqFihWIURpZ1JN++vIiy02qhKZ99xaFBxDa62cw6dh+Yxb8FLtlyDSkyaNpYQhWaG51zNk7o0DXwoiE+8vGJNyA9MtAvXcM7ACy/nSm9AcC4oXjKLuBX0JtTgK7EhGHnBlKYBAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f52nrzr2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738854777; x=1770390777;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RJROzD70sbLf/RKSEZXXu1DnnrsB6KPPwD5H/f13nuM=;
  b=f52nrzr2l5lXIl6xecjDZfjGNXcMBCkYmXCxofG0qaSvVVLmopY1OICG
   9QVaajw39e33DxMzLHkAgr5T5baBSJSc83zt93lx4ZMrB3F2zvGQFxZEG
   sydeLk7wHTbwhqZnZJgVsAw9oTv48W9Gds23NekLSOEN+IE2EUq/+ieNV
   ZM6AyLT2GQNpxk8TJTz28AHc2r9gai4zfacsXXErIn4HzbzH4oNc+aZkZ
   nXK1OIyfarn7qQL28qdiVOoZtZ5Z6vRVQl6hDVbFlHndWenRgoj1+C4gq
   rrz2bsxDW7JKoXs9dt17v0M74J1mvB9ZLvGi4K+5jhRWU0FIlqPg8UWvo
   A==;
X-CSE-ConnectionGUID: to4Rh9/9TJOMcTF0upm9wA==
X-CSE-MsgGUID: pDztWKraTVan9eY/lD7nBw==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="50448752"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="50448752"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 07:12:56 -0800
X-CSE-ConnectionGUID: QnALr2VzTZyFg9bpJmXmjA==
X-CSE-MsgGUID: 2xYi5FCITu6xcFHgfqxkaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="142128361"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 07:12:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tg3Yf-00000008l6g-2fnM;
	Thu, 06 Feb 2025 17:12:49 +0200
Date: Thu, 6 Feb 2025 17:12:49 +0200
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
Message-ID: <Z6TRcWCKe__oxCUV@smile.fi.intel.com>
References: <20250203080902.1864382-2-raag.jadav@intel.com>
 <202502060025.XJwUub6I-lkp@intel.com>
 <Z6RS-A2FFjYuPoyn@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6RS-A2FFjYuPoyn@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, Feb 06, 2025 at 08:13:12AM +0200, Raag Jadav wrote:
> On Thu, Feb 06, 2025 at 12:27:03AM +0800, kernel test robot wrote:

> >    102	
> >    103	static inline
> >    104	void __iomem *devm_ioremap_resource(struct device *dev, const struct resource *res)
> >    105	{
> >  > 106		return ERR_PTR(-EINVAL);
> >    107	}
> >    108	
> 
> Andy, are we expecting this?

Oh, no, it's sparse error, but easy to fix. Need to have

		return IOMEM_ERR_PTR(-EINVAL);

-- 
With Best Regards,
Andy Shevchenko



