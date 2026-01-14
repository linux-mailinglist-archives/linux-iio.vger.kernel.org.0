Return-Path: <linux-iio+bounces-27707-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2F4D1D5F5
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A2EA8306A0E5
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 08:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BB43803D2;
	Wed, 14 Jan 2026 08:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="examljUg"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F41B237F75A;
	Wed, 14 Jan 2026 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381039; cv=none; b=ocErAeSrdkVFPtCeMgWrgNXWNt5DVRFslBCjjqK+KvtUrxoqtNcqaEn+JUzAh3Gow/FeuJJvEXjXL1O2K+VKA5119/z36mhsoGMyhP2XEWpeqxW8orTZ1N1kOgNRqgT0bx/HBXqJ3f1eBOnSpfx264xRVDzueqp1ti1HWEa6iko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381039; c=relaxed/simple;
	bh=HIkzILhgmWy3kG68XFN5wNFScMmkW6IPVLk8hi5sn5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lKvHc3jtlVoKjYJmg+etqSZLvCRjl6vkxgqBz++3XBfRl/cjg6OUfBW49uBflRTJh/3mpVuH4PN55o9e1zvfwBy3nq7qajgFxakxxiawPoDWHlNK1I1ntoHoueo22fBP9sQ8C60KapJ9QQctLzeW5X/nte/zpgW+zcdJLuA3vXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=examljUg; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768381035; x=1799917035;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HIkzILhgmWy3kG68XFN5wNFScMmkW6IPVLk8hi5sn5g=;
  b=examljUgrFxwp25DDVBzwRjb7aM5G5PafO2HECBRrLEgZRxD12xYyhN9
   vIl/GGff5SOpmH6oGDJEvBbNEvoIvlTxT7IxybFxwwtr3gDKkKU7QOjxb
   hIIPWa+Uwp0p/z8oaDFGRmKCZhEFA12KNYx9kRz0dakA1cvryGxYNZj21
   ANngab86lFXX1NhyWBQEjVRLuot6WLGdzVignCJOE3i0Cv2KZ+zWnjYCJ
   GTzGZWiA0jRhjzOT3gVKSsJlSZMw/Ko3v8qiM3W0MGpaE2cDItpvQSe0u
   qRctU+nkfop2i8iy+XsS+Ahyf/5kVwQXX861qSzabAi+eP2sc4IQRpBq0
   A==;
X-CSE-ConnectionGUID: cpGBxTezQ7m+AKjDpWy40g==
X-CSE-MsgGUID: CChaLPZmQKWS5RgbYKai3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="73311197"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="73311197"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 00:57:09 -0800
X-CSE-ConnectionGUID: JwC21BClT52N5BFbRPnySQ==
X-CSE-MsgGUID: RAtdZy/tSs2IStYTIHc58g==
X-ExtLoop1: 1
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 00:56:59 -0800
Date: Wed, 14 Jan 2026 10:56:57 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
	srini@kernel.org, vkoul@kernel.org, neil.armstrong@linaro.org,
	sre@kernel.org, sboyd@kernel.org, krzk@kernel.org,
	dmitry.baryshkov@oss.qualcomm.com, quic_wcheng@quicinc.com,
	melody.olvera@oss.qualcomm.com, quic_nsekar@quicinc.com,
	ivo.ivanov.ivanov1@gmail.com, abelvesa@kernel.org,
	luca.weiss@fairphone.com, konrad.dybcio@oss.qualcomm.com,
	mitltlatltl@gmail.com, krishna.kurapati@oss.qualcomm.com,
	linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-pm@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v7 05/10] nvmem: qcom-spmi-sdam: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <aWdaWY2tWUMllOHH@smile.fi.intel.com>
References: <20260114083957.9945-1-angelogioacchino.delregno@collabora.com>
 <20260114083957.9945-6-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114083957.9945-6-angelogioacchino.delregno@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 09:39:52AM +0100, AngeloGioacchino Del Regno wrote:
> Some Qualcomm PMICs integrate a SDAM device, internally located in
> a specific address range reachable through SPMI communication.
> 
> Instead of using the parent SPMI device (the main PMIC) as a kind
> of syscon in this driver, register a new SPMI sub-device for SDAM
> and initialize its own regmap with this sub-device's specific base
> address, retrieved from the devicetree.
> 
> This allows to stop manually adding the register base address to
> every R/W call in this driver, as this can be, and is now, handled
> by the regmap API instead.

...

> +	struct regmap_config sdam_regmap_config = {
> +		.reg_bits = 16,
> +		.val_bits = 8,

> +		.max_register = 0x100,

Are you sure? This might be a bad naming, but here max == the last accessible.
I bet it has to be 0xff (but since the address is 16-bit it might be actually
257 registers, but sounds very weird).

> +		.fast_io = true,
> +	};

...

> +	rc = of_property_read_u32(dev->of_node, "reg", &sdam_regmap_config.reg_base);

Why not device_property_read_u32(dev, ...) ?

...

> +	sdam->regmap = devm_regmap_init_spmi_ext(&sub_sdev->sdev, &sdam_regmap_config);
> +	if (IS_ERR(sdam->regmap))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(sdam->regmap),

You have "dev".

> +				     "Failed to get regmap handle\n");

-- 
With Best Regards,
Andy Shevchenko



