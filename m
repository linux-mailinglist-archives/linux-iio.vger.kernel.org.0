Return-Path: <linux-iio+bounces-23095-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F5FB2F402
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 11:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8AC516260D
	for <lists+linux-iio@lfdr.de>; Thu, 21 Aug 2025 09:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E8A2D6E75;
	Thu, 21 Aug 2025 09:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WFB/MmNz"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63992DA77B;
	Thu, 21 Aug 2025 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755768616; cv=none; b=V0L+/zxCo4Hs/SYrvVHcgYrhlscJOezfMem+LxRAL+V+nbeBWxj64L1LXaB9W0lm+8NZ7x2EZJHj7TXX7VcXtETx70U286B+yu4T8fYrwQOqwyfohTFY6XhkNnhzLP/v26JF+biB3kUCzysLZUZtrcD6bOF+OBsuAwSJcQKJv/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755768616; c=relaxed/simple;
	bh=SkrOLnyn4FIIlpTYZ60Uhme84j7dI/55XtJFlPHBzzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W5szagTosqXMYBV6NO6KMfyI91ZjNNnZ95pBtJNEsFATAbDiv5SoNTDo5owzEixnjBnD1iSN6UHRU9qaH/UPiCZB8M1wDc9ZdtC03VkGPGBQXhwfvD2In4MRlFUsnAJB9hkIotrTsLwdvdhfKAM81849FpGreC2HlIF59Bhb6sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WFB/MmNz; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755768615; x=1787304615;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SkrOLnyn4FIIlpTYZ60Uhme84j7dI/55XtJFlPHBzzE=;
  b=WFB/MmNztaWhoNvDAlAJTMp/PjRF05Ou3py7P0jC8UZMFg9PprzfQUzU
   tUGnDy9mJzI3/GwTmQm8DrpjyM8//DU0PX+w7LnbqroBa8SBeRvyYnEdy
   Xcm/BBAjBjuIiEC5C6Zz5tCTFW0dSz84YCqviaqkJEIxexoH8U5wn+fmo
   06dAWi5qbjK0q1jtLrfau/mB7yI4Gqw/PReLQJb5Hc90sseW78FtbWjcE
   grznKamXF8qgAbR9LuYk8irOq8zHPDFWGbHVRljXLwfq6JoK7rSIzufyY
   2YEPPCaM5Xq0PE98FMo1620VMJW/9fiqzvMu/JZkTUP3mG7hASK0Ml5zf
   Q==;
X-CSE-ConnectionGUID: KP0Pjem/S3ezYn8pogJxCg==
X-CSE-MsgGUID: Gdz5GlFwQv6HG42oiJ2CMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="58148119"
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="58148119"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 02:30:14 -0700
X-CSE-ConnectionGUID: upGgceekQ3WpWalVmVKSUg==
X-CSE-MsgGUID: mBYt9FI5TcyfXBZYFwvMbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,306,1747724400"; 
   d="scan'208";a="173631401"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2025 02:30:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1up1cY-00000007BXq-0OAb;
	Thu, 21 Aug 2025 12:30:10 +0300
Date: Thu, 21 Aug 2025 12:30:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Ben Collins <bcollins@watter.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] iio: mcp9600: White space and fixed width cleanup
Message-ID: <aKbnIVQOxBs1o27C@smile.fi.intel.com>
References: <20250818035053.32626-1-bcollins@watter.com>
 <20250818035053.32626-3-bcollins@watter.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250818035053.32626-3-bcollins@watter.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Aug 17, 2025 at 11:50:50PM -0400, Ben Collins wrote:
> Make tabs consistent for register definitions and also fix width
> to byte size.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko



