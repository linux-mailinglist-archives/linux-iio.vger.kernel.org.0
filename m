Return-Path: <linux-iio+bounces-27585-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D964ED0C03A
	for <lists+linux-iio@lfdr.de>; Fri, 09 Jan 2026 20:09:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 29F0F30078B7
	for <lists+linux-iio@lfdr.de>; Fri,  9 Jan 2026 19:09:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570B22E6CC2;
	Fri,  9 Jan 2026 19:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXWja+tb"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC3729BD88;
	Fri,  9 Jan 2026 19:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767985754; cv=none; b=km8LfI+a2wPMJjIwp2mKxWhHmE3LLUS1WQJpkZ0eZfCQAR2cG2+Jx2OlkD+yHEU0RZTFc09pZmzSnQIO8HoetmJXRaQcTy//nMuE6DRmACEr/tlq2j1qJmn1njooo41oQqKtbcIxhZi5x3fzp2NT2q/GMUEfuvNcUQ84J5WpaTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767985754; c=relaxed/simple;
	bh=MbbtNyYC8/9lBM1YRHOjZp8Eu+mbv5hhAZ9liMf8x2s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WpWcXWsPe6pRBnfNl7t4pa6Bj03dXtZwSQvS42d59S2Ib52njXsk39YIpX897QwWm/uPewfNu7mESWWw1aJoGSL4uQ3qYDjf7wP9Um2CQAemnAO7SUHBqNLI+/jIUzspR2XHeWF1lwaXmwEbIVqU/JBcSa0w+YSOViltHddBgbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXWja+tb; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767985753; x=1799521753;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MbbtNyYC8/9lBM1YRHOjZp8Eu+mbv5hhAZ9liMf8x2s=;
  b=PXWja+tboepbUgFMv5XaDSrjbW/JudTMZox45XUGNBllpeZRtJZjWYLu
   LaOIC09AzIioZ/li28ALlIcab1L3GveZKz3b+1IZ7oCDuaHyhi/CA4Qce
   k8vqqXzEIzEhPgha85lV0GuKtuB6ZJMCqIv2UlKwmREeOMVTmzusAotwH
   +upH8afNPt/k+WgyZ4+ZvORZBUXWQamVXvCMl0tWJDs1g/OvvV16GPKPH
   hXc0JFgSd2zVyACNOBREX5C/Bj6U4mMJFnBU75lssXYVYpISLkncyoRCr
   jyqB8dg+hVzCozvoSHihlitbjiphaFovAUoVW3GAUvZxvbwdFTpC5JKvd
   w==;
X-CSE-ConnectionGUID: ytpAPBY5RQ2ZfRCH+YiqLg==
X-CSE-MsgGUID: 9ZdADLrpTXGqhEPtcC7K2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11666"; a="80007785"
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="80007785"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 11:09:12 -0800
X-CSE-ConnectionGUID: yLTUQQBiSAGPVW/4WXUfAw==
X-CSE-MsgGUID: tHcMPdGCTbup6zv4txq7Kw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,214,1763452800"; 
   d="scan'208";a="203455342"
Received: from abityuts-desk.ger.corp.intel.com (HELO localhost) ([10.245.244.157])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2026 11:09:10 -0800
Date: Fri, 9 Jan 2026 21:09:08 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Francesco Lavra <flavra@baylibre.com>
Cc: Lorenzo Bianconi <lorenzo@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: imu: st_lsm6dsx: set FIFO ODR for accelerometer
 and magnetometer only
Message-ID: <aWFSVKBCYzjuZzic@smile.fi.intel.com>
References: <20260109181528.154127-1-flavra@baylibre.com>
 <20260109181528.154127-3-flavra@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260109181528.154127-3-flavra@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jan 09, 2026 at 07:15:27PM +0100, Francesco Lavra wrote:
> The st_lsm6dsx_set_fifo_odr() function, which is called when enabling and
> disabling the hardware FIFO, checks the contents of the hw->settings->batch
> array at index sensor->id, and then sets the current ODR value in sensor
> registers that depend on whether the register address is set in the above
> array element. This logic is valid for internal sensors only, i.e. the
> accelerometer and magnetometer; however, since commit c91c1c844ebd ("iio:
> imu: st_lsm6dsx: add i2c embedded controller support"), this function is
> called also when configuring the hardware FIFO for external sensors (i.e.
> sensors accessed through the sensor hub functionality), which can result in
> unrelated device registers being written.
> 
> Add a check to the beginning of st_lsm6dsx_set_fifo_odr() so that it does
> not touch any registers unless it is called for internal sensors.

...

>  	const struct st_lsm6dsx_reg *batch_reg;
>  	u8 data;
>  
> +	/* Only accel and gyro have batch registers. */
> +	if (sensor->id >= ARRAY_SIZE(hw->settings->batch))
> +		return 0;

+ Blank line.

>  	batch_reg = &hw->settings->batch[sensor->id];

-- 
With Best Regards,
Andy Shevchenko



