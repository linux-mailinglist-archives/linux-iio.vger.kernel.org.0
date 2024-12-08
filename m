Return-Path: <linux-iio+bounces-13235-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB009E8701
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 18:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D4A016455A
	for <lists+linux-iio@lfdr.de>; Sun,  8 Dec 2024 17:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BC1B15B971;
	Sun,  8 Dec 2024 17:16:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7mZE4gb"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFCB13B2B6;
	Sun,  8 Dec 2024 17:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733678219; cv=none; b=WMMn3Mn0JlrvpLtHccXh1oyA04af1B6+XYa6mjWxMPgf9VD4eV4iEPAEMwCxdJND6vtE7eNh6xArf4AFkoP9V9TO4PUi2xXmGfOSIUASKC267U91vkYVDTSZ5JB3la2nClYoINJNDkxHPFx2vV9Xbn+d8vKihrBVlFighqYW3BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733678219; c=relaxed/simple;
	bh=80jm1WGeYCwdtfUxEN8KjbUhw+3thz/j0DAOCSXhp5k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwTBwU726jkaar6WWaB+Ra+lbzoW5lC6FpSERcELtqc/Tm/0p2Oly5tCGxgfc6b+Dtxb+E0q1mA3jSFWX+9RU6mdzcI4HecbcgGGzIRRGt5D8BPdj6T6fTaBHtQBDL/9C0/bV2wmei9DW6niNEXOc6dSU+4hgyDu7M7r006LPsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7mZE4gb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBFDDC4CED2;
	Sun,  8 Dec 2024 17:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733678218;
	bh=80jm1WGeYCwdtfUxEN8KjbUhw+3thz/j0DAOCSXhp5k=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=J7mZE4gbcAjvD3ebbTAarbmj9Cxl+vuoNBsmn8aET2qbOfc0DDscYXSdWjPpbNCrd
	 u/HlYPrPa2/zKDpdS5oUhnBVNZtvMTZZliKgTUBJIVJ5RAIB2k0knS5rATe4DrC4Ve
	 nL7AuzdFnEsFWjdLC7JEYAgnJGWCKb1VdaLp1qQ1UPYYz1x3bw1rksaKZ+46BXviY/
	 H2WooL49CvuW2ujKVzRH4S5bPXRW7TU6QixT46JbZaLIrlLk8wAvmXOmnn4RKwW2sx
	 syZe9hZ2KJ88RzRXcSng7AQ661rfE11SZasHmckdMFm5F27k3Idfr9l1JWrCJIID6t
	 JwR3pvPiLLatA==
Date: Sun, 8 Dec 2024 17:16:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Yu-Hsian Yang <j2anfernee@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
 venture@google.com, yuenn@google.com, benjaminfair@google.com,
 lars@metafoo.de, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 nuno.sa@analog.com, dlechner@baylibre.com, javier.carrasco.cruz@gmail.com,
 marcelo.schmitt@analog.com, olivier.moysan@foss.st.com,
 mitrutzceclan@gmail.com, tgamblin@baylibre.com, matteomartelli3@gmail.com,
 alisadariana@gmail.com, gstols@baylibre.com, thomas.bonnefille@bootlin.com,
 ramona.nechita@analog.com, mike.looijmans@topic.nl,
 chanh@os.amperecomputing.com, KWLIU@nuvoton.com, yhyang2@nuvoton.com,
 openbmc@lists.ozlabs.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: adc: add Nuvoton NCT720x ADC driver
Message-ID: <20241208171642.2bbfa5aa@jic23-huawei>
In-Reply-To: <CA+4Vgc+HUwbHUWHdCoLVgm7aSMdqOGQZZawU8L8z7hMFop_VxQ@mail.gmail.com>
References: <20241203091540.3695650-1-j2anfernee@gmail.com>
	<20241203091540.3695650-3-j2anfernee@gmail.com>
	<Z08MkR40fjfW3MXZ@smile.fi.intel.com>
	<CA+4VgcJW=9rtuqr3VZbfA8QxgYAR+KvfAHdf_0xv4XLQtVVQJw@mail.gmail.com>
	<Z0_aNIrNvLxqcRHv@smile.fi.intel.com>
	<CA+4Vgc+HUwbHUWHdCoLVgm7aSMdqOGQZZawU8L8z7hMFop_VxQ@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 4 Dec 2024 17:05:19 +0800
Yu-Hsian Yang <j2anfernee@gmail.com> wrote:

> Dear Andy Shevchenko,
>=20
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> =E6=96=BC 2024=E5=B9=
=B412=E6=9C=884=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=8812:27=E5=AF=
=AB=E9=81=93=EF=BC=9A
> >
> > On Wed, Dec 04, 2024 at 11:20:20AM +0800, Yu-Hsian Yang wrote: =20
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> =E6=96=BC 2024=E5=
=B9=B412=E6=9C=883=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=889:50=E5=AF=
=AB=E9=81=93=EF=BC=9A =20
> > > > On Tue, Dec 03, 2024 at 05:15:40PM +0800, Eason Yang wrote: =20
> >
> > ...
> > =20
> > > > Second, why do you need two regmaps? How debugfs is supposed to wor=
k on the
> > > > registers that are 16-bit if you access them via 8-bit regmap and v=
ice versa?
> > > >
> > > > Can't you simply use bulk reads/writes when it makes sense and drop=
 16-bit
> > > > regmap completely? =20
> > >
> > > Read VIN info can use word read or byte read, and other registers
> > > should use byte read.
> > >
> > > For a reviewer's comment, If the i2c controller allows word read then=
 the
> > > right thing is to always use it. =20
> >
> > But how does this differ to bulk read of two sequential 8-bit offsets?
> > And if there is a difference, shouldn't this be addressed on regmap lev=
el for
> > all? Like testing for the supported flags and access registers based on=
 the
> > controller capability and user request.
> > =20
>=20
> We would explain why we use two regmaps.
> In the beginning, we declare a property read-vin-data-size for user to
> select byte read or word read.
> After discuss with reviewers, we don't need this property.
> So I get rid of this property and take word read vin data first.
> We can't use regmap_bulk_read since the vin data is not sequential.
>=20
> For Nuvoton NCT7201/NCT7202 chip,
> Take an example as to Vin1:
> The VIN reading supports Byte read (One Byte) and Word read (Two Byte)
>=20
> For Byte read:
> First read Index 00h to get VIN1 MSB, then read Index 0Fh Bit 3~7 to
> get VIN1 LSB.
> Index 0Fh is a shared LSB for all VINs.
>=20
> For Word read:
> Read Index 00h and get 2 Byte (VIN1 MSB and VIN1 LSB).

Yeah. This is a really weird device.  2 regmaps is probably
the best option.  The regmap access tables or functions can be used to
avoid the debugfs problem Andy mentioned.

Jonathan

>=20
> > --
> > With Best Regards,
> > Andy Shevchenko
> >
> > =20


