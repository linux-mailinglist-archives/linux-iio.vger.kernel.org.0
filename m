Return-Path: <linux-iio+bounces-15442-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CBDAA32442
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 12:05:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83966168C1D
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 11:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E616A20A5F8;
	Wed, 12 Feb 2025 11:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OuHO1Avs"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15662209F4F;
	Wed, 12 Feb 2025 11:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358325; cv=none; b=ZumrkzNwy9jAhY2dmnsjd1nTA6aeR4JiuEEVtkSwcCV8GxDRRW7HILxCURcXvYngoyGt6rCEeqS+tjm0HlPahqW7Fp8zD3Lild1W/LQ0wjv8WrTSjADk+85xeey09QnPczmtEQMFnVCPwhilC5H0fmpliLZxznTUS/RZnRkTmRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358325; c=relaxed/simple;
	bh=0g7QU6yu2LWPgfB5UYFK/r1xn2uufsX7snmqWwkUlsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZnH8aajCHEw4CtKDtP0/HslIAUQ4PGK8RHbSkmbfCVz0HoPS6AsbZkkoUReQTC8GfenozyoM14biWShNgGR8zb4Y0RHFcsLZljAetNTI7LfbtCykuUh/IjQHyHShESPqjTpK3MJMY7ugpfmYxNg4pnB45eQQoBACnjelka6J7K8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OuHO1Avs; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739358324; x=1770894324;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0g7QU6yu2LWPgfB5UYFK/r1xn2uufsX7snmqWwkUlsM=;
  b=OuHO1Avsdi+lVHxQl8v+LeXNpoDY48twnHYOzqDaKN7JmwW+1jN9mZBO
   Zazy9sBAvyW3TlgXK33Sz81l1FdbCMD91B7hN2z7fVvNgg2sPLVNuzYPW
   hzF9X3XVHt5pNK57Yf1D+WVB4rpTnWN9bZpa5bFK9jt3axwcKh2nw65PV
   gEKLOajH4G8Yh25bkELU1VgncIkrlMcAAIOZ317D1rGGBhV+I+MSvDTSR
   D4JiR6otuo6xX2mvFcoj3oGhtvIfF84rEcSy+uI+5vIMD47AFKIieCFeu
   WevFSD1ZTIOeYNXegrU6AkZXBJOiXU+Y0ed1r0g/sg5KKzdij3ZHiIaQt
   A==;
X-CSE-ConnectionGUID: ek+9dLuUS3ebJ2MHdTtuRg==
X-CSE-MsgGUID: S9ZGn1OMQWi2hNphLvAffQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="40272344"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="40272344"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 03:05:23 -0800
X-CSE-ConnectionGUID: HKSKIniRRXaWdIMTlC8KYA==
X-CSE-MsgGUID: iBOVjp/cQV+utTzuDskRyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117415953"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 03:05:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiAYP-0000000AoRw-2ZHi;
	Wed, 12 Feb 2025 13:05:17 +0200
Date: Wed, 12 Feb 2025 13:05:17 +0200
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
Message-ID: <Z6yAbfVtm8nlZzqu@smile.fi.intel.com>
References: <20250212062513.2254767-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212062513.2254767-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 12, 2025 at 11:55:01AM +0530, Raag Jadav wrote:
> This series
> 
> 1. Splits device/devres.h for the users that are only interested in devres APIs.
>    Original work by Andy Shevchenko:
>    https://lore.kernel.org/r/20241203195340.855879-1-andriy.shevchenko@linux.intel.com
> 
> 2. Introduces a more robust and cleaner devm_kmemdup_array() helper and uses it
>    across drivers.
> 
> The idea behind embedding both work into a single series is to make the review
> process easier and reduce conflicts while merging.
> 
> Current proposal is to merge initial patches with an immutable tag (volunteered
> by Andy) for other subsystems to use. Feel free to share a better alternative.

> v5: Move IOMEM_ERR_PTR() to err.h (Andy)
>     Reduce distribution to pinctrl/iio/input patches

Weren't there two more patches that were actually Acked by Jonathan?

-- 
With Best Regards,
Andy Shevchenko



