Return-Path: <linux-iio+bounces-15937-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F49A4086D
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 13:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E87217FE4C
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 12:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4046D1C3BEE;
	Sat, 22 Feb 2025 12:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vDRHqRRY"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B70207A2D;
	Sat, 22 Feb 2025 12:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740228236; cv=none; b=KhEuOnhr/pyx07zyQAMszIXQCZPzdUeTqjnq19Sa/rSBiik5xOvYpsK+q38FeqpdX9QR92wzocHdIJB4rWrNMpXz/aSrUh4dyoGwKtU1Lji2UrHOEvxlCP2n2ZPg4tNJfvRIaF/ijqEK+O6T0uDBP33o6hmGqzqehm8up8aCNvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740228236; c=relaxed/simple;
	bh=2iHP1e50rWeyaCq0VBUun72HKQAa8yqND08z10Xn2Jo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I/1zUDjz71IMlS7FExFyShKzrDSKjvgwR2iwgVf0O2Aq3C90bly1xu5VCrE+GLZHnMf77o+uDEVDWz853KU4vr7nqr6o4kkwB9Ho2DB5BMUDi9sE8PxSpPtnESRzbX9mohwVPsV/1stlmOjmhMBhBlMdAQRL7yTg5DRL9qG3Oiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vDRHqRRY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42B54C4CEE2;
	Sat, 22 Feb 2025 12:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740228235;
	bh=2iHP1e50rWeyaCq0VBUun72HKQAa8yqND08z10Xn2Jo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vDRHqRRYcEN4DVDiwq/rJDILx9BICeP5HkQ060aPJ05Dc7y01mmSf2YxZD70jxl1c
	 bUXlg2tlKMRzrtRdmdtmLazBoMQwkYoN9NDcJsfifSA2lMhWSPcaGovZJ73WngHNZT
	 1YG0Jb/pdvO0tsZ/EBShT63A17HOuamVzz9BjPc4z2ZmCs4wbHPjkZY/unAvddOvQC
	 qr4xUoidEm/bT1KfdzbaRrF+EfKkwSIKEBhgCB3eIAi02xL7YagPPsQKCSqeIsjIfT
	 W9K4Sd4+M7iAmMjYcR6cLw+dIm35DwUAjbHYeJXH51xUOBoY24/e4V7cDKXG6Yr1Zm
	 uon5aGXyT9N7A==
Date: Sat, 22 Feb 2025 12:43:42 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan
 Hunter <jonathanh@nvidia.com>, Javier Carrasco
 <javier.carrasco.cruz@gmail.com>, Matti Vaittinen
 <mazziesaccount@gmail.com>, Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Emil Gedenryd
 <emil.gedenryd@axis.com>, Arthur Becker <arthur.becker@sentec.com>, Mudit
 Sharma <muditsharma.info@gmail.com>, Per-Daniel Olsson
 <perdaniel.olsson@axis.com>, Subhajit Ghosh
 <subhajit.ghosh@tweaklogic.com>, Ivan Orlov <ivan.orlov0322@gmail.com>,
 David Heidelberg <david@ixit.cz>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 0/3] iio: light: add al3000a als support
Message-ID: <20250222124342.6bf6d007@jic23-huawei>
In-Reply-To: <CAPVz0n1FKe_ujAHyn=f1+12pV4r3GZpaZKPZe+caE79L3dn9tg@mail.gmail.com>
References: <20250217140336.107476-1-clamor95@gmail.com>
	<20250217143006.1f043a0e@jic23-huawei>
	<CAPVz0n1FKe_ujAHyn=f1+12pV4r3GZpaZKPZe+caE79L3dn9tg@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Feb 2025 16:33:45 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D0=BF=D0=BD, 17 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:30 Jo=
nathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Mon, 17 Feb 2025 16:03:33 +0200
> > Svyatoslav Ryhel <clamor95@gmail.com> wrote:
> > =20
> > > AL3000a is an illuminance sensor found in ASUS TF101 tablet. =20
> > Hi Svyatoslav,
> >
> > Just a small request.  Please reduce rate of sending new versions.
> > That tends to give time for discussions on earlier versions to progress
> > and for more reviewers to see the current version.
> >
> > I'd suggest at least 3-4 days between versions.  It's great to
> > responsive to reviewers of course!
> >
> > Jonathan
> >
> > =20
>=20
> Once you are satisfied with amount of time patch will hang, let me
> know, I will upload new version. Thank you.

That approach will never work.   Just use 1 week between versions
if you need a simple number.

Jonathan

>=20
> > >
> > > ---
> > > Changes on switching from v3 to v4:
> > > - return write function directly
> > > - clean up and fix i2c_device_id
> > >
> > > Changes on switching from v2 to v3:
> > > - droped linux/iio/sysfs.h
> > > - set driver name directly
> > > - switched to IIO_CHAN_INFO_PROCESSED
> > > - split al3000a_set_pwr into 2 functions
> > > - added i2c_device_id
> > > - improved code formatting
> > >
> > > Changes on switching from v1 to v2:
> > > - sort compatible alphabetically in schema
> > > - clarify commit descriptions
> > > - convert to use regmap
> > > - arrangle lux conversion table in rows of 8
> > > - add more used headers
> > > - improve code formatting
> > > ---
> > >
> > > Svyatoslav Ryhel (3):
> > >   dt-bindings: iio: light: al3010: add al3000a support
> > >   iio: light: Add support for AL3000a illuminance sensor
> > >   ARM: tegra: tf101: Add al3000a illuminance sensor node
> > >
> > >  .../bindings/iio/light/dynaimage,al3010.yaml  |   6 +-
> > >  .../boot/dts/nvidia/tegra20-asus-tf101.dts    |  11 +
> > >  drivers/iio/light/Kconfig                     |  10 +
> > >  drivers/iio/light/Makefile                    |   1 +
> > >  drivers/iio/light/al3000a.c                   | 209 ++++++++++++++++=
++
> > >  5 files changed, 235 insertions(+), 2 deletions(-)
> > >  create mode 100644 drivers/iio/light/al3000a.c
> > > =20
> > =20


