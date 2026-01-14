Return-Path: <linux-iio+bounces-27737-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C5AA7D1DABA
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 10:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BF5FB304C64F
	for <lists+linux-iio@lfdr.de>; Wed, 14 Jan 2026 09:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B733E389E12;
	Wed, 14 Jan 2026 09:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DvYV7qVI"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9AC37F8BC;
	Wed, 14 Jan 2026 09:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768383832; cv=none; b=KrvKuiMe0/PfTpi/XyXJ26jn+TREWBeB14xNFDmhjRhnDaBBstgZl2P3jVgIWmo1Cmg0A97QFEQqgkASSnTAsoEzov6w3gflN4nCSm9pMNnktlSJZ7/KuVgPGjFfZ1rjVFp3K52mLMW+9Pg21UhdwjdDRFl1mRuTZwTvptUyvUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768383832; c=relaxed/simple;
	bh=L9IhLHxjWYeBsO8OEGHzLOjllo7uXiWf/O2foAudpdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FRG2G9N1mYNBqebzZkQn1WpGWgjBwNygbZs/9Pv+KAtCYsbMbhCQhIPJtFeSuq1JjCdgv8Dj8kNED1OUZynnzGReyhx0iAqx/a24io+CzMwtyHGnGSOMwfn2vQeY+yBfG707zAefu7PTO9F75a9BjGUY6N4EJroUV8JF4LXZPUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DvYV7qVI; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768383832; x=1799919832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L9IhLHxjWYeBsO8OEGHzLOjllo7uXiWf/O2foAudpdU=;
  b=DvYV7qVILlZ99W1Deb2+ZApCMXxR7kfCVqAhArJoY29KZPsfND7PyYCO
   10KUlOJSWid/dvcGUWYfyyPa1sRfjiI0cR7pRa1NHbyMcxxeQEIFPAVoe
   xNYW0H+s6kJWPaf1QaGcmqqbC+c1AZTLkzBYjaTyUJmXqYDh23zAmCQjH
   r2Wj7jA5w6Gfa19JfsaeT5O/0ey0K8jUXYX5jAOmxHuKT1UKzXw/hs8BB
   x7zXx3HQrNYvVUi297K7FssGcXpu8MuiOWJx8ytkIrlZkbsrVVpw6zcZn
   8J2rf7+CzPPoCOjv19M5PMYV0M6G6HpETuB1lM5zT/kHp593n+L3LZT/s
   g==;
X-CSE-ConnectionGUID: rkROO7I6Qi6slsB7wowmqg==
X-CSE-MsgGUID: FMQiIosKSn2n1VBUWrYBuA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="73315011"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="73315011"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:43:47 -0800
X-CSE-ConnectionGUID: It0L+crLSkulcHNBCOzdMA==
X-CSE-MsgGUID: 67kHELfRTT2+AF40OL6r3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="209092335"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.244.83])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 01:43:40 -0800
Date: Wed, 14 Jan 2026 11:43:38 +0200
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
Subject: Re: [PATCH v8 00/10] SPMI: Implement sub-devices and migrate drivers
Message-ID: <aWdlSlI85ro7SbJv@smile.fi.intel.com>
References: <20260114092742.13231-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260114092742.13231-1-angelogioacchino.delregno@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jan 14, 2026 at 10:27:32AM +0100, AngeloGioacchino Del Regno wrote:
> Changes in v8:
>  - Renamed *res to *sub_sdev in devm_spmi_subdevice_remove() (Andy)
>  - Changed kerneldoc wording to "error pointer" for function
>    spmi_subdevice_alloc_and_add() (Andy)
>  - Shuffled around some assignments in spmi_subdevice_alloc_and_add() (Andy)
>  - Used device_property_read_u32() instead of of_property_read_u32()
>    in all of the migrated drivers (Andy)
>  - Changed .max_register field in all of the migrated drivers from
>    0x100 to 0xff (Andy)
>  - Kept `sta1` declaration in reversed xmas tree order in function
>    iadc_poll_wait_eoc() of qcom-spmi-iadc.c (Andy)

Thanks, in principle I'm okay with this version, but it would be nice to have
clarification on the max_register for sure (it doesn't prevent the series from
being applied).

-- 
With Best Regards,
Andy Shevchenko



