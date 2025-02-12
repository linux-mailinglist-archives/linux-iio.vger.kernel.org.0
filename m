Return-Path: <linux-iio+bounces-15441-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D9CA32435
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 12:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7A1B3A7C74
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 11:02:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DA0B20A5E8;
	Wed, 12 Feb 2025 11:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gf+XzD4E"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2BF420A5CC;
	Wed, 12 Feb 2025 11:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739358172; cv=none; b=Aq4mFFxnuLI2B9mNC9d1ToSLd8Mv/I/2vWC8pppM78BYRkSlsmLs8eeK76EbETvbyYMjJvlN0elFVvSFb4SL7iBHi0jvgxNtm6v7EkrnYGeMIZ/hTGS/w+82HGB4WtQA7w/hw0JHwTOL1eb+Wi5QaBKpls09D0nz2DLCKDJs5LM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739358172; c=relaxed/simple;
	bh=z16+7ZEO5MVrgvOcxr9QCLuQ0Xfo1ReUAEntw8k1gTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ARK/GOwr6R8+5zGrLl2bnlepJpr03DKQAWYlfKhsLbVBPI6TQ2+0+L+znyKUNgs8r0w73ZjXbtHBYdCOxJJEGQ8yUtDwMr1IgCZDV4EqywvaAVKxJ2cF7YYVRP4MnE/gSfIOQytrVmATh3rzX7IRYdFJ9/wBKL01eDDzrteOUoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gf+XzD4E; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739358171; x=1770894171;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z16+7ZEO5MVrgvOcxr9QCLuQ0Xfo1ReUAEntw8k1gTQ=;
  b=Gf+XzD4E9lzz75TiAVTwmcFcmAQuaSlosz9fF8NBRgR+rszCb61aNv7s
   1Fz0qT1UuCHTJunjw74DAXyArPurjyCaD9LFopA3Z4s65IRsWyP1HnmMC
   UedQnHADkYwoMMiEVH32S0BEIhVbWtZxDmGJOLGXZdtoU18bLrd155xk1
   p0jI5k8PeBdV1RgjWKDW7s0HLBTk2/q5Lnf/6Om62ZuonqVCoBmgiwwNO
   v6G+yPxeqkz2mOohIRJwUQ1oftOk3U1+DtPpluxPunJ9y1txoG17TWWWl
   RVxXgMWrKgq4+KLzfpVpHqOcT/61/n/QGMduKsE4m6aHisO6rIeQ0rgJa
   A==;
X-CSE-ConnectionGUID: VP2yuPhaQW2BAvGVXSmgDw==
X-CSE-MsgGUID: 443iaO7rS7yvHGxg71I3yA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="51440574"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="51440574"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 03:02:50 -0800
X-CSE-ConnectionGUID: Iw9B5/mHTA+bafJ9LL2sLw==
X-CSE-MsgGUID: D6MTUzZTQOe7UHDcpwl/+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="112644578"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 03:02:43 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiAVt-0000000AoPx-3ob7;
	Wed, 12 Feb 2025 13:02:41 +0200
Date: Wed, 12 Feb 2025 13:02:41 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v1 0/2] mfd: lm3533: convert to use OF
Message-ID: <Z6x_0Q_FOF6Hz5I3@smile.fi.intel.com>
References: <20250212075845.11338-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212075845.11338-1-clamor95@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 12, 2025 at 09:58:40AM +0200, Svyatoslav Ryhel wrote:
> Add schema and add support for lm3533 mfd to use device
> tree bindings.

Thank you! I'm going to review the series this week, I definitely have
the comments. Stay tuned.

-- 
With Best Regards,
Andy Shevchenko



