Return-Path: <linux-iio+bounces-20915-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66402AE46F8
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 16:37:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4D96446D0C
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 14:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECED323E347;
	Mon, 23 Jun 2025 14:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y0Xx3kaW"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF2F7263F;
	Mon, 23 Jun 2025 14:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750689027; cv=none; b=sWxoUDXHnLHk7pYWayBIDrjsd+9WnB9gwWI96JXE9xtxskCKeI/k89vAUJoyKEEQglRlCjMuY9A3GuS2I/gFHnp8m8ozismQyV+F18VDMkeCqXL4trjVYgvJFhihoSD0/T4I24fuHxy2evCkKyobQfbV6hcTwcA44JjIWvt2nTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750689027; c=relaxed/simple;
	bh=48eVt2PPcxAS9n4RtU7GsK0fPkHm0p1WawWnWIodk7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HOxNCM4CAonsUvhI/I9Tpa50+BNPIB1FryvTOsrlB9kuNZ+5GXnsj/4VtFjsVA1OOc1R9SUljCGFXt20Vi4la8Hz2w3ic28CU9haj14zn5bcKs7HR43/udykfytSQWBePBbOab5DMKKnWPjMza4styb7wovbRyXpvdSIv9KznZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y0Xx3kaW; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750689027; x=1782225027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=48eVt2PPcxAS9n4RtU7GsK0fPkHm0p1WawWnWIodk7o=;
  b=Y0Xx3kaW2Wvc17ZhqQCjpeW7XBedqx07pIAFmRGpel9hIkV4WAG9h8vi
   Mpox9VQWj98hWJEvgeDT0UxfytFFQvftS4B7P5gRoJEvbFpY33g/mdGuy
   RbD+NdlNxE7PYXiLv/G96XGnB7orNAOHC1VtHMQEOXnMQopb6lWF4ZLPX
   pP37j0PT9BPlHemR++P7yrvNaH5yLkPrdb+OY+a155tttOFUYlEq8RANe
   /kIpc45acUNFfVhvry8bv0HuwkdaNzyvGgLoN7csjGh5CiWhrEWT00bdk
   3laLP5OPk1qdfoVwv3ns8TDA4EKCfoP9vXgwwYec7sqZgJteDCFAJCLlO
   A==;
X-CSE-ConnectionGUID: qPipcxzgSHa5D8C8nNilNg==
X-CSE-MsgGUID: LWWNxQbfSGSOyq2PgHxR2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11473"; a="53031893"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="53031893"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 07:30:26 -0700
X-CSE-ConnectionGUID: H7JwwNNASkipLkEQE+BTyw==
X-CSE-MsgGUID: xVHtY9bDRp25jG8Rf2mRPQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="155914307"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 07:30:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTiBf-00000009CQ9-0zoy;
	Mon, 23 Jun 2025 17:30:19 +0300
Date: Mon, 23 Jun 2025 17:30:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v1 4/5] iio: adc: mt6359: Add support for MediaTek MT6363
 PMIC AUXADC
Message-ID: <aFlk-l5LhgO8dnXK@smile.fi.intel.com>
References: <20250623120028.108809-1-angelogioacchino.delregno@collabora.com>
 <20250623120028.108809-5-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623120028.108809-5-angelogioacchino.delregno@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jun 23, 2025 at 02:00:27PM +0200, AngeloGioacchino Del Regno wrote:
> MediaTek MT6363 is a PMIC found on MT8196/MT6991 board designs
> and communicates with the SoC over SPMI.
> 
> This PMIC integrates an Auxiliary ADC (AUXADC) which has a grand
> total of 54 ADC channels: 49 PMIC-internal channels, 2 external
> NTC thermistor channels and 2 generic ADC channels (mapped to 7
> PMIC ADC external inputs).
> 
> To use a generic ADC channel it is necessary to enable one of
> the PMIC ADC inputs at a time and only then start the reading,
> so in this case it is possible to read only one external input
> for each generic ADC channel.
> 
> Due to the lack of documentation, this implementation supports
> using only one generic ADC channel, hence supports reading only
> one external input at a time.

> +#define MT6363_EXT_CHAN_MASK		GENMASK(2, 0)
> +#define MT6363_EXT_PURES_MASK		GENMASK(4, 3)
> + #define MT6363_PULLUP_RES_100K		0
> + #define MT6363_PULLUP_RES_OPEN		3

I would rather expect the two spaces after #define. This most likely will break
syntax highlighting in (some of) the editors.

...

> +#define MTK_PMIC_ADC_EXT_CHAN(_ch_idx, _req_idx, _req_bit, _rdy_idx, _rdy_bit,	\
> +			      _ext_sel_idx, _ext_sel_ch, _ext_sel_pu,		\
> +			      _samples, _rnum, _rdiv)				\

Wondering, and it's out of scope here, if we can go to use a macro for
initialization of struct *_fract.

>  	[PMIC_AUXADC_CHAN_##_ch_idx] = {					\
>  		.req_idx = _req_idx,						\
>  		.req_mask = BIT(_req_bit),					\
>  		.rdy_idx = _rdy_idx,						\
>  		.rdy_mask = BIT(_rdy_bit),					\
> +		.ext_sel_idx = _ext_sel_idx,					\
> +		.ext_sel_ch = _ext_sel_ch,					\
> +		.ext_sel_pu = _ext_sel_pu,					\
>  		.num_samples = _samples,					\
>  		.r_ratio = { _rnum, _rdiv }					\
>  	}

Perhaps something in math.h as

#define INIT_STRUCT_FRACT_UXX(n, d) ...

...

> +	if (MTK_AUXADC_HAS_FLAG(cinfo, IS_SPMI)) {
> +		/* If the previous read succeeded, this can't fail */
> +		regmap_read(regmap, reg - 1, &lval);

No error check? lval may contain garbage here, right?

> +		val = (val << 8) | lval;

Is it guaranteed that lval is always less than 256 (if unsigned)?

> +	}

...

> +		regmap_update_bits(regmap, cinfo->regs[desc->ext_sel_idx],
> +				   MT6363_EXT_PURES_MASK, ext_sel);

No  error check?

> +	}

-- 
With Best Regards,
Andy Shevchenko



