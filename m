Return-Path: <linux-iio+bounces-21306-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7F3AF7751
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 16:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DF8118887B7
	for <lists+linux-iio@lfdr.de>; Thu,  3 Jul 2025 14:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42FD72EA160;
	Thu,  3 Jul 2025 14:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cZnRlvEi"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905F22EA146;
	Thu,  3 Jul 2025 14:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751552686; cv=none; b=NvlowkMCVSdOCl+7wIz1WHiJSFPvKpF4ERmjerfEU4WfhEqmbDUJj+qMUlkMgBCO+iNb6lzA/88LjI74PxT3FAKLnXG/fbLTA2F17psmJZCxFGEle9R6owpCi/NXl2zcJelbIoV1awtUolHy/W4g0VP59kJ1FuhPWyS8W3zs7iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751552686; c=relaxed/simple;
	bh=yffRsJc1NP8ufrxOyID0lhAqiUfJnx3U+dSGYmPc99M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p6yyz03uay+4lIE2dblloZOczZmmUFOJ6v7vstEv+lrv6k+emd8kQf0tgk3P2MXTBnfycQpUd8Rdq2s6dyTV5l3++Fwq3jnMn45D6iCJhyh1CxJjMX7kovpoZ34HudvcO/jzcq6SFpqcIPjSOHLhB8Hbq87HcfWWgSHR0Zem4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cZnRlvEi; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751552685; x=1783088685;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yffRsJc1NP8ufrxOyID0lhAqiUfJnx3U+dSGYmPc99M=;
  b=cZnRlvEiaVCsr0TAW37LpfD1WioeZlKyAFCwuoVOVmnSx3wy9kiBRV7v
   LW7uUb3PrAAbLO7DX/zkMQZ4ujIEAZD35oDO8p1/Q2ziGHmB0kGGWe52q
   fDRM1uTeL3Lsn/2wYx7mNAezBCtCgAXDdhZ+DDkkuppqOUXlYcrrZbusE
   Dba+YIFwM7i4Ek2TXRGVpD4MgamTV6lZu34vPPRX3ytJL/Qf1pfi6WJ0G
   cOsh4Yvp/fqeq3EZ+c+cEFJEwDYq1ommusqJiw9mLLbrDwfUDwRpBJ7qd
   WblzbeuWgWT3IWJkwYTtif819PQ5NMM8GSm7J2TlpcX/OfL8hrYzEOJVH
   w==;
X-CSE-ConnectionGUID: R2JP4IUkRdOEZWpx0kzi9g==
X-CSE-MsgGUID: qsjh7FexQbycbu6Y1kd/yQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11483"; a="71319474"
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="71319474"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:24:35 -0700
X-CSE-ConnectionGUID: BLmQb38oR9mtgRqeofVSAg==
X-CSE-MsgGUID: Ru4B9lFJR6u9+aUhkef4gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,284,1744095600"; 
   d="scan'208";a="158748497"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2025 07:24:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uXKrJ-0000000CE64-3nOA;
	Thu, 03 Jul 2025 17:24:17 +0300
Date: Thu, 3 Jul 2025 17:24:17 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Lothar Rubusch <l.rubusch@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	corbet@lwn.net, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	eraretuya@gmail.com
Subject: Re: [PATCH v11 3/8] iio: accel: adxl345: add activity event feature
Message-ID: <aGaSkQHQKCqfrVXF@smile.fi.intel.com>
References: <20250702230315.19297-1-l.rubusch@gmail.com>
 <20250702230315.19297-4-l.rubusch@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702230315.19297-4-l.rubusch@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jul 02, 2025 at 11:03:10PM +0000, Lothar Rubusch wrote:
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

>  #define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
>  #define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3)
>  #define ADXL345_REG_TAP_SUPPRESS	BIT(3)
> +#define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
>  
>  #define ADXL345_TAP_Z_EN		BIT(0)
>  #define ADXL345_TAP_Y_EN		BIT(1)
>  #define ADXL345_TAP_X_EN		BIT(2)
>  
> +#define ADXL345_ACT_Z_EN		BIT(4)
> +#define ADXL345_ACT_Y_EN		BIT(5)
> +#define ADXL345_ACT_X_EN		BIT(6)
> +#define ADXL345_ACT_XYZ_EN		(ADXL345_ACT_Z_EN | ADXL345_ACT_Y_EN | ADXL345_ACT_X_EN)

I'm trying to understand the logic behind the placement of the masks and bits.
To me it sounds that the above should be rather

#define ADXL345_REG_TAP_AXIS_MSK	GENMASK(2, 0)
#define ADXL345_TAP_Z_EN		BIT(0)
#define ADXL345_TAP_Y_EN		BIT(1)
#define ADXL345_TAP_X_EN		BIT(2)
#define ADXL345_REG_TAP_SUPPRESS_MSK	BIT(3) // Do we need this at all?
#define ADXL345_REG_TAP_SUPPRESS	BIT(3) // or actually this? One is enough, no?
#define ADXL345_REG_ACT_AXIS_MSK	GENMASK(6, 4)
#define ADXL345_ACT_Z_EN		BIT(4)
#define ADXL345_ACT_Y_EN		BIT(5)
#define ADXL345_ACT_X_EN		BIT(6)
#define ADXL345_ACT_XYZ_EN		(ADXL345_ACT_Z_EN | ADXL345_ACT_Y_EN | ADXL345_ACT_X_EN)

(Yes, I know that the mess is preexisted, but try to keep some order in the
 pieces you add here.)

...

> +		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
> +			BIT(IIO_EV_INFO_VALUE),

I would expect one of the below (indentation) styles

		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
				       BIT(IIO_EV_INFO_VALUE),

		.mask_shared_by_type =
			BIT(IIO_EV_INFO_ENABLE) |
			BIT(IIO_EV_INFO_VALUE),

...

>  static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
> -			      enum iio_modifier tap_dir)
> +			      enum iio_modifier tap_dir,
> +			      enum iio_modifier act_dir)

Hmm... Why not

static int adxl345_push_event(struct iio_dev *indio_dev, int int_stat,
			      enum iio_modifier act_dir,
			      enum iio_modifier tap_dir)

?

-- 
With Best Regards,
Andy Shevchenko



