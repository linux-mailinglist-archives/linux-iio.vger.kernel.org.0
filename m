Return-Path: <linux-iio+bounces-27711-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EECD1D558
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 81F1F3014D78
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECD83815C3;
	Wed, 14 Jan 2026 09:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ipsp5rRR"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403C137F8AE;
	Wed, 14 Jan 2026 09:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381209; cv=none; b=cf0acyeh+GjTGLKgcBWWK6GJHuFXcZhduSdiiMI6RrdKtVdEWm6krfHHBblEZ+Xi2nrgXqkyHtzfPL4RD4Cb9kVTd7+eb1str56Lpi2pdDEpSZU8tQibH/2TSVsTNtHvm033l79Xzzkzfl1L5gQ+CiqL/Rav6Xs7oKuVHW8en38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381209; c=relaxed/simple;
	bh=34jVjerwqYxOEQcuaSsWoBv5CsPOOzGoscXW0zoe/5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c4hv4nA69wk3dtnvMn/GsDSaQW71W/sDDWN/Xo4YF5OnqEpfr0YHgmQqxlLHkH7/3VIs7dsSV1f3uy9UIB9zbOxw+cq/Ej8CwI0hQq7WIKgjbcyt0EtF6Fjy/CYOdCHe4V4moJVJ838bqL3lTu6oMhWe5sRA4xUV6bU4PB33w4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ipsp5rRR; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768381205; x=1799917205;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=34jVjerwqYxOEQcuaSsWoBv5CsPOOzGoscXW0zoe/5M=;
  b=Ipsp5rRR24BVLxOcWuNHS2DSXGJY6pVJZ9jt+v53lMnDVwfSyzGOvyH0
   7++nJxT+uLoIOcaXmTuv5a4FDIrn6cu4H4s+s4F2VJ3IX0cMqYoEooMhH
   QPaGSwsxQmA35HuzHMsnBRYOg1HsLIOu603zrBHtXPGZ4aYZaeDd2It3h
   4FWcpKhXNbHMksHDVoU40fvPhsaivpfnHUoZKlYb/QSXLhpYsBlU7U3us
   ouspzOJUemkcllEU+ULuzL5rJILb6X9j+p1BIR2Bzco18Ej//hiUd3o7n
   C7Mcc0ObTZJJdIHHoIyUXHua9XNtGZYbGGre4t+u6ofnMp7jFnE7EAnQ7
   w==;
X-CSE-ConnectionGUID: ytV/iaIkR923y+DNY+NWRQ==
X-CSE-MsgGUID: L5QjEpDfRy6xoQyIE5D/iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="57231526"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="57231526"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:00:01 -0800
X-CSE-ConnectionGUID: MR0yAgE+ROqJn82tw1i+XQ==
X-CSE-MsgGUID: NYAbW1r9RHeVJwJIuq4/aw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="204636173"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 00:59:54 -0800
Date: Wed, 14 Jan 2026 10:59:51 +0200
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
	linux-pm@vger.kernel.org, kernel@collabora.com,
	Abel Vesa <abel.vesa@linaro.org>
Subject: Re: [PATCH v7 07/10] phy: qualcomm: eusb2-repeater: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <aWdbB4vJ6Z8k0g4s@smile.fi.intel.com>
References: <20260114083957.9945-1-angelogioacchino.delregno@collabora.com>
 <20260114083957.9945-8-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114083957.9945-8-angelogioacchino.delregno@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 09:39:54AM +0100, AngeloGioacchino Del Regno wrote:
> Some Qualcomm PMICs integrate an USB Repeater device, used to
> convert between eUSB2 and USB 2.0 signaling levels, reachable
> in a specific address range over SPMI.
> 
> Instead of using the parent SPMI device (the main PMIC) as a kind
> of syscon in this driver, register a new SPMI sub-device for EUSB2
> and initialize its own regmap with this sub-device's specific base
> address, retrieved from the devicetree.
> 
> This allows to stop manually adding the register base address to
> every R/W call in this driver, as this can be, and is now, handled
> by the regmap API instead.

Same comments and actually one more.

...

> +	struct regmap_config eusb2_regmap_config = {
> +		.reg_bits = 16,
> +		.val_bits = 8,
> +		.max_register = 0x100,
> +		.fast_io = true,
> +	};

This is third time of the same. Make it part of SPMI core and export to
the users. Or are they semantically different like different slices?
In that case you can export it under generic name like

	spmi_default_slice_regmap_config

-- 
With Best Regards,
Andy Shevchenko



