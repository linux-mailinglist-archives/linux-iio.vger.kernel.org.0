Return-Path: <linux-iio+bounces-13288-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 892089E9DDF
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 19:14:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EA018880E8
	for <lists+linux-iio@lfdr.de>; Mon,  9 Dec 2024 18:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4DC155345;
	Mon,  9 Dec 2024 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hnekQZ8y"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C503B1F5F6
	for <linux-iio@vger.kernel.org>; Mon,  9 Dec 2024 18:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733768027; cv=none; b=Prz9Pju0swqLquyi9SrbristIe4whlBIwdjSmflbr7uVuR+h+giSKEq+A5uS15Lo+Thi+u5wOvoNhwMPgtokDduPqGl8rLXCt9PolpfOUuzOaKkgmGPO+CLM37QpYYloSKPBYoSlj5/FbFagu/h7gkj4ofqlisu8amJgSVF4ETI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733768027; c=relaxed/simple;
	bh=BPK8v77kGC14wETpK8Q2f3wVyOjyNI0YlFTkxsxb/no=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idTT7A0uRLWezg/p1OmUf1a9ikuiVLq9JNuV7HpXwzC9Aa3KsFrP9Q7ITfsfC9aUvn8JHg9uuVGIptCa3bdHyC85ucGwoIZfXu7Cv8rMvttXMAToFhVDWIWG51OZAxxrZJEOCPi+IpGcQa+7urJZgX+/GkPApgg2lTr343bn/9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hnekQZ8y; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733768025; x=1765304025;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BPK8v77kGC14wETpK8Q2f3wVyOjyNI0YlFTkxsxb/no=;
  b=hnekQZ8yZMGn2dQ8NbnFohoAX36BYKTVpYziWTQ4jNd8dhmxIioZesV8
   deP5TFqOL6v95LxX9muGJOcKauXedH1IWK3OrvwbQ7UEEOzV5+SDTRRVC
   BhHjl7XvLD6OOQjGUJ2XqJyM3x7R8Utr3uOWx6J2J86a7bVXWxJVyb1KI
   3QDv9QBxt6+Dc2/IBqd63dT71GA63IeN3NLcDMO9ASO+iAkAwjPOdMWge
   xMrT8FOiS+Nm8xsFHAGrauCXkYJG2tlPYdUFpH3syFc3pdj3AcjcXLh7S
   IUIhZBhBbrO4IOLJydcnFqYtNkrVK0H7IVXqLIaMbfYvAYgPPeqHRTy/P
   w==;
X-CSE-ConnectionGUID: mpHt1t8RQqysU4HzQaMFSA==
X-CSE-MsgGUID: QHtMN8AIQoKHcjIglDOcWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="34215020"
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="34215020"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 10:13:45 -0800
X-CSE-ConnectionGUID: Bx0sYL8kR62EmuYDHegU5A==
X-CSE-MsgGUID: 3ZYXk6gURaKeu6u1wJoWIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,220,1728975600"; 
   d="scan'208";a="100196770"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 10:13:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tKiGL-00000005pSn-2CQy;
	Mon, 09 Dec 2024 20:13:41 +0200
Date: Mon, 9 Dec 2024 20:13:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Fabio Estevam <festevam@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	Fabio Estevam <festevam@denx.de>
Subject: Re: [PATCH] iio: adc: ti-ads124s08: Switch to fsleep()
Message-ID: <Z1czVY4KiN4Pr6SW@smile.fi.intel.com>
References: <20241209180242.1258587-1-festevam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209180242.1258587-1-festevam@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Dec 09, 2024 at 03:02:42PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <festevam@denx.de>
> 
> According to Documentation/timers/delay_sleep_functions.rst,
> fsleep() is the preferred delay function to be used in non-atomic
> context, so switch to it accordingly.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Can you also change my email in other tags and email headers to be
@linux.intel.com?

-- 
With Best Regards,
Andy Shevchenko



