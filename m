Return-Path: <linux-iio+bounces-20546-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E5387AD70BC
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 14:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B74571BC07F9
	for <lists+linux-iio@lfdr.de>; Thu, 12 Jun 2025 12:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B163922FF35;
	Thu, 12 Jun 2025 12:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g+CNHlCq"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16132F432C;
	Thu, 12 Jun 2025 12:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749732492; cv=none; b=GSEUbLuRTUgM3zV3odB2ObSPDwXiOVDv+aM4Dm8sFyGS+IyTk1lY2wXBv0NFpxbPKGXT+R7AJgYFv77D5PptVmneVrlnLDdC2+p5qQp4rHHPbw7DONsT7qcDqdcHg4pGpG338jb6FD7Uthl967fURJegYb8JtStqlkVAYeQw3dQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749732492; c=relaxed/simple;
	bh=Fjp9hcmXAIrCkfYCQtqV83QQT9g0u4DPzSNaZbioKKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqGtM9QxaefmLEnFXhZ822opaN2I5OF/7y3PFO3unZwgivOQHtCli/h/6SL0E5P4yRD1kWyjQDXHCz4A0tOzhW1TmvIKHyewHZiWLAuMGZlhtfsDibe+zioyksf5pQ05YUaw6hvwQOWysXvFuPK2He5KNCce0g6bo8DN16CtjIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g+CNHlCq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749732491; x=1781268491;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Fjp9hcmXAIrCkfYCQtqV83QQT9g0u4DPzSNaZbioKKM=;
  b=g+CNHlCq0InXuXmU9CDXOTcmPMg0gXlRI27eFCwOY08aSf6ISFbTQhq6
   RagmoBGcqK1ipgyFAL8rkB5nKV0yHNUpN64lrwz0qdMT1nIcXpc5G/fmS
   3mw/o3WbulpKOsaa6CnyFIn87NiAuCalWfdP3u9gkppkfU5Z/hQTJKwT5
   Ygu3YE27THdDWa6aEHePAmFeM+u9kaFsB/0Uea2EsupoqN4OLeokrJQT+
   x/8b4WxWeAGqGOpNjcG2B55wKzALTljD0PV+L0Jk/P10h1UL9egx/3bvo
   Fg2umBaRjklkb2TgYrXzYvQE1k1ahDAri6ViajAUeDx0MUaXLXOw3KkLL
   w==;
X-CSE-ConnectionGUID: eJlamKFvQlyD9WdNgHJ7WA==
X-CSE-MsgGUID: 2/7kVuruTVuLt8uhzk3t1g==
X-IronPort-AV: E=McAfee;i="6800,10657,11462"; a="55582807"
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="55582807"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 05:48:10 -0700
X-CSE-ConnectionGUID: 6hrNdlaVQpmn9K1K+Vr+jA==
X-CSE-MsgGUID: X9pY8ZHGQNiXuIxi6mZ8ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,230,1744095600"; 
   d="scan'208";a="178414898"
Received: from smile.fi.intel.com ([10.237.72.52])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2025 05:48:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uPhLe-00000005x4y-2rhE;
	Thu, 12 Jun 2025 15:48:02 +0300
Date: Thu, 12 Jun 2025 15:48:02 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Marcelo Schmitt <marcelo.schmitt@analog.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ana-Maria Cusco <ana-maria.cusco@analog.com>, jic23@kernel.org,
	lars@metafoo.de, Michael.Hennerich@analog.com,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, linus.walleij@linaro.org,
	brgl@bgdev.pl
Subject: Re: [PATCH v5 02/11] iio: adc: Add basic support for AD4170
Message-ID: <aErMgh6AKVStF4rQ@smile.fi.intel.com>
References: <cover.1749582679.git.marcelo.schmitt@analog.com>
 <48598c0753cccf515addbe85acba3f883ff8f036.1749582679.git.marcelo.schmitt@analog.com>
 <aEifWXPV1nsIyWbT@smile.fi.intel.com>
 <aEnvcaP2ZNPLhzXi@debian-BULLSEYE-live-builder-AMD64>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aEnvcaP2ZNPLhzXi@debian-BULLSEYE-live-builder-AMD64>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Wed, Jun 11, 2025 at 06:04:49PM -0300, Marcelo Schmitt wrote:
> On 06/11, Andy Shevchenko wrote:
> > On Tue, Jun 10, 2025 at 05:31:25PM -0300, Marcelo Schmitt wrote:

...

> > > +	return spi_write(st->spi, st->tx_buf, size + 2);
> > 
> > ... + sizeof(reg) ?
> 
> The size of the specific ADC register is stored in the size variable.
> The result of sizeof(reg) can be different on different machines and will
> probably not be equal to the size of the register in the ADC chip.

Hmm... But shouldn't we have a variable type that respects the sizeof() of the
register in HW to keep it there? 2 is magic.

...

> > > +static bool ad4170_setup_eq(struct ad4170_setup *a, struct ad4170_setup *b)
> > > +{
> > > +	/*
> > > +	 * The use of static_assert() here is to make sure that, if
> > > +	 * struct ad4170_setup is ever changed (e.g. a field is added to the
> > > +	 * struct's declaration), the comparison below is adapted to keep
> > > +	 * comparing each of struct ad4170_setup fields.
> > > +	 */
> > 
> > Okay. But this also will trigger the case when the field just changes the type.
> > So, it also brings false positives. I really think this is wrong place to put
> > static_assert(). To me it looks like a solving rare problem, if any.
> 
> I think it is unlikely that struct ad4170_setup declaration will ever change.
> The fields match the registers that are associated with a channel setup and
> the their types match the size of the respective registers. So, I do agree
> that triggering this assert would be something rare.

Yep, which thinks to me as an unneeded noise in the code, making it harder to
read and maintain (in _this_ case).

> > But I leave this to the IIO maintainers.
> > 
> > In my opinion static_assert() makes only sense when memcmp() is being used.
> > Otherwise it has prons and cons.
> 
> I think the most relevant reason to have this static_assert would be to keep
> some consistency with ad4130, ad7124, and ad7173, but no strong opinion about it.

I would argue that those needs to be revisited for the same reasons as above.

> Actually, I don't get why static_assert() would only matter if memcmp() was
> being used. Would it be better to not bother if the fields change type?
> 
> Anyway, I'll go with whatever be IIO maintainer's preference.

> > > +	static_assert(sizeof(*a) ==
> > > +		      sizeof(struct {
> > > +				     u16 misc;
> > > +				     u16 afe;
> > > +				     u16 filter;
> > > +				     u16 filter_fs;
> > > +				     u32 offset;
> > > +				     u32 gain;
> > > +			     }));
> > > +
> > > +	if (a->misc != b->misc ||
> > > +	    a->afe != b->afe ||
> > > +	    a->filter != b->filter ||
> > > +	    a->filter_fs != b->filter_fs ||
> > > +	    a->offset != b->offset ||
> > > +	    a->gain != b->gain)
> > > +		return false;
> > > +
> > > +	return true;
> > > +}

...

> > > +	/* Assume AVSS at GND (0V) if not provided */
> > > +	st->vrefs_uv[AD4170_AVSS_SUP] = ret == -ENODEV ? 0 : -ret;
> > 
> > -ret ?!?!
> 
> That's because AVSS is never above system ground level (i.e. AVSS is either GND
> or a negative voltage). But we currently don't have support for reading negative
> voltages with the regulator framework. So, the current AD4170 support reads
> a positive value from the regulator, then inverts signal to make it negative :)

This needs a good comment and ideally a TODO item in the regulator framework.
(It might be easy to implement by adding a flag without changing the type of
 the field, if it's unsigned.)

> > Even if you know that *now* it can't have any other error code, it's quite
> > fragile.
> 
> Yeah, I guess ADCs that can take bipolar power supplies are not that common.
> I couldn't think of any better way to have that, though.

-- 
With Best Regards,
Andy Shevchenko



