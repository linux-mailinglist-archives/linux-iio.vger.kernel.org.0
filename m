Return-Path: <linux-iio+bounces-27716-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F1BD1D619
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E2F853029FA1
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93776387366;
	Wed, 14 Jan 2026 09:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WA6usuek"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CACD30E82B;
	Wed, 14 Jan 2026 09:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381564; cv=none; b=G3FRtpc4HrJnOv7G+yTfst8Ju43VvHy2sNZW42XWltFzWLMh1ctPTTd6VLdKBzmSeOuUO1LBmhhztEjphduQFTBgTUsRoDEc2ltH6wFgqy6qMt3rq7BBp8p8+gYoNNsIid61/kFpld9TP3vtMRkf8SNNda9UCN7gm0EzUa7xJik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381564; c=relaxed/simple;
	bh=z8JMD/67eqjZ9kzPMFeujRha7sVyRHasdTbZAjbLZ7k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t4i78nAS1N6fB0pXqJL2h4oZd9QJke3awtqGPxXieVlgZMILB9dtoIXM8TD35lAEQqUcVW09AcclWG1iyOpjyBmyxVcAAYXs9voAd0HCCUqV+TLfleEThRaxjgkBkG6zt9L+fYaVqmELcHTnwZmqNz6DRU9klliqD1hwIeGskyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WA6usuek; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768381562; x=1799917562;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z8JMD/67eqjZ9kzPMFeujRha7sVyRHasdTbZAjbLZ7k=;
  b=WA6usuekNcVf+M95KUV0pBSAgFxkbAq1bdoYqi8+Auw2Fx6vLeZvaQSq
   ohjjGuweKWQE7C6Wh7wlw3kt3cxhj+7vi66p90kFhtgdPq7gjIKHasp0L
   MlhqAYPXbgsCAgsO/U0pGf3IdKQE3axKEiFqye99YObLPdM/xvnQjoj++
   kkVrj+RcA7BvGiz06/OxBRFSx6R92hWhQigY1AUTCAL/NInyS9khbEP7g
   125mwwgfVVm8yjExB7+rbt2Ium3lUZgkesO0SR6enjmwEnBa379arnSqg
   4jz7rQuJ6hDsA7dD5bGQrNq3KE9Ea9iwruqj5U0W6KDO8/0/8fjsDtwS3
   g==;
X-CSE-ConnectionGUID: yp+yI/KyQg+5vHQYziEIBA==
X-CSE-MsgGUID: HMzCftw/SJSOtLaebODYHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69728881"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="69728881"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:06:01 -0800
X-CSE-ConnectionGUID: pRSBKz3ySZGVDB6pBJwWiQ==
X-CSE-MsgGUID: pHSYxn8WS/KQJ7fkbYseMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="209674205"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:05:55 -0800
Date: Wed, 14 Jan 2026 11:05:51 +0200
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
	Jonathan Cameron <jonathan.cameron@huawei.com>
Subject: Re: [PATCH v7 09/10] iio: adc: qcom-spmi-iadc: Migrate to
 devm_spmi_subdevice_alloc_and_add()
Message-ID: <aWdcb9bTLJqhZ4Bf@smile.fi.intel.com>
References: <20260114083957.9945-1-angelogioacchino.delregno@collabora.com>
 <20260114083957.9945-10-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114083957.9945-10-angelogioacchino.delregno@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 09:39:56AM +0100, AngeloGioacchino Del Regno wrote:
> Some Qualcomm PMICs integrate an Current ADC device, reachable
> in a specific address range over SPMI.
> 
> Instead of using the parent SPMI device (the main PMIC) as a kind
> of syscon in this driver, register a new SPMI sub-device and
> initialize its own regmap with this sub-device's specific base
> address, retrieved from the devicetree.
> 
> This allows to stop manually adding the register base address to
> every R/W call in this driver, as this can be, and is now, handled
> by the regmap API instead.

> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on SM8650-QRD

I see these tags, but just again pointing out that max_register in regmap !=
MAX! It's MAX - 1, i.e. the last *accessible* register. So, I find personally
weird the configurations which has 257 registers instead of 256.

This can be easily checked when dumping register contents via debugfs.

Plus the same comments applies here as I gave previously.


-- 
With Best Regards,
Andy Shevchenko



