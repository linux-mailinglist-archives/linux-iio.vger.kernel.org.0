Return-Path: <linux-iio+bounces-27363-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 013D8CDFE37
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 16:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6334230022C1
	for <lists+linux-iio@lfdr.de>; Sat, 27 Dec 2025 15:14:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4191C2512E6;
	Sat, 27 Dec 2025 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="exbvYdwx"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFA9012F5A5;
	Sat, 27 Dec 2025 15:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766848456; cv=none; b=vCAJ1e7CKjthb4LjmGT+9kkoN/nuUcfcUIaYRwrwWrsSfKhy1xc8pkyMVuEjFtyywq6G+RglR/zIiXoLcnz/xtDkOcymq8M9JhzHcp4YGIsNjAJBQLouL38NQU/cGOJtaRvfub7LKvJ8ks6UhBFdB3Zu07kTJ07xYaXmu4+CF8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766848456; c=relaxed/simple;
	bh=ayGnvzGYTMOYZSbWIa1SXRKPdxDlB2oCn9u0AuNbJrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kLfjJ7m9qpYeWfrH5DnEGloIEuXbcsc5ppH8dO/8qyA7Dk1FUhTLo6IuVV2Hg36kT81f8UbOIMryibgrQoJLuJrTT9MyP32Kc0XiI4zWdX3ndqtVlE4U9807sdTUA5NFYl9Y7Ni5nXxMfSVpq7JyRln6tYwN/4jrvSX0AVvfKIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=exbvYdwx; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1766848454; x=1798384454;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ayGnvzGYTMOYZSbWIa1SXRKPdxDlB2oCn9u0AuNbJrQ=;
  b=exbvYdwxO1Thm2eK9HVa3tciGMCztmfwJwDAigh0xsFMImZ8x5CXW43A
   uc/NAIFbwp7YcqHstI/mcS5WKRkPS5vociphE1iQu3V0izEzQpBHSj/wP
   wKGCyixpdTfdRe13m194Dxkmb9e2TdZSczstvOzVysT+ZtOsEHsTTfUlM
   joR3sjINNwfyXfjMLFlm+xClqRauK1tfYRmhacVttmi+AEuoSntjq+CH5
   zmNsuNT/vGFVoXzIn+jDr6tQIn8ejMxakfRHo6CNvQJfFfHf9RIjKRJPU
   qylWWksGBf6wjwyWi0rbNYUbrNsglVU+QqLQgOYbY6831fz5pFQGTwnvq
   g==;
X-CSE-ConnectionGUID: WhfAhOT6TXq76OfMkV90eg==
X-CSE-MsgGUID: XUnXJ/f2RNyhqJAoJx2Q+w==
X-IronPort-AV: E=McAfee;i="6800,10657,11654"; a="68706781"
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="68706781"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 07:14:13 -0800
X-CSE-ConnectionGUID: Fz8pSKfGRN+9mMDadppbbw==
X-CSE-MsgGUID: NwCboQ1dSzKyicwXdmCCjQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,180,1763452800"; 
   d="scan'208";a="200586196"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.211])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2025 07:14:09 -0800
Date: Sat, 27 Dec 2025 17:14:07 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: David Lechner <dlechner@baylibre.com>
Cc: Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Sean Anderson <sean.anderson@linux.dev>, linux-spi@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH v4 4/9] spi: add multi_lane_mode field to struct
 spi_transfer
Message-ID: <aU_3v5smP1AnsHCG@smile.fi.intel.com>
References: <20251219-spi-add-multi-bus-support-v4-0-145dc5204cd8@baylibre.com>
 <20251219-spi-add-multi-bus-support-v4-4-145dc5204cd8@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251219-spi-add-multi-bus-support-v4-4-145dc5204cd8@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Dec 19, 2025 at 03:32:12PM -0600, David Lechner wrote:
> Add a new multi_lane_mode field to struct spi_transfer to allow
> peripherals that support multiple SPI lanes to be used with a single
> SPI controller.
> 
> This requires both the peripheral and the controller to have multiple
> serializers connected to separate data lanes. It could also be used with
> a single controller and multiple peripherals that are functioning as a
> single logical device (similar to parallel memories).

...

>  	unsigned	cs_change:1;
>  	unsigned	tx_nbits:4;
>  	unsigned	rx_nbits:4;
> +
> +#define SPI_MULTI_LANE_MODE_SINGLE	0 /* only use single lane */
> +#define SPI_MULTI_LANE_MODE_STRIPE	1 /* one data word per lane */
> +#define SPI_MULTI_LANE_MODE_MIRROR	2 /* same word sent on all lanes */
> +	unsigned	multi_lane_mode: 2;
> +
>  	unsigned	timestamped:1;

Btw, have you checked the layout of these bitfields? Are they all in one 32-bit
word or split? Dunno if `pahole` handles them, never actually paid attention
before.

-- 
With Best Regards,
Andy Shevchenko



