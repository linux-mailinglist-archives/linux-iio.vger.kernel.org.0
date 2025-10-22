Return-Path: <linux-iio+bounces-25345-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DE9BFBBA0
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 13:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6A4618853FD
	for <lists+linux-iio@lfdr.de>; Wed, 22 Oct 2025 11:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47D730F7FA;
	Wed, 22 Oct 2025 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SmIhARcm"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E35F530F52B;
	Wed, 22 Oct 2025 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761133825; cv=none; b=anxYcDCRBBZuTaNOPbJroHLTWbui1vELiJa06S3ux9n+VdU77aOSseeiomEiiH5hVAGsmx5hpvawfyKQfFKF0i4obvO8M8ydPlB7F9D7x1NVhDfIR2u1hZk+8UpUTY3eQOvGdQxzXhtUBQFje7anbbivzTMQUGoW7DpSZ+RorkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761133825; c=relaxed/simple;
	bh=u5TPYnOkoEfABi04+jGPySZnwP59I3PvfB31Ze/FrEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UOnmsLKZn11d2DV/sdlBTo+V3084ivzLTVHLuip+GkuRRuL8lETOkG/fVM3tDkPZ9F4XKGMsQnC7D/ikEwS+NoUQGtceAZWXjNneTz4KOz6rlig786Pl/Lca2NvPC9diPxuOK5BHRifMRiR3GLv7WytIPqgp/oGUttdhnE0C1dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SmIhARcm; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761133824; x=1792669824;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=u5TPYnOkoEfABi04+jGPySZnwP59I3PvfB31Ze/FrEo=;
  b=SmIhARcm3RyVLDrkOc1d/sHMQgsLBYq5igNyJXnLRD1QRAaUx4bqrh/Q
   +VfXZIbeSjBQFsJmylRGslhd06Uj195RmSH2ZgcLZXtDTwg/V4K7/bHMY
   h9p7ckIe09L9Pw9MNptFp7zyKew4l4OxVF/Mtt60aP9/UQtYRtdCExp7o
   +wlfNU/SyApiAQL3UgFQbx3sYwHahwErsW9qfAHI+XsGkBmBSYZhhZC4o
   tSV+UH3RMdfUXFwafvKt8ko3/YwHqnmUXqIbNlwTA6L/Bo+vi7rPCKWR5
   EkkZaeAAixHF0IZ7qtdKWN8o0p2XUTqb56wVIGuh0nFRwSBr+Gsoyl9L9
   Q==;
X-CSE-ConnectionGUID: nOXmuV/ASFeh7FJ5zYVYXg==
X-CSE-MsgGUID: TMDEUm87TBuZBNEvJbYnTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="85900915"
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="85900915"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 04:50:23 -0700
X-CSE-ConnectionGUID: 7tbYMpNsR72hBj0nd/kZmw==
X-CSE-MsgGUID: 6Dr86KTbTkWFBvufRE1c7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,247,1754982000"; 
   d="scan'208";a="214796781"
Received: from cpetruta-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.83])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Oct 2025 04:50:21 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1vBXMA-00000001geN-2G2G;
	Wed, 22 Oct 2025 14:50:18 +0300
Date: Wed, 22 Oct 2025 14:50:18 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] iio: accel: bma220: move set_wdt() out of bma220_core
Message-ID: <aPjE-n0wKNIJd2-M@smile.fi.intel.com>
References: <20251021-bma220_set_wdt_move-v1-1-6c99f6fd951c@subdimension.ro>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021-bma220_set_wdt_move-v1-1-6c99f6fd951c@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Oct 21, 2025 at 01:31:49PM +0300, Petre Rodan wrote:
> Move bma220_set_wdt() into bma220_i2c.c instead of using a conditional
> based on i2c_verify_client() in bma220_core.c that would make core
> always depend on the i2c module.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

But Kconfig for this driver is a bit strange. Usually we do other way around,
i.e. make user visible selection of the glue drivers, while core is selected if
at least one of the leaf driver selected by the user.

-- 
With Best Regards,
Andy Shevchenko



