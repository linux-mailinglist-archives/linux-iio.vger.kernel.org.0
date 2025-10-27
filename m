Return-Path: <linux-iio+bounces-25451-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5777C0C516
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 09:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDCEC19A0ECF
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 08:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAD382E88BD;
	Mon, 27 Oct 2025 08:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WnkLJyW0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEA8145B16;
	Mon, 27 Oct 2025 08:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761553986; cv=none; b=cW8xGV3g70fJhx2s2ghTuHXNB7/VGH5bTXIBUJBvPaiWhyVt2Rfz9aWDvad+JQmZcBQ5b6eVpm5dCEcMgJyI58vpxu469oamnEaQqqbv4zVvnmRAYTHu6AcGZfgXSlXUkzQ3B0tMSYY5o/FAWRIXdIFf03AUXAB2CQSbNRBfxvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761553986; c=relaxed/simple;
	bh=J94I/XxMyqD+R/xjvVJmAjIzOxJ0IKNNoqfA8Y499JA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HCy2wdSooOz+dLbLi7TtTHq5Eacq62skVrnbElIxINsZFtNr16p9Rzug4C1VFRTKZ2qy+29htVNkdqP7CpOqU2sAwclVYOtwudmL9AGRsIv2jtAm3u0f1+gZDc2cqW0c+zZDdAceU3Fu8LulIp8MQ5rq50h3thSbLseEr3i8ouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WnkLJyW0; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761553985; x=1793089985;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J94I/XxMyqD+R/xjvVJmAjIzOxJ0IKNNoqfA8Y499JA=;
  b=WnkLJyW0dftIdHp6FZsRJlhS1amgpyyv47KJVv8FAJJFkBhbnHGyRRO3
   1Hn72JUSfU/P+yVtaygSqYTre3Ox/JrtkQJJpn1Wi7kjUF9XdYbzukIfd
   9Ixdro821g8Y5+MUsXoSOchjIBg4iY0ASMsXVVFd+/9yfaT5m9q3uvWJA
   m2qsf+GJPUhu8Q5qq00C137ZmzfugZHlYZ6rl+jsmpOrAF4cM/ZfjK7iP
   FY/2N/D8f98BGqjXNsRy7Wwsc2FRSE5ODvsngPKqfGAVmqFzBzCNLvbOd
   02kSE/E87Huw9OeBzH6oL+Fr9Y4tu+IvNflWOyBy62LkS2KMQqGvA1zDw
   A==;
X-CSE-ConnectionGUID: QDi718GCRk61gRHeDaEK1g==
X-CSE-MsgGUID: PwDJDaAnRjWgYD6EWskf4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63721516"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="63721516"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 01:33:04 -0700
X-CSE-ConnectionGUID: cGgRWlOjSmu6Qx7EiSkS5w==
X-CSE-MsgGUID: br4NxVIGRvKJR2vC2gSF6Q==
X-ExtLoop1: 1
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.5])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 01:33:03 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDIey-00000002wtS-100D;
	Mon, 27 Oct 2025 10:33:00 +0200
Date: Mon, 27 Oct 2025 10:32:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org
Subject: Re: [PATCH] iio: imu: adis: fix all kernel-doc warnings in header
 file
Message-ID: <aP8uOznzM-ixyRLJ@smile.fi.intel.com>
References: <20251026024759.433956-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251026024759.433956-1-rdunlap@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sat, Oct 25, 2025 at 07:47:59PM -0700, Randy Dunlap wrote:
> Correct and add to adis.h to resolve all kernel-doc warnings:
> 
> - add a missing struct member description
> - change one non-kernel-doc comment to use /* instead of /**
> - correct function parameter @value to @val (7 locations)
> - add function return value comments (13 locations)
> 
> Warning: include/linux/iio/imu/adis.h:97 struct member 'has_fifo'
>  not described in 'adis_data'
> Warning: include/linux/iio/imu/adis.h:139 Incorrect use of kernel-doc
>  format: * The state_lock is meant to be used during operations that
>  require
> Warning: include/linux/iio/imu/adis.h:158 struct member '"__adis_"'
>  not described in 'adis'
> Warning: include/linux/iio/imu/adis.h:264 function parameter 'val'
>  not described in 'adis_write_reg'
> Warning: include/linux/iio/imu/adis.h:371 No description found for
>  return value of 'adis_update_bits_base'

Thanks for fixing all these, Randy!
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



