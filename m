Return-Path: <linux-iio+bounces-26132-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 949BCC46B77
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 13:54:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67EAE188544F
	for <lists+linux-iio@lfdr.de>; Mon, 10 Nov 2025 12:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72E4930F54C;
	Mon, 10 Nov 2025 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="O9NW65S6"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0CF28B415;
	Mon, 10 Nov 2025 12:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762779251; cv=none; b=h+34IX9hiVbILFePHUBGR/nuhbcHLK9YimaMZhj5zT/QO8zvfQ9gNsRiFDFf2Fx9B7UBT0zY1QPIbvFd8Ve76rEr9ZJ47KlAXZwWPIth9vnpobzmIWIbeKyNftNO80SA6Yt5mnPJpPvNGqICd2vdfsh4Y34Xvr4hE8HSRpQkn3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762779251; c=relaxed/simple;
	bh=Z/w5BvGlJ6S3Y78v5wnf1cn1h8pvJ5oWK1cCIxL/Wzk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S8ekM1H2ik99tyY1EGt6EPskgBGI7VugiQOVshEWeqn6F1ho9czIZSNSFRrTnsqq+meqb9UHx7K7S0O3zdMDlxv8DIWukQ2j4XqxCEEeX6UKnyMxSkbDXpitl1UdPQEz+A3jNH9wkbo1D3oB1C6eSK0xVN7OMQWw6HNKUI0ts4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=O9NW65S6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762779250; x=1794315250;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z/w5BvGlJ6S3Y78v5wnf1cn1h8pvJ5oWK1cCIxL/Wzk=;
  b=O9NW65S6svWyiOrF+T8b/mhBZTUYoykncnt0xeB8KGkTfTAq+08HWb+u
   omvY+UQktiykOUQc7Mqw73Jnm96LxAAhwpKGP+AJtNDvo1wYG0J3Nzviw
   T+gY9JvhVCxmGBMfrL8jo5YgQUz13GOzBY4d3NN0UpmD4ODexkATwRiOn
   UREPMRFMSoWc+/plCjvGHqv96FdZg2I6fDyRXEtw7ThfPwt7bpYo/Rcbg
   sMBmDzQu1t4f/APdnMmXbwHObiGYQhGYasbPBzJ9tkd7niOhesym0BYPe
   O14smIioGtnh0+nsjffBq0ztwf3bFM9Jd4G1hB8uoKRmtStVK4gJktvUd
   w==;
X-CSE-ConnectionGUID: J3EniCoqReCLo456qC1kmw==
X-CSE-MsgGUID: ueXCOewiR8Sjhtmltz82jg==
X-IronPort-AV: E=McAfee;i="6800,10657,11609"; a="82224960"
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="82224960"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:54:09 -0800
X-CSE-ConnectionGUID: PLVia+OkQsaKhN9quXcB1A==
X-CSE-MsgGUID: fxthXgjHSrGsTrJlNqurfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,293,1754982000"; 
   d="scan'208";a="192777077"
Received: from kniemiec-mobl1.ger.corp.intel.com (HELO ashevche-desk.local) ([10.245.245.235])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2025 04:54:05 -0800
Received: from andy by ashevche-desk.local with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1vIRPF-00000007Snr-3tiy;
	Mon, 10 Nov 2025 14:54:01 +0200
Date: Mon, 10 Nov 2025 14:54:01 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	jic23@kernel.org, nuno.sa@analog.com, dlechner@baylibre.com,
	andy@kernel.org, Michael.Hennerich@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, corbet@lwn.net,
	cosmin.tanislav@analog.com, marcelo.schmitt1@gmail.com
Subject: Re: [PATCH v1 0/3] iio: adc: Add AD4134 minimum I/O support
Message-ID: <aRHgaXxxnD5YsIQQ@smile.fi.intel.com>
References: <cover.1762777931.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1762777931.git.marcelo.schmitt@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Nov 10, 2025 at 09:44:56AM -0300, Marcelo Schmitt wrote:
> This patch series adds basic support for ad4134. AD4134 is a very flexible
> device that can be configured in many different ways. This series aims to
> support the simplest way of interfacing with AD4134 which is called minimum I/O
> mode in data sheet. This is essentially usual SPI with the addition of an ODR
> (Output Data Rate) GPIO which functions as conversion start signal in minimum
> I/O mode. The CS pin may be connected to a host controller CS pin or grounded.
> 
> This set provides just one feature:
> - Single-shot ADC sample read.
> 
> [PATCH 1] Device tree documentation for AD4134.
> [PATCH 2] IIO Linux driver for AD4134.
> [PATCH 3] Initial IIO documentation.
> 
> There is a driver by Cosmin on ADI Linux tree that supports AD4134 in wiring
> configurations suited for high speed data transfers. Even though the minimum I/O
> support was initialy based on that high speed transfer driver, the result ended
> up becoming entirely different. Also, because the different wiring
> configurations are likely going to use different resources and software
> interfaces, the code for AD4134 support was split into ad4134-spi.c,
> ad4134-common.h, and ad4134-common.c.

The cover letter misses the answer to: "Why do we need a brand new driver?
Don't we have anything similar already in IIO that can be expanded to cover
this one?"

-- 
With Best Regards,
Andy Shevchenko



