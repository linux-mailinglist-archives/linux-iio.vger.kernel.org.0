Return-Path: <linux-iio+bounces-27987-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C2FD3B589
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 19:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9B25C3004EC8
	for <lists+linux-iio@lfdr.de>; Mon, 19 Jan 2026 18:22:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93F837E313;
	Mon, 19 Jan 2026 18:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lJwsKfFc"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EAD6254B03;
	Mon, 19 Jan 2026 18:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768846968; cv=none; b=Lkz95Xe45u8vxCe89wrjzrs2OJejQs5+VHwIvEFFML+hRyLxnG9oVxkTFtBD+I5TqqIrBa5xxqJrIIySV98PJVmYx8Xlc7NTsCNsoYJf0Ps1Gruq2nJQWu7jBEMVLtbuP8Kj1nW++K+fcV0K2nNcDkJWGH4o1gVl2xjdn8ppoVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768846968; c=relaxed/simple;
	bh=JHJ/cOtD0glHS1pJFE//DW8gkneCLATeGmK89MO9MGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dkZfeunYou5rFYHxTnSkoMSn6F1YScE9uaSbEvf4zxvRKk0DB9PhUB7NiZk0gpOSL2cjpl4XF6MgWqq1eUHAhUZF4sUG66mMVCBoL2MXCX+I0zXSPqP9jzO4mrFGZG8jACh/c7QZcRYDB/kXOcFqmhd80OHvcSkjwrtKkJsnfps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lJwsKfFc; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768846967; x=1800382967;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JHJ/cOtD0glHS1pJFE//DW8gkneCLATeGmK89MO9MGM=;
  b=lJwsKfFckReAsYfmJxNYGe1fVXJD7eDh6zKthU9KBM1PuqBQStUP+CG+
   YROZAK8o7klUvuiirfK53VUvwiwwWey7ycjP+KZpDNKuMBPwr0WTmSMlr
   Fc0HpvxQcr1ICBVf7LEscUJHHSwSRshfEFTh0S5oeM0Y4xxYRq5iRmuzJ
   K9pzchrA2T5BljE80Kr84yNVRjQo5xJUqitCugz8LijHqEq/G6essdU5S
   g4MVgcWNcRxcBzQDguZvs9/NeRkaWD+rB15zDmfp7enEzRu6oenDsJDk+
   GZh7Z5gVxt2u9lRgVl6mP3uuLoeVpTF/KG8jPjj1zqnUSdb2abL8IAs5u
   g==;
X-CSE-ConnectionGUID: wRpG7HjMTO6exj0EdomgCg==
X-CSE-MsgGUID: KOvTHu8cTRaiDlDN9jg3qQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11676"; a="80693819"
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="80693819"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 10:22:46 -0800
X-CSE-ConnectionGUID: BE8m/+stS9i958n7xbG2gQ==
X-CSE-MsgGUID: qPKvEdBpQqGzMPrqJ6niow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,238,1763452800"; 
   d="scan'208";a="205175361"
Received: from egrumbac-mobl6.ger.corp.intel.com (HELO localhost) ([10.245.244.37])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2026 10:22:42 -0800
Date: Mon, 19 Jan 2026 20:22:39 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: petr.hodina@protonmail.com
Cc: Song Qiang <songqiang1304521@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>, David Heidelberg <david@ixit.cz>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] iio: proximity: vl53l0x-i2c: Fix reset sequence
Message-ID: <aW52bwvXOrsSUMLX@smile.fi.intel.com>
References: <20260119-vl53l0x-v1-0-cf71715a1353@protonmail.com>
 <20260119-vl53l0x-v1-3-cf71715a1353@protonmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260119-vl53l0x-v1-3-cf71715a1353@protonmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Mon, Jan 19, 2026 at 06:19:57PM +0100, Petr Hodina via B4 Relay wrote:

> Fix the reset GPIO handling and power-up timing to better match the
> VL53L0X reset requirements.

...

> -	usleep_range(3200, 5000);
> +	usleep_range(5000, 6000);

> +		usleep_range(5000, 6000);

> +		usleep_range(5000, 6000);

Can you switch to fsleep() while at it?

...

> -	data->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_HIGH);
> +	data->reset_gpio = devm_gpiod_get_optional(&client->dev, "reset", GPIOD_OUT_LOW);
>  	if (IS_ERR(data->reset_gpio))
>  		return dev_err_probe(&client->dev, PTR_ERR(data->reset_gpio),
>  				     "Cannot get reset GPIO\n");

Wondering if in a future change this can be converted to use reset-gpio driver
instead of poking GPIOs directly.

-- 
With Best Regards,
Andy Shevchenko



