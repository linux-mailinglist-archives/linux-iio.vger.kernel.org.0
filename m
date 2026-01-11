Return-Path: <linux-iio+bounces-27612-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D1FFD0EF7E
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 14:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1511300A34A
	for <lists+linux-iio@lfdr.de>; Sun, 11 Jan 2026 13:18:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5218B3314B8;
	Sun, 11 Jan 2026 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W32tExuM"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164F614F70;
	Sun, 11 Jan 2026 13:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768137503; cv=none; b=goJ+etCaFeJr6+9NkC2r6XjFl3Ca3gstXB2FaN2doHe7mIVn6ihgmRoN3mgVnwznllygr1gSHLQ2p7jRc31bHic4uxyKFSsOai8uq+8RvlKkSoF9tSWha5n2wqHOVoZew4nCHXQ3GmKAYNeGaJQLC+yJgBwFiZgzAqW+yLmq1M4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768137503; c=relaxed/simple;
	bh=GWyDziDxw5WX7dYG0nFpHm4LsIHv2Mlr914TAAzC0r4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bZ5MPreiBB2mshQDa/n0k54D5k2sZ6cm2M0y8o82LaZ7rvCwHs+67AoUIkeH6LifbQMebOyqrQ9wEOdBgWsrigYhUM8wZGJ/je5RRoETAdOFy7aUgrlrjtJRMrAdL8sm22K7NHFJgP628YFZLCAoE/TQMAx6LUTnLFKaAflna5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W32tExuM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31DFC4CEF7;
	Sun, 11 Jan 2026 13:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768137502;
	bh=GWyDziDxw5WX7dYG0nFpHm4LsIHv2Mlr914TAAzC0r4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W32tExuMcwhrVmTkCWzFDGU4auufLDOetLPkkxD8m073ydOAxkgssLmx6f+KiU9qc
	 yf/cET0GLBzIdfCN8rtoSbHJ+UVE+MFPKl2eajDIbiNJXQvsq51MvZJ6P3Uw6pLKx4
	 yE56zmO6i0UJYKzcokx1ceDDnRKWKcRFYUs4mz3eiMrhfRhQVFk31IuSu2aIH6iE66
	 ar7aBuQ2BfxD4gA4xkLt3n6/6waeIVjVRTi3EmeSnloi09+UE9eYXdHvEiWQGFCY7U
	 N+vr4+WtkDFbaphGcImhWGo1dN5IxMxy8ajRz1Dt3H5YqFhB2Ewaypx8yLNVHNmGWm
	 x5eqJUEr6maew==
Date: Sun, 11 Jan 2026 13:18:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Chen Ni <nichen@iscas.ac.cn>, mazziesaccount@gmail.com, lars@metafoo.de,
 Michael.Hennerich@analog.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] iio: adc: ad7476: Remove duplicate include and sort
 the rest
Message-ID: <20260111131814.649cd226@jic23-huawei>
In-Reply-To: <CAHp75Vdiq0jhRV0SuQ9nT1NvSqnpv=3T6OPOLogkrT3f5kGt8A@mail.gmail.com>
References: <20260108083924.2579676-1-nichen@iscas.ac.cn>
	<CAHp75Vdiq0jhRV0SuQ9nT1NvSqnpv=3T6OPOLogkrT3f5kGt8A@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 8 Jan 2026 11:22:53 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Thu, Jan 8, 2026 at 10:41=E2=80=AFAM Chen Ni <nichen@iscas.ac.cn> wrot=
e:
> >
> > Remove duplicate <linux/bitops.h> and sort all headers alphabetically. =
=20
>=20
> I'm okay with this change, but I think ideally it would be three
> patches in a series:
> patch 1) as your v1;
I picked up v1 for this reason.

> patch 2) sorting the headers (as here);
> patch 3) getting rid of "proxy" headers, e.g. kernel.h, by replacing
> them with what actually is being used.
Absolutely on these being good follow up steps.

>=20
> >  #include <linux/bitops.h>
> > +#include <linux/delay.h> =20
>=20
> >  #include <linux/device.h> =20
>=20
> ^^^ needs to be checked if it's used as a "proxy"
>=20
> > +#include <linux/err.h>
> > +#include <linux/gpio/consumer.h> =20
>=20
> >  #include <linux/kernel.h> =20
>=20
> ^^^ This is for sure not used as is in the driver, so definitely has
> to be replaced.
>=20
> > +#include <linux/module.h>
> > +#include <linux/regulator/consumer.h>
> >  #include <linux/slab.h>
> > -#include <linux/sysfs.h>
> >  #include <linux/spi/spi.h>
> > -#include <linux/regulator/consumer.h>
> > -#include <linux/gpio/consumer.h>
> > -#include <linux/err.h>
> > -#include <linux/module.h>
> > -#include <linux/bitops.h>
> > -#include <linux/delay.h>
> > +#include <linux/sysfs.h> =20
>=20
> It's up to the maintainers and to you to resplit, send a v3, but
> again, I'm fine with this version.
I'd prefer the split as you have it above. As such I picked v1 up
to get patch 1 of that split up.

Thanks,

Jonathan

>=20


