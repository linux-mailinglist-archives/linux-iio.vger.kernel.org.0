Return-Path: <linux-iio+bounces-15450-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C202A32B38
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 17:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0BC33A31D4
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 16:10:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A5F211A3F;
	Wed, 12 Feb 2025 16:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RJ7U+0wt"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59D531B21AD;
	Wed, 12 Feb 2025 16:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739376651; cv=none; b=izL0CXY2hdnrcm/s4ZSk//xn/13X1oZ5vXziOfsPYBB3d9BmWUAkwUV8AEnRKyxrwmiiPZYwOzZ04/tRgUyEH+AwEKzp9/+mxj/YbomZwV7ta5/QOYdiDifoEVlClP5cW29tdq3ISVklZA6WWzSIWVjtZGeHdQThCb19ZlpK/jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739376651; c=relaxed/simple;
	bh=ARGKeV1embwkeSEmwa7d0u/VvHoPmhoca3LzkXk9Fuo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tPofwwi5VHWhUIm7ZaNzcbVUt2ucH4SDjX9Lu3CATcgNH/vQ6WIEoulvAVmHAo2InX2A6wVkcUWRMyFqZqV/mzM4pEWbt3gVsOEnRbfpKobSmAf3qLWyi7OiuL7oSE0UDUEgMZ//d0+eCgtMSG5lkUoIxl995tgQiCoEmWsn7j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RJ7U+0wt; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739376650; x=1770912650;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=ARGKeV1embwkeSEmwa7d0u/VvHoPmhoca3LzkXk9Fuo=;
  b=RJ7U+0wtywJKfx96EcDj3SFrr+qo3iuSVi2CAkDShD6GI7Nx0bb4+m/B
   lUmWgPS03MQgPgUlx+WSl2arhhdE4tgklc3rVjV1pOqN/hgrl4VWWI4TB
   Tnt2Xvfx0xuxev2FQhNHHfVmSHccZfyKAtSbYXkdzPduV0JCxQFatrp6G
   cqnFGEKOzIMl7utIl9WFBebaxRKKLJnO+TtZjRTMNIVLZd2h70759jHLi
   D9/3vobhxyqR92/54gWFOb82XxSYPb8PzE3MYzZVBQ4xvDHBoMYneQaMe
   neBNWc4sNPhYbEwIiKhQjvObpn3bvCGwivFvCFwesTinKr3/Nm5jLZZlk
   Q==;
X-CSE-ConnectionGUID: UzMLV5NxSceKUcVAtrMQOg==
X-CSE-MsgGUID: aKUhLuTdTvWv+e+7kJhdrg==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="39744865"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="39744865"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:10:49 -0800
X-CSE-ConnectionGUID: pXka0SYVRLCX4jjNwFzZQA==
X-CSE-MsgGUID: h0CdDmYITay347p06L1vTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117496172"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 08:10:44 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiFJw-0000000At2Z-2uU4;
	Wed, 12 Feb 2025 18:10:40 +0200
Date: Wed, 12 Feb 2025 18:10:40 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Javier Carrasco <javier.carrasco.cruz@gmail.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Emil Gedenryd <emil.gedenryd@axis.com>,
	Arthur Becker <arthur.becker@sentec.com>,
	Mudit Sharma <muditsharma.info@gmail.com>,
	Per-Daniel Olsson <perdaniel.olsson@axis.com>,
	Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
	Ivan Orlov <ivan.orlov0322@gmail.com>,
	David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH v1 2/3] iio: light: Add support for AL3000a illuminance
 sensor
Message-ID: <Z6zIAGLot3YQLo9S@smile.fi.intel.com>
References: <20250212064657.5683-1-clamor95@gmail.com>
 <20250212064657.5683-3-clamor95@gmail.com>
 <Z6ywGgofzU1bvm0H@smile.fi.intel.com>
 <CAPVz0n1UuZPCb3Jdj_fK3Ut7WKBgtvj7aROqJ4YeYVMutuyv7A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n1UuZPCb3Jdj_fK3Ut7WKBgtvj7aROqJ4YeYVMutuyv7A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 12, 2025 at 05:20:04PM +0200, Svyatoslav Ryhel wrote:
> ср, 12 лют. 2025 р. о 16:28 Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> пише:
> > On Wed, Feb 12, 2025 at 08:46:56AM +0200, Svyatoslav Ryhel wrote:

...

> > > +/*
> > > + * AL3000a - Dyna Image Ambient Light Sensor
> > > + */
> >
> > Can be on a single line.
> 
> Patch checking script did not catch this as warning or style issue. If
> such commenting is discouraged than please add this to patch checking
> script. Comments are stripped on compilation anyway, they do not
> affect size.

First of all, it uses verb 'can' for a reason (it's not anyhow big deal).
Second, not all stuff should be documented or scripted, we called it
a "common sense". The common sense rule in the code is: "Do not introduce
lines that are not needed or do not add a value". I see these 3 LoCs can
be replaced without any downsides to 1 LoC and make it even more readable,
less consumable of the resources, and more informative as opening the
first page in the editor will give me more code than mostly unrelated
comments.

...

> > > +#include <linux/bitfield.h>
> > > +#include <linux/i2c.h>
> > > +#include <linux/module.h>
> >
> > > +#include <linux/of.h>
> >
> > No of*.h in the new code, please.
> >
> > > +#include <linux/regulator/consumer.h>
> >
> > Too small headers to be included. You use much more.
> 
> Is there a check which determines the amount of headers I must include
> and which headers are mandatory to be included and which are forbidden
> to inclusion. Maybe at least a list? Thanks

No check, there is IWYU principle.

https://include-what-you-use.org/

The tool is not (yet?) suitable for the Linux kernel project and Jonathan,
who is the maintainer of IIO code, had even tried it for real some time ago.

> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/sysfs.h>

...

> > > +static const u32 lux_table[64] = {
> >
> > I think you don't need 64 to be there, but okay, I understand the intention.
> >
> > > +     1, 1, 1, 2, 2, 2, 3, 4, 4, 5, 6, 7, 9, 11, 13, 16,
> >
> > For the better readability and maintenance put pow-of-2 amount of values per
> > line, like 8, and add the respective comment:
> >
> >         1, 1, 1, 2, 2, 2, 3, 4,                                 /*  0 -  7 */
> >         4, 5, 6, 7, 9, 11, 13, 16,                              /*  8 - 15 */
> >
> > > +     19, 22, 27, 32, 39, 46, 56, 67, 80, 96, 116, 139,
> > > +     167, 200, 240, 289, 347, 416, 499, 600, 720, 864,
> > > +     1037, 1245, 1495, 1795, 2155, 2587, 3105, 3728, 4475,
> > > +     5373, 6450, 7743, 9296, 11160, 13397, 16084, 19309,
> > > +     23180, 27828, 33408, 40107, 48148, 57803, 69393,
> > > +     83306, 100000
> >
> > Leave trailing comma, it's not a terminated list generally speaking
> > (in the future it might grow).
> 
> No, this list will not grow since the bit field seems to be 0x3f
> (datasheet is not available, code is adaptation of downstream driver).

You never know. Sometimes driver is getting reused to support other compatible
HW. Telling you from the experience.

> > > +};

...

> > > +     ret = i2c_smbus_write_byte_data(data->client, AL3000A_REG_SYSTEM, val);
> >
> > Why not using regmap I涎 APIs?
> 
> This adaptation was written quite a long time ago, patch check did not
> complained about using of i2c smbus. Is use of regmap mandatory now?
> Is it somewhere specified? Thanks

It adds a value to the code (in particular debugfs for free and
many nice helper APIs). It's recommended and many maintainers would like
to have it. It's rare that some of the generic framework or library committed
into the kernel just left to become rotten there.

> I am not a full time linux contributor and may not be familiar with
> the recent rules.

Many are not the rules so far, but recommendations and/or preferences by
certain maintainer(s).

-- 
With Best Regards,
Andy Shevchenko



