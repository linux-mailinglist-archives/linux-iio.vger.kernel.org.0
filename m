Return-Path: <linux-iio+bounces-25457-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AF647C0CBD3
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 10:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6828D4E77CC
	for <lists+linux-iio@lfdr.de>; Mon, 27 Oct 2025 09:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA63C2F12A9;
	Mon, 27 Oct 2025 09:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMB72e3M"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2451E2E543B;
	Mon, 27 Oct 2025 09:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761558371; cv=none; b=cEpnpSlM0cJfHdXuGWMiTCto9ntzc82q3W5pkFoFE6gDANtYEIWVC97g585DKMC0sglqVHy7tjTYS0mhIuDt/Po3pcJlR7uvjMbAsUjOxZtBgiNCfivY7kQhxHWC7zomuyVFFROzpO/5BT3nRLL0D9cq/Q82t9j6rzZU+bLB2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761558371; c=relaxed/simple;
	bh=QcJ6CT++aEn+rLIlStUe0QmiWdxWpE6IGw5mgOB5qKI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SYbalTwBD/EQsF64uWun0vr8+LNUwgr7MzCKrxNsWI1/f+2NW0SPDHqM4G+FXKrEG0XmJqmmR8UwbxZVSSyKqFZmuT2rVnP4IrKQlArk2RjQJBhRte7AeNDR/HPdf60Ln/W7/FU8cv0fVkliRK8QsNZfsM1p/c/dKp7KSrU8m7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMB72e3M; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761558370; x=1793094370;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QcJ6CT++aEn+rLIlStUe0QmiWdxWpE6IGw5mgOB5qKI=;
  b=DMB72e3Mt+TBpUKBmb5uu/IpOi1x6W3KQ4JuQ9+Ioh/rBWw+ZjnejAkm
   x9e37rdyccIf/LnyO4rE7M157ESvV/y2u+XCJr9LjDyOEWTbEkrzEFXfj
   ph0JK/42AjiuQ8IBYSrZNRTi7ILd5INktU32g2otCfrd8kXDkXoRy4h/Y
   sRjRcNmtF8sBmbKd2pnzkJjJ3dJ/vOgwSvbEhF4YOUMIXqN65sehkvYdW
   aNdsXFCfR8bM2RYql690IdvhftIHP5DrNum63XP090n77ejjD6vH1hT4d
   gUAr6B0O16IYMLYc4liD4WdNlGequG2kN3FwnIdzjGJko3E7nZJLPBoSJ
   Q==;
X-CSE-ConnectionGUID: 6klijF/xSDySOIDY6YWv1A==
X-CSE-MsgGUID: 997/PM8zSBGoLLFUfEzPwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="81265047"
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="81265047"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 02:46:09 -0700
X-CSE-ConnectionGUID: +K3PtrJQRkyxj3IFl35iWA==
X-CSE-MsgGUID: lMNCkFxYSpSLHRQ75r0koQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,258,1754982000"; 
   d="scan'208";a="185467119"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.244.5])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2025 02:46:07 -0700
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vDJng-00000002y5I-3V6M;
	Mon, 27 Oct 2025 11:46:04 +0200
Date: Mon, 27 Oct 2025 11:46:04 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: KRIISHSHARMA <kriish.sharma2006@gmail.com>
Cc: nuno.sa@analog.com, olivier.moysan@foss.st.com, jic23@kernel.org,
	dlechner@baylibre.com, andy@kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v2] iio: fix kernel-doc warnings in industrialio-backend.c
Message-ID: <aP8_XPQHbvsofGRa@smile.fi.intel.com>
References: <20251027092159.918445-1-kriish.sharma2006@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251027092159.918445-1-kriish.sharma2006@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Oct 27, 2025 at 09:21:59AM +0000, KRIISHSHARMA wrote:
> 
> Fix multiple kernel-doc warnings in drivers/iio/industrialio-backend.c,
> including a missing description for the @chan parameter in
> iio_backend_oversampling_ratio_set() and a missing return value
> description in iio_backend_get_priv().
> 
> This addresses the warnings reported by kernel-doc and the kernel test
> robot.

Reviewed-by: Andy Shevchenko <andy@kernel.org>

Subject should be rather

iio: backend: fix kernel-doc to avoid warnings

But no need to resend, until Jonathan requests this. I hope he can massage
the commit message whilst applying.

-- 
With Best Regards,
Andy Shevchenko



