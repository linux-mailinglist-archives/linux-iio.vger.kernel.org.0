Return-Path: <linux-iio+bounces-15799-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23027A3C449
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 16:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6289D3B3C14
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 15:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BA01FDE00;
	Wed, 19 Feb 2025 15:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lwlqJK1L"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1069B1FCCE7;
	Wed, 19 Feb 2025 15:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739980580; cv=none; b=XUylcvMQTHPtLp+1+rc8+LciWJ0sGXKX3XJv6XV3F8vwu7dPK9P+lfkWFDmfo70TAn2g1cwzrHhVyJna+hH4CTKdty6V653DCrqifTu2v9O9c+qp4rCuAGh0OAYe5bC3FXtwX/HSx+1pypWz5aVd1CUCkVyCClsrDI9D5Y9LPdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739980580; c=relaxed/simple;
	bh=uV3soKwL+HCNAvSymtrWOzDP+EtcGO1BQkAUCm5Wg+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k8ihoQis5BMrsJSyR+VJ3NK9gH6MxP5xEBTlb5uanFZeKgw6YNb2iELwKlkWVP3iqJQ6aI4GdjdIVn6v4ontKtPuFNhv7X4xQMsswwgcxB9c3c9efBMLpL6Z6JUYYPItloEct+/cC3UHafqbbiEEgaN3vEN2uP3an3ulq2oVOYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lwlqJK1L; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739980579; x=1771516579;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=uV3soKwL+HCNAvSymtrWOzDP+EtcGO1BQkAUCm5Wg+g=;
  b=lwlqJK1LXTvxJ+EWudFro8aZPJMqcJPUT58kxjNEZ30GML6GSKnX9EAB
   liAhzqJS5SDhtwvZcQMnOjFibzq++KcRAtqG30zoRL9mbRMYhlJVvLHWE
   bu52UwMhnVY4w8glg6dMCLs/Ax2z3KE1P99rj0e51sfsjJvOcRvsRVnC5
   0lfWofu3WTokGPBr9X39mAVp1xImbe3esC5xatTO7alkn7svGQ/jSqCQ5
   pxUA0mChaMFS3bJs+yC9z2N5B0T1ehQeC0MuLGKtuS7gybUcwMbHaj3CP
   nsD2xaEGaf+xVJPa2Q/lB0yICi0LRhMeUC1XMs4a4P2ex5jUPk5IiRJc5
   w==;
X-CSE-ConnectionGUID: p18e5709S3i1yRm3An+ukg==
X-CSE-MsgGUID: c4WqoUpRTjW1gzzBzpm1ng==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="44641211"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="44641211"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 07:56:15 -0800
X-CSE-ConnectionGUID: 9tQ7e4C6QyWDwrfSehe6Ew==
X-CSE-MsgGUID: pjGdWZJjSauXppPQLfgMhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="145612236"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 07:23:30 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tkluw-0000000D3ix-2SQZ;
	Wed, 19 Feb 2025 17:23:18 +0200
Date: Wed, 19 Feb 2025 17:23:18 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>,
	Daniel Thompson <danielt@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org, linux-leds@vger.kernel.org,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mfd: lm3533: convert to use OF
Message-ID: <Z7X3ZvQbSe75U-AR@smile.fi.intel.com>
References: <20250218132702.114669-1-clamor95@gmail.com>
 <20250218132702.114669-3-clamor95@gmail.com>
 <Z7XqKcOUt5niXzpv@smile.fi.intel.com>
 <CAPVz0n1_WQyOHhtEVAh53uhEUhZvqqZSEJh6XALtSrVfkMSLYw@mail.gmail.com>
 <Z7XzgfHcjyK_UZKv@smile.fi.intel.com>
 <CAPVz0n2WwAOb1UU7J7aDTdhXXCaAZkCpYjW_nc_CBRgkGWdEOw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n2WwAOb1UU7J7aDTdhXXCaAZkCpYjW_nc_CBRgkGWdEOw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 19, 2025 at 05:13:15PM +0200, Svyatoslav Ryhel wrote:
> ср, 19 лют. 2025 р. о 17:07 Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> пише:
> > On Wed, Feb 19, 2025 at 04:36:38PM +0200, Svyatoslav Ryhel wrote:
> > > ср, 19 лют. 2025 р. о 16:27 Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> пише:

...

> > > MFD part is removed since MFD cells binding is unconditional, while
> > > the device supports any amount of children grater then one. For
> > > example, my  device uses only backlight at bank A, while all other
> > > subdevices are not present and used. This patch switches to dynamic
> > > bind of children.
> >
> > MFD does the same. Please, take your time and get familiar with how MFD works.
> 
> It does not. I have tried. If mfd cell binding is missing, driver will
> complain and fail.

I really don't know what exactly is going on here, you can check it later, but
I'm 100% sure that MFD works for only driver that are present. What you are
describing is how component framework is designed.

To proove my words you can check drivers/mfd/intel_soc_pmic_*.c and find listed
cells that never had a driver in the Linux kernel. They are just placeholders.

...

> > --
> > With Best Regards,
> > Andy Shevchenko

Please, when answering, remove unrelated context from the replies.

...

> Let this driver rot for now, I might return to it. At some point

Up to you. But thanks for trying!

-- 
With Best Regards,
Andy Shevchenko



