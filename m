Return-Path: <linux-iio+bounces-15994-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DAE9A41AE7
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 11:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 203FA189237E
	for <lists+linux-iio@lfdr.de>; Mon, 24 Feb 2025 10:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D644024E4B1;
	Mon, 24 Feb 2025 10:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G/ff/+qY"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310A719DF66;
	Mon, 24 Feb 2025 10:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740392892; cv=none; b=SdNq9x7eMpDXAoJTYCIyvel0ZjomLkkuJ3pY62EXG7bvBCK1KHALUtYxvNuhqmqYCsPHuIGa0czqWAsk+9aMlU755V/HUNasChSBxOcJs17MB+vUINltWwnpsWWEXxJZmzzbTW7sr1P16I0t36gkr1zBCzk8uSsW15M4p5LsOGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740392892; c=relaxed/simple;
	bh=S8wm+XV/Cr0JYPZotECeO1cpUzS9+EOP32CfMiFPv1U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oN8G9HvN0285oyo1+y5u34xHp6PdwBOZlR/FzaN/69Hi0JNb/1RZXwhwWKVovY5+pp68weaO/Mo9eKpTt2GluK6axP+qhxNsWk1+vscxbKu+JfHSx9WzM3tr4eBD1AkwAJGMUzmGWeVOHboMOfgpH+dpr4505JjsVNs9vx2e/fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G/ff/+qY; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740392891; x=1771928891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S8wm+XV/Cr0JYPZotECeO1cpUzS9+EOP32CfMiFPv1U=;
  b=G/ff/+qY1x59uXvDg4b5pw2N52hcdzPUgmCDJkR7dB5/kiSbGaZn6GG7
   BIi8mlhWZNMxa/f9XAZIXn2bl+rcEq/8da5UVywKCdXZy7Gsmz+DcWmxQ
   p9Ggh4dQbJW1CWXIJX4FunCoXcvpfSea0WLlY0a6ELP7UV9hTuIR+Q4Mn
   tEM9SeZkHSuyYLDVjRkgIQbA/8nEwBbrIDw6x5Ek45Vl0p/Iw1kxFuUdy
   47ikLPXxkNmV1WDusb5XAskjfjWT8M5C+aHIs6rkiruC6IEs2rKhb95KV
   YETL70lZBPpDN3kzWy+zRN/yhfi0tVTRzh29zi9BfWPq06exMwGzPWZ5D
   A==;
X-CSE-ConnectionGUID: qucUPv8FTTyv3+N7auR0RQ==
X-CSE-MsgGUID: 4JfcvDU7Q2azfsW78hRl7w==
X-IronPort-AV: E=McAfee;i="6700,10204,11354"; a="45049523"
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="45049523"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 02:28:10 -0800
X-CSE-ConnectionGUID: aZtrCXIgTxSMlzKpmyVcoA==
X-CSE-MsgGUID: c1cIP0m6QByS7ujE9gXNzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,309,1732608000"; 
   d="scan'208";a="115999633"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 02:28:08 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tmVgy-0000000EfID-2aiv;
	Mon, 24 Feb 2025 12:28:04 +0200
Date: Mon, 24 Feb 2025 12:28:04 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Linux pin control <linux-gpio@vger.kernel.org>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	Sebastian Reichel <sre@kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [GIT PULL] ib-devres-iio-input-pinctrl-v6.15
Message-ID: <Z7xJtKPX1qMUPsdI@smile.fi.intel.com>
References: <Z7xGpz3Q4Zj6YHx7@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7xGpz3Q4Zj6YHx7@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Feb 24, 2025 at 12:15:03PM +0200, Andy Shevchenko wrote:
> Hi Linux kernel maintainers,
> 
> Here is an immutable tag of the "Split devres APIs to device/devres.h and
> introduce devm_kmemdup_array()" series [1], please pull if needed.
> 
> Link: https://lore.kernel.org/r/20250212062513.2254767-1-raag.jadav@intel.com [1]

This is an updated version of PR [2] that has proper SoB of the committer as
reported by Stephen [3].

Link: https://lore.kernel.org/r/Z7cqCaME4LxTTBn6@black.fi.intel.com [2]
Link: https://lore.kernel.org/r/20250224083406.6174f821@canb.auug.org.au [3]

-- 
With Best Regards,
Andy Shevchenko



