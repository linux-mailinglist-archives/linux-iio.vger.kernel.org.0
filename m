Return-Path: <linux-iio+bounces-28043-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8897ED3C14B
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 09:02:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F3052387D13
	for <lists+linux-iio@lfdr.de>; Tue, 20 Jan 2026 07:58:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D89563AE706;
	Tue, 20 Jan 2026 07:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VTAFo3tk"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0DA3AEF22
	for <linux-iio@vger.kernel.org>; Tue, 20 Jan 2026 07:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768895826; cv=none; b=WvgfzQ9qF2bxvRGe5Zk2o94g3VPdkU7k5Iwx/P28cEhVCUcgvr0IzJD/erY2rSAJTEi+lfXuarrxKZJef9uUxu4u2aK4ubIi4Y+pf0RttIoDyc80VpRsyGLfaotEBZcyhRXeQLOaXlj4nl0UKV8KtzvcLtdAE8+o9hm1Wdr+JKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768895826; c=relaxed/simple;
	bh=O4/K+wwfeELiRKhAeY449RKzArG8vJku2FPHldMd/7A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAhNDlDwMF4adEJVQqLkEOy+MLbBlMnFwWwExqNwivWZHNXMfEpY0uPgFptMG66Qx8QMd7Tj3n3ftu8qLbNwSuxhtge/5TBAcQKSw/IqMx6zSZGU9YaOyuwa8GdVD74CxxA5joGEv4ERwwOkhADEgWaRUHuRcOHAq18bzFsVmjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VTAFo3tk; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768895825; x=1800431825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O4/K+wwfeELiRKhAeY449RKzArG8vJku2FPHldMd/7A=;
  b=VTAFo3tknp3NgBIC6j3PRer8DDB1zYSBRjnOTvRReLP8Vbp6pPcpTSdn
   CIclXHSbN/KSLXk5qaCz2ThqkvqN+BgdR5CLf5I4HK5+e28r6tMzfchPW
   +zejqJ/i2Y4s+QWyw8KJVQQe/EqaF0v7RBprE+jd3orkxDY4DJTw6Vz+V
   dLACTCuiChummBQsoKqqaesc+XeGzzuOJogfkxhuy/RVYuWZ8WJaRC8Ix
   kfzbTNWeVFdJ3RETEksUC03MnKlpM6563L3WVV5ngpuHMZMpOL+vHwLts
   OqmeNlruEHaUqWZPbbNrU1z+pz2xj8YBH/wztAJRe3mdjG4O6nfDuTEEq
   w==;
X-CSE-ConnectionGUID: pwSQX44iQLObSz7uM4apXQ==
X-CSE-MsgGUID: J7/AzpqhSrug+CgkCtIqMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="73963598"
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="73963598"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:57:04 -0800
X-CSE-ConnectionGUID: +byG7AbCRRWx/zcxYtlZXg==
X-CSE-MsgGUID: slwZ8Sw2Qy2vVlMUqHMXuw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,240,1763452800"; 
   d="scan'208";a="205681298"
Received: from dalessan-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.179])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 23:57:02 -0800
Date: Tue, 20 Jan 2026 09:56:59 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org, Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Mike Looijmans <mike.looijmans@topic.nl>,
	Liam Beguin <liambeguin@gmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
	Cosmin Tanislav <cosmin.tanislav@analog.com>,
	Alisa-Dariana Roman <alisadariana@gmail.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 04/11] iio: adc: max1027: Improve include relevance
Message-ID: <aW81S3XcVBnuYI71@smile.fi.intel.com>
References: <20260119212110.726941-1-jic23@kernel.org>
 <20260119212110.726941-5-jic23@kernel.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119212110.726941-5-jic23@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 09:21:03PM +0000, Jonathan Cameron wrote:

> Drop kernel.h in favor of more specific headers and add includes that were
> previously relying on other headers including them.
> 
> Whether to include device.h or the relevant sub headers is non obvious.
> In this case, there is an access to struct device for
> spi->dev.driver->name which is used to name the irq.
> 
> The justification from iwyu for the additional includes is:
>   #include <asm/byteorder.h>           // for be16_to_cpu
>   #include <linux/array_size.h>        // for ARRAY_SIZE
>   #include <linux/bitops.h>            // for BIT, GENMASK, fls, hweight32
>   #include <linux/cleanup.h>           // for guard
>   #include <linux/compiler.h>          // for __aligned
>   #include <linux/completion.h>        // for complete, init_completion

>   #include <linux/device.h>            // for dev_err, dev_name, devm_kmal. ..

Not good, we also should treat device.h as "include everything" and try to
avoid that, above comment hints like

dev_printk.h
device/devres.h

>   #include <linux/errno.h>             // for ENOMEM, EINVAL, EBUSY, ETIME...
>   #include <linux/interrupt.h>         // for devm_request_irq, irqreturn
>   #include <linux/jiffies.h>           // for msecs_to_jiffies
>   #include <linux/minmax.h>            // for __cmp_op_max
>   #include <linux/mutex.h>             // for class_mutex_constructor, cla...
>   #include <linux/stddef.h>            // for NULL, false
>   #include <linux/types.h>             // for u8, bool, __be16

> stddef.h not directly included as few drivers do this.

Yes, we assume that types guarantees stddef.h to be provided.

> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> ---

Cc here...

>  drivers/iio/adc/max1027.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

...

> +#include <linux/array_size.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>

> +#include <linux/compiler.h>

Same as stddef. types.h will bring this.

> +#include <linux/completion.h>
>  #include <linux/delay.h>
> -#include <linux/kernel.h>

> +#include <linux/device.h>

See above.

> +#include <linux/errno.h>
> +#include <linux/interrupt.h>
> +#include <linux/jiffies.h>
> +#include <linux/minmax.h>
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
> +#include <linux/mutex.h>
> +#include <linux/printk.h>
>  #include <linux/spi/spi.h>
> +#include <linux/types.h>

-- 
With Best Regards,
Andy Shevchenko



