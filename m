Return-Path: <linux-iio+bounces-20887-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB725AE364B
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 08:52:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 581B01892C6A
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 06:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273461F416B;
	Mon, 23 Jun 2025 06:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XNPOTc5w"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50EFDBA2E;
	Mon, 23 Jun 2025 06:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750661505; cv=none; b=ZzeAalv0dpcGVFFkpy5n2RDEOKB2OMCgyKDVjrahkc/c0UxAUyuia+5lZ8dupIzHgiqkV3IZBIZY60QzgnPq5LkZcnKcVF+NxDHkBJr7W5MzSXqDIiDGYdGz1pR+W4bLbOfot9kSsAlHyh82N1edIoxWZSD5i9P7IfTYixX27u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750661505; c=relaxed/simple;
	bh=BfCjIpMptWB6njP/yypWFTaa8isoACoKePFM94OtggE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcvL1Rmdqc2Zhl4QiAJMIPCYSz42nP6FniIiVZTsguRFSlf506Oo7Zv5yhtC3OML+RYj57xnvGVQafMBg45m59Jtj6NwC6wFYOGG8Suqoxj/IKGkmk4NgDrAPsw6hgqKjj2fAJ0WE2B/wWoxW8tRcaEJtt37DQryeRzZI9RzAUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XNPOTc5w; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750661505; x=1782197505;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BfCjIpMptWB6njP/yypWFTaa8isoACoKePFM94OtggE=;
  b=XNPOTc5wMEonmcv9AlvMX3Yeop96sjCUkJWDGKJFmyuFQr6VVu2jT2Lf
   yHm9X3gYaZ3HX5Tx/NatUuBP8LIexbUSQf6SEYIxmU933iV0rdKgPUOu1
   GSxa1NlZ2MaP2EcdDmOrH0+0+1DYa56E6IO/1rpxt/RoZfjBQoeoSwZlH
   PwBVY6l9W4unMGpyzhAWahUngsHp9Ehetrdr0T0EP5taqoGMSFZT3T2bz
   btv01JXZJHJVzEnaWfs45CR30VhUhN47VUIG80Uqc7OXEhNQGeznc/znl
   d4RJOCkEySgHK5Jpv9gstv6eW5TjXBcG6ptnyFWJ5Gz9vV7QRamBCALOp
   A==;
X-CSE-ConnectionGUID: QfDt6B47T4CAgrsKIEHS6Q==
X-CSE-MsgGUID: EAhzDa+nROSuvjD3R3H+nA==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="52722374"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="52722374"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 23:51:44 -0700
X-CSE-ConnectionGUID: bvMYzSWRRf+P8QJ+/9HKvA==
X-CSE-MsgGUID: B5I016lYSpyUI8zT8Y0hMA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="151656980"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2025 23:51:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTb1k-000000095TZ-4BkS;
	Mon, 23 Jun 2025 09:51:37 +0300
Date: Mon, 23 Jun 2025 09:51:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Mark Brown <broonie@kernel.org>,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, linux-spi@vger.kernel.org
Subject: Re: [PATCH 2/9] iio: adc: ad_sigma_delta: use u8 instead of uint8_t
Message-ID: <aFj5eEvn2uw_HSl0@smile.fi.intel.com>
References: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-0-0766f6297430@baylibre.com>
 <20250620-iio-adc-ad7173-add-spi-offload-support-v1-2-0766f6297430@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250620-iio-adc-ad7173-add-spi-offload-support-v1-2-0766f6297430@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 20, 2025 at 05:20:08PM -0500, David Lechner wrote:
> Replace uint8_t with u8 in the ad_sigma_delta driver.
> 
> Technically, uint8_t comes from the C standard library, while u8 is a
> Linux kernel type. Since we don't use the C standard library in the
> kernel, we should use the kernel types instead.

...

>  	unsigned int reset_length = sigma_delta->info->num_resetclks;
> -	uint8_t *buf;
> +	u8 *buf;
>  	unsigned int size;
>  	int ret;

Wondering if in the cases like this we may make it to be reversed xmas tree.

	unsigned int reset_length = sigma_delta->info->num_resetclks;
	unsigned int size;
	u8 *buf;
	int ret;

-- 
With Best Regards,
Andy Shevchenko



