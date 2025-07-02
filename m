Return-Path: <linux-iio+bounces-21227-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F9AAF0D74
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 10:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A5371C240D6
	for <lists+linux-iio@lfdr.de>; Wed,  2 Jul 2025 08:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13497231A3F;
	Wed,  2 Jul 2025 08:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cM49nz4T"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5D7137923;
	Wed,  2 Jul 2025 08:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751443496; cv=none; b=HRVIFZoEBhhfY8tQEISLFOIIVZlT2aV3RznnqFFPyyeLJiOBBYssg4Yub2W970akvZwVAz2bllGradTFRg9yslz75ChgR5aPgXBUtodMJO4CF7pxgelF3GvobByWvjIg0FT/0xewKCA7GNEsqxEflbawtX9ufsAYuvWhQRoDl/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751443496; c=relaxed/simple;
	bh=l0pSZlRPG8LstMnELObDfWKePkirOAxhEP7OlBTiROU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bRFRLg1eH/Jym3et1O/TXWijKNa8YyKlhry77y3fmv5x80fXgWYMFr5cprQ+88vYmk77ZYtaDTXIDix9NxwBtQyW2jBcQnT2BWc/IgTJkaj6inGfWq96QiZMzysnZNF3gmEEyTvFadOqTg6jWD77Mn3w8TtAEMDIFs8y+YiBq8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cM49nz4T; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751443495; x=1782979495;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=l0pSZlRPG8LstMnELObDfWKePkirOAxhEP7OlBTiROU=;
  b=cM49nz4TBTComOWsfLgZfKYPbq8Gd0mwC6WIw6UFT+wwbWjL0MApbrWB
   T3/PP8yng5/OSEvDerrVnnf+c7m81SaiUC4iKTU8y1TQQEMOdaxTK+Uw4
   t+qmtOxvBc5YX91KVsvcv2C5ig6Png8iqMd7hEjQMwOPqIyeWvWQ2EHik
   7OgqHQIAz+ShPiHQG+jcmhD1f8s2lhjGdUdd3GytfWzVE/WuUTF2RBlFT
   lrhyMnQ37QJ/JCOOjouwb5LLFkx3WZ9Qy09mwavpzIdxDTkdvcjm/aLH5
   CWfb4F6QmHV0n67KP3+iH/QTLsZlkdJ420N1Ps5xDwnzPF9J30GEegVld
   w==;
X-CSE-ConnectionGUID: jLaDj3QgSPKpONs/K6xi7w==
X-CSE-MsgGUID: zEu/3CbLRgSKr2oIWkYOMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="57536231"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="57536231"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 01:04:54 -0700
X-CSE-ConnectionGUID: ZjpuVCdBQyWgkIfdFROO8Q==
X-CSE-MsgGUID: 9nb3zhAlSeq/KFRxve4Q5Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="154556266"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 01:04:51 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWsSW-0000000BrMJ-28tk;
	Wed, 02 Jul 2025 11:04:48 +0300
Date: Wed, 2 Jul 2025 11:04:48 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH v3 00/12] iio: adc: ad7173: add SPI offload support
Message-ID: <aGToIInJLMHmB4ay@smile.fi.intel.com>
References: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250701-iio-adc-ad7173-add-spi-offload-support-v3-0-42abb83e3dac@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 01, 2025 at 04:37:48PM -0500, David Lechner wrote:
> Here comes another series for adding SPI offload support to an ADC.
> 
> The primary target is AD411x, but since this uses the ad_sigma_delta
> shared module, a lot of this series is focused on that.
> 
> To start with, we have some cleanups to the ad_sigma_delta code, so feel
> free to pick these up as they are ready as they generally stand on their
> own.
> 
> Then before adding proper SPI offload support, we make use of
> spi_optimize_message() to reduce CPU usage of all users of this driver
> during buffered reads.
> 
> Also there is a new dt-binding and driver for a special SPI offload
> trigger FPGA IP core that is used in this particular setup.
> 
> Then finally actual SPI offload support is added to the ad_sigma_delta
> module and the ad7173 driver.
> 
> This was tested using EVAL-AD4112ARDZ on a DE10-Nano.

This version LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko



