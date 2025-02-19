Return-Path: <linux-iio+bounces-15795-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3AF2A3C322
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 16:08:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD35175EA5
	for <lists+linux-iio@lfdr.de>; Wed, 19 Feb 2025 15:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4271F4169;
	Wed, 19 Feb 2025 15:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Xj5AiI7F"
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92E51DF25E;
	Wed, 19 Feb 2025 15:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739977664; cv=none; b=E2yD7X45xi+mqL744h84CpaQhDue0Pr4J/aC5HdfqCBxLy7UWslure1n8SMFX6lJLC4v9n6MVPx4MOVkn7tebdx5jhQJtfoI/P28tJ0Ps7JUWeZJezw6eWu61NoCQW+m4i2TezJNDfDttBA0RQVCuT/r7vmBUxBullQzI8BN0GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739977664; c=relaxed/simple;
	bh=qLMt/EjgXexfc92vAw0wlJWhv6oYot1ftBwA0iHaP28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rv3WSnDDeBuhDrHBOSxX9yoUWC6aQ0aI38e3iF+VXP+YkGo0B2niSyRp9pawU+pY9mhyBc8qhFqV37SgcCbkpEkWQhIxNCmrAOf58uIuFfcnemvLXgBsBFgP57ZTNLX5q0184oaA4ROj9wiqO3EqH92aLYAAeVt3mEuo3af+6/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Xj5AiI7F; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739977663; x=1771513663;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=qLMt/EjgXexfc92vAw0wlJWhv6oYot1ftBwA0iHaP28=;
  b=Xj5AiI7FF6KiB88fqeQCPpravKK4AxGKyw969UnEU7OUiieC891tlh8V
   v9LjCdsYL/C9ewE91wWFcwRpOpphd66smVmFRmKB/yCbe+9lwgiq0PCZw
   uiLamkeyV8wh5PbMjwaOArdCsPSFbHHIXB8kcgvRqLfsjKOx1qf2UJUU3
   YRGlO/pAGGPkkU+n+zxvMxqMxi6cP0y7tlGiime7H2m9ysaagJKxvogxn
   rjI6b/WzY8y5bYRkg+Y3VnQ0c2mkzFwN2Mkietuk+yjYvRjyOWqVd1zh/
   jsgAmmBEIakFpaaAkOi35gxsFay0YyQOXCKXzlzwe7pYd3cJY5PWq7W9y
   Q==;
X-CSE-ConnectionGUID: twPQxufsQW27BeCE4KZ4qA==
X-CSE-MsgGUID: FI6od6Y8RTawZBnbDkOiNg==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="58127017"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="58127017"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 07:06:49 -0800
X-CSE-ConnectionGUID: OB0MzcPQQFC05yUlRCyNdg==
X-CSE-MsgGUID: Qu6UFl4VQgGe64cmCmVi0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="114593212"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 07:06:45 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tkles-0000000D3UY-0lnR;
	Wed, 19 Feb 2025 17:06:42 +0200
Date: Wed, 19 Feb 2025 17:06:41 +0200
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
Message-ID: <Z7XzgfHcjyK_UZKv@smile.fi.intel.com>
References: <20250218132702.114669-1-clamor95@gmail.com>
 <20250218132702.114669-3-clamor95@gmail.com>
 <Z7XqKcOUt5niXzpv@smile.fi.intel.com>
 <CAPVz0n1_WQyOHhtEVAh53uhEUhZvqqZSEJh6XALtSrVfkMSLYw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPVz0n1_WQyOHhtEVAh53uhEUhZvqqZSEJh6XALtSrVfkMSLYw@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Wed, Feb 19, 2025 at 04:36:38PM +0200, Svyatoslav Ryhel wrote:
> ср, 19 лют. 2025 р. о 16:27 Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> пише:
> > On Tue, Feb 18, 2025 at 03:27:00PM +0200, Svyatoslav Ryhel wrote:
> > > Remove platform data and fully relay on OF and device tree
> > > parsing and binding devices.
> >
> > Thanks for following the advice, but the problem with this change as it does
> > too much at once. It should be split to a few simpler ones.
> > On top of that, this removes MFD participation from the driver but leaves it
> > under MFD realm. Moreover, looking briefly at the code it looks like it open
> > codes the parts of MFD. The latter needs a very goo justification which commit
> > message is missing.

...

> Splitting this into a set of commits would be nearly impossible,

I don't buy this.
One patch can introduce device property support.
Another one removes the old platform data interface.

So, at bare minimum there will be two patches. (Besides the advice to have
two more.)

> original driver does not relay on OF, it relays on platform data.

And?..

> Ripping out platform data will leave behind a broken useless driver.

Hmm... This cna be the case if and only if we have the user in kernel.
Is this the case?

> So it has to be done simultaneously.

Nope.

> MFD part is removed since MFD cells binding is unconditional, while
> the device supports any amount of children grater then one. For
> example, my  device uses only backlight at bank A, while all other
> subdevices are not present and used. This patch switches to dynamic
> bind of children.

MFD does the same. Please, take your time and get familiar with how MFD works.

...

> > > +     device_property_read_string(&pdev->dev, "linux,default-trigger",
> > > +                                 &led->cdev.default_trigger);
> >
> > One prerequisite patch you probably want is an introduction of
> >
> >         struct device *dev = &pdev->dev;
> >
> > in the respective ->probe() implementations. This, in particular, makes the
> > above lines shorter and fit one line.
> 
> This is not a scope of this patchset. Original driver uses &pdev->dev

Indirectly it is. The change you are proposing tries to continue using this
construction with making needlessly longer.

...

> > > +             if (!strcmp(comatible, "ti,lm3533-als"))
> > > +                     lm3533->have_als = 1;
> >
> > If you end up having this, it's not the best what we can do. OF ID tables have
> > a driver_data field exactly for the cases like this.
> 
> This is required by core driver to handle some attributes and is here
> solely not to touch those in this patch.

What does this mean?

-- 
With Best Regards,
Andy Shevchenko



