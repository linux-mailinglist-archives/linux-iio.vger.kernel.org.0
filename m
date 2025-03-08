Return-Path: <linux-iio+bounces-16577-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 099D0A57C4A
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 18:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 856F07A6FCF
	for <lists+linux-iio@lfdr.de>; Sat,  8 Mar 2025 17:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0C81E520D;
	Sat,  8 Mar 2025 17:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MrnmAze8"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662591537A7;
	Sat,  8 Mar 2025 17:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741454385; cv=none; b=RUsbfMO0jUNIjyo3GibA1gAZE/XtshG4KsUT2g+8O5B8ehDo8cQDijbsDtXW+psJlUIzWcqxoempw/LcActR85Erc6hX20ZGhDsALQLLMQtjjaJZmLpcHs14YShwPirbKVklnRuZzEMA7hPbMXEOnsNTLFYH8NFKvH/ZZCYIbaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741454385; c=relaxed/simple;
	bh=WIXPEAfYW6XziCXxNrSUx8MTO0qn8BfggsX4aIVdclE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLMK4igxRIUTpG3f23+eLJHL0K6KEuyGDMIOV7z8v87i6Tgvj+uJDHvdSVa+tehq9kRZm+pL3gqEIC3rfeol8TcZ3f7cHPckzT1Ajg3Cfrx4NElO3Zx4Sye4h95hJEkafvv8qbyUcoP+hX7G2chs2jcwLiUQ4EHqLwF3Y53OSQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MrnmAze8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 392D4C4CEE0;
	Sat,  8 Mar 2025 17:19:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741454384;
	bh=WIXPEAfYW6XziCXxNrSUx8MTO0qn8BfggsX4aIVdclE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MrnmAze88WmBN/BzwaskCEYUl/E7BBXL4zio3IYdhby50e3KiZaPauGIURpacE/Dw
	 UBb+o9RKvUtD8FZcx+9DBz69KbwMmZvn2ADR3VrAbBy/2I1GDssGYJO/4K4wzG8GHO
	 ZNbnsL1ebkV6GXU+0h1iUkYgnp4fYYw0r6cpHTSamn2fJL7YrK3H+DbBSVhBrHd79z
	 4+8kH/U1hj2tQWYIYiWfT6rJ+xAVemaQUqHdmxSzu99yAMjBKruAuTJ6pwXAwXukK4
	 3H6s/bCklWlVZPO+/buxuUFR+Kh2tQE6JcuTP6m2tyv9PI3eg6FIP25uHYQWvuJQmp
	 EmH1Nmlv0ciDg==
Date: Sat, 8 Mar 2025 17:19:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Pavel Machek <pavel@ucw.cz>, Daniel
 Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, Helge
 Deller <deller@gmx.de>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-leds@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v3 2/2] mfd: lm3533: convert to use OF
Message-ID: <20250308171932.2a5f0a9b@jic23-huawei>
In-Reply-To: <CAPVz0n3Qt00my1ejoyEgxTRi-mQszHybwhPq70eO=94oxMfECQ@mail.gmail.com>
References: <20250224114815.146053-1-clamor95@gmail.com>
	<20250224114815.146053-3-clamor95@gmail.com>
	<20250228085927.GM824852@google.com>
	<CAPVz0n0jaR=UM7WbBs3zM-cZzuaPVWBjf4Q7i82hvxtXg2oCzQ@mail.gmail.com>
	<20250305134455.2843f603@jic23-huawei>
	<CAPVz0n3Qt00my1ejoyEgxTRi-mQszHybwhPq70eO=94oxMfECQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 5 Mar 2025 16:18:38 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D1=81=D1=80, 5 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 15:45 Jon=
athan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Fri, 28 Feb 2025 11:30:51 +0200
> > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > =20
> > > =D0=BF=D1=82, 28 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 10:5=
9 Lee Jones <lee@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5: =20
> > > >
> > > > On Mon, 24 Feb 2025, Svyatoslav Ryhel wrote:
> > > > =20
> > > > > Remove platform data and fully relay on OF and device tree
> > > > > parsing and binding devices.
> > > > >
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > ---
> > > > >  drivers/iio/light/lm3533-als.c      |  40 ++++---
> > > > >  drivers/leds/leds-lm3533.c          |  46 +++++---
> > > > >  drivers/mfd/lm3533-core.c           | 159 ++++++++--------------=
------
> > > > >  drivers/video/backlight/lm3533_bl.c |  71 ++++++++++---
> > > > >  include/linux/mfd/lm3533.h          |  35 +-----
> > > > >  5 files changed, 164 insertions(+), 187 deletions(-)
> > > > > =20
> ...
> > > > >       /* ALS input is always high impedance in PWM-mode. */
> > > > > -     if (!pdata->pwm_mode) {
> > > > > -             ret =3D lm3533_als_set_resistor(als, pdata->r_selec=
t);
> > > > > +     if (!als->pwm_mode) {
> > > > > +             ret =3D lm3533_als_set_resistor(als, als->r_select)=
; =20
> > > >
> > > > You're already passing 'als'.
> > > >
> > > > Just teach lm3533_als_set_resistor that 'r_select' is now contained.
> > > > =20
> > >
> > > This is not scope of this patchset. I was already accused in too much
> > > changes which make it unreadable. This patchset is dedicated to
> > > swapping platform data to use of the device tree. NOT improving
> > > functions, NOT rewriting arbitrary mechanics. If you feed a need for
> > > this change, then propose a followup. I need from this driver only one
> > > thing, that it could work with device tree. But it seems that it is
> > > better that it just rots in the garbage bin until removed cause no one
> > > cared. =20
> >
> > This is not an unreasonable request as you added r_select to als.
> > Perhaps it belongs in a separate follow up patch. =20
>=20
> I have just moved values used in pdata to private structs of each
> driver. Without changing names or purpose.
>=20
> > However
> > it is worth remembering the motivation here is that you want get
> > this code upstream, the maintainers don't have that motivation. =20
>=20
> This driver is already upstream and it is useless and incompatible
> with majority of supported devices. Maintainers should encourage those
> who try to help and instead we have what? A total discouragement. Well
> defined path into nowhere.

That is not how I read the situation. A simple request was made to
result in more maintainable code as a direct result of that
improvement being enabled by code changes you were making.
I'm sorry to hear that discouraged you.

>=20
> >
> > Greg KH has given various talks on the different motivations in the
> > past. It maybe worth a watch.
> >
> > =20
> > > =20
> > > > >               if (ret)
> > > > >                       return ret;
> > > > >       }
> > > > > @@ -828,22 +833,16 @@ static const struct iio_info lm3533_als_inf=
o =3D {
> > > > >
> > > > >  static int lm3533_als_probe(struct platform_device *pdev)
> > > > >  {
> > > > > -     const struct lm3533_als_platform_data *pdata;
> > > > >       struct lm3533 *lm3533;
> > > > >       struct lm3533_als *als;
> > > > >       struct iio_dev *indio_dev;
> > > > > +     u32 val; =20
> > > >
> > > > Value of what, potatoes?
> > > > =20
> > >
> > > Oranges. =20
> >
> > A well named variable would avoid need for any discussion of
> > what it is the value of.
> > =20
>=20
> This is temporary placeholder used to get values from the tree and
> then pass it driver struct.

Better if it is a temporary placeholder with a meaningful name.

>=20
> > > =20
> > > > >       int ret;
> > > > >
> > > > >       lm3533 =3D dev_get_drvdata(pdev->dev.parent);
> > > > >       if (!lm3533)
> > > > >               return -EINVAL;
> > > > >
> > > > > -     pdata =3D dev_get_platdata(&pdev->dev);
> > > > > -     if (!pdata) {
> > > > > -             dev_err(&pdev->dev, "no platform data\n");
> > > > > -             return -EINVAL;
> > > > > -     }
> > > > > -
> > > > >       indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*als=
));
> > > > >       if (!indio_dev)
> > > > >               return -ENOMEM;
> > > > > @@ -864,13 +863,21 @@ static int lm3533_als_probe(struct platform=
_device *pdev)
> > > > >
> > > > >       platform_set_drvdata(pdev, indio_dev);
> > > > >
> > > > > +     val =3D 200 * KILO; /* 200kOhm */ =20
> > > >
> > > > Better to #define magic numbers; DEFAULT_{DESCRIPTION}_OHMS
> > > > =20
> > >
> > > Why? that is not needed. =20
> > If this variable had a more useful name there would be no need for
> > the comment either.
> >
> >         val_resitor_ohms =3D 200 * KILLO;
> >
> > or similar.
> > =20
>=20
> So I have to add a "reasonably" named variable for each property I
> want to get from device tree? Why? It seems to be a bit of overkill,
> no? Maybe I am not aware, have variables stopped being reusable?

Lets go with yes if you want a definitive answer. In reality it's
a question of how many are needed.  If 10-100s sure reuse is fine,
if just a few sensible naming can remove the need for comments
and improve readability.

Jonathan


