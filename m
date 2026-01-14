Return-Path: <linux-iio+bounces-27712-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 33EC3D1D69D
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 001D5303E408
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4739D3815D0;
	Wed, 14 Jan 2026 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="i1WmgPLO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432EB27C842;
	Wed, 14 Jan 2026 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381272; cv=none; b=eoShMAYvzc9CejCIgLRrPrx1veX/s36G4/5MwCcrQnE8lgewxp0+JY0WuOMpqKnWn2meguKtKN/uHBfTOdZHXZNhMWkFwXzcX/ps+4UNbQTQEK2VDW67+Zw7CoJbA6TSAALgoHpguUdxHFsG8XYgNxa5IXnP8fthHjD8is02yEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381272; c=relaxed/simple;
	bh=3MTdLgR7EYrllSYqsPVsivWnYqpalKljGcBuvMMrHQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XZnDURpq35+jwG1KTD8fNUGnBi+KwmuFLSBWfMKVLHQ3/TWETm3FK6zt5p06NUhhv8LqSFEg2icFXnO9/TqmNMCD9QIaXjWbfTkRUw/YqNCmmwlqx+56rVAooSEkb84L53qokaI23FY32KNzQbhcHtibYWlgh9sxXi8i875Cfds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=i1WmgPLO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768381269; x=1799917269;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3MTdLgR7EYrllSYqsPVsivWnYqpalKljGcBuvMMrHQw=;
  b=i1WmgPLOqIWYqi82/IokW52mChbN92PIArfGYTjhQz7AEls9G00M5m/U
   Yiq9SiI/2sD4TzKmoxqnYP6/obg09OSNfbRg4pHW1xbucNwHf5oUcto7V
   m+Uec608PwvV0Tdiaz9xI2YOuNPsWlp1QHmfVk3b889fVO1i1GRS7gaNE
   Thd+Mb7Zpj2xCcNw9zTZICUCv+A+iyxHO3alDLdqWIvX1zTOYxqExyXml
   U88ECWQmH9brmjip6MC5dhUk5ZAZ7enefuZYr3CQfRcEp+4OnsfGoPOFG
   ur8VMeYjLhaKP8S4RqmZaSlkUZBGDjtBd1BHQ/1eMK7Cb9bt2a1YSCiQ5
   A==;
X-CSE-ConnectionGUID: B+vt5ij+R2OUkoqR/dDPdQ==
X-CSE-MsgGUID: zy8IMd8FTe6rVomfLCCsIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="80785905"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="80785905"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:00:58 -0800
X-CSE-ConnectionGUID: 8oA79wd9S7qrqlUbvjEBxQ==
X-CSE-MsgGUID: L3zNIa1cScWTiizkk+o/sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="203767160"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:00:50 -0800
Date: Wed, 14 Jan 2026 11:00:47 +0200
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
Message-ID: <aWdbPze-f_2_5EbL@smile.fi.intel.com>
References: <20260114083957.9945-1-angelogioacchino.delregno@collabora.com>
 <20260114083957.9945-6-angelogioacchino.delregno@collabora.com>
 <aWdaWY2tWUMllOHH@smile.fi.intel.com>
 <8bf79979-0946-4ed9-b8d4-c442a6e54833@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8bf79979-0946-4ed9-b8d4-c442a6e54833@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 09:59:40AM +0100, AngeloGioacchino Del Regno wrote:
> Il 14/01/26 09:56, Andy Shevchenko ha scritto:
> > On Wed, Jan 14, 2026 at 09:39:52AM +0100, AngeloGioacchino Del Regno wrote:
> > > Some Qualcomm PMICs integrate a SDAM device, internally located in
> > > a specific address range reachable through SPMI communication.
> > > 
> > > Instead of using the parent SPMI device (the main PMIC) as a kind
> > > of syscon in this driver, register a new SPMI sub-device for SDAM
> > > and initialize its own regmap with this sub-device's specific base
> > > address, retrieved from the devicetree.
> > > 
> > > This allows to stop manually adding the register base address to
> > > every R/W call in this driver, as this can be, and is now, handled
> > > by the regmap API instead.

...

> > > +	struct regmap_config sdam_regmap_config = {
> > > +		.reg_bits = 16,
> > > +		.val_bits = 8,
> > 
> > > +		.max_register = 0x100,
> > 
> > Are you sure? This might be a bad naming, but here max == the last accessible.
> > I bet it has to be 0xff (but since the address is 16-bit it might be actually
> > 257 registers, but sounds very weird).
> 
> Yes, I'm sure.

So, what is resided on address 0x100 ?

> > > +		.fast_io = true,
> > > +	};


-- 
With Best Regards,
Andy Shevchenko



