Return-Path: <linux-iio+bounces-21371-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17956AFA125
	for <lists+linux-iio@lfdr.de>; Sat,  5 Jul 2025 20:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803E048480D
	for <lists+linux-iio@lfdr.de>; Sat,  5 Jul 2025 18:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8142E1FECAD;
	Sat,  5 Jul 2025 18:19:07 +0000 (UTC)
X-Original-To: linux-iio@vger.kernel.org
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A792E134A8
	for <linux-iio@vger.kernel.org>; Sat,  5 Jul 2025 18:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751739547; cv=none; b=MIEhfUl/ugnxiQ0nhVtMMARFbOxe06WHoNRwVDz0EL2Si0GnYAGnFPtNwp5s2kDeZx+j/rvz7egDmRDZJ7i7enX6zRkTh3+VKZaQ36Nm90RF1rsk+6nS2L2g1QWIzfHMVfGhu5YnR4xX4nn9jnC550CnGG0R2Hvcb0g1fBegtcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751739547; c=relaxed/simple;
	bh=7hthfrc7tTdg4jCbIpZXZsXxRkwD5UHIMJ/9LVWFQrU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iwI2EUsFEiOIsy8lRJhHrZFZIrCqWD401KNwet+SJc9Ikan4tJuRxpCsbpyPl6eUKvd+lC+z1b3uw6yD1266HCmvqO5w54E2C7poRfVGBQv9MtABzwq/h5O7yGCHJ1c8EUUI8YiSN4kM2821GvUxGKwK1onSExlJcE/d3fEPpvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-26-232.elisa-laajakaista.fi [88.113.26.232])
	by fgw20.mail.saunalahti.fi (Halon) with ESMTP
	id 82ce853c-59cc-11f0-a04e-005056bd6ce9;
	Sat, 05 Jul 2025 21:18:57 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 5 Jul 2025 21:18:55 +0300
To: Andrew Ijano <andrew.ijano@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
	Andy Shevchenko <andy.shevchenko@gmail.com>, jic23@kernel.org,
	andrew.lopes@alumni.usp.br, gustavobastos@usp.br,
	dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
	jstephan@baylibre.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 0/4] iio: accel: sca3000: simplify by using newer
 infrastructure
Message-ID: <aGlsj1m4TygpRkjt@surfacebook.localdomain>
References: <20250618031638.26477-1-andrew.lopes@alumni.usp.br>
 <CAHp75Ve4yAp6sViUWZY+0abRoNZ0W+rQLCmsbijEcrh8kguVOA@mail.gmail.com>
 <CANZih_S9_8OdY=oKyVPBCTSTqYm_z_rkE=xbPym3uHOSsHMv6A@mail.gmail.com>
 <aFL6PE-8KLLKZun_@smile.fi.intel.com>
 <CANZih_QeeA_G5mFOAb=TMNYiR4eo9SUD5iW1G-5LBGL27NpTRw@mail.gmail.com>
 <aFQrgEw4zw9RSAO3@smile.fi.intel.com>
 <CANZih_S=7-ArpBT3NF54-RH_KYER=mdS9nf1bUO3djEiDY_RWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANZih_S=7-ArpBT3NF54-RH_KYER=mdS9nf1bUO3djEiDY_RWQ@mail.gmail.com>

Sat, Jul 05, 2025 at 12:03:37AM -0300, Andrew Ijano kirjoitti:
> On Thu, Jun 19, 2025 at 12:23 PM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
> > On Wed, Jun 18, 2025 at 03:20:06PM -0300, Andrew Ijano wrote:
> > > On Wed, Jun 18, 2025 at 2:41 PM Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > > On Wed, Jun 18, 2025 at 09:24:19AM -0300, Andrew Ijano wrote:
> > > > > On Wed, Jun 18, 2025 at 2:56 AM Andy Shevchenko
> > > > > <andy.shevchenko@gmail.com> wrote:
> > > > > > On Wed, Jun 18, 2025 at 6:17 AM Andrew Ijano <andrew.ijano@gmail.com> wrote:

...

> > > > > > I haven't found any reference to a base commit here. Have you
> > > > > > forgotten to use --base when preparing the series?
> > > > > > In any case, please clarify what this series is based on.
> > > > >
> > > > > Thank you for pointing this out! I think I forgot to use --base for
> > > > > it. In this case, should I submit a new version of the whole patchset
> > > > > with this information or is there a better way to do it?
> > > >
> > > > For now just reply here what is the base. I asked this question above.
> > >
> > > Ok! No problem. So the base for this patchset is the commit
> > > 3c23416f69f2870bea83697d7ab03c6a8497daa7.
> >
> > No such commit in the repository. :-(
> > You are doing something interesting here [1].
> >
> > So, make sure you are based on the iio/testing or so, make sure that the base
> > commit is the one that may be found on git.kernel.org. Use that in the next
> > version. Due to above this version is ambiguous to even start reviewing it.
> >
> > [1] I have connected IIO subsystem as a remote, so I have access to many trees
> > from kernel.org (but not to all of them).
> 
> Actually, I think I didn't fully understand this part of the
> contribution process and that's what was causing confusion.
> Basically, the base commit appeared in the previous version of this
> patchset but I removed it after it was approved, to prevent it from
> being reviewed again. However, I think I could just add the
> reviewed-by tag.
> 
> I'll send a next version with other corrections and the missing commit
> based on iio/testing.

What you just described is a normal process of rebasing your local tree against
the (updated) upstream branch (in this case we are taling about iio/testing or
iio/togreg whichever suits better). Hence, if the commit was approved, the new
base should be provided. Under "approved" means that it made the subsystem tree
and pending for the upstream.


-- 
With Best Regards,
Andy Shevchenko



