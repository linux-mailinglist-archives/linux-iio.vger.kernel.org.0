Return-Path: <linux-iio+bounces-19962-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB697AC49FD
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 10:18:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A678517338D
	for <lists+linux-iio@lfdr.de>; Tue, 27 May 2025 08:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08BC248893;
	Tue, 27 May 2025 08:18:07 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DBC61F461A;
	Tue, 27 May 2025 08:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748333887; cv=none; b=h9CRm8etf2fwvSgO8OFjxoDFsnMH8ErO+mycZgGNIVWN9v+tS7ZeuQJ9tOeUEo4LsBDaJRr0c5WjiozsK5utQ18kdHp22QEW9/OA531/L89NYvRHsytGUCBO4PMn9ku3KedAMMfwgPzLDstcg/J7T4iN/1TnVP5Hs6mnmhbnbZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748333887; c=relaxed/simple;
	bh=bR1NuJphAxo4BEJpVZ4xCM+6Jt7sJuBR86KzC2aYtBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uK4tvbaHsSSEclgrCvDcwPQfA2XKKXbKMO4UT17d0EXt/5W80TwqEm3n25ktiqBC7hbQoeoxuU4Xtxod/mi+9u0wivwGdNIvwbJav3pGUl4FdLkLhl+rHUXk/9zZTblcxnvA7JWGCtzaTwWv3Law5cW90EFLtJoBDCludxYJsL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: VJo24VmvR6e64SbxaNe4mw==
X-CSE-MsgGUID: zhYtAfAtT323/g+JfeW+Iw==
X-IronPort-AV: E=McAfee;i="6700,10204,11445"; a="52933868"
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="52933868"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 01:18:05 -0700
X-CSE-ConnectionGUID: geUUSBLSSiK3T9WXN98Feg==
X-CSE-MsgGUID: D//pKkMBTkWNOvMc7764yw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,317,1739865600"; 
   d="scan'208";a="146591285"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2025 01:18:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uJpVY-000000017B4-2NXj;
	Tue, 27 May 2025 11:18:00 +0300
Date: Tue, 27 May 2025 11:18:00 +0300
From: Andy Shevchenko <andy@kernel.org>
To: maudspierings@gocontroll.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Christian Heusel <christian@heusel.eu>,
	Linus Walleij <linus.walleij@linaro.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v4] iio: common: st_sensors: Fix use of uninitialize
 device structs
Message-ID: <aDV1OF6EKqLMl2D8@smile.fi.intel.com>
References: <20250527-st_iio_fix-v4-1-12d89801c761@gocontroll.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250527-st_iio_fix-v4-1-12d89801c761@gocontroll.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 27, 2025 at 08:36:08AM +0200, Maud Spierings via B4 Relay wrote:
> From: Maud Spierings <maudspierings@gocontroll.com>
> 
> Throughout the various probe functions &indio_dev->dev is used before it
> is initialized. This caused a kernel panic in st_sensors_power_enable()
> when the call to devm_regulator_bulk_get_enable() fails and then calls
> dev_err_probe() with the uninitialized device.
> 
> This seems to only cause a panic with dev_err_probe(), dev_err(),
> dev_warn() and dev_info() don't seem to cause a panic, but are fixed
> as well.
> 
> The issue is reported and traced here: [1]

FWIW,
Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko



