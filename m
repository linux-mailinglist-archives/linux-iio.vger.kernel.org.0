Return-Path: <linux-iio+bounces-15932-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63886A40830
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 13:05:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2992704179
	for <lists+linux-iio@lfdr.de>; Sat, 22 Feb 2025 12:05:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E3620ADFA;
	Sat, 22 Feb 2025 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JryyxsrO"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B42207A3F;
	Sat, 22 Feb 2025 12:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740225950; cv=none; b=IWoOojjM/av90IEQJSQZuJ8CUqHafSDhTu1lI8rh0Kwp2l7E9yg7R5YIn+QKERVHm5pEO7xFcQtwx7cvL1M3hgAbY+hxQJ0Hp+vILHKUoq0b392es2V6uW0E9K4C4s19KpscZbm8l0A2okVmBHOAm1f4x8EKbgbdfIzqB2G4AdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740225950; c=relaxed/simple;
	bh=S4WNPvUzEd747Q4bqxEodcOBXf04/ZRutTnpWea1NVg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s0wZpNYitaTWtw3yqHFLioUk/i88H86JbKCd77ky8M+T7/jcUl3fY36YrPBZyqJ/lSeJ8XS5tb0s6CJWkr2tS7aTLH+v21AqFitNhREiUeIr9Y8vXfhCuXUyR2K+26nztzy28l3FsMLdzYoeIplZeZxbM3VBaRSf990zhGarCKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JryyxsrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93032C4CED1;
	Sat, 22 Feb 2025 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740225950;
	bh=S4WNPvUzEd747Q4bqxEodcOBXf04/ZRutTnpWea1NVg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JryyxsrOeM6YnZ0MK7+e+OJnT3oVhSlMBUtvted2tjsEhNkQ2wtBsYYWV2tN12Pjn
	 rZOWyEpgAQhB6fNYKJgXh+fv1iulirE2RX91WtylxmS39UtiCJ5BO6MWH1fsX/VBWn
	 qXQQVaRdwtCFtQ9OjAS/VWdMYG41C+G0o2m/i4onUwCmTtM1sIBltWn+ZWZ3DkVYSs
	 TtCXlIC16GgYD8zW6e1KJg5ibz92XEGT6TzTz1QMKiB12S4xUevz0wiOEGcM50kDcL
	 VNub+GdP8hUrQaSSKo7GWzQ/U7qL/wvYJ+6yOGAEi/yB3lgfBmDDUaMkaCpmsU8Zqg
	 r71tEKkkBy/MQ==
Date: Sat, 22 Feb 2025 12:05:37 +0000
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
Subject: Re: [PATCH v2 2/3] iio: light: Add support for AL3000a illuminance
 sensor
Message-ID: <20250222120537.13d2998e@jic23-huawei>
In-Reply-To: <CAPVz0n23XYG4R6JhMd9qOoKW-PbJk53j-A3iRgb-znLHt5hm8w@mail.gmail.com>
References: <20250215103159.106343-1-clamor95@gmail.com>
	<20250215103159.106343-3-clamor95@gmail.com>
	<20250216145445.1278b6ae@jic23-huawei>
	<CAPVz0n1529ydFRHn9N3jEsS8Rhdf-c4xECkMd9TDczzBTNuJzA@mail.gmail.com>
	<20250217142433.12183a17@jic23-huawei>
	<CAPVz0n23XYG4R6JhMd9qOoKW-PbJk53j-A3iRgb-znLHt5hm8w@mail.gmail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.48; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Feb 2025 16:32:33 +0200
Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> =D0=BF=D0=BD, 17 =D0=BB=D1=8E=D1=82. 2025=E2=80=AF=D1=80. =D0=BE 16:24 Jo=
nathan Cameron <jic23@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> >
> > Hi,
> > =20
> > > > > +static int al3000a_read_raw(struct iio_dev *indio_dev,
> > > > > +                         struct iio_chan_spec const *chan, int *=
val,
> > > > > +                         int *val2, long mask)
> > > > > +{
> > > > > +     struct al3000a_data *data =3D iio_priv(indio_dev);
> > > > > +     int ret, gain;
> > > > > +
> > > > > +     switch (mask) {
> > > > > +     case IIO_CHAN_INFO_RAW:
> > > > > +             ret =3D regmap_read(data->regmap, AL3000A_REG_DATA,=
 &gain);
> > > > > +             if (ret < 0)
> > > > > +                     return ret;
> > > > > +
> > > > > +             *val =3D lux_table[gain & AL3000A_GAIN_MASK]; =20
> > > >
> > > > I may have misinterpreted the other thread.  IS this value in lux?
> > > > If it is make this channel IIO_CHAN_INFO_PROCESSED instead.
> > > > =20
> > >
> > > This is actually a really good hint, I will check if this works out
> > > and if yes, then definitely will use it. Thank you. =20
> >
> > From your other reply it seems we have no idea of the correct scaling.
> > If that is the case, then channel type should be IIO_INTENSITY as
> > I assume we also have no idea if the light sensitivity curve is
> > matched to that required for illuminance (which approximates the
> > sensitivity of the human eye). Various datasheets provide completely
> > garbage conversion formulas btw so even if we have data this can
> > be problematic. One recent sensor was using a green filter and
> > saying illuminance in lux was 1.2 * green which was assuming their
> > own definition of white light.
> >
> > Jonathan
> > =20
>=20
> Then why IIO_LIGHT exists at all? If you state that datasheets provide
> garbage formulas and sensors cannot be trusted and all is around human
> eye, then why IIO_LIGHT is still the case? I did not recall any
> drivers for human eyes (thank god). Please be more consistent. Thank

It exists because some sensors do this correctly, or at least a good
approximation to the standard sensitivity curves.  This is done two
ways.

1. Good light frequency filtering in front of the sensor to compensate
   for the difference in sensitivity between the measuring element
   and that the standard curves.  CIE1931 (there are a few other standards
   but they are close enough that we don't care).
   https://en.wikipedia.org/wiki/Illuminance
2. Multiple sensing elements. A common reason for this is to remove
   bit of infrared that we don't want. Often the calculation is a
   non linear combination of the various sensor outputs. Such a driver
   usually presents several IIO_INTENSITY channels and a calculated
   IIO_LIGHT channel.

In both cases the datasheet tends to include a comparison the the
CIE1931 etc standards. There will be small differences but that is
very different from taking a sensor that is only sensitive to green
and weighting it which is the example I gave above.

These sensors will compensate for the different sensivity
of the human eye to different wavelengths.  E.g. if you
think blue and green light LEDs have the same brightness then
the sensor will give close to the same output.

Anyhow, light sensors are a hole I have gone far too deep in over
the years. Key is some manufacturers provide insufficient information
or take the view it is a problem for the integrator of the sensor
to deal with. For those we do not pretend to know the answer and
use intensity channels instead.

Jonathan


> you
>=20


