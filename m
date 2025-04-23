Return-Path: <linux-iio+bounces-18568-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBEAA995A1
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 18:43:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB150464A1D
	for <lists+linux-iio@lfdr.de>; Wed, 23 Apr 2025 16:43:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0691A283C82;
	Wed, 23 Apr 2025 16:43:49 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA5D2820AC;
	Wed, 23 Apr 2025 16:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426628; cv=none; b=KD0izm7ElFq+P4hjQhmu61bzhlkwKNuxpr0efENCFgl1hKfDJSQr5MxKd4TpLUv3xy66W7wVqThCMSGZ63sFxfCqxGDdcP5nRAJJAftlGEG4GCaEyrj/bBDsohCrO5J24UhGajyNDmR4IVr/WJEm0jMUtDfGxQvr1hqJr0fAYsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426628; c=relaxed/simple;
	bh=2zTwYcMG8ogoTuHfXKsMTzT7WR40ubEfn19/fvEvN6U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MvRwR0TI2g/uzVqpQdC8jzIXLxM07hVBSxj+zRm2fgz2iTROviX4XiNzWYmaEn2opjpB+eYtAcD6MAWsMx0j3KQ0oeETdHMhg6bf8sH7Eo40GRnX5ms3vrdUO8O4AjRZLPowWdL0quUgLDELYSXUUZWp+CsLhXxeC1AhYFKMzw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: R9QLMutORNKbTNz6IvWsAA==
X-CSE-MsgGUID: 1oDmtaNlSC2pcYgHLxfXUQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11412"; a="47160718"
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="47160718"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:43:46 -0700
X-CSE-ConnectionGUID: s5cnf4AERSaFpT/2Uwc5/Q==
X-CSE-MsgGUID: oay+8vSfQAa4aiFXkXdhCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,233,1739865600"; 
   d="scan'208";a="155580835"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2025 09:43:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u7dCG-0000000F7Si-3R6f;
	Wed, 23 Apr 2025 19:43:40 +0300
Date: Wed, 23 Apr 2025 19:43:40 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Haibo Chen <haibo.chen@nxp.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, linux-iio@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: imx93_adc: load calibrated values even
 calibration failed
Message-ID: <aAkYvE6VtoQItM5o@smile.fi.intel.com>
References: <20250423-adcpatch-v1-1-b0e84c27ae98@nxp.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423-adcpatch-v1-1-b0e84c27ae98@nxp.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Apr 23, 2025 at 04:02:48PM +0800, Haibo Chen wrote:
> ADC calibration might fail because of the noise on reference voltage.
> To avoid calibration fail, need to meet the following requirement:
> ADC reference voltage Noise < 1.8V * 1/2^ENOB
> 
> For the case which the ADC reference voltage on board do not meet
> the requirement, still load the calibrated values, so ADC can also
> work but maybe not that accurate.

...

>  #define IMX93_ADC_PCDR6		0x118
>  #define IMX93_ADC_PCDR7		0x11c
>  #define IMX93_ADC_CALSTAT	0x39C
> +#define IMX93_ADC_CALCFG0	0X3A0

Please, keep one style of the hex values.
If the small letters are less used, prepare a patch to convert them, otherwise
do that for capital letters.

...

> +	if (msr & IMX93_ADC_MSR_CALFAIL_MASK)

Please keep {} as the body is quite long and it's easy to make a mistake in a
long term.

> +		/*
> +		 * Only give warning here, this means the noise of the
> +		 * reference voltage do not meet the requirement:
> +		 *     ADC reference voltage Noise < 1.8V * 1/2^ENOB
> +		 * And the reault of ADC is not that accurate.
> +		 */
>  		dev_warn(adc->dev, "ADC calibration failed!\n");
> -		imx93_adc_power_down(adc);
> -		return -EAGAIN;
> -	}

-- 
With Best Regards,
Andy Shevchenko



