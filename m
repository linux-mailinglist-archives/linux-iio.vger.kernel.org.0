Return-Path: <linux-iio+bounces-18894-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F70AA4BFA
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 14:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36F11C04F77
	for <lists+linux-iio@lfdr.de>; Wed, 30 Apr 2025 12:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567D72609CC;
	Wed, 30 Apr 2025 12:50:20 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41CC25FA05;
	Wed, 30 Apr 2025 12:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017420; cv=none; b=AJseDSaTPoGKcQLZcKsluYMFrrGiRkYTPtRyw2Vd7YukWXGWx8d4HTr5p2s575IllRy0x1tBwG/HDmrhLYH7p6bMYjvowHNSzGzfBHIeGyhqslmgj4jnpzJD8JPdrzxdiQLWnTd2OMtFyVGP+vc2Byq4osjiuVJTSSNSe1ZIPAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017420; c=relaxed/simple;
	bh=H+F+iZGjlbbIkM3rFYJt2hSRzsOvxDRzjzpcnjl8hbI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpIw5OSap6MyWq9vUJklvIA8XRWWGQPP6ByD145/8yE8KW9km9nbuIsKDmqJVRkJywhhIH7BA5vO4+klI1vcJX/WvuOeg+ptIAfGbQEKO0qH1kkeq/VFGjnTgWKkYl8oUMbcYcccYvzm1GUD1UOvy+9NPFb36mrzUsUKh+atJug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=fail smtp.mailfrom=kernel.org; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=kernel.org
X-CSE-ConnectionGUID: HnMxuA0aTM2oYf6FPnpYDQ==
X-CSE-MsgGUID: jHfQWFxjRDGExErvaiCd/w==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="59050290"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="59050290"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:50:19 -0700
X-CSE-ConnectionGUID: VzAt0l1ET1yJCUQ0lnI/ug==
X-CSE-MsgGUID: Vsmx34vWTGOiG6B4Gi4dVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="135054432"
Received: from smile.fi.intel.com ([10.237.72.55])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:50:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy@kernel.org>)
	id 1uA6tA-00000001d25-0NSD;
	Wed, 30 Apr 2025 15:50:12 +0300
Date: Wed, 30 Apr 2025 15:50:11 +0300
From: Andy Shevchenko <andy@kernel.org>
To: Angelo Dureghello <adureghello@baylibre.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] iio: adc: ad7606: add offset and phase calibration
 support
Message-ID: <aBIcgxcUHXRpd882@smile.fi.intel.com>
References: <20250429-wip-bl-ad7606-calibration-v1-0-eb4d4821b172@baylibre.com>
 <20250429-wip-bl-ad7606-calibration-v1-3-eb4d4821b172@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429-wip-bl-ad7606-calibration-v1-3-eb4d4821b172@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Apr 29, 2025 at 03:06:47PM +0200, Angelo Dureghello wrote:
> From: Angelo Dureghello <adureghello@baylibre.com>
> 
> Add support for offset and phase calibration, only for
> devices that support software mode, that are:
> 
> ad7606b
> ad7606c-16
> ad7606c-18

...

> +	if (val2 < start_ns || val2 > stop_ns)
> +			return -EINVAL;

Wrong indentation.

-- 
With Best Regards,
Andy Shevchenko



