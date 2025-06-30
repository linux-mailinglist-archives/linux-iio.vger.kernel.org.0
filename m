Return-Path: <linux-iio+bounces-21146-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82B76AED817
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 11:02:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C76175D3C
	for <lists+linux-iio@lfdr.de>; Mon, 30 Jun 2025 09:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6470B21CA14;
	Mon, 30 Jun 2025 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cQrkY26H"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D26A2110;
	Mon, 30 Jun 2025 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751274155; cv=none; b=hCtbL9a36z9Kao4lzrjY67dKgJ3ni51jMYdDURWjv/sloIrLVzCtmWEvzFDrt9H4ImjJse+GtjRsTHCj7eb2ML0dB45fWa5hs2R/w1hECtUo7MeeFkE6n65NZjPmoRIZ37tmMKIee8JR1sTwnW/Hnz8RUyr4RXeiIPIxqH8GRRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751274155; c=relaxed/simple;
	bh=BNV5dwz5C2CpBAwinG45/8SbEo8XjoILHf3jGxqkzJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UijM0rM1DIHAA605Hfs1iUsQ1j2p++U2tWwm2/gphiXeM7PoU81EGIOvctvI9etS9zKL8JqT4nmiO5kF1m6jCd5kqYWcERNXjtw8dyVs0Le181Wy81DTj2zNaU9n473D/oiU3d9lk0XmJ82rD1rcLlaWyaApUmQ7V2s19I58Aro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cQrkY26H; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751274153; x=1782810153;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BNV5dwz5C2CpBAwinG45/8SbEo8XjoILHf3jGxqkzJo=;
  b=cQrkY26HfNnYyE74V8eW9BnIT+gFPyp4SNn4vx1ka65E793sXjCs5mgP
   KYafxoSWvQs+ELmxrYxmhL/weEkxgbxMVkApZcZbyCrPQiRCGOXZUvQMk
   GA1QC7hgpBS1C/ODeD72GcCy4BXYHusj5+acLC/o/hhM1pZhOXA+tWeKx
   Izz18pgWdE7zePs4iO9WBAKUHsKdY2FnLdxubmWQg7CpdZaiOppRmXLEa
   IA7un8fuTGJ3FYQ0US983b5KMvTCm0Y+H3BII4ISuJGxJZuMwj93d9KAV
   W90gMGhdEO5WTlhXNZmDg8WaSoesPSZROVxQyeTcign1eqoPpX+D/4lXa
   A==;
X-CSE-ConnectionGUID: YlGnDDu1TYO5Cl3fQKvxOQ==
X-CSE-MsgGUID: o/8kh/UTTv2CUnsRUrYKqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11479"; a="53368633"
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="53368633"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 02:02:33 -0700
X-CSE-ConnectionGUID: Oe+CdnWdR4CXE9wxPznqgg==
X-CSE-MsgGUID: WkXbaZDyRV6b1jtMrRfagw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,277,1744095600"; 
   d="scan'208";a="157946454"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2025 02:02:29 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uWAPC-0000000BFs4-3Snj;
	Mon, 30 Jun 2025 12:02:26 +0300
Date: Mon, 30 Jun 2025 12:02:26 +0300
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
Subject: Re: [PATCH v2 05/11] iio: adc: ad_sigma_delta: audit included headers
Message-ID: <aGJSoqDxkDQcJ1YE@smile.fi.intel.com>
References: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-0-f49c55599113@baylibre.com>
 <20250627-iio-adc-ad7173-add-spi-offload-support-v2-5-f49c55599113@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627-iio-adc-ad7173-add-spi-offload-support-v2-5-f49c55599113@baylibre.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jun 27, 2025 at 06:40:01PM -0500, David Lechner wrote:
> Drop linux/iio/sysfs.h since it is unused and replace linux/kernel.h
> with more explicit headers. There are a couple of other headers added
> weren't covered by kernel.h, like linux/gpio/consumer.h that are added
> since the module makes used of those APIs as well.

s/used/use/

> Signed-off-by: David Lechner <dlechner@baylibre.com>

...

>  #include <linux/align.h>
> +#include <linux/bitmap.h>
>  #include <linux/bitops.h>

bitops.h is implied by bitmap.h, but I'm fine with this being left untouched.

> +#include <linux/cleanup.h>
> +#include <linux/completion.h>
>  #include <linux/device.h>
>  #include <linux/err.h>
> +#include <linux/export.h>
> +#include <linux/find.h>
> +#include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
> -#include <linux/kernel.h>
>  #include <linux/module.h>
> +#include <linux/property.h>
>  #include <linux/slab.h>
>  #include <linux/spi/spi.h>
> +#include <linux/spinlock.h>
> +#include <linux/string.h>
>  #include <linux/types.h>
>  #include <linux/unaligned.h>

-- 
With Best Regards,
Andy Shevchenko



