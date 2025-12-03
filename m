Return-Path: <linux-iio+bounces-26661-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADA8C9E542
	for <lists+linux-iio@lfdr.de>; Wed, 03 Dec 2025 09:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8C5D04E1369
	for <lists+linux-iio@lfdr.de>; Wed,  3 Dec 2025 08:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929E32D7D59;
	Wed,  3 Dec 2025 08:58:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A0FYpDZX"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFAB2D7D3A;
	Wed,  3 Dec 2025 08:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764752333; cv=none; b=ZPWJsBm6hV93XnbtlzbPX3s2EQHqIh1YrENY6t9DX/fjfqrAW1uwWQ/phVyNXIloL3a/G3WZVAZqKIb0BdeH8QQVqAGrT3Q4wflQVh5qvML/CF3yYb0XfGRUaOQnbrRp8uRuIPTRiPg4FoF++dDZV0EC9J4HFtvEXrQEnnuh/Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764752333; c=relaxed/simple;
	bh=OrdqKKoBR2F1QwnGWsv5JWAe5seCPfiw89V9PPsR2S0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rXtmz9KsVJU3qBoJK/qBy5tX6rweInUyb8AuCBfjwtdOnkCnMJtjZYFvN5RYeuHgtql5miaQvx0PbQpjEpaFWbNxzgFeiGbybXZ5JFj7rd8IpeTT10hJCUM4+KoYlbii5zByaTMQjrhCej8AOM1h7U6m3A8NNXKNaVtwVrLtZYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A0FYpDZX; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764752332; x=1796288332;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OrdqKKoBR2F1QwnGWsv5JWAe5seCPfiw89V9PPsR2S0=;
  b=A0FYpDZX0M3PmCF6kG+XjS8IhLp2Jci2AVlG9NpxLa4qxQxNi/DFwJcO
   cSkhQfBhbxVvMDxLYhZrM4xOyQQip9+XHWE9a+ApvWy05aBjJC4bBr3KZ
   74HR7zbqJyqWCAaQzhLRWTuIYxrY8D/1ssGz8F6QU3NIeZEnJO4RQnBN3
   84rnZOTA/1lTRlUQQ4jWnXhT7kDl1/Yx8qGKydkg+xugMFROj+eYQsi0B
   M6OvFKQh/6gZsZnDSuQ8yhenOVlPhkIiNR2c9/tkCb7cpzmoeLNGGBzwR
   RwE9Pv42rBkOjxc9BmXz3m0DQR91eYxJw2CvJhm2nxb9O/L6Q5udIrM9T
   g==;
X-CSE-ConnectionGUID: NiElxKzPTO6TN1AcPwwPVA==
X-CSE-MsgGUID: E++oteBaTtGgijCcz6oHkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11631"; a="92216463"
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="92216463"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 00:58:51 -0800
X-CSE-ConnectionGUID: NYxcTz2ZQjSqRGJ6mUX32Q==
X-CSE-MsgGUID: /qQ0wv0FRy+rNzsPmrSCtg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,245,1758610800"; 
   d="scan'208";a="195042934"
Received: from vpanait-mobl.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2025 00:58:48 -0800
Date: Wed, 3 Dec 2025 10:58:46 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Kurt Borja <kuurtb@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Tobias Sperling <tobias.sperling@softing.com>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v4 2/2] iio: adc: Add ti-ads1018 driver
Message-ID: <aS_7xrMwW42qolG4@smile.fi.intel.com>
References: <20251202-ads1x18-v4-0-8c3580bc273f@gmail.com>
 <20251202-ads1x18-v4-2-8c3580bc273f@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251202-ads1x18-v4-2-8c3580bc273f@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Dec 02, 2025 at 11:56:19PM -0500, Kurt Borja wrote:
> Add ti-ads1018 driver for Texas Instruments ADS1018 and ADS1118 SPI
> analog-to-digital converters.
> 
> These chips' MOSI pin is shared with a data-ready interrupt. Defining
> this interrupt in devicetree is optional, therefore we only create an
> IIO trigger if one is found.
> 
> Handling this interrupt requires some considerations. When enabling the
> trigger the CS line is tied low (active), thus we need to hold
> spi_bus_lock() too, to avoid state corruption. This is done inside the
> set_trigger_state() callback, to let users use other triggers without
> wasting a bus lock.

...

> +/**
> + * ADS1018_FSR_TO_SCALE - Converts FSR into scale
> + * @_fsr: Full-scale range in millivolts
> + * @_res: ADC resolution
> + *
> + * The macro is crafted to avoid potential overflows on 32-bit machines. This
> + * imposes restrictions on the possible values for @_fsr (less than 274878),

> + * and @_res (greater than or equal to 6 bits).

This is actually incorrect. See below.

> + * Return: Scale in IIO_VAL_INT_PLUS_NANO format
> + */
> +#define ADS1018_FSR_TO_SCALE(_fsr, _res) \
> +	{ 0, ((_fsr) * (MICRO >> 6)) / (BIT((_res) - 1) >> 6) }

This is different from what I suggested. But I think I was mistaken with
the parentheses and thought that you are dividing on the mask-like value.

If the current version correct by the result, first of all, the limitation for
@_res is 7 and not 6. And second, it can be rewritten in a simpler form.

	{ 0, ((_fsr) * (MICRO >> 6)) >> ((_res) - 6 - 1) }

Please, check it again.

-- 
With Best Regards,
Andy Shevchenko



