Return-Path: <linux-iio+bounces-2648-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDFE8581B3
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 16:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F9791F21DE4
	for <lists+linux-iio@lfdr.de>; Fri, 16 Feb 2024 15:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEB812F5A6;
	Fri, 16 Feb 2024 15:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DzAfjgSO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E0778B5C
	for <linux-iio@vger.kernel.org>; Fri, 16 Feb 2024 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708098576; cv=none; b=u+wm0dOhHV13829tDmDDDAQ4bIDm/z09C1gRZrqtixzQi0JharhgMjKpNQWbeuV2NI1OfCMtwhOk+KzLCUL2XuA0AZjo71uxmTwlsLcC6tOfMOAo6PIdWZKN7bmBaOvapYyxVuJa6a9UmVLaSTCcHhXecYdRSuyUqLimjcbX/WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708098576; c=relaxed/simple;
	bh=SktmkLlUnqLfgxQdTmDlDHwkKl0WpH+eQObBsO4TCJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ammrOSkoUIdkieyx9ZpphZqjK4TPT0JQm3XT0ntvdxd4mWoNbfc1/Y1n8L5ZhGgR2ZU24nrHclGnrg+muutTdK73hNt2t3VvU2MNltwNtxBlF4WcpUwDbtQtYBS6hvd7d/pDM686tYckcZOOdF3OcLr/t9kl2iftqypSSr+7Rs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DzAfjgSO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D846AC433F1;
	Fri, 16 Feb 2024 15:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708098575;
	bh=SktmkLlUnqLfgxQdTmDlDHwkKl0WpH+eQObBsO4TCJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DzAfjgSOYMCbey0eql2Hk8Fyzbnp6ici21Ks3IynXg1iTnqZPAI5eypigKtmmQUS7
	 6BfYkbU7Gii5g1VsfmnccKSI0QhM9nhUvqRDZnNr6Kdnz8BEQ2OzjPj/UkvGP4lBGb
	 uvgCEqmPf9Lt9exEKa5H2i3NPrHr9bOekSLLFYxdXeGDHY+wqKgB9Ax8VapYIkYJSd
	 ZdwQ+xTRdGVnCmFFAti/IpIoiE99nb8SbN9avkazUQDdsQF7OZ5DcUD8AKjXwNqbMR
	 gajgVbXwLcTXQyjn5nlZIUSQfqUfykE2ocZmbVnKvwYgayuhdT+C5S+B5h+6H1os/R
	 OfZkaMVkRrUGA==
Date: Fri, 16 Feb 2024 15:49:22 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jonathan LoBue <jlobue10@gmail.com>
Cc: linux-iio@vger.kernel.org, andy.shevchenko@gmail.com,
 hdegoede@redhat.com, ilpo.jarvinen@linux.intel.com,
 jagathjog1996@gmail.com, luke@ljones.dev, benato.denis96@gmail.com,
 lkml@antheas.dev, derekjohn.clark@gmail.com
Subject: Re: [PATCH v5 1/2] iio: accel: bmc150: Duplicate ACPI entries
Message-ID: <20240216154922.302a3664@jic23-huawei>
In-Reply-To: <CAF6rpDwCx-0XnpSvkdHjpa+m-ztybjyUAzJGO25i+eT3QPx+Bw@mail.gmail.com>
References: <CAF6rpDwtj-mtpfFntf8XtTnF2vQMw4rtg1eV-kFGYj6r9hWvKA@mail.gmail.com>
	<20240215182425.57334-1-jlobue10@gmail.com>
	<20240216113706.695b22fc@jic23-huawei>
	<CAF6rpDwCx-0XnpSvkdHjpa+m-ztybjyUAzJGO25i+eT3QPx+Bw@mail.gmail.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Feb 2024 06:30:10 -0800
Jonathan LoBue <jlobue10@gmail.com> wrote:

> Would you prefer if I make these small changes in a version 6?

Sure, saves me a few seconds ;)  We will be waiting for Hans to have
a chance to test anyway.

Jonathan

>=20
> Best Regards,
> Jon LoBue
>=20
> On Fri, Feb 16, 2024 at 3:37=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Thu, 15 Feb 2024 10:24:25 -0800
> > Jonathan LoBue <jlobue10@gmail.com> wrote:
> > =20
> > > This patch adds a description of the duplicate ACPI identifier issue
> > > between devices using bmc150 and bmi323. =20
> > Title of patch doesn't reflect what is going on.
> >
> > If there are no other changes needed I can tweak that whilst applying
> > to
> >
> > iio: accel: bmc150: Document duplicate ACPI entries with bmi323 driver
> > =20
> > >
> > > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Co-developed-by: Luke D. Jones <luke@ljones.dev>
> > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > > Co-developed-by: Denis Benato <benato.denis96@gmail.com>
> > > Signed-off-by: Denis Benato <benato.denis96@gmail.com>
> > > Co-developed-by: Antheas Kapenekakis <lkml@antheas.dev>
> > > Signed-off-by: Antheas Kapenekakis <lkml@antheas.dev>
> > > Signed-off-by: Jonathan LoBue <jlobue10@gmail.com>
> > > ---
> > >  drivers/iio/accel/bmc150-accel-i2c.c | 13 +++++++++++++
> > >  1 file changed, 13 insertions(+)
> > >
> > > diff --git a/drivers/iio/accel/bmc150-accel-i2c.c b/drivers/iio/accel=
/bmc150-accel-i2c.c
> > > index ee1ba134ad42..353271e23235 100644
> > > --- a/drivers/iio/accel/bmc150-accel-i2c.c
> > > +++ b/drivers/iio/accel/bmc150-accel-i2c.c
> > > @@ -224,6 +224,19 @@ static const struct acpi_device_id bmc150_accel_=
acpi_match[] =3D {
> > >       {"BMA250E"},
> > >       {"BMC150A"},
> > >       {"BMI055A"},
> > > +     /*
> > > +      * The "BOSC0200" identifier used here is not unique to devices=
 using
> > > +      * bmc150. The same "BOSC0200" identifier is found in the ACPI =
tables of
> > > +      * the ASUS ROG ALLY and Ayaneo AIR Plus which both use a Bosch=
 BMI323
> > > +      * chip. This creates a conflict with duplicate ACPI identifier=
s which
> > > +      * multiple drivers want to use. Fortunately, when the bmc150 d=
river
> > > +      * starts to load on the ASUS ROG ALLY, the chip ID check porti=
on fails
> > > +      * (correctly) because the chip IDs received (via i2c) are uniq=
ue between
> > > +      * bmc150 and bmi323 and a dmesg output similar to this:
> > > +      * "bmc150_accel_i2c i2c-BOSC0200:00: Invalid chip 0" can be se=
en.
> > > +      * This allows the bmi323 driver to take over for ASUS ROG ALLY=
, and
> > > +      * other devices using the bmi323 chip.
> > > +      */
> > >       {"BOSC0200"},
> > >       {"BSBA0150"},
> > >       {"DUAL250E"}, =20
> > =20


