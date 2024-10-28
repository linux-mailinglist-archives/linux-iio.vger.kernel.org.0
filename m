Return-Path: <linux-iio+bounces-11440-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A089B2B93
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 10:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93DB01F22532
	for <lists+linux-iio@lfdr.de>; Mon, 28 Oct 2024 09:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9923E1917F6;
	Mon, 28 Oct 2024 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XOW98CWP"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732C8187876;
	Mon, 28 Oct 2024 09:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730107984; cv=none; b=XcMkJdvCMXZ34RND5H2dHolhM0MpCwP26o9hiOWZd5RVGA1Nw+kLKiZo0k/ogMzR32Qx4awuuEcOSPStjdSWyvpdVhvSnJcbz6aUSlqG3EuuWYS5cZ8YsYjNuk5WWeFGrWkPp0W5F4hucXGJVo4FOE+EUniJ7FDsMbleToRRbWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730107984; c=relaxed/simple;
	bh=Q4k57nq1ylRfX7JqHq2qJwhX08jvaDrJ8QWoMLElP/E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AYrIq6zEVWNPCrkwTcidjhtOHF1xipMILzYjASbBD23KawBmYUR66aV+UETy8n4MjIiq/4hVov6KKkhmvrQdCUBCwjCZ/pGjczFeBVeSjoQl46pZql6byS7vW5TVRvWhjrgzltwrY32wEkavV+ssVKLAkikLDBlsI/PujQ78Htc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XOW98CWP; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730107982; x=1761643982;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q4k57nq1ylRfX7JqHq2qJwhX08jvaDrJ8QWoMLElP/E=;
  b=XOW98CWPHL2wCeRvy+A98/6SksQlhDHvnueot9il5Y3errEnfJE635oC
   CZYt+MqWXvP/691IeIKG0CYNn4kfNr+utqzEw2WKyRrCCArRBUP+orHn+
   rSvDNvDYcih2CvNfUPt6n1FTmg6p/wQmLdmIgzWYF8avU8fAbkkkhLjNk
   4EeI50D5dThuuWM06nQOSJdCNh03xQroE2fsyivkP7QrI7wxLb+woLdX0
   VWERfNQLsmkTA0y61wO3wHMPZ1jXWU/EQNc4sqnI98HYKPm19s6YTFoo3
   AhSAUjfD0ox5quoYFrgHL2qXvWnEi96lOZzJmrjQQ3ckMS7qFctiKkWSH
   w==;
X-CSE-ConnectionGUID: XmRWD9lPQ7WlGz1F4JNT5A==
X-CSE-MsgGUID: /Jue91fGRVaFv1wa0xp5tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11238"; a="29601103"
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="29601103"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:33:01 -0700
X-CSE-ConnectionGUID: euAh/kf+Q7GfOVU4/eotZQ==
X-CSE-MsgGUID: uExKR1haR3mqDtTAKeefzg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,238,1725346800"; 
   d="scan'208";a="82003378"
Received: from smile.fi.intel.com ([10.237.72.154])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Oct 2024 02:32:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1t5M7L-00000007tSi-1pPz;
	Mon, 28 Oct 2024 11:32:55 +0200
Date: Mon, 28 Oct 2024 11:32:55 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Justin Weiss <justin@justinweiss.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Derek J . Clark" <derekjohn.clark@gmail.com>,
	Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Subject: Re: [PATCH v4 2/4] iio: imu: bmi270: Add scale and sampling
 frequency to BMI270 IMU
Message-ID: <Zx9aR2h9pjdIMglO@smile.fi.intel.com>
References: <20241027172029.160134-1-justin@justinweiss.com>
 <20241027172029.160134-3-justin@justinweiss.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241027172029.160134-3-justin@justinweiss.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Sun, Oct 27, 2024 at 10:20:23AM -0700, Justin Weiss wrote:
> Add read and write functions and create _available entries.

...

> +static int bmi270_set_scale(struct bmi270_data *data,
> +			    int chan_type, int uscale)

There is available space in the previous line, (And I would even join them
despite being 83 characters long.)

...

> +static int bmi270_get_scale(struct bmi270_data *bmi270_device,
> +			    int chan_type, int *uscale)

Ditto (for chan_type).

...

> +static int bmi270_set_odr(struct bmi270_data *data, int chan_type,
> +			  int odr, int uodr)

Ditto.

...

> +	for (i = 0; i < bmi270_odr_item.num; i++) {
> +		if (bmi270_odr_item.tbl[i].odr != odr ||
> +		    bmi270_odr_item.tbl[i].uodr != uodr)
> +			continue;
> +
> +		return regmap_update_bits(data->regmap, reg, mask,
> +					  bmi270_odr_item.vals[i]);
> +	}
> +
> +	return -EINVAL;

Wouldn't be better to use regular patterns, i.e. checking for errors first?

	for (i = 0; i < bmi270_odr_item.num; i++) {
		if (bmi270_odr_item.tbl[i].odr == odr ||
		    bmi270_odr_item.tbl[i].uodr == uodr)
			break;
	}
	if (i == bmi270_odr_item.num)
		return -EINVAL;

	return regmap_update_bits(data->regmap, reg, mask, bmi270_odr_item.vals[i]);

...

> +static int bmi270_get_odr(struct bmi270_data *data, int chan_type,
> +			  int *odr, int *uodr)

As per above.

> +	for (i = 0; i < bmi270_odr_item.num; i++) {
> +		if (val != bmi270_odr_item.vals[i])
> +			continue;
> +
> +		*odr = bmi270_odr_item.tbl[i].odr;
> +		*uodr = bmi270_odr_item.tbl[i].uodr;
> +		return 0;
> +	}
> +
> +	return -EINVAL;

As per above.

-- 
With Best Regards,
Andy Shevchenko



