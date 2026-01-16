Return-Path: <linux-iio+bounces-27868-lists+linux-iio=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-iio@lfdr.de
Delivered-To: lists+linux-iio@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF673D3845C
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 19:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9208A301065F
	for <lists+linux-iio@lfdr.de>; Fri, 16 Jan 2026 18:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E1134CFB5;
	Fri, 16 Jan 2026 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTvZYIvm"
X-Original-To: linux-iio@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCF2340D93;
	Fri, 16 Jan 2026 18:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768588341; cv=none; b=gyoNK99OfzY4DZ0UN4XpOJaploEz8m9kIWdzFedNCajKd4Zh21L8dBamswr0actm4gNeVMe8d1PAuObuUEaTxyL3P5Ev/MURqHi47ox7nLlmjIxPcdJKkb5ZoZRct7/Vd+YE3fiyQqRASdT4eth/20Jc2YrNtiPcwWJNCu3fitQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768588341; c=relaxed/simple;
	bh=vJLQpArmA+TDjAtxTGYBDeAaXLkTnGiLPgKLZT9uDRc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=guG7yd42LK+IMJhy+tB0ScMzB0seit/WqqwXNxowonNh+xnjFxKHP3ZTAHEv2DHjVTeXUlYsqT9d45y/bFOIum1dZ45YGIn70Nr2cVVHYY64g7qrNpncutNF/2onYCYAp3492yrIEtBcL0bXOi108SDsVGJLUezhthpamC/k67A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTvZYIvm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61727C116C6;
	Fri, 16 Jan 2026 18:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768588341;
	bh=vJLQpArmA+TDjAtxTGYBDeAaXLkTnGiLPgKLZT9uDRc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QTvZYIvmx52admJfv6LoO+ezZfM1ZQI3hVbxATCPmWRiwDUwQ4OS8Gszf4IX1lxda
	 tY8ecCF6DBNADMIXKAiRPrIw++MjX8WPr2WO3z+xeZFFDsWsw43myUDkP76hTZTJZw
	 Wu1itAOp46dVufA2QWMSq44aAJEw3+w2VxNcUYIfJ7I5NaWu6+pvL7eON31GYjcO3W
	 ovhTzDuQhTbYsepv7AcOb5lJ1L6BasoxB5zGfp5imR3a1Ulsyubae1sr0OznsgnelR
	 O4pogV+BH9WBSylpfalqYfDGSqy9CWKV93VhKaLxd9Fvr9Nx+n6a9lKi7dk4hzBQ28
	 N6HOKjd5RfXRA==
Date: Fri, 16 Jan 2026 18:32:12 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: Tomas Melin <tomas.melin@vaisala.com>, Michael Hennerich	
 <Michael.Hennerich@analog.com>, Nuno Sa <nuno.sa@analog.com>, Lars-Peter
 Clausen <lars@metafoo.de>, David Lechner	 <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Olivier Moysan	 <olivier.moysan@foss.st.com>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/4] iio: adc: ad9467: check for backend capabilities
Message-ID: <20260116183212.08630389@jic23-huawei>
In-Reply-To: <9214d1ba49ee31e4f35d8d3fe5d894142e1d6fef.camel@gmail.com>
References: <20260114-b4-ad9467-optional-backend-v3-0-d2c84979d010@vaisala.com>
	<20260114-b4-ad9467-optional-backend-v3-4-d2c84979d010@vaisala.com>
	<34e97dbb610e82953657d8354c0a343a9e1fa57a.camel@gmail.com>
	<68cee45e-4822-41af-a0da-d1b88166425d@vaisala.com>
	<9214d1ba49ee31e4f35d8d3fe5d894142e1d6fef.camel@gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Jan 2026 11:54:28 +0000
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Wed, 2026-01-14 at 17:23 +0200, Tomas Melin wrote:
> > Hi,
> >=20
> > On 14/01/2026 14:29, Nuno S=C3=A1 wrote: =20
> > > On Wed, 2026-01-14 at 10:45 +0000, Tomas Melin wrote: =20
> > > > Add capability checks for operation with backends that do not suppo=
rt
> > > > full set of features, but are otherwise compatible with the device.
> > > >  =20
> >  =20
> > > > +		return 0;
> > > > + =20
> > >=20
> > > As David suggested, it might make more sense to do the check from the=
 callers. Not as
> > > important as within the backend functions though.
> > >  =20
> > > > =C2=A0	/* all points invalid */
> > > > =C2=A0	bitmap_fill(st->calib_map, st->calib_map_size);
> > > > =C2=A0
> > > > @@ -1357,7 +1366,7 @@ static int ad9467_probe(struct spi_device *sp=
i)
> > > > =C2=A0		return ret;
> > > > =C2=A0
> > > > =C2=A0	ret =3D devm_iio_backend_request_buffer(&spi->dev, st->back,=
 indio_dev);
> > > > -	if (ret)
> > > > +	if (ret && ret !=3D -EOPNOTSUPP)
> > > > =C2=A0		return ret; =20
> > >=20
> > > Don't agree with the above. I would prefer to see a dedicated CAP for=
 buffering
> > > otherwise I would argue why not doing the same for everything? While =
it might
> > > be acceptable merging IIO_BACKEND_CAP_TEST_PATTERNS and IIO_BACKEND_C=
AP_CALIBRATION
> > > (given they are related to some extent), that does not apply to buffe=
ring. =20
> >=20
> > Okay perhaps we first need to agree on how we define a capability;)
> >=20
> > So my thinking here was that calibration capability expands across
> > several or even many op calls, so it's a feature level thing and
> > requires several coordinated functions. So does the test pattern, but
> > it's a sub entity of the calibration so I merged the two together. So
> > checking for a capability in these cases makes sense, since checking
> > against a single operation call for determining if the capability is
> > present is not easy and which function would it be, etc. =20
>=20
> Makes sense.
>=20
> >=20
> > The backend buffer on the other hand maps to a single op call (in theory
> > two). So checking for that buffering capability can be done by checking
> > if the op call is supported (eopnotsupp). I was kindof thinking that why
> > need a capability if the mapping is 1:1 and the information is available
> > through that error value directly? =20
>=20
> Yeah, TBH the only reason I can think of is readability. To me, it is more
> explicit:
>=20
> if (has_buffering())
> 	request_buffer(); //not allowed to fail
>=20
> And can be a bit confusing having a mix of has_capability() and checking =
for
> error codes.
>=20
> But yes, checking for specific error codes for determining behavior is a =
common
> pattern so I won't be nitpicky about it.

I'd prefer capabilities for each thing rather than a mixed scheme.
Nothing wrong with also returning -ENOTSUPP if someone doesn't check
the capability first as that's still helpful for debug.


>=20
> >=20
> > On frontend level, like here it is known that the driver can function
> > without that buffering, so if the backend does not supported it can be
> > okay to proceed.
> > If we add a capability for a single operation that has 1:1 mapping then
> > basically we should map all and that is not really the point? =20
>=20
> > I see the capability like a contract between the backend and frontend on
> > feature level, that the feature is there but the implementation of a
> > specific capability might actually differ depending on the use case
> > (like we see with ad9467 and ad485x calibration and their backends)
> >=20
> > What are your thoughts about this?
> >  =20
>=20
> Ok, I think it makes sense to me but maybe we should be more explicit/cle=
ar in
> the docs:
>=20
> "... meaning that a capability requires certain=C2=A0
> operations to be implemented by the backend"
>=20
> Maybe s/certain/multiple and we could even mention that if a frontend is =
interested
> in knowing that a operation is not supported, the error code can be check=
ed
> (though this could be obvious already).
>=20
> Let's see what Jonathan and others thinks about it.
>=20
> - Nuno S=C3=A1
>=20
>=20
>=20
>=20
>=20
>=20


