Return-Path: <linux-iio+bounces-21309-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDBDAF7784
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 16:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B9324A763A
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 14:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B7E02ECD28;
	Thu,  3 Jul 2025 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dW56HGTZ"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1A42ECD00;
	Thu,  3 Jul 2025 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751553027; cv=none; b=LqWndMFYcIyaM0hwaehJPD0YeGEzCuiEE7hWQ4S69YoZapdpquwihYfbdO/4eC1nstbDd5V84VcpFl9XPzBbUj+TpDcUyhrr9FhBrD3GoMHg16hvzKmBtckoI9h+AQT2Mo8FR407eyead9ki1gN8vbzc5lyBRlJbacYjvpsa4Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751553027; c=relaxed/simple;
	bh=+7Tp7mxCk+lHbCkMLaMMOj3pQFJ6m6rrmptwiX2ag3U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qv/5MHWM2L1XoVahDLhi9HivPvWDN0kqSm2nrl3NHRUZGhf4GV2Rr7aHDDIhV6G7GrzxTgMgswcBMn0kQ9YwGEcOLCitwoaV2Fp3AxFRzq72bluXua6TmoD0o2qmmXKGH6z9KYBhXD701irQEgM20T6jTnEwpLntPPOSnSOQjgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dW56HGTZ; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751553027; x=1783089027;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+7Tp7mxCk+lHbCkMLaMMOj3pQFJ6m6rrmptwiX2ag3U=;
  b=dW56HGTZ7iaK69xQE7qGRhGbygNNJKPeHHfHb5YF+fSTv97sEES7oYAC
   4Gi/l8Yx1weU6N8eoYm87H2kkU4hEa2v6ZKeqtM+OXhIgCJcsc86cIT3z
   vPVVsduQ2D6SHfJrAn9ZuCjbGnvnY+n8o2Tcxe1gA83ifnfge3ep/Uf+W
   H5Z6t6cbagU4ERV6rjLPE0niyhm74JALmSF5zbOs8I6pTmSSzlNJB9RVF
   HWfk9/kdyOVhkRnUvzXFXRb1qa7xoHQbDlgzot3RwG4wVKN1abM5sWE3C
   xvpNLPPCZMwC6RfcrxSDEo1yj8TVzvVSZ6iydXHyduX4lTrnYna15swMr
   w==;
X-CSE-ConnectionGUID: lrcFAdRjSCix9/r5XkJk6Q==
X-CSE-MsgGUID: 5265kkMwSImNT0BEPfawGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="79319355"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="79319355"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:30:26 -0700
X-CSE-ConnectionGUID: eA+mFOxLQj+7OWl0Mm1sDw==
X-CSE-MsgGUID: pF6OSx0VSE+KewFcfBhPTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="153814024"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:30:22 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uXKx8-0000000CEAh-3598;
	Thu, 03 Jul 2025 17:30:18 +0300
Date: Thu, 3 Jul 2025 17:30:18 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, matthias.bgg@gmail.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH v2 0/6] iio: Add support for MT6363/6373 Auxiliary ADC
Message-ID: <aGaT-rSmUoukjvR7@smile.fi.intel.com>
References: <20250703141146.171431-1-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250703141146.171431-1-angelogioacchino.delregno@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Jul 03, 2025 at 04:11:40PM +0200, AngeloGioacchino Del Regno wrote:
> Changes in v2:
>  - Added error checks to all regmap r/w operations
>  - Moved adc_vref addition to different commit
>  - Various other fixes
> 
> This series adds support for the Auxiliary ADC IP found on the new
> MediaTek MT6363 and MT6373 PMICs, found on board designs featuring
> the MT8196 Chromebook SoC or the MT6991 Dimensity 9400 Smartphone SoC.

Overall LGTM, but one nit-pick in one patch.

-- 
With Best Regards,
Andy Shevchenko



