Return-Path: <linux-iio+bounces-9077-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5969896A0CE
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 16:37:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ECA71B26768
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 14:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C08113D245;
	Tue,  3 Sep 2024 14:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lFHDrx6s"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D74CE1CA69B;
	Tue,  3 Sep 2024 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374240; cv=none; b=rG8FsRCFYdK/DztFfqCyD+KvhUfyz5WoCLWRQIjLBQAxojZF7iZ55bLI1Na04+nx75jKRDWlATeYoNf1k9moVVQrku9zx3nBpW44lW/nZOS5vdR15V8PVeKjNQ6w+u9SDY4WqHXGKqqwFKPWxAwY7hUiy92xQsId7H7Y6GX6PTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374240; c=relaxed/simple;
	bh=mc5whrycKE1zZyd4VrCEjvI4WG+qhy2PVteQgWMSXtw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtpyZkvt8rb9JYPNtk/rzy7AF30jsRlgNR8cRK7TQ+JYev9IDgq4Vy1segS55cAOZnrcJJvclzkYxhS66AJTK/x3LBgBmBcbqLTHsbi9AuDpJdUftC2Twj5tyy+B4rZyDJ4AJ86oqlHPa0gt5fBZYzvhQRv9eq4HYHlT0CI2yPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lFHDrx6s; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725374238; x=1756910238;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mc5whrycKE1zZyd4VrCEjvI4WG+qhy2PVteQgWMSXtw=;
  b=lFHDrx6sQpQOA31y3Solv/y8Jd4ZtioPIZ35mvjL7N2ZHzUx5ixTO0VB
   B0mCfYTqKnnNh3ICSzQmx2RCRCWNlAyy9kNEkUcNkbYp4tW/j66OjsXdn
   ZVk0WcrPj+4GUA/gmvjRuhU+/vuENQZR8v6cwWd+ScH3Hmzm0aR132v7I
   tu0oFC8okBRSKVr3YEWvXoK83xeO+eYQDOAPEJwxfaQmZxeljbUpbQZfZ
   OHD2W2y2Vwtwk674V2Yvpmwu8YJnIKMvg97ifOPHS+hEb1wu3TDwrV739
   569PGBDUIkJ/xKEd01adD5gt19ae/lFt9QT6QmE+iguZ1gt/AvQfBoE0t
   Q==;
X-CSE-ConnectionGUID: WlEhgYZZQNCd0f4mrrv2Lw==
X-CSE-MsgGUID: ZEUxrHXXQkq3/nKJ7yD/Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="41448282"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="41448282"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:37:18 -0700
X-CSE-ConnectionGUID: Yx364v7fQOiVDbEliVDe2g==
X-CSE-MsgGUID: 3zheBD5OSe6COrbaFU7NIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="64933040"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:37:14 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slUeP-00000004job-1DuJ;
	Tue, 03 Sep 2024 17:36:57 +0300
Date: Tue, 3 Sep 2024 17:36:57 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v5 0/7] pressure: bmp280: Minor cleanup and interrupt
 support
Message-ID: <ZtcfCVcV_1hCVp7N@smile.fi.intel.com>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902184222.24874-1-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 02, 2024 at 08:42:15PM +0200, Vasileios Amoiridis wrote:
> Depends on this: https://lore.kernel.org/linux-iio/20240823172017.9028-1-vassilisamir@gmail.com

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

for the patches 1,2, and 3.

-- 
With Best Regards,
Andy Shevchenko



