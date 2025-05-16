Return-Path: <linux-iio+bounces-19585-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 426DDAB98B9
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 11:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38C22A21BDD
	for <lists+linux-iio@lfdr.de>; Fri, 16 May 2025 09:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B37723026C;
	Fri, 16 May 2025 09:24:56 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7DD224AEB;
	Fri, 16 May 2025 09:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747387496; cv=none; b=B/8a1fU/MSNtcgJ23oaJDxJKWWvTd6CU6fSC9XngAW9Y31M8YPDzORo76Iopc1AVVVLkf3HLzoMhfuFpycqTs9TiRylVjlI/h+PFHsqH44nAx7nsFNAlUPr3Dp+Q+qAFCNTblOInZubrEF/7LQR24vqtLtQjCEBvWuIIRLrurjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747387496; c=relaxed/simple;
	bh=0gxJ5Nuaa9Hd2/guT1VIQPrisnCfb8est5bYt9sT5LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JLPJqbRNKfGaameypHcYjU1NBk1PeRAK7AsZTTE+nHIEXbqajt69xtP9rhnivNkKDYDPrIfnQ8dnePkR+fX8z0IEoC+zEZ2AVwj8Nj6o2g2vw5p0gPEJFiK6em0M1GkBMUqzFzFhlChLLB0M7pp8+hH/5E+8KQtfMHbaIZNRlYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: 0mfrzuLnT6O7hzLW+uGg7Q==
X-CSE-MsgGUID: 5L2skAuqTY64fXcLGt/Gnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11434"; a="59992352"
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="59992352"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:24:53 -0700
X-CSE-ConnectionGUID: KYD/wBC6QHiiSGteKrTlCw==
X-CSE-MsgGUID: kyTeyVBrRmqPPAY2L6X8lQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,293,1739865600"; 
   d="scan'208";a="138557687"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 May 2025 02:24:49 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uFrJ8-00000002632-3X8C;
	Fri, 16 May 2025 12:24:46 +0300
Date: Fri, 16 May 2025 12:24:46 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Jonathan Santos <Jonathan.Santos@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	nuno.sa@analog.com, Michael.Hennerich@analog.com,
	marcelo.schmitt@analog.com, jic23@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, marcelo.schmitt1@gmail.com,
	linus.walleij@linaro.org, brgl@bgdev.pl, lgirdwood@gmail.com,
	broonie@kernel.org, jonath4nns@gmail.com, dlechner@baylibre.com
Subject: Re: [PATCH v8 07/11] iio: adc: ad7768-1: add multiple scan types to
 support 16-bits mode
Message-ID: <aCcEXgd3My425JRV@smile.fi.intel.com>
References: <cover.1747175187.git.Jonathan.Santos@analog.com>
 <0faf8e6acef1493e8e29c75a6098ca0136740780.1747175187.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0faf8e6acef1493e8e29c75a6098ca0136740780.1747175187.git.Jonathan.Santos@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Thu, May 15, 2025 at 06:13:43PM -0300, Jonathan Santos wrote:
> When the device is configured to decimation x8, only possible in the
> sinc5 filter, output data is reduced to 16-bits in order to support
> 1 MHz of sampling frequency due to clock limitation.
> 
> Use multiple scan types feature to enable the driver to switch
> scan type at runtime, making it possible to support both 24-bit and
> 16-bit resolution.

...

> +static int ad7768_get_current_scan_type(const struct iio_dev *indio_dev,
> +					const struct iio_chan_spec *chan)
> +{
> +	struct ad7768_state *st = iio_priv(indio_dev);
> +
> +	return st->dec_rate == 8 ? AD7768_SCAN_TYPE_HIGH_SPEED :
> +		AD7768_SCAN_TYPE_NORMAL;

Besides issues with the indentation, the logical split seems to me better:

	return st->dec_rate == 8 ?
	       AD7768_SCAN_TYPE_HIGH_SPEED : AD7768_SCAN_TYPE_NORMAL;

> +}

But no need to resend just for this. Perhaps Jonathan can update.

-- 
With Best Regards,
Andy Shevchenko



