Return-Path: <linux-iio+bounces-20895-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CA2AE3AAA
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 11:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4929168BAD
	for <lists+linux-iio@lfdr.de>; Mon, 23 Jun 2025 09:37:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECFE0239072;
	Mon, 23 Jun 2025 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQgtWlKD"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42E0019CCEC;
	Mon, 23 Jun 2025 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750671252; cv=none; b=ju2v00TLxC/ovctpflFYwGKz7SBene6gQXQrKNbF9oAfzonYSAaP7bPFXFzu+DWcLCRZDbWqhyT8clOS7HQdHsde1OWisHjWyGLun3cDBL06jvTSX3yooTozCon5ixuCocmBwphb96DL36qtC7EYLsI3gS9EiTQyyb2WFR6sdJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750671252; c=relaxed/simple;
	bh=Vz5OSubXfv+7o3fkxilrYlVlKM2SH7uyFsn4jPoJ3YA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJYPEQCXNYRrJ8Cn8aX2so1Lo+g8ylw4iGIC9UuXMRHNf0iPKThpgiD69QyYvcfPEavK21HTu3mdMSiXkJbJgQUSlx5M+FG9gEllULcc8j/tptJPU8ERrOm4s3wY3C8rdfBEcQX6sERIhpaEqE2wn4GIxt62z37t/fwoWDm37gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQgtWlKD; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1750671252; x=1782207252;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Vz5OSubXfv+7o3fkxilrYlVlKM2SH7uyFsn4jPoJ3YA=;
  b=JQgtWlKDK6Wn36QzGLVD/4/aKLF8b2+hWM4c8UD8kl4Bo3qrDhW3nrNO
   fdXCrNm4IUWTEZ2E7r6wq5QHy/X6Z1BsUm19ZZk4RY0BN/KVeRRf1bJRV
   rZZsKPZmdB/tMEflytgoNRYGPnvZxn80usBDZZYORJZznEN2/pHNNJw9z
   hHsdkOVKlfL4iDOgxRxdaQQ2SGMVP1J8B9UZgk9msTMdpfW//MIv7HAHw
   fO0B4bs7O85p8zNkrUEkASMPuzQwDhoD3zjYB7PY9dgV4r1i12g4fCKBd
   6BSiT1tOs20KxE442e03nL+IuwB6ZNJiOXHKEs4yvyevll4hU2j3R+e8J
   g==;
X-CSE-ConnectionGUID: mSWOb2l5Tb+O3B/l/EfFNQ==
X-CSE-MsgGUID: a9bHveN6TQayO22iuvYiXg==
X-IronPort-AV: E=McAfee;i="6800,10657,11472"; a="56541530"
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="56541530"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 02:34:11 -0700
X-CSE-ConnectionGUID: IcjhYKI6SPq8ByprE03HEw==
X-CSE-MsgGUID: 9Wevme+gRvSm3pHsEKbbmg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,258,1744095600"; 
   d="scan'208";a="151834511"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2025 02:34:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uTdYy-000000097hk-3rxN;
	Mon, 23 Jun 2025 12:34:04 +0300
Date: Mon, 23 Jun 2025 12:34:04 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v10 3/7] iio: accel: adxl345: add activity event feature
Message-ID: <aFkfjAekGJTU5o71@smile.fi.intel.com>
References: <20250622155010.164451-1-l.rubusch@gmail.com>
 <20250622155010.164451-4-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622155010.164451-4-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Sun, Jun 22, 2025 at 03:50:06PM +0000, Lothar Rubusch wrote:
> Enable the sensor to detect activity and trigger interrupts accordingly.
> Activity events are determined based on a threshold, which is initialized
> to a sensible default during probe. This default value is adopted from the
> legacy ADXL345 input driver to maintain consistent behavior.
> 
> The combination of activity detection, ODR configuration, and range
> settings lays the groundwork for the activity/inactivity hysteresis
> mechanism, which will be implemented in a subsequent patch. As such,
> portions of this patch prepare switch-case structures to support those
> upcoming changes.

...

> +static int adxl345_set_act_inact_en(struct adxl345_state *st,
> +				    enum adxl345_activity_type type,
> +				    bool cmd_en)
> +{
> +	unsigned int axis_ctrl;
> +	unsigned int threshold;
> +	int ret;
> +
> +	if (cmd_en) {
> +		/* When turning on, check if threshold is valid */

> +		ret = regmap_read(st->regmap,
> +				  adxl345_act_thresh_reg[type],
> +				  &threshold);

Can occupy less LoCs.

> +		if (ret)
> +			return ret;
> +
> +		if (!threshold) /* Just ignore the command if threshold is 0 */
> +			return 0;
> +	}
> +
> +	/* Start modifying configuration registers */
> +	ret = adxl345_set_measure_en(st, false);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable axis according to the command */
> +	switch (type) {
> +	case ADXL345_ACTIVITY:

> +		axis_ctrl = ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN |
> +				ADXL345_ACT_Z_EN;

I think

		axis_ctrl =
			ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN | ADXL345_ACT_Z_EN;

is slightly better to read.

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	ret = regmap_assign_bits(st->regmap, ADXL345_REG_ACT_INACT_CTRL,
> +				 axis_ctrl, cmd_en);
> +	if (ret)
> +		return ret;
> +
> +	/* Enable the interrupt line, according to the command */
> +	ret = regmap_assign_bits(st->regmap, ADXL345_REG_INT_ENABLE,
> +				 adxl345_act_int_reg[type], cmd_en);
> +	if (ret)
> +		return ret;
> +
> +	return adxl345_set_measure_en(st, true);
> +}

...

> +	case IIO_EV_TYPE_MAG:
> +		return adxl345_read_mag_config(st, dir,
> +					       ADXL345_ACTIVITY);

It looks like you set the editor to wrap at 72 characters, but here the single
line less than 80! Note that the limit is *exactly* 80 character.

...

> +	case IIO_EV_TYPE_MAG:
> +		return adxl345_write_mag_config(st, dir,
> +						ADXL345_ACTIVITY,

Ditto.

...

> +		return adxl345_read_mag_value(st, dir, info,
> +					      ADXL345_ACTIVITY,
> +					      val, val2);

Ditto and so on...

-- 
With Best Regards,
Andy Shevchenko



