Return-Path: <linux-iio+bounces-22359-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E318B1CD61
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 22:21:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED145189EF1B
	for <lists+linux-iio@lfdr.de>; Wed,  6 Aug 2025 20:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B92621A447;
	Wed,  6 Aug 2025 20:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NF3Y6Eul"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877D71EFFB7;
	Wed,  6 Aug 2025 20:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754511678; cv=none; b=l1uuzRFQKWqMf922anvTCvnmO5x0Fxj0+ZGVuQhQfYgaq2o+kVi+YWT8VTIPZVK+dncjRXguUokCsb4LUMXRm0J1m9DXEV3TvVKm39ZPLoxFqa33AGI9xZLXSnM4n6SQ4D7eETNbG1gq4wwp4+UktuuATqXrt/8QEkMhjAiIRoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754511678; c=relaxed/simple;
	bh=GhUYINd18AX2enAG4jJkuEbtK/ker1ziFX5YVu+5vzc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DxeLom1jBzmopO8FDRUovUnPWrduUORQoaWHcejPRiUG/bl81FIPMNTdRO3eL8k4faj4elhDQ5iv5bMHZQHAA9wDOXPJY1rE3PYNir4mRXKX8r9/PFGRTpHsGfUxFHED7UYVn3Ajk9jiOQky3lVPwM/fv12yERkbgDfVF1BV/U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NF3Y6Eul; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1754511677; x=1786047677;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GhUYINd18AX2enAG4jJkuEbtK/ker1ziFX5YVu+5vzc=;
  b=NF3Y6EulO9V1s4Uq0nfCsDorfV/EHbqvOWHgoUPgqby0g3POuEnczebr
   a9gm7mYCZUg8avlYvs33hAYeFZ4YJpvmEvE5Gy1vqEeBbGsIrgioK9HhY
   zEIONgZcb/OmdGrrYkKtJ7qZ/wkElzWxMCIkK8jvCELcS6HWiTFLzq/UN
   34h5cYr7oP8tlb/ZTK6kUgeyE/3uPn+QtF4oS4qiRmHCdkRrokhCcl/nY
   UkdTRAigUnj1ygynFt5txM1gIkaae0PgIJIUgbQrRo4UHbg1N9X0XlRR1
   jmXRUeUh08QkWsWn6dDMZ+2AXZ0G7rnnCkaY2XununUAw9IL1kkQl2g5i
   A==;
X-CSE-ConnectionGUID: MapPORZiRMyFBgqDQjyZhg==
X-CSE-MsgGUID: Ww4/Hx48SsmpaHvz415XQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11514"; a="59456574"
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="59456574"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:21:16 -0700
X-CSE-ConnectionGUID: 3Bjj3fr2TFGV7sLR4pXiQA==
X-CSE-MsgGUID: rDyNSKfPTNS73cTGIdMvHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,271,1747724400"; 
   d="scan'208";a="165232439"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2025 13:21:12 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ujkdJ-000000046if-1kug;
	Wed, 06 Aug 2025 23:21:09 +0300
Date: Wed, 6 Aug 2025 23:21:09 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] iio: adc: ad7476: Simplify scale handling
Message-ID: <aJO5NRESqxFfxi3s@smile.fi.intel.com>
References: <cover.1754463393.git.mazziesaccount@gmail.com>
 <645ac6fb917e12db6cdc0fc343487531f61c176a.1754463393.git.mazziesaccount@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <645ac6fb917e12db6cdc0fc343487531f61c176a.1754463393.git.mazziesaccount@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Aug 06, 2025 at 10:03:07AM +0300, Matti Vaittinen wrote:
> The ad7476 driver supports variants with different amount of supply
> regulators. On some variants there is only VCC, which is used as a
> reference voltage. Others have separate VREF regulator, and some rely on
> internal VREF. Some have both internal VREF and option to connect
> external one.
> 
> The ad7476 driver reads the regulator voltage only when the user asks to
> get the scale. This means the driver needs to do some dancing while
> picking the correct reference regulator (or internal reference), and
> store it for the later use.

> According to the discussion:
> https://lore.kernel.org/linux-iio/20250331122247.05c6b09d@jic23-huawei/

This may be made a Link tag

According to the discussion [1] ...
...
Link: $URL #1

> variable voltage references are rare, making it hard to justify the
> added complexity for supporting those.
> 
> Drop the support for the variable voltage references and simplify things
> by using the managed regulator get and enable interfaces.

-- 
With Best Regards,
Andy Shevchenko



