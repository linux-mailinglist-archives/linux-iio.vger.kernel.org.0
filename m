Return-Path: <linux-iio+bounces-15455-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 127F9A32D86
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 18:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAB9E163D4C
	for <lists+linux-iio@lfdr.de>; Wed, 12 Feb 2025 17:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5703E25A351;
	Wed, 12 Feb 2025 17:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d8IwQx5v"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55A54271829;
	Wed, 12 Feb 2025 17:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739381570; cv=none; b=QHbfTZDt+vZiNrnf0eURwyGrO8j4b+AmKfCVRKfat6K3F5WoabL8uBNYJShgOcjXk1OrEXZeK5Lxm0HhLBjis0fULcznwhgSE4wpyKotUzk2HaaojeWPS1ZvZcR1xfVbpCABXPcL7e70F/0/3koHLk8JE5ivNcb83tPoZzwGMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739381570; c=relaxed/simple;
	bh=TsAUZDN7dw/ozl9tzhSbG2kUks+xD1sddY6H6S783ic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvhMnTF5WZfWfjKfxjQq8eoW0+9IVW+EI/RSOrzqGJP3Wj21r2WQTZ50FuCxXeWG+r/Di5WSh681WFzwCmlVQ/Amzh5cZYhIc7jbbYlLzIQjjf42sHoxXwGf7kqEtRFPx8VVDKVwGI3h2MTq+hLmUk6GBjDOO+GCAxvNbKEaSqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d8IwQx5v; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739381568; x=1770917568;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=TsAUZDN7dw/ozl9tzhSbG2kUks+xD1sddY6H6S783ic=;
  b=d8IwQx5vYRSvj5olKnmWXaXg594i3QfA9NlT37OyIPcJKz7YLB2Qbwvz
   sYq0QC9PIQTip3ST3lZxvAkMy7mrfK5O3nL2vILoTCDWhYvy8kfKY8o1y
   FQg57HcSp6kxkEgdfYKCjIzm/CWQnhOdG6DkmrS3se/sL93SrHQUDC1Ld
   x2ib3zqxNb4v0Sj6rCZncs1XB0hf8aN73E6veY4PELQcNwzzA8Zutm7y5
   uX1veO3pU75HC5GlzmWNDNO/jaN7h3v2OChLLWSEijM/zyA/pUNJfU1dT
   Q0J/7wp2LvspDl1muVgbX4wCiDmux6NpRWmRe8l+BpKEexKvjW7Bo9pBT
   A==;
X-CSE-ConnectionGUID: YjMzeyO3SQe4w7xWlUIykQ==
X-CSE-MsgGUID: z8geW/MQR0ueqB9BarC9aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11343"; a="62520857"
X-IronPort-AV: E=Sophos;i="6.13,280,1732608000"; 
   d="scan'208";a="62520857"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 09:32:47 -0800
X-CSE-ConnectionGUID: pBozJAGsQ2GYbDJd89JYmA==
X-CSE-MsgGUID: SwvQ+c5+Tm6OzSEl8XKpdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="117831698"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 09:32:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tiGbH-0000000AuIS-1VRs;
	Wed, 12 Feb 2025 19:32:39 +0200
Date: Wed, 12 Feb 2025 19:32:39 +0200
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
Message-ID: <Z6zbN4fjD1YUQlDI@smile.fi.intel.com>
References: <20250212064657.5683-1-clamor95@gmail.com>
 <20250212064657.5683-3-clamor95@gmail.com>
 <Z6ywGgofzU1bvm0H@smile.fi.intel.com>
 <CAPVz0n1UuZPCb3Jdj_fK3Ut7WKBgtvj7aROqJ4YeYVMutuyv7A@mail.gmail.com>
 <Z6zIAGLot3YQLo9S@smile.fi.intel.com>
 <CAPVz0n1Mf02GvSBd_TOuNiuCVTTOx4-228qkdf-JL_eqGCh2MA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n1Mf02GvSBd_TOuNiuCVTTOx4-228qkdf-JL_eqGCh2MA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 12, 2025 at 06:36:37PM +0200, Svyatoslav Ryhel wrote:
> ср, 12 лют. 2025 р. о 18:10 Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> пише:
> > On Wed, Feb 12, 2025 at 05:20:04PM +0200, Svyatoslav Ryhel wrote:
> > > ср, 12 лют. 2025 р. о 16:28 Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> пише:
> > > > On Wed, Feb 12, 2025 at 08:46:56AM +0200, Svyatoslav Ryhel wrote:

...

> > > > > +#include <linux/i2c.h>
> > > > > +#include <linux/module.h>
> > > >
> > > > > +#include <linux/of.h>
> > > >
> > > > No of*.h in the new code, please.
> > > >
> > > > > +#include <linux/regulator/consumer.h>
> > > >
> > > > Too small headers to be included. You use much more.
> > >
> > > Is there a check which determines the amount of headers I must include
> > > and which headers are mandatory to be included and which are forbidden
> > > to inclusion. Maybe at least a list? Thanks
> >
> > No check, there is IWYU principle.
> >
> > https://include-what-you-use.org/
> >
> > The tool is not (yet?) suitable for the Linux kernel project and Jonathan,
> > who is the maintainer of IIO code, had even tried it for real some time ago.
> 
> So it is not adopted by the Linux kernel.
> Lets return to this once it will be adopted.

I understand you want to push your way, but here is the thing. This is a
community of people and review is not something that comes for free. People,
who are reviewing a code, want to make sure the code follows not only
documented style, etc., but also common sense and the future maintenance.
When a contributor comes and drops something into Linux Kernel project
it adds a lot of work on maintainers' shoulders and other contributors
who may be in progress of solving the other tasks. I specifically sent
you a link where the tool and the principle is _explained_. So, it's not
about the tool, it's about the whole project to become better and easier
to maintain. You are a new guy in the development as you stated, so,
please try to see how this all works.

Of course, the last word here is Jonathan's as he is the maintainer of IIO,
but I truly believe he will suggest you to follow my advice and not otherwise.

> > > > > +#include <linux/iio/iio.h>
> > > > > +#include <linux/iio/sysfs.h>

...

I assume the non-commented parts you are satisfied with and they will be
addressed as suggested. Thank you!

-- 
With Best Regards,
Andy Shevchenko



