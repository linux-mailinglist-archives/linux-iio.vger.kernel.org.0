Return-Path: <linux-iio+bounces-11884-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 640E89BAE51
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 09:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D7B1C217CA
	for <lists+linux-iio@lfdr.de>; Mon,  4 Nov 2024 08:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E728F18BB93;
	Mon,  4 Nov 2024 08:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iVWKy7lB"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BE9A195811;
	Mon,  4 Nov 2024 08:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730709681; cv=none; b=bj8MtO/hMrrPTEUhQw151Wn2ObiNHLkmpGEyc0z82gImRz1mqrSdDbZgqxz7D9r1+xkucVTerKQJZmf5JFKrq1PQH9y7KfeQ+AuYtlh+O5aoQalOMn4k8tScW2ZjFxQ410Tv2s5zR1er4xqrid/zmR50n95ZxBlNdcAWaFfyCzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730709681; c=relaxed/simple;
	bh=zDYq57ceopXWdZlfFAbeiXO9ZVobTOfwl8WWXD/RefQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lI9zCckytAmnsSWjaDQXQG1/VILeM+wQ4n0sqA7v1je82nxCwpgT1NBnGrBGkUrmrCrkMx8qhY6X2M4fl9iQvTdmUEKBbge+GX8gr1CKrSw4t2wYGhZJag/bZZNvTZENaRidzi1WdHQGmEHqINoUku8FmUPlomkN8MlHgMLVao0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iVWKy7lB; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730709680; x=1762245680;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zDYq57ceopXWdZlfFAbeiXO9ZVobTOfwl8WWXD/RefQ=;
  b=iVWKy7lBEmq/WoTQ01Jqz18o1U1IE3W3P+ZGncFrRZkMmVSInmQuxKI0
   3uj0YOUKHQJe8CHKiKjIX341nxHSSvQmC5ZYYiB3kmSmcqJy+En4XSNSK
   Y6lDENgpo4EYspZfvz+qe7jXJqU1YsUYL0snWsfmflmE4BSi3NV7I7SAk
   g8//0OEODMm2r+tz7wzgrU/SO49HWCcHPzW/pFwa6edMzkugI3yXkT9CI
   ExjvCC7wZhkIznilNl6FdcCFmWYR/d2rnAi7dW9KdJz47HYYPe+efM3/r
   3UyrG9h7B7OSXjlpBfGVGqGJqMxZHHBoy1hMcZ4U10BPmZpC3FSyTq18v
   w==;
X-CSE-ConnectionGUID: E2amXk9fSR65392d27XEQw==
X-CSE-MsgGUID: OiCprmRJSjiGs29tUCKDYQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11245"; a="29823838"
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="29823838"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 00:41:19 -0800
X-CSE-ConnectionGUID: vWm3BvYMSWmedTSoklhIiQ==
X-CSE-MsgGUID: 8NfREzgwQpmiLMQYcIRotQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,256,1725346800"; 
   d="scan'208";a="83472466"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2024 00:41:15 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t7se7-0000000Az7U-1K9x;
	Mon, 04 Nov 2024 10:41:11 +0200
Date: Mon, 4 Nov 2024 10:41:11 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Aren Moynihan <aren@peacevolution.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>,
	=?iso-8859-1?B?QmFybmFi4XMgQ3rpbeFu?= <trabarni@gmail.com>,
	Ondrej Jirman <megi@xff.cz>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev, Dragan Simic <dsimic@manjaro.org>,
	phone-devel@vger.kernel.org
Subject: Re: [PATCH v4 5/6] iio: light: stk3310: log error if reading the
 chip id fails
Message-ID: <ZyiIp6t53FN9ssyV@smile.fi.intel.com>
References: <20241102195037.3013934-3-aren@peacevolution.org>
 <20241102195037.3013934-13-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241102195037.3013934-13-aren@peacevolution.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sat, Nov 02, 2024 at 03:50:43PM -0400, Aren Moynihan wrote:
> If the chip isn't powered, this call is likely to return an error.
> Without a log here the driver will silently fail to probe. Potential
> errors include ENXIO (when the chip isn't powered) and ETIMEDOUT (when
> the i2c bus isn't powered).
> 
> This function is only called from stk3310_probe, and this condition
> should return an error, which fits what dev_err_probe is designed for.

...

> +		return dev_err_probe(dev, ret, "failed to read chip id\n");

Please, make sure you have consistent style in the messages. Most of what
I have seen use period at the end. This one doesn't.

-- 
With Best Regards,
Andy Shevchenko



