Return-Path: <linux-iio+bounces-21185-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09718AEFB3E
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 15:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E7C17AC82
	for <lists+linux-iio@lfdr.de>; Tue,  1 Jul 2025 13:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C14277020;
	Tue,  1 Jul 2025 13:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5DuswYJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C72C426FA59;
	Tue,  1 Jul 2025 13:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378094; cv=none; b=KwBmO3kYF8thcxzorSMZnZzwjamS8Ijylalle8mBo3zp+My2hAnPfhXP14/51jR61Z/seGxepWct/YgAoqu/0P4Tt274/uL5tL1u+iWksGKcyyWVUJu/iEnpgyCNiBVGJ+02CL9UF/XqAAGd1d/S2DnGkVm2MoSw/W4+HhMw6AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378094; c=relaxed/simple;
	bh=5ItF9Taz+DNHnbbPxKWNU1QXo7XWqvCYdr5EbofRFrI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DPwLLE0krfkoQX+ni+anS3szge0BzFLSaGyRlGgdiW4Xy4c/uNQsP2oZT7ejuf6ODgm0M1shIrFVtX/y2jkZJd4AL52cAz3ka2JvnGeqIX1mkvIBq/5FEzXGBTxWODK0G9wzcjfj5xsSSCAh+AU0OpU1LVVhlfF7ufDKurz4XcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5DuswYJ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751378093; x=1782914093;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5ItF9Taz+DNHnbbPxKWNU1QXo7XWqvCYdr5EbofRFrI=;
  b=j5DuswYJa+zH4zc/Qxw0v/oQKzax+8xUXBc6dbs6uUs4wsPUeFByloPH
   ewiGFfqRy4BC+R3xSHbPszdHAxBWZ1sh7GFX5F9T01HH8dBX51QpQgh+w
   jlXu4J6FcgrLlru2MwPOffqcTYxdmoCtQK3VBL9dfjOW/zeyS99ZF7i37
   MgT0XjwUVTrNViHBmG7aJEHUNN7f6fAOkziwBGabMoiP0I63rl1//fpTJ
   byvtIkRdTobqn+yofwo40FuPX5wy86rX6rm5RYG+4NzUHqSF0BjOK6r20
   Ak+smkUlELWOQ1lFkBU5UNfZR4dC2BPwQrTgDV0jC1dxsqcMXtAFDs1fN
   Q==;
X-CSE-ConnectionGUID: geVwBeM+QISO0si42u5G2A==
X-CSE-MsgGUID: udxyTurtSb2t2pfDZkcJWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="71071282"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="71071282"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 06:54:53 -0700
X-CSE-ConnectionGUID: nHUDxnizR5O4rjnodM4zyw==
X-CSE-MsgGUID: C4eZp7IRSaqqFdR/McRv/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="177448223"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 06:54:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uWbRf-0000000Bc2B-1UFW;
	Tue, 01 Jul 2025 16:54:47 +0300
Date: Tue, 1 Jul 2025 16:54:47 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Cc: jean-baptiste.maneyrol@tdk.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: Replace scnprintf with sysfs_emit
Message-ID: <aGPopyM1KbbDS4IH@smile.fi.intel.com>
References: <20250701113945.6865-1-chelsyratnawat2001@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701113945.6865-1-chelsyratnawat2001@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 01, 2025 at 04:39:45AM -0700, Chelsy Ratnawat wrote:
> Documentation/filesystems/sysfs.rst mentions that show() should only
> use sysfs_emit() or sysfs_emit_at() when formating the value to be
> returned to user space. So replace scnprintf() with sysfs_emit().

...

>  	case ATTR_ACCL_MATRIX:
>  		m = st->plat_data.orientation;
>  
> -		return scnprintf(buf, PAGE_SIZE,
> +		return sysfs_emit(buf,
>  			"%d, %d, %d; %d, %d, %d; %d, %d, %d\n",

Now this fits one line

		return sysfs_emit(buf, "%d, %d, %d; %d, %d, %d; %d, %d, %d\n",

>  			m[0], m[1], m[2], m[3], m[4], m[5], m[6], m[7], m[8]);

-- 
With Best Regards,
Andy Shevchenko



