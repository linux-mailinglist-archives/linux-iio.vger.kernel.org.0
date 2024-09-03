Return-Path: <linux-iio+bounces-9078-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A25EB96A0DB
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 16:40:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5EFE1C23E75
	for <lists+linux-iio@lfdr.de>; Tue,  3 Sep 2024 14:40:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A093D13F43E;
	Tue,  3 Sep 2024 14:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TEEf2WAy"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CABC213D625;
	Tue,  3 Sep 2024 14:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725374396; cv=none; b=D5tmro/oBZ5aWEnQsvs2n/SIr7fwbLFad+rcST5cl6Rg/XGv6EgwlItCawLbEyQUqLEIrgy7PMLjHST1AmZ2q4od/tQUblEPmsXo3FqZH2K8Wz0DFEdGqMGS7/M5M7DZnoCmybEjlcqGCs33gJrL4onzsr9hNkMPT+wzB8R2FHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725374396; c=relaxed/simple;
	bh=18ErWonMY+5270jdrv3f8u/lrBXpunSgd5cvf5gJZK4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gnyfQWVqoppqTcTw4DrSb5jBRRKEKRYrsy0YJJ7/zMfh8QJi6uQSRLlL2mwvX/kzZ0xFKldMT2M8RoQs4ZRAFsAloZllaPHR2V18O21s8kXdNNGB/+h74h9qbAAPCJVJFJA6QPL6+MeWbCL6hYbPpmbeL5vG7CogyLSXbWibWyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TEEf2WAy; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725374395; x=1756910395;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=18ErWonMY+5270jdrv3f8u/lrBXpunSgd5cvf5gJZK4=;
  b=TEEf2WAyNHjDsX8U0lHXMa5pmJcM6jA8gOabu9GU4mzuQgyY9E+b08lT
   VojB9MIjfT/U1E9Wm82xcMwmvEhWG7Ls6sZGJ1vre8UPX/Eo4xaryt10W
   dn98PDfcqWlvzqy4WPN7ILo49OOZjaT4EcB9WBN5EOG1umGygLjmlNI3C
   Nq6ZdVmBAQ/pehlT6qHKSB3AP8KJvBvdQwkIjcEebElNt55InAsyzVV77
   7ifiBVjmqYwZE+7NUB8kGIHDEfkTTPVD+TwxhCtCNJJ1i1kgkmtNXNaN4
   KK3Gz14IU04h6YERck94cDroD9O40S/J1IJ3FnPwFbbN8QLhH3UfJFmjJ
   A==;
X-CSE-ConnectionGUID: M+OueBqDQkyqIrl3Cx9SVQ==
X-CSE-MsgGUID: YCLV4GU1QlKEWdwyUgL/jA==
X-IronPort-AV: E=McAfee;i="6700,10204,11184"; a="23853192"
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="23853192"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:39:54 -0700
X-CSE-ConnectionGUID: f0UEFQVdQFK+4XR9uSxwMw==
X-CSE-MsgGUID: aCeKh2sGTJmeO1X2xjz0ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,199,1719903600"; 
   d="scan'208";a="69731145"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2024 07:39:50 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1slUh9-00000004jrC-14wb;
	Tue, 03 Sep 2024 17:39:47 +0300
Date: Tue, 3 Sep 2024 17:39:47 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Vasileios Amoiridis <vassilisamir@gmail.com>
Cc: jic23@kernel.org, lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, ang.iglesiasg@gmail.com,
	linus.walleij@linaro.org, biju.das.jz@bp.renesas.com,
	javier.carrasco.cruz@gmail.com, semen.protsenko@linaro.org,
	579lpy@gmail.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	christophe.jaillet@wanadoo.fr
Subject: Re: [PATCH v5 7/7] iio: pressure: bmp280: Move bmp085 interrupt to
 new configuration
Message-ID: <Ztcfs3Pvy9tzIFNm@smile.fi.intel.com>
References: <20240902184222.24874-1-vassilisamir@gmail.com>
 <20240902184222.24874-8-vassilisamir@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902184222.24874-8-vassilisamir@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Sep 02, 2024 at 08:42:22PM +0200, Vasileios Amoiridis wrote:
> This commit intends to add the old BMP085 sensor to the new IRQ interface
> of the driver for consistence. No functional changes intended.
> 
> The BMP085 sensor is equivalent with the BMP180 with the only difference of
> BMP085 having an extra interrupt pin to inform about an End of Conversion.

This one also LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

...

> -	int ret;
> +	int ret, irq;

I'm not fan of such a churn, meaning a new variable just on the new line to
make diff less noisy, but it's not a big deal at all.

-- 
With Best Regards,
Andy Shevchenko



