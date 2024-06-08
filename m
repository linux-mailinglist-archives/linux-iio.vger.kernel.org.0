Return-Path: <linux-iio+bounces-6065-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA8C9012D2
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 18:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C59DE282930
	for <lists+linux-iio@lfdr.de>; Sat,  8 Jun 2024 16:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C799A13E8BC;
	Sat,  8 Jun 2024 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmeOnuBP"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15A1E526;
	Sat,  8 Jun 2024 16:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717865376; cv=none; b=mxgjwyc9B0b3ZN0SJMdOBRKDOHf2HoMugD5CCzN4j5vsh7M4qng6uwFASz556+QEAKjRcn3On92LGncf+wNUUxOAB3Zx2HeGDNGHc2SOqaT9kNCZ+jtnNQJDqcgmPz6YZfhQDoZz78gsUGC0RI9ndeeyQNeE7hIPUzEzfW8ue8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717865376; c=relaxed/simple;
	bh=+mpRkOh6rjXaG3EKggTO3VYVSska1ba0Ipx/xyJRRRg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pyLz61bn/NHfZxlEPScdA1oN/p4eJxYWlvdDROD+NQr4TO+CCmFkIiDQB5Onx54NSiLlr8OxgGLfBMw7JKdFTGBl+AO9kmslVMfwBJfNVZQiHhEizCXLZUffvXKX5Pp8OMB1Uu0jvLRtAmnDnI5F28/8OqnRRQoO2rfUnE37UgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmeOnuBP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D58E8C2BD11;
	Sat,  8 Jun 2024 16:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717865376;
	bh=+mpRkOh6rjXaG3EKggTO3VYVSska1ba0Ipx/xyJRRRg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KmeOnuBPlFzgRSwmBXF30pdVRilFZ71TYj4+7n5qU4z7332metcPBIJMYmhyl7MP+
	 JiydxlOkrJbCZUpCKMu9Gs2N43PNAX2l3UssqojFUqTWBpr3yfwX3I845avM1xkHuq
	 FzvUIq1ZvyT4atC+BpMYN39v5rgPtLdLZabSKu7dNEZBBvEg5VGe6dtfHShmzHhq6p
	 b1nfCyHCltqRo1T/MXab6w/33WPsTLVWkhGHNQFZaohQYp31bjpN2nKO8uTSguAy70
	 wEGeot0hIBKZImGgrb/+hVtudnqdq7l07P9ilMfrBVOUElQ1H2/R8DUiJKZV+mP9Fe
	 /k2/FyYihQi9g==
Date: Sat, 8 Jun 2024 17:49:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Yasin Lee <yasin.lee.x@outlook.com>, lars@metafoo.de,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, nuno.a@analog.com,
 swboyd@chromium.org, u.kleine-koenig@pengutronix.de, yasin.lee.x@gmail.com
Subject: Re: [PATCH v4 2/2] iio:proximity:hx9023s: Add TYHX HX9023S sensor
 driver
Message-ID: <20240608174929.14cd9f51@jic23-huawei>
In-Reply-To: <CAHp75VfYhMbHK7pMTuVDZ3uc5ZjytA7uC+3fr7u3nWUEosGZHw@mail.gmail.com>
References: <20240607114138.390272-1-yasin.lee.x@outlook.com>
	<SN7PR12MB81017291E79E6B61A8DEC9A5A4FB2@SN7PR12MB8101.namprd12.prod.outlook.com>
	<CAHp75VdYYGe7rXJm1z2a=r7ZnSU0-y+3N8juoNF-5xXi5=z5nA@mail.gmail.com>
	<CAHp75VfYhMbHK7pMTuVDZ3uc5ZjytA7uC+3fr7u3nWUEosGZHw@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 7 Jun 2024 22:45:49 +0300
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Jun 7, 2024 at 10:40=E2=80=AFPM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Jun 7, 2024 at 2:42=E2=80=AFPM Yasin Lee <yasin.lee.x@outlook.c=
om> wrote: =20
>=20
> ...
> .
> > > +static const struct acpi_device_id hx9023s_acpi_match[] =3D {
> > > +       { "TYHX9023" },
> > > +       {}
> > > +}; =20
> >
> > Btw, do you have a reference to any device on the market that has this =
ID? =20
>=20
> Aaaargh!
> Jonathan, we have to have a big rule from now on on ACPI IDs, if
> anybody introduces an ID in the driver, they must provide the device
> model that is (are going to) use it and excerpt from the ACPI ID
> registry to prove the vendor ID is real.
>=20
> This is the heck fake ID!
> NAK.

Agreed.  Though we should also put together some boilerplate text /
Documentation on how to get a real ID if it makes sense and what
information we need to justify carrying a bad one (which usually
has to include that you've made the supplier aware that the Linux
maintainers are going to be grumpy and our ire wasn't enough to persuade
them to promise to mend their ways - note it has worked a few times!)

For this case, key is:  There are two types of valid ID the one here
is of the ACPI ID form. For that...

ACPI IDs have to be granted by a manufacturer who has registered
with UEFI forum and been granted the use of the four letter sequence
for their products.  For example HiSilicon (my employer) has HISI.
Note that the list on the website is sometimes a bit out of date, so
if you know it has been granted recently just say that in your
patch header.  Note, I can check an would guess Andy can as well :)

That company is then responsible for handling their ID space. In my
case I know who has control of the big spread sheet, so when I want
a valid ID I go ask him and make a case for why.  Those ID spreadsheets
aren't public though in most cases, so we only know it's gone wrong
when we get a clash or a suspicious value (DEAD or BEEF usually ;)

If this process has not been gone through but some device manufacturer
has shipped a firmware with a made up ID, then we are effectively
carrying a workaround for their errata.  We will do that, but we need
much more information and a comment next to the id table entry to provide
at least one example of the shipping product suffering from this bug.

Jonathan

p.s Occasionally these sneak past me (less so with Andy's eagle eyes
on the job) and in the past I was young and didn't know better.
We will rip new ones out if we detect them reasonably quickly and
we reserve the right to rip out old ones to see who screams...
>=20


