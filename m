Return-Path: <linux-iio+bounces-27735-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D48D1D9FB
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38F12302B523
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89229387577;
	Wed, 14 Jan 2026 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FyYyp1k0"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF90A38944F;
	Wed, 14 Jan 2026 09:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768383648; cv=none; b=lf59iec9CcSbi1nuK4P1FIVm2VvfvowFQ74FYPPLladQmpsMJBaxXrzOEdctoO8wUGr4843kuPHtWPh6p4zIrgeJLas8Zl9elRciyS7uCO0vLRcR2lzSyWx0khQGqKmofaidRcJqmaNPaZFILuRWJuo+Mi9wQecYBJWeM19STEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768383648; c=relaxed/simple;
	bh=1qCJbDf3LNBQnokPmnk8fcBE3EDda534imX16lpluf8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LKRJgdUMJxFzQa2hLJeSyKykASlNfuV85pxr0kMiyHlEzdvjKSUEQuVb4azfa3gOadHErVrVIfjETQK2tecnUlQD8ZZsG5DiGaPK1J/MauSIj7CQ9nT7dpk0Lj/ajpM7eehqfZBGFo7MB0hDVX5UJquiGsQvxgkh21qnNCaPRR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FyYyp1k0; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768383647; x=1799919647;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1qCJbDf3LNBQnokPmnk8fcBE3EDda534imX16lpluf8=;
  b=FyYyp1k0nK0l1VMNxfYh+LPufx7wPmQTjpAohcUDYMAnDEG52x92O1TL
   +H2LdgrTQHIaoYjkKhuTYHl4ms4+xvVUf2kA66I9r7MdxhG/5aLAfGd9C
   R85fluXakBs0k+BDJ1rxrDzGxjzw/ABqn+w1hPB07tgQtrSGjbQfTvD+m
   rFjWZJhGgTs7w8z8vW8hH1oWcaX1tSO+Rxt+L1Gzkhnmxw6J/a/tKf/rs
   K+7F4Mz7YfxQmYUa9XkUUksdaGwdu1402QnrNXKx7ukMjeLJysdeuxqLj
   tQtI8VinDoyphpIzboeJQ2JzCTTLqnfEt0ziIZKipUWOOKslt3z5Q1sVD
   w==;
X-CSE-ConnectionGUID: Osp62IS2QFekKapWdr4kyw==
X-CSE-MsgGUID: 5B5h+8mCQuSx4xCYdnjFZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="87259328"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="87259328"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:40:46 -0800
X-CSE-ConnectionGUID: mw6jqSNOTz6KKRVCXQZMUg==
X-CSE-MsgGUID: HUqMSmL5QUeIkI8VEWpavw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="209478599"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:40:40 -0800
Date: Wed, 14 Jan 2026 11:40:38 +0200
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
Message-ID: <aWdklo0u1g0oHn3z@smile.fi.intel.com>
References: <20260114083957.9945-1-angelogioacchino.delregno@collabora.com>
 <20260114083957.9945-8-angelogioacchino.delregno@collabora.com>
 <aWdbB4vJ6Z8k0g4s@smile.fi.intel.com>
 <8f5c79e0-5f7e-4fe4-b9d7-60375e779892@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f5c79e0-5f7e-4fe4-b9d7-60375e779892@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 10:26:42AM +0100, AngeloGioacchino Del Regno wrote:
> Il 14/01/26 09:59, Andy Shevchenko ha scritto:
> > On Wed, Jan 14, 2026 at 09:39:54AM +0100, AngeloGioacchino Del Regno wrote:

...

> > > +	struct regmap_config eusb2_regmap_config = {
> > > +		.reg_bits = 16,
> > > +		.val_bits = 8,
> > > +		.max_register = 0x100,
> > > +		.fast_io = true,
> > > +	};
> > 
> > This is third time of the same. Make it part of SPMI core and export to
> > the users. Or are they semantically different like different slices?
> > In that case you can export it under generic name like
> > 
> > 	spmi_default_slice_regmap_config
> 
> There are more complicated devices around that I didn't port to the new
> spmi subdevices, and I really don't want to make a default for now.
> 
> At least some of those need different params (including some MediaTek ones
> that are not upstream yet).
> 
> Can we please let this in and *then* see how much can be commonized after
> the majority of more complicated drivers are migrated in the future?

Sure, but it looks like a pattern currently...

-- 
With Best Regards,
Andy Shevchenko



