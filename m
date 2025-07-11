Return-Path: <linux-iio+bounces-21566-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A61EFB01B43
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 13:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8AEC641210
	for <lists+linux-iio@lfdr.de>; Fri, 11 Jul 2025 11:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB3E28CF74;
	Fri, 11 Jul 2025 11:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aknrRFNN"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC71175D47;
	Fri, 11 Jul 2025 11:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234965; cv=none; b=E3rYEl7C2cLXi3onB+Mb1lkmXyJmnDMRadtCp/RlL02wKXYrIAytLrUIGVGjYpSfULlq31JopBi+gzwiScxiGVbyX5gfNHV81AbbZg9UWuMOVMWGkSgmoFm+2uMbqFfDZReKk84y/wS5xYz8DGlUPtKUB2H169Y1IqmBADIkrrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234965; c=relaxed/simple;
	bh=uSKd2RVB0tIwRPjad+fXye8jIGKv7bJIxmADcCDmtuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iMRPt9g4SfykkVEMrHI15uvgeUlyIAqcY7bxn8dKT0pKOCZ5RAYuN5orYOK23j1daIbgV4xoAkdzbwsR47bEHsaMviIcogdcsTT+CDS2qNHIL8nnFdi2XR7Rc39olVKSC36RJMv1rRi9mlgj6tg8mJcpho79yi2ciFWLLzrOnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aknrRFNN; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752234964; x=1783770964;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uSKd2RVB0tIwRPjad+fXye8jIGKv7bJIxmADcCDmtuo=;
  b=aknrRFNNtxe4yQtijIJ0ptV3/Dsbys+56XlbsiPZGGqNGW4r/yZIYGj1
   +wz+eAZwCTt2N3V2avwFVBX5nFladOj7JULNFSPJ1L/nWNakQ1R0Ig/yQ
   lBQfqi0w0KobFSwVplnKX4CBkOjHYPSXUzozTG5I55+N+l1/qozw1Yyg+
   v1khpZ2zli4P9YZri0iQgsAdZDghavVLA2OUo7kP4KL33cu6q7HAqPhHZ
   V7R6B92QwHhXlGfNcb1NM7DnXa4NobRMBWBpre03pRr5xtERTKONEeuBF
   /+C0AigKWWsrJnEqaRZfL7W820rHux41UV0Dad/Em5DEglYIY3NspIcAO
   w==;
X-CSE-ConnectionGUID: PMsgIrJ5RRam9Lrcf49Y9Q==
X-CSE-MsgGUID: +NOvohlfR0mVNzLanjVq7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="58294193"
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="58294193"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 04:56:02 -0700
X-CSE-ConnectionGUID: +NPLzskRQ0ya3OSvAnbJwA==
X-CSE-MsgGUID: avaESkGATuiIlGzGyW/riQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,303,1744095600"; 
   d="scan'208";a="156137560"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 04:56:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@intel.com>)
	id 1uaCM8-0000000EVtS-1Wr8;
	Fri, 11 Jul 2025 14:55:56 +0300
Date: Fri, 11 Jul 2025 14:55:56 +0300
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
Subject: Re: [PATCH v2 2/8] iio: imu: inv_icm45600: add new inv_icm45600
 driver
Message-ID: <aHD7zEzvVuwSB9Ke@smile.fi.intel.com>
References: <20250710-add_newport_driver-v2-0-bf76d8142ef2@tdk.com>
 <20250710-add_newport_driver-v2-2-bf76d8142ef2@tdk.com>
 <aG-ID7O3HgVc1EOX@smile.fi.intel.com>
 <FR2PPF4571F02BC5366477EC02E9C44041A8C4BA@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FR2PPF4571F02BC5366477EC02E9C44041A8C4BA@FR2PPF4571F02BC.DEUP281.PROD.OUTLOOK.COM>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Fri, Jul 11, 2025 at 11:32:48AM +0000, Remi Buisson wrote:
> >From: Andy Shevchenko andriy.shevchenko@intel.com<mailto:andriy.shevchenko@intel.com>
> >Sent: Thursday, July 10, 2025 11:30 AM
> >To: Remi Buisson Remi.Buisson@tdk.com<mailto:Remi.Buisson@tdk.com>
> >On Thu, Jul 10, 2025 at 08:57:57AM +0000, Remi Buisson via B4 Relay wrote:

...

> >> +struct inv_icm45600_sensor_conf {
> >> +       int mode;
> >> +       int fs;
> >> +       int odr;
> >> +       int filter;
> >
> >Any of them can hold negative value?
> 
> Yes, when setting the configuration, a negative value means "keep previous configured value".
> Like in the INV_ICM45600_SENSOR_CONF_INIT macro below.

I see, but can't it be as simple as "big number" with the proper type instead?

#define ..._KEEP_VALUE		U8_MAX // or whatever type

> >> +};

...

> >> +#define INV_ICM45600_SENSOR_CONF_INIT                        {-1, -1, -1, -1}
> >
> >Unused.
> This is used in later patch of the serie.
> I will move this definition to the patch using it.

Yes, unused in this code. You should compile the series incrementally,
so each patch will get a compilation test. This is called compile-time
bisectability. Also run the system each time to confirm no regressions
(this is called run-time bisectability).

...

> >> +                      udelay(INV_ICM45600_IREG_DELAY_US);
> >
> >Can fsleep() be used here?
> I will use fsleep there.
> Is it recommended to use fsleep everywhere else in place of other sleep APIs?

Not everywhere, but in general yes, if in doubt, use it (but the author is
the one who knows their the code and answer to this question).

...

> It's probably safer to keep the delay even in case of failure to make sure
> the device is ready before next operation.

I am not sure about it. Why? This has to be well justified as it's quite
unusual pattern.

-- 
With Best Regards,
Andy Shevchenko



