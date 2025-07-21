Return-Path: <linux-iio+bounces-21818-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DBB2B0C355
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 13:41:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A04C4E5C93
	for <lists+linux-iio@lfdr.de>; Mon, 21 Jul 2025 11:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D26A12D6630;
	Mon, 21 Jul 2025 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z2ESS2Yl"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36EC2D5C62;
	Mon, 21 Jul 2025 11:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753097827; cv=none; b=gOxSl8zgqisM9U967WKIUi6nLRYtPLAp8ZSsR+sXe7Iy0U+/vyFVX8b6PHEHSjwWJ7Wj3gcPy/0BQImCml2J84NpkctPRD7R8TDxhU4E/yPPxflW8pV3CVs9777K2k77SU8rRlWWHXi2Jq0oygB9/3OHrHsJYfkuOuLJUp7ox2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753097827; c=relaxed/simple;
	bh=rwXgrluBp9rUpOy4oUp6piiP3wsnYPTjn0FNFxcB0Pg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSnGCkSQxnXfC5C/+GWaAjHhu0QaTt56rM2W5ncS7AG0mZmYwUAey0pXFZqinGbk4ck06szmUEr+/eSQFA+kT+LbnTDQ/oZDfoy7PqLe9gJlMTPWkp895a6x6a/mABiSfr4iPLbOOskCJ1yyuw2BZTBAMLyNmMBuwz9UbKLZBrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z2ESS2Yl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753097826; x=1784633826;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rwXgrluBp9rUpOy4oUp6piiP3wsnYPTjn0FNFxcB0Pg=;
  b=Z2ESS2YlvmGybJ9xY/u/viZHBLG92VdjhCmNOP2c/LE90DpxWKQG4h6Z
   SfeQmFLEiUnj+HeycYqO95JLXxZ2AOKItW6jZ+bthmSpWKVtXeoiTQjj0
   hsa+hCXzfrDEq1xn5fZ+hju3qfCPIar/6W99fuIshK7j1lgaWKbC/dk2z
   uTIfxGaPpSjZ846v3Bz4wwA7t8kBqeal4nfxmjksAvel3/mHTjBV3FMwj
   QbB8djipNKGGFiiyy+s7FITcSwvHzmMO/ahC0moF1ppqE39+7IrxPMJ1m
   BSwEb5aTC9drIFh7qbxWunJeaXK0ZuXhruTxmE8+/T9UWy7hpz+bG6f3O
   A==;
X-CSE-ConnectionGUID: 7BfDr7DETZGiTVGLrd3OGQ==
X-CSE-MsgGUID: hrd9YHlNSz+SoB0YzzD07Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11498"; a="65999505"
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="65999505"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:37:05 -0700
X-CSE-ConnectionGUID: CQR6jIVHRm2P5F4mU79eVQ==
X-CSE-MsgGUID: aAD6zgaERDSvkPlKmxYTcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,328,1744095600"; 
   d="scan'208";a="162856147"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 04:37:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1udopF-0000000HKLM-1Afh;
	Mon, 21 Jul 2025 14:36:57 +0300
Date: Mon, 21 Jul 2025 14:36:57 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: sboyd@kernel.org, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, srini@kernel.org, vkoul@kernel.org,
	kishon@kernel.org, sre@kernel.org, krzysztof.kozlowski@linaro.org,
	u.kleine-koenig@baylibre.com, linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	kernel@collabora.com, wenst@chromium.org
Subject: Re: [PATCH v1 3/7] power: reset: qcom-pon: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <aH4mWfgQt_Q0O-7S@smile.fi.intel.com>
References: <20250721075525.29636-1-angelogioacchino.delregno@collabora.com>
 <20250721075525.29636-4-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721075525.29636-4-angelogioacchino.delregno@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jul 21, 2025 at 09:55:21AM +0200, AngeloGioacchino Del Regno wrote:
> Some Qualcomm PMICs integrates a Power On device supporting pwrkey
> and resin along with the Android reboot reason action identifier.
> 
> Instead of using the parent SPMI device (the main PMIC) as a kind
> of syscon in this driver, register a new SPMI sub-device for PON
> and initialize its own regmap with this sub-device's specific base
> address, retrieved from the devicetree.
> 
> This allows to stop manually adding the register base address to
> every R/W call in this driver, as this can be, and is now, handled
> by the regmap API instead.

...

> +	struct regmap_config qcom_pon_regmap_config = {
> +		.reg_bits = 16,
> +		.val_bits = 16,
> +		.max_register = 0x100,
> +		.fast_io = true

Please, leave trailing comma in this and other similar cases.

> +	};


>  	struct qcom_pon *pon;
>  	long reason_shift;
>  	int error;

> +	if (!pdev->dev.parent)
> +		return -ENODEV;

You can start using

	struct device *dev = &pdev->dev;

here and perhaps one may convert the rest to it...

...

>  	error = of_property_read_u32(pdev->dev.of_node, "reg",

...including, but not limited to, use of device_property_read_u32(dev, ...) here.

> -				     &pon->baseaddr);
> +				     &qcom_pon_regmap_config.reg_base);

-- 
With Best Regards,
Andy Shevchenko



