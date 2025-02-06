Return-Path: <linux-iio+bounces-15080-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EE61A2AFF6
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 19:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9A81885644
	for <lists+linux-iio@lfdr.de>; Thu,  6 Feb 2025 18:12:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C7C19E971;
	Thu,  6 Feb 2025 18:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aXtKdv84"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5588F19ADB0;
	Thu,  6 Feb 2025 18:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738865477; cv=none; b=mMgRQkcF7JCzQkH9l0LNvUelrstLuYPiI4pqQxd2KvvdqFmputyHA6YCGFV8hnUWJH/mTdXl/x1A1mcbl6h52s0QI76vvr98T8oFt0kbXf+ovQleBLv6VUkmSOKKeyc3qNSjpjg7xS2OnayRcjiS/sB5ZXus3Cm2JX9eerdtztE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738865477; c=relaxed/simple;
	bh=9vRyEHJHFpcr3sE+aLJw6NFhHWVoNdgXB+W5Pdi5tVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jO19+uzlmN5qIlKyIr45LGf35tIL4WVanv2pyQrXxkV7ChX3FiA8mUicQXk8QCVX00DNm6jMOYbhT3xFYcPwb8t9ykhrdVdHy4GeXY/4brFFoXcycGMYPlukybCyjn7ClVcku+VtNS1jQd/9Pfo8uJJ17HACQ6HRyGnb7f156jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aXtKdv84; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738865477; x=1770401477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9vRyEHJHFpcr3sE+aLJw6NFhHWVoNdgXB+W5Pdi5tVE=;
  b=aXtKdv84E5An8lvTcMTlolTkvUGZz1pGk/JfPjDftDK7m/372GRBy8dl
   fLOnH+XNWQwY8nvMZhAvKSJzqiaoX74HHlXHeLqs1lrzVqTVYbU+HgZGX
   eHEH0pVVqJV+z3xLgSPHdWgm9Daq7Cf3j+71NKpNH/2ttmu4cGzIc5FU/
   2xzGDN0QMs2mmatfyR3MF3/jyflSfGZ0kYU4MqL8xSly7nMScFgMSquet
   SCHeEcjbOycic0iFYZGmqi6+hWU95QStxEoy+BRFlaSdsdfteYZJx/W8U
   aaGTSY8IAqoderZ6fS5SW5TB4Acw5zqFEw//+rfryUpCHqWiCSO1ADEHo
   A==;
X-CSE-ConnectionGUID: VUoSYIK9S9+oEzOwHb9GYA==
X-CSE-MsgGUID: /347yr5JSFWMQyueWESMRA==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="56904265"
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="56904265"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:11:16 -0800
X-CSE-ConnectionGUID: Ju8QnR+iS3iwXTl/7oVP/A==
X-CSE-MsgGUID: izyH6iwjThCvY8M+hQh3Gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,264,1732608000"; 
   d="scan'208";a="111118158"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:11:11 -0800
Date: Thu, 6 Feb 2025 20:11:08 +0200
From: Raag Jadav <raag.jadav@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
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
Message-ID: <Z6T7PE2Qpw4VbQyn@black.fi.intel.com>
References: <20250203080902.1864382-2-raag.jadav@intel.com>
 <202502060025.XJwUub6I-lkp@intel.com>
 <Z6RS-A2FFjYuPoyn@black.fi.intel.com>
 <Z6TRcWCKe__oxCUV@smile.fi.intel.com>
 <Z6TRveCRK7LFwSNV@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z6TRveCRK7LFwSNV@smile.fi.intel.com>

On Thu, Feb 06, 2025 at 05:14:05PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 06, 2025 at 05:12:49PM +0200, Andy Shevchenko wrote:
> > On Thu, Feb 06, 2025 at 08:13:12AM +0200, Raag Jadav wrote:
> > > On Thu, Feb 06, 2025 at 12:27:03AM +0800, kernel test robot wrote:
> 
> ...
> 
> > > >    102	
> > > >    103	static inline
> > > >    104	void __iomem *devm_ioremap_resource(struct device *dev, const struct resource *res)
> > > >    105	{
> > > >  > 106		return ERR_PTR(-EINVAL);
> > > >    107	}
> > > >    108	
> > > 
> > > Andy, are we expecting this?
> > 
> > Oh, no, it's sparse error, but easy to fix. Need to have
> > 
> > 		return IOMEM_ERR_PTR(-EINVAL);
> 
> But isn't it the original issue? I mean that it was already before this series.

For all this time?

> If so, perhaps you can fix all sparse errors like this in the devres* code.

With a fixes tag?

Raag

