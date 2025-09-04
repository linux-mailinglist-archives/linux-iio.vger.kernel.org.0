Return-Path: <linux-iio+bounces-23712-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B280BB43CD7
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 15:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5120EA030DA
	for <lists+linux-iio@lfdr.de>; Thu,  4 Sep 2025 13:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF051AA7A6;
	Thu,  4 Sep 2025 13:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QOEeWodh"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1855C5B21A;
	Thu,  4 Sep 2025 13:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756991841; cv=none; b=GftW2Xlyp5TlkzEuJ4huG+ha+gIrFKW/B1VF39St8liTteYraF6bG3WJ9s+0gymkgtBLzpRnezyK0qhDdibzYopjmqKMrd/8IYYnE9kIY3jckPVCVOu2I67BfP2WciMxdQyJrwe0Jc7IY7OziC/J5Q2d6XTROeaM2WtIbg2aaxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756991841; c=relaxed/simple;
	bh=GZgfMe3TroFvgjok++upgu6x7x/+2ppU32692Lp6mmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bg6YILNLlfMncHOZwJcTb4qoALJz4+yp1dmzCQio0OkpGIXgzqLek7tt72Z4Sl8+isPzd5QkSWBIkutCeG3mpQNzUaV5hfNKzaXG2b7owCK9MaTIy4qqiUOJIilnvNUnfeYsI7jccjz9lqCod7r/1wM9yPt6sZAUevJwyWmu0gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QOEeWodh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756991840; x=1788527840;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GZgfMe3TroFvgjok++upgu6x7x/+2ppU32692Lp6mmc=;
  b=QOEeWodhWPEPEXXY7psOMVDQOJ5Syjz4NJeLfHmh+zdDpL+4CifkW7jQ
   9VZI3SqdK6yZR76G7rQgyN7aK7UyeCa4eKKXuFtWwdKiyNrFqiVdGjLsE
   OMmtN6TN9QhoS27eRNZsvs+UskuZfxXZXP10r1inJBv4XNYVgUCPXKO4g
   nDcypMeji8/+FzRVUdByODVj8sljgDUMyOsy8DcMRzHxJwFD3QSFgVx5x
   1VFrjPD8xQCHmtM2BKTbTVoSAgRoMN7T0YUfCZsgjlSFIKmV99WIdnD3B
   JVAIGYWS73BR5kSR7UCJrxm8pZgt7DR+uWHaP/ZhrT2b89Z25ffj65Cdi
   Q==;
X-CSE-ConnectionGUID: b/a73pBrS8GwFsVXA/Jlew==
X-CSE-MsgGUID: rGMAOR9mSUmzNDZt4hH2pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11542"; a="59186411"
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="59186411"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:17:18 -0700
X-CSE-ConnectionGUID: w93+n0GzT2OyFR+vp0DBrQ==
X-CSE-MsgGUID: 27dCC6muRWibyP4Fg4Z32Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,238,1751266800"; 
   d="scan'208";a="172256644"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2025 06:17:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uu9pw-0000000BHAS-3fE4;
	Thu, 04 Sep 2025 16:17:12 +0300
Date: Thu, 4 Sep 2025 16:17:12 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Remi Buisson <Remi.Buisson@tdk.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 2/9] iio: imu: inv_icm45600: add new inv_icm45600
 driver
Message-ID: <aLmRWHZ-fNYjeYll@smile.fi.intel.com>
References: <20250820-add_newport_driver-v5-0-2fc9f13dddee@tdk.com>
 <20250820-add_newport_driver-v5-2-2fc9f13dddee@tdk.com>
 <aKbgt_g3FsLMM8-g@smile.fi.intel.com>
 <FR2PPF4571F02BCC073F7740CBA818676388C00A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FR2PPF4571F02BCC073F7740CBA818676388C00A@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Sep 04, 2025 at 12:58:10PM +0000, Remi Buisson wrote:
> >From: Andy Shevchenko <andriy.shevchenko@intel.com> 
> >Sent: Thursday, August 21, 2025 11:03 AM
> >On Wed, Aug 20, 2025 at 02:24:20PM +0000, Remi Buisson via B4 Relay wrote:

...

> >> +struct inv_icm45600_state {
> >> +	struct mutex lock;
> >
> >No header for this.
> 
> Correct

Please, add.

...

> >> +	struct regmap *map;
> >
> >No forward declaration.
> 
> Correct again

Ditto.

...

> >> +	struct regulator *vddio_supply;
> >
> >Ditto.
> 
> Correct

Ditto.

...

> >> +static const struct regmap_config inv_icm45600_regmap_config = {
> >> +	.reg_bits = 16,
> >> +	.val_bits = 8,
> >
> >No cache?
> >
> If OK for you, we prefer to push this patch without cache.
> And introduce it in another patchset.

Fine to me if there is a comment given (in the email, not in the code) to
justify this split. Enabling cache is one line, but, of cource, it might
require a cache handling in the corner or special cases.

> >> +};

...

> >> +/**
> >> + *  inv_icm45600_setup() - check and setup chip
> >> + *  @st:	driver internal state
> >> + *  @chip_info:	detected chip description
> >> + *  @reset:	define whether a reset is required or not
> >> + *  @bus_setup:	callback for setting up bus specific registers
> >> + *
> >> + *  Returns 0 on success, a negative error code otherwise.
> >
> >Please, run kernel-doc validator. It's not happy (Return section is missing)
> 
> kernel-doc does not complain on this, on my side. 
> I ran kernel-doc.py -v -none drivers/iio/imu/inv_icm45600/*
> Is there any option I'm missing.
> Anyway, I will add the missing colon and check the result.

-Wall is missed in the command line.

> >> + */

...

> >> +		if (val == U8_MAX || val == 0)
> >
> >Hmm... Perhaps in_range() ?
> 
> Not sure of the benefit of this change.
> I prefer to keep it this way if OK for you.

It depends on the semantics of the value in the 'val'. And hence semantics of 0
and U8_MAX.

> >> +			return dev_err_probe(dev, -ENODEV,
> >> +					     "Invalid whoami %#02x expected %#02x (%s)\n",
> >> +					     val, chip_info->whoami, chip_info->name);

...

> >> +		ret = regmap_write(st->map, INV_ICM45600_REG_MISC2,
> >> +				   INV_ICM45600_MISC2_SOFT_RESET);
> >> +		if (ret)
> >> +			return ret;
> >> +		/* IMU reset time: 1ms. */
> >> +		fsleep(1000);
> >
> >Use 1 * USEC_PER_MSEC and drop useless comment after that.
> >You will need time.h for it.
> 
> Thanks for the tip, clear improvement.
> >
> >> +
> >> +		if (bus_setup) {
> >> +			ret = bus_setup(st);
> >> +			if (ret)
> >> +				return ret;
> >> +		}
> >> +
> >> +		ret = regmap_read(st->map, INV_ICM45600_REG_INT_STATUS, &val);
> >> +		if (ret)
> >> +			return ret;
> >> +		if (!(val & INV_ICM45600_INT_STATUS_RESET_DONE)) {
> >> +			dev_err(dev, "reset error, reset done bit not set\n");
> >> +			return -ENODEV;
> >> +		}
> >
> >...
> >
> >> +static int inv_icm45600_enable_regulator_vddio(struct inv_icm45600_state *st)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = regulator_enable(st->vddio_supply);
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	/* Wait a little for supply ramp. */
> >> +	fsleep(3000);
> >
> >As per above.
> Yes.

For both cases actually you can leave a comment, but rewrite it in a way that
it refers to the datasheet. This will be useful.

> >> +	return 0;
> >> +}

...

> >> +	/* IMU start-up time. */
> >> +	fsleep(100000);
> >
> >100 * USEC_PER_MSEC
> Yes.

As per above.

...

> >> +	scoped_guard(mutex, &st->lock)
> >> +		/* Restore sensors state. */
> >> +		ret = inv_icm45600_set_pwr_mgmt0(st, st->suspended.gyro,
> >> +						st->suspended.accel, NULL);
> >
> >With guard()() this whole construction will look better.
> 
> It's coming in later patch.
> I thought it would better follow coding guidelines this way.
> But let me know if it is not the case.

Ah, yes, but weren't {} missing?

> >> +	return ret;

-- 
With Best Regards,
Andy Shevchenko



