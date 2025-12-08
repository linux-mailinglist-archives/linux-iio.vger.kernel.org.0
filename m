Return-Path: <linux-iio+bounces-26942-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BF3D9CADABA
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 16:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 073963046FBE
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 15:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5F83191D4;
	Mon,  8 Dec 2025 15:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fEq7bde6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 667B831814F;
	Mon,  8 Dec 2025 15:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765209539; cv=none; b=RKAivnA8WRNQDk56idcTeZaG9YHymZem9dLLHc2bIQWiz13A1h6Sdw/Xt6bMiLEMSi1427bAcze4z6XNpISz96x+/ACbGf/b2633n3yZDO63KUidRs9tDALWLxPRTP9j+miSQ/Yl1EbOgyVYiShboRMbgpe9Iny+YlkVtw5t+tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765209539; c=relaxed/simple;
	bh=etwWzOMfLSmt9CJSWKBnmRKgPqgN051h5xAd2D7rrUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kwkLYAFxVvi5WuNLtgwaXzmeaAmctWJ/5boAAEXzfVkfW08EuVrThFvfHQRvygc5K7ocLbaYffmeOv7MhXp4c74luIFB+rI22TimjgEyHfaH9vM3lISX20R0r83YfV5TTQlNLCzwggmqa2ulkgHN5RW9Lm1F/AXtlj0XCCXVZ3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fEq7bde6; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765209539; x=1796745539;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=etwWzOMfLSmt9CJSWKBnmRKgPqgN051h5xAd2D7rrUg=;
  b=fEq7bde6+tQDGje76X/naGO/fgsdCrq1OwA6hAGSMEWS/a7T1kN5YIBA
   Dm1abbvg281o3uEXLVPs18/RofkmVKKI1EIAFnh7OPCqQi84QFGy+8MOC
   v/002j5FsfV110GQkzmOHeY0Uxg09DeSrfI51/AH+ynmv2knn/a8JHCb3
   I6MeSysPnbOhsZwkX00Bi63uWInwO/3fRqAbyFqbuUV9gVzvAaMgFAI2y
   /NhG3jl4stXzJbPwQ2L+OusjiChcM0or6vSNczkg6F0a1qHp7ftuG/hBt
   UkzDltsAYZ/ImxUo7GbDHikl5zxl6z8O30kxZzd/DMyFneIZxG9GIiyGk
   Q==;
X-CSE-ConnectionGUID: NWUnn+leQha0FRyT74v4mA==
X-CSE-MsgGUID: t2g5VjunQH25Cc8NNjXw8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11636"; a="92629121"
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="92629121"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 07:58:58 -0800
X-CSE-ConnectionGUID: XsTpd1M4SVODynbSGu/PUA==
X-CSE-MsgGUID: zeBJEmptSpO6edU05xfqvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,259,1758610800"; 
   d="scan'208";a="196423575"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 07:58:55 -0800
Date: Mon, 8 Dec 2025 17:58:52 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Tomas Melin <tomas.melin@vaisala.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Nuno Sa <nuno.sa@analog.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] iio: adc: ad9467: drop kernel.h in favor of
 array_size.h
Message-ID: <aTb1vEEJRY6Uom2l@smile.fi.intel.com>
References: <20251208-add-ad9211-v3-0-c49897fa91c4@vaisala.com>
 <20251208-add-ad9211-v3-3-c49897fa91c4@vaisala.com>
 <aTbQmOpMfQnYkeLT@smile.fi.intel.com>
 <1467f6e5-9d50-4b51-a283-aec19c031470@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1467f6e5-9d50-4b51-a283-aec19c031470@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 08, 2025 at 05:41:20PM +0200, Tomas Melin wrote:
> On 08/12/2025 15:20, Andy Shevchenko wrote:
> > On Mon, Dec 08, 2025 at 12:30:59PM +0000, Tomas Melin wrote:
> >> No need to include the entire kernel.h when the only thing needed
> >> is the ARRAY_SIZE macro.
> > 
> > ARRAY_SIZE().

Please, remove context you are agree with.

...

> >>  #include <linux/module.h>
> >>  #include <linux/mutex.h>
> >>  #include <linux/device.h>
> >> -#include <linux/kernel.h>
> >> +#include <linux/array_size.h>
> >>  #include <linux/slab.h>
> >>  #include <linux/spi/spi.h>
> >>  #include <linux/seq_file.h>
> > 
> > Please, keep them sorted.
> These were unfortunately not sorted to start with.

But your patch makes situation even worse. That's what I meant by the comment.
Since there is no a* header, it may be put to the proper location from day 1.

...

> > While this change is almost (*) okay per se, I think we can address more
> > while at it.
> > - Make the header inclusions ordered (also fix the location of clk.h)
> > - drop other proxy (device.h) or unneeded headers (bitops.h as it's implied by bitmap.h)
> > - add missing ones (dev_printk.h, device/devres.h, ...)
> 
> As this change (kernel.h) does not seem at all as straightforward as I
> envisoned based on your initial request, I will likely change this patch
> to instead just sort the headers. Reworking the includes is separate
> topic from the intent of this patch series.

If you don't feel going that deep, than it's a (small) problem.

As the author of a driver feature one should understand slightly more about
this (yeah, currently mess) header stuff. So, your first patch should add
missed headers, if any, that's required to your changes, this one can be
omitted after all.

But on some day you will still need to understand a bit more about headers...

TL;DR: make sure you have all needed headers for your changes in the previous
patch and drop this one.

> > (*) no, kernel.h provides more for this driver, for example, your patch
> > misses types.h.

-- 
With Best Regards,
Andy Shevchenko



