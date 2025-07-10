Return-Path: <linux-iio+bounces-21524-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 864E6AFFDFA
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 11:23:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7D41164F67
	for <lists+linux-iio@lfdr.de>; Thu, 10 Jul 2025 09:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFE99292B4A;
	Thu, 10 Jul 2025 09:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BmzIcBKJ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DD7928C5D5;
	Thu, 10 Jul 2025 09:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752139377; cv=none; b=JT9WZTnR/mjDpm9csPzoNdjIND00v2By6iNIlKeXz7Plo3JHs57b+1XZnnGNhcxTr1K35zYkJQ8WXmZJJBs9mVv54cdq0MivwLUPCY2KD2iag8kenc7j+fkKcsnUbGVQ7TWgAk49iBYEFP02ckdbQhWrjV698c76zFW1GyA0OQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752139377; c=relaxed/simple;
	bh=oMuEnzSiV/0zGJRZTSJdmYqP9+3hpJC5wE7fsmK9ILg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P/4qsTkJJJJIiJtNOSOyJmiPolmDdH7BcIBQUiE5qkCGNvBuzQaFXe/rqY6B0NOkjUdjmtlwFQvg31zh4AT99sK3MAdfd5LTWmOTtNmiUH8rQ9wfzDxYf5m8z4z1sDOoVANWZydHHpZ6LgyHqmxH0K96/SgpbxCJXw4kKM/egHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BmzIcBKJ; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752139376; x=1783675376;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oMuEnzSiV/0zGJRZTSJdmYqP9+3hpJC5wE7fsmK9ILg=;
  b=BmzIcBKJSPDWUEkbTuIvHCW2odvvx5Wu0HF8fPcfTwm0SUsuMIEtFU+t
   1YeMVnSkoU6+jV1IPe2roXLwDD/y3Z9nlrmiJD/RmimhR+igG5UijrxdN
   sQn9jJkSYlphb49pu7WsZewwuG8GxWsR0clSXwIFhHil2WymTxtlaRHtj
   i1etWdnFyDOEapCkpTf2T5MMormHL0zkgQc7+9kkb+z8/TXDIozaiZqoc
   p7XcLIWEPf41yoKpGi9DpndJJGWNphYQnZwOFQarZwPUxq003ve6Om3jv
   NVedamKmIg+y4yp4Em3JtbmVpBQkeEPO1DdzwTOfcmZpgdV80ZC5y/sOs
   A==;
X-CSE-ConnectionGUID: jGzCO2JTSTyJryShWwXfnQ==
X-CSE-MsgGUID: aiTRnKNHS3WWeRhNiwsZcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54130105"
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="54130105"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:22:56 -0700
X-CSE-ConnectionGUID: p0j4cVbgRGuYdUOREp4FBQ==
X-CSE-MsgGUID: hsWdMsaBR2aaOXEUBxOdGw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,300,1744095600"; 
   d="scan'208";a="186994717"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 02:22:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uZnUN-0000000E9eg-1XWN;
	Thu, 10 Jul 2025 12:22:47 +0300
Date: Thu, 10 Jul 2025 12:22:46 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Primoz Fiser <primoz.fiser@norik.com>
Cc: Haibo Chen <haibo.chen@nxp.com>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
	imx@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de, andrej.picej@norik.com
Subject: Re: [PATCH 2/2] iio: adc: imx93: Make calibration parameters
 configurable
Message-ID: <aG-GZqhABwErcEyM@smile.fi.intel.com>
References: <20250710073905.1105417-1-primoz.fiser@norik.com>
 <20250710073905.1105417-3-primoz.fiser@norik.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250710073905.1105417-3-primoz.fiser@norik.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 10, 2025 at 09:39:04AM +0200, Primoz Fiser wrote:
> 
> Make i.MX93 ADC calibration parameters:
>  - AVGEN: Enable calibration averaging function,
>  - NRSMPL: Select number of calibration samples,
>  - TSAMP: Select sample time of calibration conversions,
> 
> in the MCR register configurable with the corresponding device-tree
> properties:
>  - nxp,calib-avg-en,
>  - nxp,calib-nr-samples and
>  - nxp,calib-t-sample.

...

>  #include <linux/platform_device.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/property.h>

Keep it in order.

...

> +	ret = device_property_read_u32(adc->dev, "nxp,calib-avg-en", &val);
> +	if (!ret) {
> +		if (val != 0 && val != 1) {
> +			dev_err(adc->dev, "invalid nxp,calib-avg-en: %d\n", val);
> +			return -EINVAL;
> +		}
> +		reg = val;
> +		mcr &= ~IMX93_ADC_MCR_AVGEN_MASK;
> +		mcr |= FIELD_PREP(IMX93_ADC_MCR_AVGEN_MASK, reg);
> +	}

Please, since it's optional, do other way around.

	val = $DEFAUTL;
	device_property_read_u32(adc->dev, "nxp,calib-avg-en", &val);
	FIELD_MODIFY(...)

Similar approach may be used for the other properties.

...

> +	/* write calibration settings to MCR */
> +	writel(mcr, adc->regs + IMX93_ADC_MCR);

Please, factor out this to the function, so we won't see the direct IO in the
->probe().

-- 
With Best Regards,
Andy Shevchenko



