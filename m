Return-Path: <linux-iio+bounces-5046-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C658C56AF
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 15:13:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66102280DD5
	for <lists+linux-iio@lfdr.de>; Tue, 14 May 2024 13:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A87C11448EA;
	Tue, 14 May 2024 13:13:14 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C17F1448C5;
	Tue, 14 May 2024 13:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692394; cv=none; b=UaTSfZ/IErIX2oBY53Ih7lBLpxz07S5YW7ckOBbBJQKr6ee44SzC5VaUfSt3glUeb2ppa4487Y0siPpzm8wF5CUhvHCoqim1MzcvSrry4uSoBarW4r1QPS3BjkAlwhFjPMx+zPt+WOkieebLMm+x2px+MR9GPpFwvoqHiMrTpsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692394; c=relaxed/simple;
	bh=aOQguXPOeVpFjbc/NkW1mh5EX2xzWebjWEzQ1meSRbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKDjWfIboVtedTdylwbuM7fZ1NfZZbHDj+/dlLxc71UcxdUb8qDLGwdAIG/8+ysxQFWfBTe++Sq080yWA+GqFdD8UYkwrghwbsjfVSQ7qrucXJD0yydDioCKMCmpoe76xhktrY9fVrIw+57Y3CmjOMHkhv5yIc72CRVl30ZOHhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: GzFFwDAXR0KYdikQCwll3w==
X-CSE-MsgGUID: NywGtkIlR3q0TqStj14d9w==
X-IronPort-AV: E=McAfee;i="6600,9927,11073"; a="14617243"
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="14617243"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 06:13:12 -0700
X-CSE-ConnectionGUID: /kASNeFJRA2oVloL10ju9Q==
X-CSE-MsgGUID: u0W3hKOZRLqfR96alajX+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,159,1712646000"; 
   d="scan'208";a="61854598"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2024 06:13:08 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andy@kernel.org>)
	id 1s6rxp-00000007RCl-1243;
	Tue, 14 May 2024 16:13:05 +0300
Date: Tue, 14 May 2024 16:13:05 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Alisa-Dariana Roman <alisadariana@gmail.com>
Cc: michael.hennerich@analog.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	lars@metafoo.de, jic23@kernel.org, robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	lgirdwood@gmail.com, broonie@kernel.org, nuno.sa@analog.com,
	marcelo.schmitt@analog.com, bigunclemax@gmail.com,
	dlechner@baylibre.com, okan.sahin@analog.com, fr0st61te@gmail.com,
	alisa.roman@analog.com, marcus.folkesson@gmail.com,
	schnelle@linux.ibm.com, liambeguin@gmail.com
Subject: Re: [PATCH v8 3/6] iio: adc: ad7192: Add aincom supply
Message-ID: <ZkNjYZew7Mko7iPX@smile.fi.intel.com>
References: <20240514120222.56488-1-alisa.roman@analog.com>
 <20240514120222.56488-4-alisa.roman@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240514120222.56488-4-alisa.roman@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, May 14, 2024 at 03:02:19PM +0300, Alisa-Dariana Roman wrote:
> AINCOM should actually be a supply. AINx inputs are referenced to AINCOM
> in pseudo-differential operation mode. AINCOM voltage represents the
> offset of corresponding channels.

...

Possible cleanup with the help of

	struct device *dev = &spi->dev;


>  	struct ad7192_state *st;
>  	struct iio_dev *indio_dev;
> +	struct regulator *aincom;
>  	int ret;

...

> +	aincom = devm_regulator_get_optional(&spi->dev, "aincom");

	aincom = devm_regulator_get_optional(dev, "aincom");

...

> +			return dev_err_probe(&spi->dev, PTR_ERR(aincom),
> +					     "Failed to get AINCOM supply\n");

			return dev_err_probe(dev, PTR_ERR(aincom),
					     "Failed to get AINCOM supply\n");

...

> +			return dev_err_probe(&spi->dev, ret,
> +					     "Failed to enable specified AINCOM supply\n");

			return dev_err_probe(dev, ret,
					     "Failed to enable specified AINCOM supply\n");

...

> +		ret = devm_add_action_or_reset(&spi->dev, ad7192_reg_disable, aincom);

		ret = devm_add_action_or_reset(dev, ad7192_reg_disable, aincom);

...

> +			return dev_err_probe(&spi->dev, ret,
> +					     "Device tree error, AINCOM voltage undefined\n");

			return dev_err_probe(dev, ret,
					     "Device tree error, AINCOM voltage undefined\n");

-- 
With Best Regards,
Andy Shevchenko



