Return-Path: <linux-iio+bounces-26324-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D78BC70E3D
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 20:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 420824E16C6
	for <lists+linux-iio@lfdr.de>; Wed, 19 Nov 2025 19:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 470563730E2;
	Wed, 19 Nov 2025 19:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GfQ/wm0i"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784752773D4;
	Wed, 19 Nov 2025 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763581662; cv=none; b=hJzLbmOJ649w05xf5SR+i0dbfflRBG6OvovuD+kaitxTko1wOKUB4HQvmboq5Jg2usueu2wst1mUEx9W/WCzxZVkvb9OWebFxjvHDUGUUP9IUDbAE5/YxGQbHssTADDMA8c2Pkfm/xF/U1zjhO2YZYhuNLfy0wi1DdlKRb8f+c8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763581662; c=relaxed/simple;
	bh=yR1jifjvTn+qY7kiz3sNt3OFFB6PgyOmHUCR90yMOTs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcA8EJ1CddqhVROMhYFww0gdyDDJV2I157cRwk+gdhEqcLgmjfEhxVcaFYSOpImFwmAWMT2m8XdARNNHODldzu73qqrM7oc4dTx5buxgv6maRMpmRt+TtksxL1Py52vvNyhQWFqUM544cRuKb+BbcKGMw1UBSCGELWJjfKKLq70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GfQ/wm0i; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763581658; x=1795117658;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=yR1jifjvTn+qY7kiz3sNt3OFFB6PgyOmHUCR90yMOTs=;
  b=GfQ/wm0ikCLpjuwU3/7H4Pinu3fBrz1XfRaDAvXNiInUeMjOgNHa+59D
   kjDlOt2wXjjyT52Ycz/qjg9hIpTkcwvnNDOYKvvwPSX0XgsmeryuwFmiy
   bkt8nM9i+plruaWgjKr3YQUyxdQu60k8Mr6A3EsE8Z2lQKk2AgHyceMN8
   eNEEhrNIZ58rf0kW5dJBVLWLeCChg0wgjW1SiHGgGPcrDc6yEDUJB9HVj
   KXjiS0lHgQj/t8jjQgHE6Y40NjNoZtCcTY+TiAU21d+nM4f8qObZXa2eC
   FpHrT9bCvc01TxMO+cdn64h3WGiS9x8GtVQ16UayPt5/CLLUpBzT+Z9mm
   A==;
X-CSE-ConnectionGUID: r7pkM+beRemrb/TohhBdCg==
X-CSE-MsgGUID: Ks6glD/5Td2E2bvjD0XceQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="76248471"
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="76248471"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 11:47:30 -0800
X-CSE-ConnectionGUID: ZhJcMBwDRVyDeZotrQyU2g==
X-CSE-MsgGUID: NFvu5yZ3SsGLI0U+5XMiFA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,316,1754982000"; 
   d="scan'208";a="222084274"
Received: from rvuia-mobl.ger.corp.intel.com (HELO localhost) ([10.245.245.245])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2025 11:47:26 -0800
Date: Wed, 19 Nov 2025 21:47:24 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, conor+dt@kernel.org,
	krzk+dt@kernel.org, linux-iio@vger.kernel.org, s32@nxp.com,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	chester62515@gmail.com, mbrugger@suse.com,
	ghennadi.procopciuc@oss.nxp.com, vkoul@kernel.org
Subject: Re: [PATCH v7 2/2] iio: adc: Add the NXP SAR ADC support for the
 s32g2/3 platforms
Message-ID: <aR4ezOOnBl6S6G2e@smile.fi.intel.com>
References: <20251119191545.46053-1-daniel.lezcano@linaro.org>
 <20251119191545.46053-3-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251119191545.46053-3-daniel.lezcano@linaro.org>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Nov 19, 2025 at 08:15:45PM +0100, Daniel Lezcano wrote:
> The NXP S32G2 and S32G3 platforms integrate a successive approximation
> register (SAR) ADC. Two instances are available, each providing 8
> multiplexed input channels with 12-bit resolution. The conversion rate
> is up to 1 Msps depending on the configuration and sampling window.
> 
> The SAR ADC supports raw, buffer, and trigger modes. It can operate
> in both single-shot and continuous conversion modes, with optional
> hardware triggering through the cross-trigger unit (CTU) or external
> events. An internal prescaler allows adjusting the sampling clock,
> while per-channel programmable sampling times provide fine-grained
> trade-offs between accuracy and latency. Automatic calibration is
> performed at probe time to minimize offset and gain errors.
> 
> All modes have been validated on the S32G274-RDB2 platform using an
> externally generated square wave captured by the ADC. Tests covered
> buffered streaming via IIO, trigger synchronization, and accuracy
> verification against a precision laboratory signal source.
> 
> One potential scenario, not detected during testing, is that in some
> corner cases the DMA may already have been armed for the next
> transfer, which can lead dmaengine_tx_status() to return an incorrect
> residue.  The callback_result() operation—intended to supply the
> residue directly and eliminate the need to call
> dmaengine_tx_status()—also does not work.  Attempting to use
> dmaengine_pause() and dmaengine_resume() to prevent the residue from
> being updated does not work either.
> 
> This potential scenario should apply to any driver using cyclic DMA.
> However, no current driver actually handles this case, and they all rely
> on the same acquisition routine (e.g., the STM32 implementation).
> The NXP SAR acquisition routine has been used in production for several
> years, which is a good indication of its robustness.
> 
> As the IIO is implementing the cyclic DMA support API, it is not worth
> to do more spins to the current routine as it will go away when the
> new API will be available.
> 
> The driver is derived from the BSP implementation and has been partly
> rewritten to comply with upstream requirements. For this reason, all
> contributors are listed as co-developers.

...contributors to the original code are...


This version is good enough, only a couple of nit-picks most important of which
is PM related macros usage.
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

...

> +static int nxp_sar_adc_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	const struct nxp_sar_adc_data *data = device_get_match_data(dev);
> +	struct nxp_sar_adc *info;
> +	struct iio_dev *indio_dev;
> +	struct resource *mem;
> +	int irq, ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*info));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	info = iio_priv(indio_dev);
> +	info->vref_mV = data->vref_mV;
> +	spin_lock_init(&info->lock);
> +	info->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &mem);
> +	if (IS_ERR(info->regs))
> +		return dev_err_probe(dev, PTR_ERR(info->regs),
> +				     "failed to get and remap resource");
> +
> +	info->regs_phys = mem->start;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;

> +	ret = devm_request_irq(dev, irq, nxp_sar_adc_isr, 0,
> +			       dev_name(dev), indio_dev);

At least dev_name(dev) can be placed on the previous line.

> +	if (ret < 0)
> +		return ret;
> +
> +	info->clk = devm_clk_get_enabled(dev, NULL);
> +	if (IS_ERR(info->clk))
> +		return dev_err_probe(dev, PTR_ERR(info->clk),
> +				     "failed to get the clock\n");
> +
> +	platform_set_drvdata(pdev, indio_dev);
> +
> +	init_completion(&info->completion);
> +
> +	indio_dev->name = data->model;
> +	indio_dev->info = &nxp_sar_adc_iio_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE | INDIO_BUFFER_SOFTWARE;
> +	indio_dev->channels = nxp_sar_adc_iio_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(nxp_sar_adc_iio_channels);
> +
> +	nxp_sar_adc_set_default_values(info);
> +
> +	ret = nxp_sar_adc_calibration(info);
> +	if (ret)
> +		dev_err_probe(dev, ret, "Calibration failed\n");

Some of the messages started with capital letter, some with a small. Please,
make them consistent with whatever style you choose.

> +	ret = nxp_sar_adc_dma_probe(dev, info);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to initialize the dma\n");

DMA

> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      &iio_pollfunc_store_time,
> +					      &nxp_sar_adc_trigger_handler,
> +					      &iio_triggered_buffer_setup_ops);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Couldn't initialise the buffer\n");
> +
> +	ret = devm_iio_device_register(dev, indio_dev);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Couldn't register the device\n");
> +
> +	return 0;
> +}

...

> +static SIMPLE_DEV_PM_OPS(nxp_sar_adc_pm_ops, nxp_sar_adc_suspend, nxp_sar_adc_resume);

include/linux/pm.h:

/* Deprecated. Use DEFINE_SIMPLE_DEV_PM_OPS() instead. */

...

> +static struct platform_driver nxp_sar_adc_driver = {
> +	.probe = nxp_sar_adc_probe,
> +	.driver = {
> +		.name = "nxp-sar-adc",
> +		.of_match_table = nxp_sar_adc_match,
> +		.pm = pm_ptr(&nxp_sar_adc_pm_ops),

Shouldn't this be pm_sleep_ptr()?

> +	},
> +};

-- 
With Best Regards,
Andy Shevchenko



