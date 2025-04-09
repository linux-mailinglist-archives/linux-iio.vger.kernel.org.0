Return-Path: <linux-iio+bounces-17853-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D326A81E65
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 09:37:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B80667B5CCD
	for <lists+linux-iio@lfdr.de>; Wed,  9 Apr 2025 07:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A9F25A2D1;
	Wed,  9 Apr 2025 07:37:17 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EBB1D86F2;
	Wed,  9 Apr 2025 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744184237; cv=none; b=upX1G/PV6GeNb5O62hlgxCZNj1mMS37F5MuJwPzVaFYrORz/JgxdXiUIf+ubWKDK10lE67u/E7YvjqVuRAMdDCaTRaNdgtxl4bbTP+gaBVQQpXrb+Cbnc9LZ2G3Tk/uztV38TS39la4irhOMUDO1fH8O3aWtlXQS+BuJsbHRpW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744184237; c=relaxed/simple;
	bh=J6OOhGEhaEl1svFaD8AyfxnUQjlBezzJgbfDlKlhfoU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEM1ckL1wM+HHps7c9ZWsaMYFXbmW7NBHDPjuDBLLLHXmU6Se/bbPhvjWaUcsn3r58GKc43bSOZ0ThuLD0Noco5dWu6OsNLmhoNndWWCaHKZk1yMDwXxxL8xUt1ec32FAJX941ewZLJaW57sFUIO5uy5UTrCOQ9m8f37IzWkGrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: n+i9c4iyShijK0nBdV3bWw==
X-CSE-MsgGUID: DXR3qPnJTc+nHn47iCR+GQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="56310944"
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="56310944"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 00:37:14 -0700
X-CSE-ConnectionGUID: Q3KlOjALRHGGFN+CYJn+Pw==
X-CSE-MsgGUID: Zy41ur7VQgi4lh34jJl58w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,200,1739865600"; 
   d="scan'208";a="129451172"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2025 00:37:11 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1u2Pzg-0000000AeY9-3ZGw;
	Wed, 09 Apr 2025 10:37:08 +0300
Date: Wed, 9 Apr 2025 10:37:08 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Olivier Moysan <olivier.moysan@foss.st.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	linux-iio@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: adc: stm32: add oversampling support
Message-ID: <Z_YjpEFhBXgrWATp@smile.fi.intel.com>
References: <20250408173054.1567523-1-olivier.moysan@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408173054.1567523-1-olivier.moysan@foss.st.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 08, 2025 at 07:30:53PM +0200, Olivier Moysan wrote:
> Add oversampling support for STM32H7, STM32MP15 & STM32MP13.
> STM32F4 ADC has no oversampling feature.
> 
> The current support of the oversampling feature aims at increasing
> the data SNR, without changing the data resolution.
> As the oversampling by itself increases data resolution,
> a right shift is applied to keep initial resolution.
> Only the oversampling ratio corresponding to a power of two are
> supported here, to get a direct link between right shift and
> oversampling ratio. (2exp(n) ratio <=> n right shift)
> 
> The oversampling ratio is shared by all channels, whatever channel type.
> (e.g. single ended or differential).
> 
> Oversampling can be configured using IIO ABI:
> - oversampling_ratio_available
> - oversampling_ratio

...

> --- a/drivers/iio/adc/stm32-adc-core.h
> +++ b/drivers/iio/adc/stm32-adc-core.h

Does this include bitfield.h and bits.h already?

...

> +static const unsigned int stm32h7_adc_oversampling_avail[] = {
> +	1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024

Leave trailing comma.

> +};
> +
> +static const unsigned int stm32mp13_adc_oversampling_avail[] = {
> +	1, 2, 4, 8, 16, 32, 64, 128, 256

As well.

>  };

...

> +	.oversampling = stm32h7_adc_oversampling_avail,
>  	.num_res = ARRAY_SIZE(stm32h7_adc_resolutions),
> +	.num_ovs = ARRAY_SIZE(stm32h7_adc_oversampling_avail),

+ array_size.h

...

> +static void stm32h7_adc_set_ovs(struct iio_dev *indio_dev, u32 ovs_idx)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	u32 ovsr_bits, bits, msk;
> +
> +	msk = STM32H7_ROVSE | STM32H7_OVSR_MASK | STM32H7_OVSS_MASK;
> +	stm32_adc_clr_bits(adc, STM32H7_ADC_CFGR2, msk);
> +
> +	if (!ovs_idx)
> +		return;
> +
> +	/*
> +	 * Only the oversampling ratios corresponding to 2*exp(ovs_idx) are exposed in sysfs.
> +	 * Oversampling ratios [2,3,...,1024] are mapped on OVSR register values [1,2,...,1023].
> +	 * OVSR = 2 exp(ovs_idx) - 1
> +	 * These ratio increase the resolution by ovs_idx bits. Apply a right shift to keep initial
> +	 * resolution given by "assigned-resolution-bits" property.
> +	 * OVSS = ovs_idx
> +	 */
> +	ovsr_bits = (1 << ovs_idx) - 1;

Why not GENMASK(ovs_idx - 1, 0)?

> +	bits = STM32H7_ROVSE | STM32H7_OVSS(ovs_idx) | STM32H7_OVSR(ovsr_bits);
> +
> +	stm32_adc_set_bits(adc, STM32H7_ADC_CFGR2, bits & msk);
> +}
> +
> +static void stm32mp13_adc_set_ovs(struct iio_dev *indio_dev, u32 ovs_idx)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	u32 bits, msk;
> +
> +	msk = STM32H7_ROVSE | STM32MP13_OVSR_MASK | STM32MP13_OVSS_MASK;
> +	stm32_adc_clr_bits(adc, STM32H7_ADC_CFGR2, msk);
> +
> +	if (!ovs_idx)
> +		return;
> +
> +	/*
> +	 * The oversampling ratios [2,4,8,..,256] are mapped on OVSR register values [0,1,...,7].
> +	 * OVSR = ovs_idx - 1
> +	 * These ratio increase the resolution by ovs_idx bits. Apply a right shift to keep initial
> +	 * resolution given by "assigned-resolution-bits" property.
> +	 * OVSS = ovs_idx
> +	 */
> +	bits = STM32H7_ROVSE | STM32MP13_OVSS(ovs_idx);
> +	if (ovs_idx - 1)
> +		bits |= STM32MP13_OVSR(ovs_idx - 1);
> +
> +	stm32_adc_set_bits(adc, STM32H7_ADC_CFGR2, bits & msk);
> +}

...

> +static int stm32_adc_write_raw(struct iio_dev *indio_dev,
> +			       struct iio_chan_spec const *chan,
> +			       int val, int val2, long mask)
> +{
> +	struct stm32_adc *adc = iio_priv(indio_dev);
> +	struct device *dev = indio_dev->dev.parent;
> +	int nb = adc->cfg->adc_info->num_ovs;
> +	u32 idx;

Why this strange type for loop iterator? Shouldn't be as simple as unsigned int?

> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (val2)
> +			return -EINVAL;
> +
> +		for (idx = 0; idx < nb; idx++)
> +			if (adc->cfg->adc_info->oversampling[idx] == val)
> +				break;

> +

Unneeded blank line as this two are coupled well together.

> +		if (idx >= nb)
> +			return -EINVAL;
> +
> +		if (!iio_device_claim_direct(indio_dev))
> +			return -EBUSY;
> +
> +		ret = pm_runtime_resume_and_get(dev);
> +		if (ret < 0)
> +			goto err;
> +
> +		adc->cfg->set_ovs(indio_dev, idx);
> +
> +		pm_runtime_mark_last_busy(dev);
> +		pm_runtime_put_autosuspend(dev);
> +
> +		adc->ovs_idx = idx;

> +err:



> +		iio_device_release_direct(indio_dev);
> +
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}

-- 
With Best Regards,
Andy Shevchenko



