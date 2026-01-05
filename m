Return-Path: <linux-iio+bounces-27489-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DD1CF4CC1
	for <lists+linux-iio@lfdr.de>; Mon, 05 Jan 2026 17:47:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EF4033154E74
	for <lists+linux-iio@lfdr.de>; Mon,  5 Jan 2026 16:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22D8533D6D4;
	Mon,  5 Jan 2026 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HJbBp9ae"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B5833D6E1;
	Mon,  5 Jan 2026 16:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630917; cv=none; b=J+w038whxjfsycuPoUn2DqbkOsPDnUoCGECip3IthaIB6WdWItZIPopT8aLXyLY4+kEkRxKuu0CzIFgoe033KT/MtvMIB7G+mtXfhcGzN81t0z9KXF/WuvMV1zLmMGqfWdwg7xR28o2q6Nm2RJCVkDauxLOpiMuektwWUhAUPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630917; c=relaxed/simple;
	bh=J5CMmSIuiwVKEVHz96cCDyLd00VBHBdtzl1QgV2gkTg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TfBBYIYahyqthvgoHgPE6xaUXBLO7oVgrR1YHKvGbvbtT49qBqVYLYl0GZFqIPfiKKeahOso/5VaahG+ua8DFMJZ3mELb/n+gYIgPa+G8GXCLN6QMgNMiaylxn55WNfFYYHP0p8DXOcHx4KW9lF30CfHTqn1dX2I2HgC6IPcUz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HJbBp9ae; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767630917; x=1799166917;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=J5CMmSIuiwVKEVHz96cCDyLd00VBHBdtzl1QgV2gkTg=;
  b=HJbBp9aeM8zPhsVxmCbhSuv3/BBsJdcpQXnd5uVWYaX45M60j2JKKTlV
   nAUKmjYJAgqN/Ff0wvtDBv9HWX/EDCI8sb/KmNuLJnPXyIDBHMa4LqxTU
   XTSnP9P97QrIi7Js85+42mN8GkbgDy/2Le7om5KFda7tJMkieb3pqy5ef
   zAdp0KPw0lYhzcSsuWZNkitpowibSfNC+gHZzx42Pj00gAaaAbgg4jt1I
   E/kEIdaMcMBeBm65Cjl2o1gfolOvUYu6wHrbVoad3EAzuwWi0Fruz6DA0
   DIRy59Sv1MM+/z+F76jhUpaWIewpy0cLpNJEDMWtV7E9A44dsJIvMTnBp
   g==;
X-CSE-ConnectionGUID: NFHU1A3XTYOTjZyPH40cuw==
X-CSE-MsgGUID: oAlheWObTe2lIqh388QGvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11662"; a="86416222"
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="86416222"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 08:35:16 -0800
X-CSE-ConnectionGUID: KsejX/9ESh6NmUTrhWnzrw==
X-CSE-MsgGUID: ilkKLrAoTyu+GnrcE4D2BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,203,1763452800"; 
   d="scan'208";a="203392776"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.215])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2026 08:35:12 -0800
Date: Mon, 5 Jan 2026 18:35:10 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Michael Harris <michaelharriscode@gmail.com>
Cc: gregkh@linuxfoundation.org, lars@metafoo.de,
	Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	linux-iio@vger.kernel.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: iio: adt7316: modernize power management
Message-ID: <aVvoPtlsAQxeGimu@smile.fi.intel.com>
References: <20260105060803.2315274-1-michaelharriscode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105060803.2315274-1-michaelharriscode@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jan 04, 2026 at 10:08:03PM -0800, Michael Harris wrote:
> Replaced use of deprecated function SIMPLE_DEV_PM_OPS with

SIMPLE_DEV_PM_OPS()

> EXPORT_GPL_SIMPLE_DEV_PM_OPS.

EXPORT_GPL_SIMPLE_DEV_PM_OPS().

> Removed PM preprocessor conditions with usage of pm_sleep_ptr function.

First of all, pm_sleep_ptr() is a macro. Second, refer to it just like other
functions, i.e. pm_sleep_ptr().

...

Code wise it LGTM, thanks.

-- 
With Best Regards,
Andy Shevchenko



