Return-Path: <linux-iio+bounces-27713-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94A55D1D6F1
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C916130F0A9A
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF16937BE98;
	Wed, 14 Jan 2026 09:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kjHrXr6m"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370693126C2;
	Wed, 14 Jan 2026 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768381424; cv=none; b=k8MoROuWe819S4rEV620wF06yv71kKfKiAAYVvPvZBfO1fXrYA4dRcAUPBlmjbz68+gur8V15ovFbNofu7TlDxNssqJfNaDwNsCQ8mxbl2L/n0zvmSBIPNxKnXCesXxLYH43cURP0VFGxW6Rxq76CdKjXGk5BBtcT6BSD3ebGQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768381424; c=relaxed/simple;
	bh=fTUTpLyogUFStiXKIz6Fjo+kQnm2xvkbAn0exgqftAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AO50tJurugoU++Jj0oB4LpTY1eexblqS1a8dxnGh2EzpNchWUeeWXDkEI/ePYTVdiYQmtpwPX1l2HBoe+cO1Y5V/4DOiIxwd9m0QJujknewoABIcI+Gmuw21zqCyUlUd5KVz4GQIbG4iAfgw17Eyt37w/SsSXXnMsYREbLvlYgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kjHrXr6m; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768381423; x=1799917423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fTUTpLyogUFStiXKIz6Fjo+kQnm2xvkbAn0exgqftAs=;
  b=kjHrXr6mZio+JQDV4Vi2Ysnfr3RbN8zXomrs+Xy5Qzg4dttRHYC4Apom
   zs5nfJ+aWRvKE0AVUphyyc3vG4l09LObdK7t3kKMt74w6YZeuwtkGUB8t
   z9oldihywaLSf3BKDT6aY8TGehJjCoy3vU6vFvaHGWOVDBd54Ld6hlpAC
   LsBiwKy5/xe9/gJVqLtsJDxyZWyLZFOA7TH2DdeYoX/c0/LdRnwtvtIss
   TRNF8SeMuZLTOLxhwk1XYKEEFGaY2I/sKrNqyI3ct3hW+LTHwbICDQDJB
   te745VjlRmHwiliDm9uMQ34gU1v/L6i3D6fzK/fUuHaY2IROiyoErSXwu
   w==;
X-CSE-ConnectionGUID: ewbO/UMHRCGIXvzpfj7fIQ==
X-CSE-MsgGUID: 5vjCxAjtTuiw0K+TdgbJDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="95151841"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="95151841"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:03:42 -0800
X-CSE-ConnectionGUID: jGJ3Vz1DT82KoBTjR/uURA==
X-CSE-MsgGUID: IKQGulzRQV60LuTBHMOxsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="208777513"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:03:35 -0800
Date: Wed, 14 Jan 2026 11:03:33 +0200
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
Subject: Re: [PATCH v7 10/10] iio: adc: qcom-spmi-iadc: Remove regmap R/W
 wrapper functions
Message-ID: <aWdb5FQpodBLZLHY@smile.fi.intel.com>
References: <20260114083957.9945-1-angelogioacchino.delregno@collabora.com>
 <20260114083957.9945-11-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114083957.9945-11-angelogioacchino.delregno@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 09:39:57AM +0100, AngeloGioacchino Del Regno wrote:
> This driver doesn't need to add any register base address to any
> regmap call anymore since it was migrated to register as a SPMI
> subdevice with its own regmap reg_base, which makes the regmap
> API to automatically add such base address internally.
> 
> Since the iadc_{read,write,read_result}() functions now only do
> call regmap_{read,write,bulk_read}() and nothing else, simplify
> the driver by removing them and by calling regmap APIs directly.

...

>  {
>  	unsigned int count, retry;
>  	int ret;
> -	u8 sta1;
> +	u32 sta1;

Keep it in reversed xmas tree order.

>  	retry = interval_us / IADC_CONV_TIME_MIN_US;

-- 
With Best Regards,
Andy Shevchenko



