Return-Path: <linux-iio+bounces-21201-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ADEFAF03AA
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 21:23:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19E917A8D1D
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 19:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FB4289E17;
	Tue,  1 Jul 2025 19:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pi7muLhS"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28722289368;
	Tue,  1 Jul 2025 19:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751397556; cv=none; b=ryngnBqs+lriUdL1iOn/u58qxF2R6yXvn76TqNp1AK5a8t/4RV5UOnOMZvYZz6qISAnSg+yx6jflGDP2SBeA87Aca4OkII4c5/UkL3+HH7H6PN5maMkK/DF89V/53qCOfqYQ4cGm6q0RntqxU746u+8euKsqHCtRbNXvrfxQFfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751397556; c=relaxed/simple;
	bh=8MHjH/6XZDvpT7djI41gL9aJAkFZWYXWBGKE1Obf8YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GwM3JqmDg9fMpQrPPQX3pCOyn64zmmE8G+/8hYUKR7nMC4mJe7H3c4Twpts3buKjLtedVNipgisNUBxAkP5O9r8g66QPc4dCwt+rbOVgqIrZI9/1EJa2A2Qiy8q6YMYGLOr6io49MYP0S8fgMwv/rO+Xc1S+TFese39pXWzTvTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pi7muLhS; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751397555; x=1782933555;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8MHjH/6XZDvpT7djI41gL9aJAkFZWYXWBGKE1Obf8YY=;
  b=Pi7muLhSHD2hNg1oKlz3lwzYPTFW/4RMsv+wyQB0uKJ2Fvwsv9w+i0gb
   NZeaKQTEcogkkUhQYvP5mVsTKntpgRB2MjMqh64swp0U4nqxYSVBQaZMK
   sDgIc/B5rB5TxL7h7TJ5LXm1r+mv/ErobQ2MyZi3nB0KbqSSPjolHD3xi
   B1O1JbYGtoOpC5qpzPWxDUkcGVWE+Pw+JvuGah/mO+cr+5vWsLOGlu177
   ZLa5sFiT3DXue2S/fzbllIBSr7jwusz5KlpMXI/uy/oe2tD2q+0/3dNc5
   vL2g+02OCzaBMQaQuS2Nwo9haH+RU7AWgLoZco9hBHQbgryOT9w2CJ5wQ
   g==;
X-CSE-ConnectionGUID: ztDqNVr6QZey78KtCisYdA==
X-CSE-MsgGUID: fEqDT+1LSJ2S60NQYz2Dxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53821610"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="53821610"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 12:19:14 -0700
X-CSE-ConnectionGUID: ZPla5lKLSbumskX2qcs/iQ==
X-CSE-MsgGUID: dHqb5JBxQzeoSp6IompcSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="184802034"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 12:19:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWgVZ-0000000Bfxc-2RHt;
	Tue, 01 Jul 2025 22:19:09 +0300
Date: Tue, 1 Jul 2025 22:19:09 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Cc: jean-baptiste.maneyrol@tdk.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: Replace scnprintf with
 sysfs_emit
Message-ID: <aGQ0re136jUaPN-o@smile.fi.intel.com>
References: <20250701154720.54276-1-chelsyratnawat2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701154720.54276-1-chelsyratnawat2001@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 01, 2025 at 08:47:20AM -0700, Chelsy Ratnawat wrote:
> Documentation/filesystems/sysfs.rst mentions that show() should only
> use sysfs_emit() or sysfs_emit_at() when formating the value to be
> returned to user space. So replace scnprintf() with sysfs_emit().

...

> -		return scnprintf(buf, PAGE_SIZE,
> -			"%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
> +		return sysfs_emit(buf, "%d, %d, %d; %d, %d, %d; %d, %d, %d\n",
>  			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);

Ideally second line should be reindented, but I won't be bothered by that
right now.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



