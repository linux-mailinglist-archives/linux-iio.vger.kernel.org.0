Return-Path: <linux-iio+bounces-20541-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 544E2AD6F7E
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 13:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5CC3A424F
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 11:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6D2223714;
	Thu, 12 Jun 2025 11:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QeU+I3dO"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C891442F4;
	Thu, 12 Jun 2025 11:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749729105; cv=none; b=hpKgLS9tVTK0C9YzPOD+M9tHeKezQ9W9EveLOkli4k9npRl2UdhR9a11ZztdUV30HZHRDgV/egB+RiRbJ7eBL6AD2oqJvSJzm13/qXex7bFbGyatjr7Vc5mpBkESoTntVH8fOQaYpcZMyio11fP+21almYsr+BdwJisbAlMaW/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749729105; c=relaxed/simple;
	bh=3vxB5ciP5Q8mkeDoU2cs45u/huhJIF9YPX7zbCUC/TI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfkalEa5LV4sHRb9SvxBJYtOtwoR0wkkLzqXwd/e8+k1s4m7aX9UXSMzJEPZgsax8CsctUbhVqPANmEwbNzSr5Ac8/Yw2ynHw57ovw1Eh/8xDPfv0divrwHl44r5M6kU2Yh4EtUeGX9oBFvkXTJCg6vgKV8gJf26zgHjOiLIACw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QeU+I3dO; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749729104; x=1781265104;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3vxB5ciP5Q8mkeDoU2cs45u/huhJIF9YPX7zbCUC/TI=;
  b=QeU+I3dOncfOWRyb10WaVjt39n5ImdBKl1OuYMoVvBP4UTFuZUX0EH+O
   90u5EyjhdXOkS6EOyEEJLx4b9Jf96u0uUsh7g6k2K2srFR8JXvK+V088L
   3fQMvWUc10BBSq5vAvqI/D+TAz7hfSVMM5fuf6C5QHh32rBI/lzSdd3Fr
   bLbEoP7Yxy6ogW0u8nNHft9whPrGryn8FYh30df900GXy6HiXmu0TKJE+
   mVzzD98ASk5v12+MproOfwDkf5VG8doGc9L+CAol/+rj/DeWIlD6V3pYD
   wHmnIeqJWlUhgRVBEgEXYLcBTJPzhjcRo7eMfmamQq9KuaBW1znIrUqrm
   A==;
X-CSE-ConnectionGUID: 5ufzmy/iSYmLKzFAWYXHpw==
X-CSE-MsgGUID: Sc3a9jksSPm+e6eCXSrWeA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="62942768"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="62942768"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:51:42 -0700
X-CSE-ConnectionGUID: Vem2LwBBRsySpsqnJ1mrJQ==
X-CSE-MsgGUID: l3+3aSBiSreXanS90hhqsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="147850054"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 04:51:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uPgT2-00000005wLa-1Io0;
	Thu, 12 Jun 2025 14:51:36 +0300
Date: Thu, 12 Jun 2025 14:51:36 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v9 07/11] iio: accel: adxl345: add activity event feature
Message-ID: <aEq_SJMDzPYGSMu6@smile.fi.intel.com>
References: <20250610215933.84795-1-l.rubusch@gmail.com>
 <20250610215933.84795-8-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610215933.84795-8-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jun 10, 2025 at 09:59:29PM +0000, Lothar Rubusch wrote:
> Make the sensor detect and issue interrupts at activity. Activity
> events are configured by a threshold. Initialize the activity threshold
> register to a reasonable default value in probe. The value is taken from
> the older ADXL345 input driver, to provide a similar behavior.
> 
> Activity, ODR configuration together with the range setting prepare the
> activity/inactivity hysteresis setup, implemented in a follow up patch.
> Thus parts of this patch prepare switch/case setups for the follow up
> patches.

...

> +/* act/inact */

Useless comment. If you want it to stay, decrypt it and make it useful.

...

> +static int adxl345_is_act_inact_en(struct adxl345_state *st,
> +				   enum adxl345_activity_type type)
> +{
> +	unsigned int regval;
> +	u32 axis_ctrl;
> +	bool en;
> +	int ret;
> +
> +	ret = regmap_read(st->regmap, ADXL345_REG_ACT_INACT_CTRL, &axis_ctrl);
> +	if (ret)
> +		return ret;
> +
> +	switch (type) {
> +	case ADXL345_ACTIVITY:
> +		en = FIELD_GET(ADXL345_ACT_X_EN, axis_ctrl) |
> +			FIELD_GET(ADXL345_ACT_Y_EN, axis_ctrl) |
> +			FIELD_GET(ADXL345_ACT_Z_EN, axis_ctrl);

Something happened to the indentation.
Ditto for several places in the code (upper and lower from this).

> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	if (!en)
> +		return en;
> +
> +	/* Check if corresponding interrupts are enabled */
> +	ret = regmap_read(st->regmap, ADXL345_REG_INT_ENABLE, &regval);
> +	if (ret)
> +		return ret;
> +
> +	return adxl345_act_int_reg[type] & regval;
> +}

...

> +	if (type == ADXL345_ACTIVITY) {
> +		axis_ctrl = ADXL345_ACT_X_EN | ADXL345_ACT_Y_EN |
> +				ADXL345_ACT_Z_EN;
> +	} else {
> +		axis_ctrl = 0x00;
> +	}

Besides an indentation issue, {} are redundant.

...

> +	en = false;

This line makes no sense. When it will, it should be there, not in this change.

> +	switch (type) {
> +	case ADXL345_ACTIVITY:
> +		en = FIELD_GET(ADXL345_REG_ACT_AXIS_MSK, axis_ctrl) &&
> +			threshold;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}

...

>  	switch (type) {
> +	case IIO_EV_TYPE_MAG:
> +		switch (info) {
> +		case IIO_EV_INFO_VALUE:
> +			switch (dir) {
> +			case IIO_EV_DIR_RISING:
> +				ret = regmap_read(st->regmap,
> +						  adxl345_act_thresh_reg[ADXL345_ACTIVITY],
> +						  &act_threshold);
> +				if (ret)
> +					return ret;
> +				*val = 62500 * act_threshold;
> +				*val2 = MICRO;
> +				return IIO_VAL_FRACTIONAL;
> +			default:
> +				return -EINVAL;
> +			}
> +		default:
> +			return -EINVAL;
> +		}

As I mentioned before, try to avoid nested switch cases like this. Use helpers
to make this gone to 1 level or so.

>  	case IIO_EV_TYPE_GESTURE:
>  		switch (info) {
>  		case IIO_EV_INFO_VALUE:

Ditto for other similar cases.

...

>  static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
> -			      enum iio_modifier tap_dir)
> +			      enum iio_modifier tap_dir,
> +			      enum iio_modifier act_dir)

If the order of parameters is not so important, I would squeeze new one to be
before the last argument.

-- 
With Best Regards,
Andy Shevchenko



