Return-Path: <linux-iio+bounces-21658-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 136E0B05368
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 09:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 727971AA39E9
	for <lists+linux-iio@lfdr.de>; Tue, 15 Jul 2025 07:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740BE25CC64;
	Tue, 15 Jul 2025 07:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gIo/dORN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4066DF76;
	Tue, 15 Jul 2025 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752565049; cv=none; b=GrQ+sXibDO0j12246J+DzX0j4TQt6IG+M2KG4CEUgST0BQONQAEC8YOe6waT5KXpzAlh94ZEc55fbtCFbC79yvkNqJD9uFjGqvP+NMFr0AeDkp6n9l18gX5BRDuzEmYZOTxBVk5+2hT+vBCZIQiaM2Lb4qi2p/W8ML22ldTDm34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752565049; c=relaxed/simple;
	bh=fXsb3G8xiuntoQgw8qYOGeWugRH4KGw/AFlpKx1i7rs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GTKGmY1BnsXLcF8BUSyLgWpB6Igwpktm8nBTBRSezK0EA68zgD2QkdbxzFjqGMmG+wyVBwwm1SB7JZGAuAKQiQMS+beXc+X3wFDNBZfJR/mNDgUaiLDVMdaxWPP0qzVsVGkmBUm86TEb5maqJGvWzrcM1/bgj87g5tXBlqug3MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gIo/dORN; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752565048; x=1784101048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fXsb3G8xiuntoQgw8qYOGeWugRH4KGw/AFlpKx1i7rs=;
  b=gIo/dORNHfhLWT82YuKxWl3UPmTf/wfMz49j/n8DDzLrex6OEDIHP0KS
   6gyNnnKOW141rTpBR/pzzsUZJmEdGUrNWEtzlfHgv7kNVhjnIlXdmw8gk
   bH5/D9Zt0PhhdhB9AD8kjYS5SswCLEgZW3eft+xyvDb7cfQ5q/z4Lm1sN
   y2oHtrh7m0+0s622THDwlAlaKcuBAQRLcYFJjBKQrS8juLwGIdLP+dIOC
   5Hfrl33ZaPO2qcYeCAGgCOPuZw/q8BRBczz8jBxsYIQbxkH3wbxd85Ss6
   i8X2WKhV+JgvlhFfU84rCKJzY3krbYJxI8czk9ykcNWur828yUcKiigB7
   w==;
X-CSE-ConnectionGUID: YmV76esQQ6KB/ronKfANCA==
X-CSE-MsgGUID: 016af84HTxGEtJfKbPg53g==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="57384028"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="57384028"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:37:27 -0700
X-CSE-ConnectionGUID: FtXZki46QEy5ga5QZrvM6w==
X-CSE-MsgGUID: Samaty+iR2enRSDUbbCLyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="180850732"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 00:37:25 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1ubaE6-0000000FaIl-1PqZ;
	Tue, 15 Jul 2025 10:37:22 +0300
Date: Tue, 15 Jul 2025 10:37:21 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Gustavo Silva <gustavograzs@gmail.com>
Cc: Alex Lanzano <lanzano.alex@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Lothar Rubusch <l.rubusch@gmail.com>
Subject: Re: [PATCH v4 3/3] iio: imu: bmi270: add support for motion events
Message-ID: <aHYFMf8QGDNt-5Nf@smile.fi.intel.com>
References: <20250711-bmi270-events-v4-0-53ec7da35046@gmail.com>
 <20250711-bmi270-events-v4-3-53ec7da35046@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711-bmi270-events-v4-3-53ec7da35046@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 11, 2025 at 08:36:03PM -0300, Gustavo Silva wrote:
> Any-motion event can be enabled on a per-axis basis and triggers a
> combined event when motion is detected on any axis.
> 
> No-motion event is triggered if the rate of change on all axes falls
> below a specified threshold for a configurable duration. A fake channel
> is used to report this event.
> 
> Threshold and duration can be configured from userspace.

...

> +/* 9.81 * 1000000 m/s^2 */
> +#define BMI270_G_MEGA_M_S_2				9810000

I thought this is MICRO...

...

> +#define BMI270_INT_MICRO_TO_RAW(val, val2, scale) \
> +	((val) * (scale) + ((val2) * (scale)) / MEGA)

Side note: Perhaps good candidate to have it in math.h
(AFAIR there are more users of the same.)

> +#define BMI270_RAW_TO_MICRO(raw, scale) \
> +	((((raw) % (scale)) * MEGA) / scale)

...

> +static ssize_t bmi270_show_accel_value_avail(struct device *dev,
> +					     struct device_attribute *attr,
> +					     char *buf)
> +{
> +	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
> +	struct bmi270_data *data = iio_priv(indio_dev);
> +	int ret, scale, uscale;
> +	unsigned int step, max;
> +
> +	ret = bmi270_get_scale(data, IIO_ACCEL, &scale, &uscale);
> +	if (ret)
> +		return ret;
> +
> +	max = BMI270_G_MEGA_M_S_2 / uscale;

...as here we divide 10^6/10^-6 semantically speaking.

> +	step = max / BMI270_MOTION_THRES_FULL_SCALE;
> +
> +	return sysfs_emit(buf, "[0 %u %u]\n", step, max);
> +}

Is this already documented in ABI?

-- 
With Best Regards,
Andy Shevchenko



