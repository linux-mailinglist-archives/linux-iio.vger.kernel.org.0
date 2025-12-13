Return-Path: <linux-iio+bounces-27069-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FFBCBB17A
	for <lists+linux-iio@lfdr.de>; Sat, 13 Dec 2025 17:35:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6766300B6A0
	for <lists+linux-iio@lfdr.de>; Sat, 13 Dec 2025 16:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E30A2D46A9;
	Sat, 13 Dec 2025 16:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="naxpG4tB"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138F621FF5F;
	Sat, 13 Dec 2025 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765643709; cv=none; b=fMrZBo9UpKdZppRg5oiuZfVr1HpM0BoF8cUhNrDyNomyvqeBoxEPUNuU+utM6q/Y3BgRh7pqifRcu07ZHgsGwbw3GCYLrcpiCUT+wD5nCYlGaE5DFMHCOm8sOAJBZzgFAYQ8d5wC9V1xgkKg+fxf18roHyJGxajBfL+7R8cJ3Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765643709; c=relaxed/simple;
	bh=ViazW6PvriH9HwsLAvmSJVMIKy5+cXD6aXT4TXjigo0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KqsTXEvWdXfeF0DRPG3hWUW9uHP4GINphu5lpDNtR/FOlYzZFMWZ7Y7VGpRKkWu5mlaEWTvLpen5I9BJYbrF5I1rvshQOGe9pUPDlE3OsYmTnlhYzmFOmIAH8g/cSnDiyabdDyd34MarH+LjP+iAj2tgZhignpaUoNEebbHNX4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=naxpG4tB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B90EC4CEF7;
	Sat, 13 Dec 2025 16:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765643706;
	bh=ViazW6PvriH9HwsLAvmSJVMIKy5+cXD6aXT4TXjigo0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=naxpG4tBO73G0tkktqL+EWUsebfhMp104Ac2O8xTJsNt6oFbz6DijoL7ICvpNucsK
	 GnySRcK8OMvZ5zUt2MbIpdchfCczbJjK3HG4nCweZk9x68xqVqM/YSSbKTl1uKZgXY
	 42Jdjq9ZhrIEuBE7OAT+yFsh0EGCjzvXjQ/wMfD0hZ02xlXMOx4euA2kd1XRbUQcFa
	 bfgtvM2CnB5MBwvAgP9/Pa+s4d7vH7eLreoV0yaPv+A6ymsT+kNS18nbawu41rljp+
	 zDyh6MQ0AWJegbAbvGTU3OeNRzcNW72mCwVD+jp6TeY9089h2kadvOhuq29buHIBqG
	 ZR6jtSpQiBOiQ==
Date: Sat, 13 Dec 2025 16:34:56 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Tomas Melin <tomas.melin@vaisala.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>,
 David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/3] iio: adc: ad9467: sort header includes
Message-ID: <20251213163456.2ba481b6@jic23-huawei>
In-Reply-To: <aThnybDs4lk9ht_f@smile.fi.intel.com>
References: <20251209-add-ad9211-v4-0-02217f401292@vaisala.com>
	<20251209-add-ad9211-v4-2-02217f401292@vaisala.com>
	<CAHp75VeOZHvxr60R0TCS5_c-xsrmfC97gWdP4-EWvFPpbodLTA@mail.gmail.com>
	<7a792f4e-edba-42f3-bcc8-76004972c2f7@vaisala.com>
	<aThnybDs4lk9ht_f@smile.fi.intel.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 9 Dec 2025 20:17:45 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Dec 09, 2025 at 05:46:16PM +0200, Tomas Melin wrote:
> > On 09/12/2025 16:41, Andy Shevchenko wrote: =20
> > > On Tue, Dec 9, 2025 at 7:34=E2=80=AFAM Tomas Melin <tomas.melin@vaisa=
la.com> wrote: =20
> > >>
> > >> Include headers in ascending order. =20
> > >=20
> > > Thanks, but...
> > >  =20
> > >>  #include <linux/iio/backend.h>
> > >>  #include <linux/iio/iio.h>
> > >>  #include <linux/iio/sysfs.h> =20
> > >=20
> > > ...this was specifically grouped to show the relation to the certain
> > > subsystem. At the end we should have something like this
> > >=20
> > > linux/*.h // generic ones
> > > ...blank line...
> > > asm/*.h // generic ones (optionally, if there is a need in a such)
> > > ...blank line...
> > > linux/iio/*.h
> > > ...blank line... =20
> >=20
> > Thanks for the clarification. Sure, it's not a big deal to do a new
> > version. But FWIW, that convention is not AFAIS explicitly stated
> > anywhere and with even recent drivers not all following it, it's
> > somewhat hard to know what expected formatting should be.
> > It would really be good to have that documented somewhere. =20
>=20
> I fully agree. The problem with such a documentation is that you will alw=
ays
> have 50/50% split at best. At worse ~100% will be against any doc updates
> like this. For minimum we can do it on an IIO level (only for this subsys=
tem),
> see how others do Documentation/process/maintainer-*.rst. There is no IIO.
> You can start it :-)
>=20

That maintainer doc is my xmas holiday todo list.  Then again it was
on there last year and I think the year before :(

It's possibly something where we need a rolling draft for a bit out
of tree so that by the time it actually merges it doesn't imply things
simply because we forgot certain aspects.

Jonathan


