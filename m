Return-Path: <linux-iio+bounces-26938-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3153CAD3BD
	for <lists+linux-iio@lfdr.de>; Mon, 08 Dec 2025 14:21:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 764203030FE7
	for <lists+linux-iio@lfdr.de>; Mon,  8 Dec 2025 13:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770E1313535;
	Mon,  8 Dec 2025 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PpbZhLtZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9118D7262B;
	Mon,  8 Dec 2025 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765200033; cv=none; b=eaYa340fO5m0OR93jcv4EevuHoIzGXwPG28jj/CYOflUYbxDyvWII5sJMPY6MAb2f9MHKsACTtsYHnqGIrl6dJ6u8kFb7+EKgT5T28XvUE+FNKLiCEmUPb2yAc1J/xLnJzNHF8hXrc2aWYfUf6Z6aPbDrtpsolExEj4IfyiKUfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765200033; c=relaxed/simple;
	bh=kIGMA4eYf9FWBTX61PdX0uRsyDj2sgxjSlWvyFVcj7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dlKV9duvrOwczP/BpCeffqa5s2LBj5YW2WYdUYk9EA4VfbC9472t4+gxrBp+IC7sHZerCgGAPOPmo4vFMyKeghGtqbQU6d57mK2sB/q9HIaNviIsWri/M+4sburr541vFu9MiNt87IdqsG4JNbh+AVnCbL1YOFkU4LlHYsUueKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PpbZhLtZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1765200031; x=1796736031;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kIGMA4eYf9FWBTX61PdX0uRsyDj2sgxjSlWvyFVcj7E=;
  b=PpbZhLtZZMePTpfWc5iORIcF9NYja3PXmSEo/jYxPW/A+8gCuWiQdl31
   raZgYD3EyQ+n5oLUXYH125GtQxy5jAHmv49TAoXeW11rAh0wJwzO4/FlT
   kjZEx1W1GuVaUZ950dWVOuZg8vZVzUpn4hO5sO+GL2WMhdznkgyK3zfMN
   MZaslZgHKWdMEi66Ru3d/FntPdVa86BX6tszEqhA7Sv3ZULnGFx4rssJd
   rxXLIOw8Rr+QqhDAms7FLrpwtgJ9g0JaVElUtolRYmJwh1xuClZSfoxJa
   hYfQRsui6+OgDvFUjVORq2sO9RUliG0Hq5Qv/naaOsDXfUkZ1bjInnxkW
   w==;
X-CSE-ConnectionGUID: JYzlgryIRMqzgTF4kGYljg==
X-CSE-MsgGUID: DnxHbOGZRQCngxKcmcQCeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11635"; a="78496211"
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="78496211"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 05:20:30 -0800
X-CSE-ConnectionGUID: dtNfUKknT8SLweMwjUMe5A==
X-CSE-MsgGUID: evPB4lZATbi57clgyxVczw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,258,1758610800"; 
   d="scan'208";a="201057100"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.47])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2025 05:20:27 -0800
Date: Mon, 8 Dec 2025 15:20:24 +0200
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
Message-ID: <aTbQmOpMfQnYkeLT@smile.fi.intel.com>
References: <20251208-add-ad9211-v3-0-c49897fa91c4@vaisala.com>
 <20251208-add-ad9211-v3-3-c49897fa91c4@vaisala.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-add-ad9211-v3-3-c49897fa91c4@vaisala.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Dec 08, 2025 at 12:30:59PM +0000, Tomas Melin wrote:
> No need to include the entire kernel.h when the only thing needed
> is the ARRAY_SIZE macro.

ARRAY_SIZE().

...


> --- a/drivers/iio/adc/ad9467.c
> +++ b/drivers/iio/adc/ad9467.c
> @@ -12,7 +12,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/device.h>
> -#include <linux/kernel.h>
> +#include <linux/array_size.h>
>  #include <linux/slab.h>
>  #include <linux/spi/spi.h>
>  #include <linux/seq_file.h>

Please, keep them sorted.

...

While this change is almost (*) okay per se, I think we can address more
while at it.
- Make the header inclusions ordered (also fix the location of clk.h)
- drop other proxy (device.h) or unneeded headers (bitops.h as it's implied by bitmap.h)
- add missing ones (dev_printk.h, device/devres.h, ...)

(*) no, kernel.h provides more for this driver, for example, your patch
misses types.h.

-- 
With Best Regards,
Andy Shevchenko



