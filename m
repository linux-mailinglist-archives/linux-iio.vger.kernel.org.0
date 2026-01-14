Return-Path: <linux-iio+bounces-27718-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF425D1D667
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A8C633015A5C
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853B5387349;
	Wed, 14 Jan 2026 09:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BGY8irHN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E20381711;
	Wed, 14 Jan 2026 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381656; cv=none; b=LZ6vvZD4rHTal7npAYMKQvxcyaOOxNV4a++APTQGPQVmdy3B2bhFc8VbiS3Mbit+suteQuW91YJ8zYAy0wpkZh8MWpwzsq4XDO7DfH1SaxXKio4a+pjxJz6jrDOdml95mDbqMoIGNVyoMrGwbpfNcjDMNsqJmEIqeK3/6V1UQbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381656; c=relaxed/simple;
	bh=1DosfIvkwmLXhLuyIUk1njEDi+VFcxY+Fb3zWtz4sZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bYzeMdZlX4vk/SY6e+Cuqvo/ZBinKOz4xCWfA7znonqrkT8rybQsqi8rPzWnG54YoUSXXyVNNkCL2yjApkSHB32/IYAy5QuMl6P1SzgJfMfWguEP5GfeTTBO5Z0TG91ZzcJaa8Dd70C4Bws0YB3DN7/2Mly66C7hIHM2rocfRCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BGY8irHN; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768381655; x=1799917655;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1DosfIvkwmLXhLuyIUk1njEDi+VFcxY+Fb3zWtz4sZk=;
  b=BGY8irHN9NStYDJtLEJo6VCIfjYvBbvJyt73FsSrEDadH/9l9+iaDLY4
   oH1e+A0UuoyO5VyMQBtcBeqirybrjrCkbWAlH/3yB/uM2raNqjXGhWDbe
   l93pQarnJ1vSU1CiBl/UFl6Pb+PAY4aIoOG90mvfgAb8aLxOkN/e2pgc7
   xxZ4zeZr2IUqwwqQhvsO14bHbwGmPSLdbVzjhgppsYl7av0oRBIgPXu+o
   he7QTQj3L0Vz2/+c/vqQ3o2DkzGSHd0EIOljjZFChI1bJyxU8Tvx2gdii
   zglSTjYIIopRfD9IyvZaPUjOmwQYrh2bXlbSwb3Hz1Pv7gI8CIAnZ5pTz
   Q==;
X-CSE-ConnectionGUID: /MKqCQ/iRkqV9N/MiWPGEQ==
X-CSE-MsgGUID: Q+isdxqNTDWK8D10cto6XA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="57232150"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="57232150"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:07:32 -0800
X-CSE-ConnectionGUID: p8RI8YcZQbCm1JTFWd5JJQ==
X-CSE-MsgGUID: a54m11ipThy3MmcUB72/6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="204683302"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:07:25 -0800
Date: Wed, 14 Jan 2026 11:07:23 +0200
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
Message-ID: <aWdcy2ouQHtkPd6q@smile.fi.intel.com>
References: <20260114083957.9945-1-angelogioacchino.delregno@collabora.com>
 <20260114083957.9945-6-angelogioacchino.delregno@collabora.com>
 <aWdaWY2tWUMllOHH@smile.fi.intel.com>
 <8bf79979-0946-4ed9-b8d4-c442a6e54833@collabora.com>
 <aWdbPze-f_2_5EbL@smile.fi.intel.com>
 <401c5e7b-ff33-44e8-98a5-8cc6af4f2a87@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <401c5e7b-ff33-44e8-98a5-8cc6af4f2a87@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 10:03:57AM +0100, AngeloGioacchino Del Regno wrote:
> Il 14/01/26 10:00, Andy Shevchenko ha scritto:
> > On Wed, Jan 14, 2026 at 09:59:40AM +0100, AngeloGioacchino Del Regno wrote:
> > > Il 14/01/26 09:56, Andy Shevchenko ha scritto:
> > > > On Wed, Jan 14, 2026 at 09:39:52AM +0100, AngeloGioacchino Del Regno wrote:

...

> > > > > +	struct regmap_config sdam_regmap_config = {
> > > > > +		.reg_bits = 16,
> > > > > +		.val_bits = 8,
> > > > 
> > > > > +		.max_register = 0x100,
> > > > 
> > > > Are you sure? This might be a bad naming, but here max == the last accessible.
> > > > I bet it has to be 0xff (but since the address is 16-bit it might be actually
> > > > 257 registers, but sounds very weird).
> > > 
> > > Yes, I'm sure.
> > 
> > So, what is resided on address 0x100 ?
> 
> I don't remember, this is research from around 5 months ago, when I've sent
> the v1 of this.
> 
> If you really want though, I can incorrectly set max_register to 0xff.

Why incorrectly? Can you dig into the datasheet and check, please? We don't
know what is the 0x100 address means.

> > > > > +		.fast_io = true,
> > > > > +	};

-- 
With Best Regards,
Andy Shevchenko



