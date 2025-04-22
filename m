Return-Path: <linux-iio+bounces-18489-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9482AA95FE9
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 09:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF800170174
	for <lists+linux-iio@lfdr.de>; Tue, 22 Apr 2025 07:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1D5F1EE014;
	Tue, 22 Apr 2025 07:50:48 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372431EDA14;
	Tue, 22 Apr 2025 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308248; cv=none; b=Lx9J51silI4lPMxW5edRLIa5sWeC7UMibcBhNulafiVGiD4rNbcj+InoBq5inujgP+6si39/vZpXE4L9IdD7yxujBapnAjmdxz4s8kgCBDEDl7gb3LkLsTol5+LpWWBQOTvwbXqQ8pA2XXnXmZH4/S2CkwaqhZe3gfa0IL1XjYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308248; c=relaxed/simple;
	bh=8lwaDB/KulP2VZEetKa/RIGu68AevEeRgVjMbYY+9YY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/9i3vn1XulD1hzk3IvNBS0OsrQ6zfl0tc7oqfqqdrDIybtnvxkXvY6IgdN0ESeHSwM7DZVelZLvyiXvEhmtQoS70nOZFI45oLKYmBkQjgjHPyiCEzbhh+WDYy/QLWERL2ufcCUPFJ9GkX5JmuH00QSGkrN95jhCpiYftfapWik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
X-CSE-ConnectionGUID: aYwdP5SHSW2RSKea8+8xjQ==
X-CSE-MsgGUID: z3fN7/dHS0i24Kt6ze6orw==
X-IronPort-AV: E=McAfee;i="6700,10204,11410"; a="46742918"
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="46742918"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 00:50:45 -0700
X-CSE-ConnectionGUID: GvMVVanmRjO52PEP5CiUWg==
X-CSE-MsgGUID: divgt7mWQBapDrOqeLOnow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,230,1739865600"; 
   d="scan'208";a="131852466"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2025 00:50:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andy.shevchenko@gmail.com>)
	id 1u78Ot-0000000EfH8-29f0;
	Tue, 22 Apr 2025 10:50:39 +0300
Date: Tue, 22 Apr 2025 10:50:39 +0300
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Gyeyoung Baek <gye976@gmail.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org
Subject: Re: [PATCH v4 3/4] iio: chemical: add support for winsen MHZ19B CO2
 sensor
Message-ID: <aAdKT41RRPOU4eZG@smile.fi.intel.com>
References: <20250420181015.492671-1-gye976@gmail.com>
 <20250420181015.492671-4-gye976@gmail.com>
 <CAHp75VdAeJ0HhExE=OAeFdYz2MYFKgMffbD_Gidf86w=zhKccg@mail.gmail.com>
 <CAKbEznvax5maXFH9V7ZLkME2=Ydt4DiJ9pwfyL_nbsJ5_G3B8A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKbEznvax5maXFH9V7ZLkME2=Ydt4DiJ9pwfyL_nbsJ5_G3B8A@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Mon, Apr 21, 2025 at 03:41:58PM +0900, Gyeyoung Baek wrote:
> On Mon, Apr 21, 2025 at 4:22 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sun, Apr 20, 2025 at 9:10 PM Gyeyoung Baek <gye976@gmail.com> wrote:

...

> > > The datasheet is available at
> > > Link: https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf
> >
> > Instead, just make it Datasheet: tag.

> > >

> > Should not be this blank line here.
> > > Signed-off-by: Gyeyoung Baek <gye976@gmail.com>
> 
> Sorry, I now understand what you mean.
> ('Datasheet:' is a tag, not an explanation. So there should be no
> space between the tags.)
> However, when I use the 'Datasheet:' tag, I get the following warning
> by checkpatch.pl.
> Would it be OK? then I'll use 'Datasheet:' tag.
> 
>     "WARNING: Unknown link reference 'Datasheet:', use 'Link:' or
> 'Closes:' instead
>      #8:
>      Datasheet:
> https://www.winsen-sensor.com/d/files/infrared-gas-sensor/mh-z19b-co2-ver1_0.pdf"

checkpatch is recommendation and sometimes has not fully suitable warnings. You
may ignore this one.

...

> > > +#include <linux/completion.h>
> > > +#include <linux/device.h>
> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/sysfs.h>
> > > +#include <linux/mod_devicetable.h>
> > > +#include <linux/module.h>
> > > +#include <linux/regulator/consumer.h>
> > > +#include <linux/serdev.h>
> > > +#include <linux/unaligned.h>
> >
> > Semi-baked list, see below what's missing (actually a lot). I believe
> > I already pointed that out.
> 
> From the last review, I understood the two main points as:
> (1) Avoid using large headers and explicitly include only the necessary ones.
> (2) Reduce including headers as much as possible to improve build times.
> 
> However, I found that removing headers like 'types.h' didn't cause any
> build failure,

Because we have other headers that may use it, but you shouldn't do that.

> So I thought it would be better to remove headers that are unnecessary
> to improve build time.
> But in the next patch, I'll explicitly include the headers you've pointed out.

You should follow IWYU principle, i.e. Include What You Use, e.g., types.h.

...

> > > +       if (ppm) {
> > > +               if (!in_range(ppm, 1000, 4001)) {
> >
> > Missing minmax.h.
> >
> > The second parameter is length of the range.
> >
> > > +                       dev_dbg(&indio_dev->dev,
> > > +                               "span point ppm should be 1000~5000");
> >
> > The above range check doesn't agree with this message.
> 
> in_range() uses the range 'start <= val && val < (start + len)'.
> So, to allow 5000, the 'len' should be 4001, not 4000.
> I have tested this.
> But would it be correct that I understand your point?

I see now, I recommend then to define those two:

#define ..._PPM_MIN	1000
#define ..._PPM_MAX	5000

And use here as

               if (!in_range(ppm, ..._MIN, ..._MAX - ..._MIN + 1)) {
                       dev_dbg(&indio_dev->dev,
                               "span point PPM should be in a range [%d-%d]\n",
			       _MIN, _MAX);

Note, you missed \n as well.

> > > +                       return -EINVAL;
> > > +               }

-- 
With Best Regards,
Andy Shevchenko



