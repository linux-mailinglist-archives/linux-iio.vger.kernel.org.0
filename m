Return-Path: <linux-iio+bounces-27507-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D20CFB03E
	for <lists+linux-iio@lfdr.de>; Tue, 06 Jan 2026 21:53:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA6B630FDB5D
	for <lists+linux-iio@lfdr.de>; Tue,  6 Jan 2026 20:47:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B1C2EBBBC;
	Tue,  6 Jan 2026 20:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mh7GjfYC"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF0A718E025;
	Tue,  6 Jan 2026 20:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767732445; cv=none; b=oqQDsr11y1WsxLViybbViK4PYW+kVPi651kmCy5gKyQP4C5WqX6i2Rg+D/7IzKmI1VTbixZB0WwNXTyhye1G7dqEAf/uyI8AiGIdK6RqFb4QhmuS37qb3AEoCI2WV9iKeNj9Jy/IL/y+yGz48sW1WO+OqKuvt9bLlUbGWrvRxbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767732445; c=relaxed/simple;
	bh=VfVOPlfZdPaSK69myuoZQ0HV45tCixoJy8KBQlltID4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VKdY365p1bgrAAELufMfI7Jly9+iUmD5jmXGexTfS2YNv7uL9jJjX9Ic6wG3Bab//ll9PLuYThYTU0PzKYP96vlGhvGLgIeObAiErb+jdBJLM080b3jz4n1B9hyLF0XIpZPYVLqUM7ydO61eZO/AW6Of88mWZfRiPrla1cwp4O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mh7GjfYC; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767732444; x=1799268444;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VfVOPlfZdPaSK69myuoZQ0HV45tCixoJy8KBQlltID4=;
  b=Mh7GjfYCMWSzUV9bDJEV7xaPSBrHAs3Y3d7j5k5S90jKjxtFSFCahiws
   fpYPkAsWMIEms+U28DsEnmhgzgMTDgf7mSD+Mu7uBb+3pRVQh/x0hc+Cz
   /XHVJcSEYLcDsQ3rsu3oFHSvIBwY1fxY9bnfx+CUYNxnREX9kNWmmI4zv
   F+n4QYUTdYA4H7qXeaFDrivb3qxI84KOqK1zU4npqXKdHRHUXCQT7/rgt
   KKIetyf84bCulMv3Hv11W842kFmLp1hJ3hp3dCtAAthfqROqjnasYjcgc
   WkbrtrVzRgNCpj2D2o8Ee0UxmQDvtwOfIg7u0/muRGR/hAzS5Cwt6dXSh
   Q==;
X-CSE-ConnectionGUID: TeSmvydgQZ+4fipTfPwEoQ==
X-CSE-MsgGUID: dOqFRqLXRzaXUDyCYzNYwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11663"; a="72960208"
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="72960208"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 12:47:23 -0800
X-CSE-ConnectionGUID: lh4zqpUPTmuaW15F/hEKtw==
X-CSE-MsgGUID: SygAw2PXQeOR6D2N33ZOoA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,206,1763452800"; 
   d="scan'208";a="207292320"
Received: from fpallare-mobl4.ger.corp.intel.com (HELO localhost) ([10.245.245.67])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2026 12:47:20 -0800
Date: Tue, 6 Jan 2026 22:47:17 +0200
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Shrikant <raskar.shree97@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/4] iio: proximity: rfd77402: Add interrupt handling
 support
Message-ID: <aV101TrC5hB_nHJM@smile.fi.intel.com>
References: <20260101-b4-rfd77402_irq-v4-0-42cd54359e9f@gmail.com>
 <20260101-b4-rfd77402_irq-v4-4-42cd54359e9f@gmail.com>
 <aVe7SP914oI-jAam@smile.fi.intel.com>
 <CAHc1_P4dCdt6QFgfZ8OUZGT+UfLqiP_ect7pOsd_HeQaDe8jTg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHc1_P4dCdt6QFgfZ8OUZGT+UfLqiP_ect7pOsd_HeQaDe8jTg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jan 06, 2026 at 05:39:29AM +0530, Shrikant wrote:

...

> > >  #include <linux/module.h>
> > >  #include <linux/i2c.h>
> > >  #include <linux/delay.h>
> > > +#include <linux/interrupt.h>
> > > +#include <linux/completion.h>
> > >  #include <linux/iopoll.h>
> >
> > Same comment as per previous patch. Do not add even more misordering, please.
> Will it be okay if I re-order the includes as below ?
> #include <linux/completion.h>
> #include <linux/delay.h>
> #include <linux/i2c.h>
> #include <linux/interrupt.h>
> #include <linux/iopoll.h>
> #include <linux/module.h>

Just try to squeeze the new inclusions in the longest chain of the sorted ones
(yes, some original ones may be left untouched and hence unordered).

> #include <linux/iio/iio.h>

...

> > > +/**
> > > + * struct rfd77402_data - device-specific data for the RFD77402 sensor
> > > + * @client: I2C client handle
> > > + * @lock: mutex to serialize sensor reads
> > > + * @completion: completion used for interrupt-driven measurements
> > > + * @irq_en: indicates whether interrupt mode is enabled
> > > + */
> > >  struct rfd77402_data {
> > >       struct i2c_client *client;
> > > -     /* Serialize reads from the sensor */
> > >       struct mutex lock;
> > > +     struct completion completion;
> > > +     bool irq_en;
> > >  };
> >
> > The kernel-doc conversion can be a separate patch, but I'm not insisting.
> I can split this into a separate patch within the same series.
> Please let me know if you would prefer it to be handled differently.

It's up to maintainers.

-- 
With Best Regards,
Andy Shevchenko



