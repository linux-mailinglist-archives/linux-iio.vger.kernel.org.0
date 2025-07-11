Return-Path: <linux-iio+bounces-21561-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B206B01354
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 08:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 667A75C23F7
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 06:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C041D5CDE;
	Fri, 11 Jul 2025 06:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GBgVQp/V"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43200944F;
	Fri, 11 Jul 2025 06:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752214184; cv=none; b=TW8Ftc+aE5IPGqUndOK61ABz88aJ/FofE4/LvSB30e3dBNJEUgcucS0ECB5tlprguLUjy5V23UUqcgWbGxSKtw7l4NzSPfODOB9iCaM8LefmmI+ZdKX60uejLSb3wjbebJpwsWQqZ0eWhBtyoOp5ySNOmdSvC+JwaI56YzrGvsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752214184; c=relaxed/simple;
	bh=R9Fpa73buHZaMDm/CypJX9RwDyO2X2psftk0JY+YOi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jvzGaNipdAT+q4IWam2X437i179u6bWMb3cWT6D6U5t6r6Ldr7K55FUKvvhZlyTSX9aIfyKqqRHOAGFqq27LaYG7j0Wf5Ce3KCMEWTSGr6FPvUq5dSy1HnwBVcToAf7+sYcMs4y8fKy/4wfb4RmTavqUO5OJln7OrJutA8YxDEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GBgVQp/V; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752214183; x=1783750183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R9Fpa73buHZaMDm/CypJX9RwDyO2X2psftk0JY+YOi4=;
  b=GBgVQp/VmJH/3ykLlXD/fsZNm9nuuqd3KIZ7zt7KRhAdZ1F9Q2GG8+x6
   fpoj3tWe5zL00zKHrJUvkFg1xJ7xwul4ObbasyrRc1QfgZbCKJvEMQzFh
   krsMTlvPClspUOf2/3yaCnQ4wf42TG4l7xovW3pFqLvD3uASNW1LUvO/I
   uLZFGzMLwzvbZBcgSVopGxRrIicFrSoM0GY67XVGnlFokRNZhLtRd12nu
   mf0BoUVro/MFvbgTQh3MXxzHXTfyBM5a8c2DhK50WAjiuO+Z2c9cbBn0z
   1QV3yHLP65s+8LvGfc5A01OqnscE2ffhNZ8H2K7fmNV8iVrDjLckDQMon
   Q==;
X-CSE-ConnectionGUID: RAH/8VVORCCpgEDOXvW8Hg==
X-CSE-MsgGUID: Zg6UEqNDTomWz8Z4el35uQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="58314908"
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="58314908"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 23:09:43 -0700
X-CSE-ConnectionGUID: hCnUPyLSTaGJ6KOAoXbx+A==
X-CSE-MsgGUID: hPsMswBqS8ejXImduMjRTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,302,1744095600"; 
   d="scan'208";a="156377505"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 23:09:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ua6wy-0000000EQvn-2Uh4;
	Fri, 11 Jul 2025 09:09:36 +0300
Date: Fri, 11 Jul 2025 09:09:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: kernel test robot <lkp@intel.com>
Cc: Remi Buisson via B4 Relay <devnull+remi.buisson.tdk.com@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, Remi Buisson <remi.buisson@tdk.com>
Subject: Re: [PATCH v2 6/8] iio: imu: inv_icm45600: add SPI driver for
 inv_icm45600 driver
Message-ID: <aHCqoCNhXPqdKZId@smile.fi.intel.com>
References: <20250710-add_newport_driver-v2-6-bf76d8142ef2@tdk.com>
 <202507111201.r62j5rb6-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202507111201.r62j5rb6-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 11, 2025 at 12:55:25PM +0800, kernel test robot wrote:
> Hi Remi,
> 

>    drivers/iio/imu/inv_icm45600/inv_icm45600_accel.c:100:20: note: initialize the variable 'sleep' to silence this warning
>      100 |         unsigned int sleep;
>          |                           ^
>          |                            = 0

For the record, this is usually bad advice by the compiler. You need to either
check for errors, or do something else.

>    drivers/iio/imu/inv_icm45600/inv_icm45600_gyro.c:100:20: note: initialize the variable 'sleep' to silence this warning
>      100 |         unsigned int sleep;
>          |                           ^
>          |                            = 0

Ditto.

-- 
With Best Regards,
Andy Shevchenko



